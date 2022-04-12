#!/usr/bin/env bash

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

# @description ランダムな文字列を/dev/randomから生成します
#
# @example
#    password=$(RandomString 15)
#
# @arg $1 桁数
#
# @stdout ランダムな文字列
#
# @exitcode 0 If successful.
# @exitcode 1  何かしらのコマンドが異常終了しました
RandomString(){
    base64 < "/dev/random" | fold -w "$1" | head -n 1
    return 0
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

RemoveBlank(){
    sed "s|^ *||g; s| *$||g; s|^	*||g; s|	*$||g; /^$/d"
}

# GetLastSplitString <delim> <string>
GetLastSplitString(){
    rev <<< "$2" | cut -d "$1" -f 1 | rev
}

# PrintEval <変数名>
PrintEval(){
    eval echo "\${$1}"
}

# ToLower <文字列>
ToLower(){
    local _Str="${1,,}"
    [[ -z "${_Str-""}" ]] || echo "${_Str}"
}

ToLowerStdin(){
    local _Str
    ForEach eval "_Str=\"{}\"; echo \"\${_Str,,}\""
    unset _Str
}

TextBox(){
    local _Content=() _Length _Vertical="|" _Line="="
    readarray -t _Content
    _Length="$(PrintArray "${_Content[@]}" | awk '{ if ( length > x ) { x = length } }END{ print x }')"
    echo "${_Vertical}${_Line}$(yes "${_Line}" | head -n "$_Length" | tr -d "\n")${_Vertical}"
    for _Str in "${_Content[@]}"; do
        echo "${_Vertical}${_Str}$(yes " " | head -n "$(( _Length + 1 - "${#_Str}"))" | tr -d "\n")${_Vertical}"
    done
    echo "${_Vertical}${_Line}$(yes "${_Line}" | head -n "$_Length" | tr -d "\n")${_Vertical}"
}
