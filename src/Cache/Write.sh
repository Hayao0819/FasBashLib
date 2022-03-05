#!/usr/bin/env bash

# cmd | CreateCache CacheName
# SCRIPTCACHEID: スクリプト内のキャッシュを保存するディレクトリのパスのID
# TMPDIR: /tmpもしくはそれ相当のディレクトリ
CreateCache(){
    CreateCacheDir > /dev/null
    cat > "$(@ GetCacheDir)/${1}"
    cat "$(@ GetCacheDir)/$1"
}

CreateCacheDir(){
    [[ -z "${SCRIPTCACHEID-""}" ]] || { echo "Set SCRIPTCACHEID variable" >&2 ; return 1; }
    export SCRIPTCACHEID="$SCRIPTCACHEID"
    local TMPDIR="${TMPDIR-"/tmp"}"
    local _Dir="$TMPDIR/${SCRIPTCACHEID}"
    mkdir -p "$_Dir"
    echo "$_Dir"
    return 0
}


