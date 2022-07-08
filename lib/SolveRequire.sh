#!/usr/bin/env bash

set -Eeu

MainDir="$(cd "$(dirname "${0}")/../" || exit 1 ; pwd)"
SrcDir="$MainDir/src"
LibDir="$MainDir/lib"
NoMyself=false

if [[ "$1" = "-nomyself" ]]; then
    NoMyself=true
    shift 1
fi

if (( $# < 1 )); then
    echo "Usage: $(basename "$0") LibName"
    exit 1
fi

Target="$1"
LibList=("$1")
LibFrom=("<EntryPoint>")

# Add core
if [[ "$Target" != "Core" ]]; then
    LibList+=("Core")
    LibFrom+=("$Target")
fi


GetMeta(){
    "$LibDir/GetMeta.sh" "$@"
    #"$LibDir/GetMeta-ReadLine.sh" "$@"
}

SolveRequire(){
    local _Lib _Shell
    #echo "Load: $1" >&2
    [[ -d "$SrcDir/$1/" ]] || {
        echo "Missing library: $1" >&2
        return 1
    }
    _Shell="$(GetMeta "$1" "Shell")"
    while read -r _Lib; do
        _LibShell="$(GetMeta "$_Lib" "Shell")"
        if ! printf "%s\n" "${LibList[@]}" | grep -qx "$_Lib"; then
            # Check Shell
            #[[ "$_Shell" = "Any" ]] && SolveRequire "$_Lib"
            #case "$_LibShell" in
            #    "$_Shell" | "Any")
                    LibList+=("$_Lib")
                    LibFrom+=("$1")
                    SolveRequire "$_Lib"
            #        ;;
                #*)
                    #echo "${1}($_Shell)と${_Lib}($_LibShell)は別のシェル用のライブラリです。" >&2
                    #exit 1
                    #;;
            #esac
        fi

    done < <(GetMeta "$1" "Require" | tr "," "\n")
}

# Solve 
SolveRequire "$Target"

#echo "LibList: ${LibList[*]}" >&2
#echo "LibFrom: ${LibFrom[*]}" >&2

if [[ "${NoMyself}" = true ]]; then
    printf "%s\n" "${LibList[@]}" | grep -xv "$Target" || true
else
    printf "%s\n" "${LibList[@]}"
fi
