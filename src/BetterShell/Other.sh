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


# 文字列がどれか完全一致
# Match ""
Match(){
    local stdin str
    read -r stdin
    for str in "$@"; do
        if [[ "$str" = "$stdin" ]]; then
            return 0
        fi
    done
    return 1
}

# 標準入力をまとめて引数に渡す
ToArgs(){
    readarray -t args
    "$@" "${args[@]}"
}
