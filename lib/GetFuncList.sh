#!/usr/bin/env bash
MainDir="$(cd "$(dirname "${0}")/../" || exit 1 ; pwd)"
LibDir="$MainDir/lib"
NoPrefix=false
if (( $# < 1 )); then
    echo "Usage: $(basename "$0") LibName"
    exit 1
fi

# Parse args
NoArg=()
while [[ -n "${1-""}" ]]; do
    case "${1}" in
        "-noprefix")
            NoPrefix=true
            shift 1
            ;;
        "--")
            shift 1
            break
            ;;
        "-"*)
            echo "Usage: $(basename "$0") LibName"
            [[ "${1}" = "-h" ]] && exit 0
            exit 1
            ;;
        *)
            NoArg+=("$1")
            shift 1
            ;;
    esac
done
set -- "${NoArg[@]}"

LibName="$1"
FuncList=()


while read -r File; do
    #echo "Load: $File" >&2
    readarray -O "${#FuncList[@]}" -t FuncList < <(

        # shellcheck source=/dev/null
        source "${File}"

        declare -F | cut -d " " -f 3
    )
done < <("${LibDir}/GetFileList.sh" "$LibName")

Prefix="$("$LibDir/GetMeta.sh" "$LibName" Prefix)"

if [[ -n "${Prefix-""}" ]] && [[ "$NoPrefix" = false ]]  ; then
    readarray -t FuncList < <(printf "${Prefix}.%s\n" "${FuncList[@]}")
fi

printf "%s\n" "${FuncList[@]}"
