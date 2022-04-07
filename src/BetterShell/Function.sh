#!/usr/bin/env bash

UnsetAllFunc(){
    #ForEach eval "unset \"{}\"" < <(GetFuncList)
    local Func
    while read -r Func; do
        unset "$Func"
    done < <(GetFuncList)
}


GetFuncList(){
    declare -F | cut -d " " -f 3
}
