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
PrintArray(){
    (( $# >= 1 )) || return 0
    printf "%s\n" "${@}"
}

# @description 配列の要素数を返します
#
# @example
#    NameList=(hoge fuga piyo)
#    ArrayIndex NameList
#
# @arg $1 配列名（配列をシェル展開しないでください）
#
# @set
# @stdout 指定された配列の要素数
#
# @exitcode 0 正常終了
ArrayIndex(){
    PrintEvalArray "$1" | wc -l
}

# @description 指定された配列に標準入力の内容を1行づつ追加します
#              内部でreadarrayを使用しているため、標準入力の引き渡しに配列を使用しないでください。
#              パイプはサブシェルとして実行され、配列の変更内容が破棄されます。
#              未定義の配列名が渡された場合は新たに定義されます。スコープは最初に定義した場所に依存します。
#
# @example
#    NameList=(hoge fuga piyo)
#    ArrayAppend NameList < /path/to/namelist
#
# @arg $1 配列名（配列をシェル展開しないでください）
#
# @set 指定された配列を新たに定義します
# @stdout 何も出力しません
#
# @exitcode 0 正常終了
ArrayAppend(){
    local _ArrName="$1"
    shift 1 || return 1
    readarray -t -O "$(ArrayIndex "$_ArrName")" "$_ArrName" < <(cat)
}

RevArray(){
    readarray -t "$1" < <(PrintEvalArray "$1" | tac)
}

# AddToArray <Name> <Value>
AddNewToArray(){
    eval "PrintArray \"\${$1[@]}\"" | grep -qx "$2" && return 0
    eval "$1+=(\"$2\")"
}

PrintEvalArray(){
    eval "PrintArray \"\${$1[@]}\""
}

# ArrayIncludes <Array Name> <Value>
ArrayIncludes(){
    PrintEvalArray "$1" | grep -qx "$2"
}

# GetArrayIndex <text>
GetArrayIndex(){
    local n=()
    # shellcheck disable=SC2016
    readarray -t n < <(grep -x -n "$1" | cut -d ":" -f 1 | ForEach eval echo '$(( {} - 1 ))')
    (( "${#n[@]}" >= 1 )) || return 1
    PrintArray "${n[@]}"
    return 0
}

StrToCharList(){
    declare -a -x "$1"
    readarray -t "$1" < <(BreakChar)
}

ShiftArray(){
    readarray -t "$1" < <(PrintEvalArray "$1" | sed "1,${2-"1"}d")
}

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

PopArray(){
    readarray -t "$1" < <(PrintEvalArray "$1" | sed -e '$d')
}

