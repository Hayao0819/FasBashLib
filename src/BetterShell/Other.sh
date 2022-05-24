#!/usr/bin/env bash

RemoveMatchLine(){
    local i unseted=false
    while read -r i; do
        if [[ "$i" != "${1}" ]] || [[ "${unseted}" = true ]]; then
            echo "$i"
        else
            unseted=true
        fi
    done
    unset unseted i
}
