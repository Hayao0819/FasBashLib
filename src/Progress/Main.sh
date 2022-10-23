#!/usr/bin/env bash

Rotation(){
    local Count="$1" CharList=( '|' '/' '-' "\\" )
    Esc.ClearLineAndReturn
    [[ -n "${2-""}" ]] &&  echo -n "${2}" >&2
    printf "%s" "${CharList["$(( Count % "${#CharList[@]}" ))"]}" >&2
}

Bar(){
    local Max="$1" Counter="$2"
    local SharpCount=$((Counter * 100 / Max))
    local SpaceCount=$((100 - SharpCount))
    Esc.Return
    echo -n "$Counter/$Max [$(yes "#" | head -n "$SharpCount" 2> /dev/null | tr -d "\n")$(yes " " | head -n "$SpaceCount" 2> /dev/null | tr -d "\n")]"
}
