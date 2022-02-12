#!/usr/bin/env bash

set -Eeu

MainDir="$(cd "$(dirname "${0}")/../" || exit 1 ; pwd)"
SrcDir="$MainDir/src"
LibDir="$MainDir/lib"

if (( $# < 1 )); then
    echo "Usage: $(basename "$0") DirName Param"
    exit 1
fi

Target="$1"
LibList=("$1")
LibFrom=("<EntryPoint>")

SolveRequire(){
    local _Lib _Shell
    echo "Load: $1" >&2
    [[ -d "$SrcDir/$1/" ]] || {
        echo "Missing library: $1" >&2
        return 1
    }
    _Shell="$("$LibDir/GetMeta.sh" "$1" "Shell")"
    while read -r _Lib; do
        if ! printf "%s\n" "${LibList[@]}" | grep -qx "$_Lib"; then
            # Check Shell
            case "$("$LibDir/GetMeta.sh" "$_Lib" "Shell")" in
                "$_Shell" | "Any")
                    SolveRequire "$_Lib"
                    ;;
                *)
                    echo "$1と$_Libは別のシェル用のライブラリです。"
                    exit 1
                    ;;
            esac
        fi
        LibList+=("$_Lib")
        LibFrom+=("$1")
    done < <("$LibDir/GetMeta.sh" "$1" "Require" | tr "," "\n")
}

# Solve 
SolveRequire "$Target"

#echo "LibList: ${LibList[*]}" >&2
#echo "LibFrom: ${LibFrom[*]}" >&2

printf "%s\n" "${LibList[@]}"

