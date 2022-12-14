#!/usr/bin/env bash

set -euo pipefail

TMPDIR="${TMPDIR:-/tmp}"
current_dir="$( cd "$( dirname "${0}" )" && pwd )"

readlinkf() {
	[ "${1:-}" ] || return 1
	max_symlinks=40
	CDPATH=''
	target=$1
	[ -e "${target%/}" ] || target=${1%"${1##*[!/]}"}
	[ -d "${target:-/}" ] && target="$target/"
	cd -P . 2>/dev/null || return 1
	while [ "$max_symlinks" -ge 0 ] && max_symlinks=$((max_symlinks - 1)); do
		if [ ! "$target" = "${target%/*}" ]; then
			case $target in
			/*)
				cd -P "${target%/*}/" 2>/dev/null || break
				;;
			*)
				cd -P "./${target%/*}" 2>/dev/null || break
				;;
			esac
			target=${target##*/}
		fi
		if [ ! -L "$target" ]; then
			target="${PWD%/}${target:+/}${target}"
			printf '%s\n' "${target:-/}"
			return 0
		fi
		link=$(ls -dl -- "$target" 2>/dev/null) || break
		target=${link#*" $target -> "}
	done
	return 1
}

export lib_dir="$(readlinkf "$current_dir/lib")"
export bin_dir="$(readlinkf "$current_dir/bin")"
export src_dir="$(readlinkf "$current_dir/src")"

find(){
    if { command find --help 2>/dev/null || true; } | grep -q "GNU" 1>/dev/null; then
        command find "$@"
    elif which gfind 1>/dev/null 2>&1; then
        command gfind "$@"
    else
        echo "No GNU find found"
        return 1
    fi
}

get_build_target(){
    #find "$src_dir" -name "target.json" -type f -print0 | xargs -0 -I{} sh -c 'dirname {}'
    find "$current_dir" -name "target.json" -type f -print0 | xargs -0 -I{} bash -c 'dirname {}'
}


get_header(){
    local target="$1" headers=()
    readarray -t headers < <(jq -r ".headers[]" "$target/target.json")
    while read -r script; do
        if [ -e "${target}/$script" ]; then
            echo "Header $script found" >&2
            cat "${target}/$script"
        else
            echo "Header script $script not found" >&2
            return 1
        fi
    done < <(printf '%s\n' "${headers[@]}")
    
}

get_footer(){
    local target="$1" footers=()
    readarray -t footers < <(jq -r ".footers[]" "$target/target.json")
    for script in "${footers[@]}"; do
        if [ -e "${target}/$script" ]; then
            echo "Footer $script found" >&2
            cat "${target}/$script"
        else
            echo "Footer script $script not found" >&2
            return 1
        fi
    done | grep -Ev " *#!/usr/bin/env bash" || true
    return 0
}

get_func(){
    local target="$1" funcfiles=()
    readarray -t funcfiles < <(jq -r ".functions[]" "$target/target.json")
    (
        local func
        while read -r func; do
            unset -f "$func"
        done <<< "$(typeset -F | awk '{print $3}')"
        while read -r script; do
            if [ -e "$script" ]; then
                #shellcheck source=/dev/null
                source "$script" || {
                    echo "Failed to source $script"
                    return 1
                }
            else
                echo "Function script $script not found"
                return 1
            fi
        done < <(printf "${target}/%s\\n" "${funcfiles[@]}")

        typeset -f
    )

}

unset_allfunc(){
    local func
    while read -r func; do
        unset -f "$func"
    done < <(typeset -F | awk '{print $3}')
}

get_funclist(){
    local target="$1" funcfiles=()
    readarray -t funcfiles < <(jq -r ".functions[]" "$target/target.json")
    (
        unset_allfunc
        while read -r script; do
            if [ -e "$script" ]; then
                #shellcheck source=/dev/null
                source "$script" || {
                    echo "Failed to source $script"
                    return 1
                }
            else
                echo "Function script $script not found"
                return 1
            fi
        done <<< "$(printf "${target}/%s\\n" "${funcfiles[@]}")"

        typeset -F | awk '{print $3}'
    )
}

make_entrypoint(){
    local target="$1" entrypoint
    entrypoint="$(jq -r ".entrypoint" "$target/target.json")"
    get_funclist "$target" | grep -qx "$entrypoint" || {
        echo "Entrypoint $entrypoint function are not defined" >&2
        return 1
    }
    # shellcheck disable=SC2016
    printf '%s "${@}"\n' "$entrypoint"
}

print_array(){
    (( $# == 0 )) && return 0
    printf '%s\n' "$@"
}

print_eval_array(){
    eval "print_array \"\${${1}[@]}\""
}

insert_remote(){
    local target="$1" insert_keywords=() base_script=() key
    readarray -t base_script
    readarray -t insert_keywords < <(jq -r '.["remote-inserts"] | keys[]' "$target/target.json")
    if (( ${#insert_keywords[@]} == 0 )); then
        print_array "${base_script[@]}"
        return 0
    fi
    for key in "${insert_keywords[@]}"; do
        local insert_url
        echo "Inserting $key" >&2
        insert_url="$(jq -r ".[\"remote-inserts\"][\"$key\"]" "$target/target.json")"
        if [[ -n "$insert_url" ]]; then
            #readarray -t remote_file < <(curl -s "$insert_url")
            #print_array "${remote_file[@]}" > 
            curl -sL "$insert_url" > "$TMPDIR/remote_insert"
            readarray -t base_script< <(print_array "${base_script[@]}" | sed "/^${key}$/r $TMPDIR/remote_insert" | sed "/^${key}$/d")
        fi
    done
    print_array "${base_script[@]}"
}

get_remote_func(){
    local url target="$1"
    while read -r url; do
        (
            unset_allfunc
            #shellcheck source=/dev/null
            source <(curl -s "$url") || {
                echo "Failed to source $url" >&2
                return 1
            }
            typeset -f
        )
    done < <(jq -r '.["remote-functions"][]' "$target/target.json")
}

call(){
    echo "call: $*" >&2
    "$@"
}

build(){
    local target="$1"
    {
        call get_header "$target"
        call get_remote_func "$target"
        call get_func "$target" 
        call make_entrypoint "$target"
        call get_footer "$target"
    } | insert_remote "$target" | shfmt
}

get_filename(){
    local target="$1"
    jq -r ".filename" "$target/target.json"
}


out_dir="$current_dir/out"
mkdir -p "${out_dir}"


#echo "${out_dir}/$(get_filename "$@")"
#build "$@" > "${out_dir}/$(get_filename "$@")"
#chmod +x "${out_dir}/$(get_filename "$@")"

while read -r target; do
    echo "Building $target" >&2
    build "${target}" > "${out_dir}/$(get_filename "${target}")"
    chmod +x "${out_dir}/$(get_filename "${target}")"
done < <(get_build_target)


