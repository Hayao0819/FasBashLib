#!/usr/bin/env bash

@(){
    local _Func="$1"
    shift 1 || return 1
    "FSBLIB_NAME.${_Func}" "${@}"
}
