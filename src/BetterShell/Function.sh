#!/usr/bin/env bash

UnsetAllFunc(){
    ForEach eval "unset \"{}\"" < <(GetFuncList)
}


GetFuncList(){
    declare -F | cut -d " " -f 3
}
