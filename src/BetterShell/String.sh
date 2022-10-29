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

# @description 行頭行末の空行を除去します
#
# 標準入力から受け取ったテキストの、行頭と行末にある任意の数の空白文字やTab文字を削除します。
#
# @example
#    echo "   Hello World ! I Love ArchLinux      " | RemoveBlank
#
# @noargs
#
# @stdout stdinから行頭と末尾の空白を除去したもの
#
# @exitcode 0 return only 0
RemoveBlank(){
    sed "s|^ *||g; s| *$||g; s|^	*||g; s|	*$||g; /^$/d"
}

# GetLastSplitString <delim> <string>
GetLastSplitString(){
    rev <<< "$2" | cut -d "$1" -f 1 | rev
}

# @description 指定された文字列の変数を参照します
#
# 指定された文字列の名前の変数を参照し、その値を返します。
#
# 引数として#と@を指定しても正常に動作しないことに気をつけてください。
#
# 引数の変数を展開しないでください
#
# @example
#    MyVariable="Hello World"
#    PrintEval MyVariable
#
# @arg $1 変数名
#
# @stdout 指定された変数に代入されている値
#
# @exitcode 0 return only 0
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
    local _Content=() _Length _Vertical="|" _Line="=" _Header="${1-""}"

    # 標準入力からテキストを取得
    readarray -t _Content
    #set -xv

    # 最大幅を取得
    _Length="$(PrintArray "${_Content[@]}" "$_Header"  | awk '{ if ( length > x && length > 0 ) { x = length } }END{ print x }')"
    
    # 行頭
    if [[ -z "${_Header:-""}" ]]; then
        echo "${_Vertical}$(Loop "$((_Length+1))" echo -n "${_Line}")${_Vertical}"
    else
        # ヘッダー設定時に幅を必ず偶数にする
        (( _Length % 2 == 0 )) || (( _Length++ ))
        (( ${#_Header} % 2 == 0 )) && (( _Length++ )) # ヘッダーが偶数のときに全体の幅を
        echo "${_Vertical}$(Loop "$(( (_Length - ${#_Header}) /2 ))" echo -n "${_Line}")${_Header+" ${_Header} "}$(Loop "$(( (_Length - ${#_Header}) /2 ))" echo -n "${_Line}")${_Vertical}"
    fi

    # 本文
    for _Str in "${_Content[@]}"; do
        echo "${_Vertical}${_Str}$(Loop "$(( _Length + 1 - "${#_Str}"))" echo -n " ")${_Vertical}"
    done

    # 行末
    echo "${_Vertical}$(Loop "$((_Length+1))" echo -n "${_Line}")${_Vertical}"
}

BreakChar(){
    grep -o "."
    #fold -w 1
}


GetMaxWidth(){
    awk '{ if ( length > x && length > 0 ) { x = length } }END{ print x }'
}
