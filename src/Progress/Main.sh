#!/usr/bin/env bash

Rotation(){
    local Count="$1" CharList=( '|' '/' '-' "\\" )
    Esc.ClearLineAndReturn
    [[ -n "${2-""}" ]] &&  echo -n "${2}" >&2
    printf "%s" "${CharList["$(( Count % "${#CharList[@]}" ))"]}" >&2
}

Bar(){
    local Max="$1" Counter="$2" Size="${3-"100"}"
    local SharpCount=$((Counter * Size / Max))
    local SpaceCount=$((Size - SharpCount))
    Esc.Return
    echo -n "$Counter/$Max [$(yes "#" | head -n "$SharpCount" 2> /dev/null | tr -d "\n")$(yes " " | head -n "$SpaceCount" 2> /dev/null | tr -d "\n")]"
}

WideBar(){
    local Max="$1" Counter="$2"
    local StatusString="$Counter/$Max"
    local Size=$(( $(Esc.GetTermX) - ${#StatusString} - 3 ))
    @Bar "$Max" "$Counter" "$Size"
}
