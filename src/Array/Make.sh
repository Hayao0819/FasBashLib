#!/usr/bin/env bash

# 標準入力から受け取った文字列から、1文字づつに分割された配列を返します
FromStr(){
    declare -a -x "$1"
    readarray -t "$1" < <(BreakChar)
}

# @description 指定された配列に標準入力の内容を1行づつ追加します
#              内部でreadarrayを使用しているため、標準入力の引き渡しにパイプを使用しないでください。
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
Append(){
    local _ArrName="$1"
    shift 1 || return 1
    readarray -t -O "$(ArrayIndex "$_ArrName")" "$_ArrName" < <(cat)
}

# @description 指定された配列に要素を1つ追加します
#
# @example
#    NameList=(hoge fuga piyo)
#    Array.Push NameList yamada
#    Array.Eval NameList # hoge fuga piyo yamada
#
# @arg $1 配列名（配列をシェル展開しないでください）
# @arg $2 追加する要素
#
# @set 指定された配列を新たに定義します
# @stdout 何も出力しません
#
# @exitcode 0 正常終了
Push(){
    eval "PrintArray \"\${$1[@]}\"" | grep -qx "$2" && return 0
    eval "$1+=(\"$2\")"
}

# 指定された配列を裏返します
Rev(){
    readarray -t "$1" < <(PrintEvalArray "$1" | tac)
}

# 指定された配列から最後の要素を削除します
Pop(){
    readarray -t "$1" < <(PrintEvalArray "$1" | sed -e '$d')
}

# 指定された配列から最初の要素を削除します
Shift(){
    readarray -t "$1" < <(PrintEvalArray "$1" | sed "1,${2-"1"}d")
}

#Array.Remove <Array Name> <String>
# 指定された配列から文字列と一致する要素を削除します
Remove(){
    readarray -t "$1" < <(PrintEvalArray "$1" | RemoveMatchLine "$2")
}
