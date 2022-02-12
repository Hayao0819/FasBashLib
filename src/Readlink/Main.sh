#!/usr/bin/env bash
# @file Readlink
# @brief Readlink -fと同等の機能を実装した関数
# @description
#    readlink -fをシェルスクリプトで再実装した関数です。
#
#    これらのコードは [ko1nksm/readlinkf](https://github.com/ko1nksm/readlinkf) から引用しています。
#
#    一部インデントやコードを改変して使用させていただいています。ありがとうございます。

# POSIX compliant version
Readlinkf_Posix() {
    [ "${1:-}" ] || return 1
    max_symlinks=40
    CDPATH='' # to avoid changing to an unexpected directory

    target=$1
    [ -e "${target%/}" ] || target=${1%"${1##*[!/]}"} # trim trailing slashes
    [ -d "${target:-/}" ] && target="$target/"

    cd -P . 2>/dev/null || return 1
    while [ "$max_symlinks" -ge 0 ] && max_symlinks=$((max_symlinks - 1)); do
        if [ ! "$target" = "${target%/*}" ]; then
            case $target in
                /*) cd -P "${target%/*}/" 2>/dev/null || break ;;
                *) cd -P "./${target%/*}" 2>/dev/null || break ;;
            esac
            target=${target##*/}
        fi

        if [ ! -L "$target" ]; then
            target="${PWD%/}${target:+/}${target}"
            printf '%s\n' "${target:-/}"
            return 0
        fi

        # `ls -dl` format: "%s %u %s %s %u %s %s -> %s\n",
        #   <file mode>, <number of links>, <owner name>, <group name>,
        #   <size>, <date and time>, <pathname of link>, <contents of link>
        # https://pubs.opengroup.org/onlinepubs/9699919799/utilities/ls.html
        link=$(ls -dl -- "$target" 2>/dev/null) || break
        target=${link#*" $target -> "}
    done
    return 1
}

# readlink version
Readlinkf_Readlink() {
    [ "${1:-}" ] || return 1
    max_symlinks=40
    CDPATH='' # to avoid changing to an unexpected directory

    target=$1
    [ -e "${target%/}" ] || target=${1%"${1##*[!/]}"} # trim trailing slashes
    [ -d "${target:-/}" ] && target="$target/"

    cd -P . 2>/dev/null || return 1
    while [ "$max_symlinks" -ge 0 ] && max_symlinks=$((max_symlinks - 1)); do
        if [ ! "$target" = "${target%/*}" ]; then
            case $target in
                /*) cd -P "${target%/*}/" 2>/dev/null || break ;;
                *) cd -P "./${target%/*}" 2>/dev/null || break ;;
            esac
            target=${target##*/}
        fi

        if [ ! -L "$target" ]; then
            target="${PWD%/}${target:+/}${target}"
            printf '%s\n' "${target:-/}"
            return 0
        fi

        target=$(readlink -- "$target" 2>/dev/null) || break
    done
    return 1
}

readlinkf(){
    Readlinkf_Posix "$@"
}
