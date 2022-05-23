#!/usr/bin/env bash
# @file BetterShell
# @brief よく使う構文をシンプルに書けるようにした関数
# @description
#    For文やecho文など、コーディングで多用する文を短く記述できる関数です。

# @description 標準入力から指定された行を抽出します
# headコマンドとtailコマンドのシンプルなラッパーです
#
# @example
#    cat file.txt | GetLine 4
#
# @arg $1 行番号
#
# @stdout 標準出力の指定された行
GetLine(){
    head -n "$1" | tail -n 1
}

# @description 標準入力から値を読み取り、ループします
#              標準入力から1行ずつ読み取り、指定されたコマンドの引数に渡してコマンドを繰り返し実行します。
#              xargsと似ていますが、シェル関数なども利用できます。
#              引数には、代入を行う場所を`{}`で置き換えてください。
#
# @example
#    find . -type f | ForEach mv "{}" "{}.bak"
#
# @arg $@ 実行するコマンドおよびその引数
#
# @stdout 指定されたコマンドの出力をそのまま返します。この関数特有のものはありません。
#
# @exitcode 0 正常に実行されました
# @exitcode 0以外 指定されたコマンドが0以外で終了し、ループを中止しました
ForEach(){
    local _Item
    while read -r _Item; do
        "${@//"{}"/"${_Item}"}" || return "${?}"
    done
}

# @description 指定された関数が定義されているか確認します。
#
# @example
#    function hoge(){ echo "HOGE!"; }
#    CheckFuncDefined hoge || echo "hoge is not defined"
#
# @arg $1 チェックする関数名
#
# @stdout 何も出力しません
#
# @exitcode 0 関数は定義されています
# @exitcode 1 関数は定義されていません
CheckFuncDefined(){
    typeset -f "${1}" 1> /dev/null || return 1
}

IsAvailable(){
    type "$1" 2> /dev/null 1>&2
}

Loop(){
    local _T="$1"
    shift 1 || return 1
    ForEach "$@" < <(yes "" | head -n "$_T")
}

