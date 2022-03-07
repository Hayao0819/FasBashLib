#!/usr/bin/env bash

# cmd | CreateCache CacheName
# SCRIPTCACHEID: スクリプト内のキャッシュを保存するディレクトリのパスのID
# TMPDIR: /tmpもしくはそれ相当のディレクトリ
CreateCache(){
    @CreateDir > /dev/null
    cat > "$(@GetDir)/${1}"
    cat "$(@GetDir)/$1"
}

CreateDir(){
    [[ -z "${SCRIPTCACHEID-""}" ]] || { echo "Set SCRIPTCACHEID variable" >&2 ; return 1; }
    export SCRIPTCACHEID="$SCRIPTCACHEID"
    local TMPDIR="${TMPDIR-"/tmp"}"
    local _Dir="$TMPDIR/${SCRIPTCACHEID}"
    mkdir -p "$_Dir"
    echo "$_Dir"
    return 0
}


