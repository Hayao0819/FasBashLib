#!/usr/bin/env bash

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
