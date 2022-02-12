#!/usr/bin/env bash
# @file Readlink
# @brief Readlink -fと同等の機能を実装した関数
# @description
#    readlink -fをシェルスクリプトで再実装した関数です。
#
#    これらのコードは [ko1nksm/readlinkf](https://github.com/ko1nksm/readlinkf) から引用しています。
#
#    一部インデントやコードを改変して使用させていただいています。ありがとうございます。

GetLine(){
    head -n "$1" | tail -n 1
}

CutLastString(){
    echo "${1%%"${2}"}"
}

ForArray(){
    local _Item _Cmd _C
    while read -r _Item; do
        for _C in "$@"; do
            #shellcheck disable=SC2001
            _Cmd+=("$(sed "s|{}|${_Item}|g" <<< "$_C")")
        done
        "${_Cmd[@]}" || return 1
        _Cmd=()
    done
}

CheckFunctionDefined(){
    typeset -f "${1}" 1> /dev/null
}

PrintArray(){
    (( $# >= 1 )) || return 0
    printf "%s\n" "${@}"
}

GetBaseName(){
    xargs -L 1 basename
}
