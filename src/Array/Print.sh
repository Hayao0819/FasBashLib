#!/usr/bin/env bash

# @description 引数で指定されたものを1行づつ出力します
#
# @example
#    hoge=("item1" "item2" "item3")
#    PrintArray "${hoge[@]}"
#    PrintArray Apple Banana Orange
#
# @arg $@ 出力する文字列
#
# @stdout 引数に指定された文字列を1行づつ出力します。何も指定されなかった場合は何も出力しません。
#
# @exitcode 0 return only 0
Print(){
    (( $# >= 1 )) || return 0
    printf "%s\n" "${@}"
}


Eval(){
    eval "PrintArray \"\${$1[@]}\""
}

Last(){
    PrintEval "$1[$(@LastIndex "$1")]"
}
