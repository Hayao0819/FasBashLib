#!/usr/bin/env bash

# @description 標準入力から1行づつファイル一覧を受け取りファイル名のみを出力します。
#
# @example
#    find . | GetBaseName
#
# @noarg
#
# @stdout 標準入力から受け取ったパスのファイル名
#
# @exitcode 0 return only 0
GetBaseName(){
    #xargs -L 1 basename
    ForEach basename "{}"
}

FileType(){
    file --mime-type -b "$1" 
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
