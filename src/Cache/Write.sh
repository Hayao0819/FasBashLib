#!/usr/bin/env bash

# cmd | CreateCache CacheName
# SCRIPTCACHEID: スクリプト内のキャッシュを保存するディレクトリのパスのID
# TMPDIR: /tmpもしくはそれ相当のディレクトリ
CreateCache(){
    cat > "$(CreateCacheDir)/${1}"
    cat "$(GetCacheDir)/$1"
}

CreateCacheDir(){
    SCRIPTCACHEID="${SCRIPTCACHEID-"$(RandomString 10)"}"
    export SCRIPTCACHEID
    local TMPDIR="${TMPDIR-"/tmp"}"
    local _Dir="$TMPDIR/${SCRIPTCACHEID}"
    mkdir -p "$_Dir"
    echo "$_Dir"
    return 0
}


