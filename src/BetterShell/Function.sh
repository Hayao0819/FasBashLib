#!/usr/bin/env bash

UnsetAllFunc(){
    ForEach unset "{}" < <(GetFuncList)
}


GetFuncList(){
    declare -F | cut -d " " -f 3
}
