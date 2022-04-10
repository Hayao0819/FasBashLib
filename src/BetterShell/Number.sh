#!/usr/bin/env bash

Ntest(){
    (( "$@" )) || return 1
}

CalcInt(){
    echo "$(( "$@" ))"
}

Sum(){
    local _Arg=()
    ForEach eval '_Arg+=("{}" "+")' < <(PrintArray "$@")
    readarray -t _Arg < <(PrintArray "${_Arg[@]}" | sed "${#_Arg[@]}d")
    CalcInt "${_Arg[@]}"
}
