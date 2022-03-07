#!/usr/bin/env bash


GetCacheID(){
    if [[ -z "${SCRIPTCACHEID-""}" ]]; then
        @CreateDir > /dev/null
    fi
    echo "$SCRIPTCACHEID"
}

GetDir(){
    echo "${TMPDIR-"/tmp"}/$(@GetCacheID)"
}

# Exist <Name>
# 0: exist
# 1: not exist
# 2: exist but too old
Exist(){
    local _File
    _File="$(@CreateDir)/$1"
    [[ -e "$_File" ]] || return 1
    (( "$(@GetTimeDiffFromLastUpdate "$_File")" > "${KEEPCACHESEC-"86400"}" )) && return 2
    return 0
}

GetTimeDiffFromLastUpdate(){
    local _Now _Last
    _Now="$(date "+%s")"
    _Last="$(@GetFileLastUpdate "$1")"
    echo "$(( _Now - _Last ))"
    return 0
}

GetFileLastUpdate(){
    local _isGnu=false
    date --help 2> /dev/null | grep -q "GNU" && _isGnu=true

    if [[ "$_isGnu" = true ]]; then
        date +%s -r "$1"
    else
        {
            eval "$(stat -s "$1")"
            # shellcheck disable=SC2154
            echo "$st_mtime"
        }
    fi
}

# GetCache Name
GetCache(){
    #@Exist "$1" || return 1
    cat "$(@GetDir)/$1" 2> /dev/null || return 1
}
