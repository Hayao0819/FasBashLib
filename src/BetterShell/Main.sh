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

# @description 後方最長一致を行います
# 後ろで一致した文字列を除外して出力します
#
# @example
#    CutLastString "HelloWorld!ILoveArchLinux" "Linux"
#
# @arg $1 最後を除外するための長い文字列
# @arg $2 末尾に一致する文字列
#
# @stdout $1 から 末尾の $2 を削除した文字列
#
# @exitcode 0 return only 0
CutLastString(){
    echo "${1%%"${2}"}"
    return 0
}

ForEach(){
    local _Item _Cmd _C
    while read -r _Item; do
        for _C in "$@"; do
            #shellcheck disable=SC2001
            _Cmd+=("$(sed "s|{}|${_Item}|g" <<< "$_C")")
        done
        "${_Cmd[@]}" || return 1
        _Cmd=()
    done
}

CheckFunctionDefined(){
    typeset -f "${1}" 1> /dev/null
}

PrintArray(){
    (( $# >= 1 )) || return 0
    printf "%s\n" "${@}"
}

GetBaseName(){
    xargs -L 1 basename
}

# @description 文字列がUUIDかどうかを確認します
#
# @example IsUUID "EB94BE29-6A92-41B7-B958-2319F14F96C9"
#
# @arg $1 確認する文字列
#
# @exitcode 0 $1はUUIDです
# @exitcode 1 $1はUUIDではありません
IsUUID(){
    local _UUID="${1-""}"
    [[ "${_UUID//-/}" =~ ^[[:xdigit:]]{32}$ ]] && return 0
    return 1
}

RemoveBlank(){
    sed "s|^ *||g; s| *$||g"
}

FileType(){
    file --mime-type -b "$1" 
}

IsAvailable(){
    type "$1" 2> /dev/null 1>&2
}

GetFileExt(){
    GetBaseName | rev | cut -d "." -f 1 | rev
}

RemoveFileExt(){
    # shellcheck disable=SC2034
    local Ext
    # shellcheck disable=SC2016
    ForEach eval 'Ext=$(GetFileExt <<< {}); sed "s|.$Ext$||g" <<< {}; unset Ext'
}

