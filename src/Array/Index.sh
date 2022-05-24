#!/usr/bin/env bash

# Array.IndexOf <Text>
IndexOf(){
    local n=()
    # shellcheck disable=SC2016
    readarray -t n < <(grep -x -n "$1" | cut -d ":" -f 1 | ForEach eval echo '$(( {} - 1 ))')
    (( "${#n[@]}" >= 1 )) || return 1
    PrintArray "${n[@]}"
    return 0
}

# @description 配列の要素数を返します
#
# @example
#    NameList=(hoge fuga piyo)
#    Array.Length NameList
#
# @arg $1 配列名（配列をシェル展開しないでください）
#
# @set
# @stdout 指定された配列の要素数
#
# @exitcode 0 正常終了
Length(){
    PrintEvalArray "$1" | wc -l
}

