#!/usr/bin/env bash
# Do not use FasBashLib in this file
# shellcheck disable=SC1090,SC1091

# Init
MainDir="$(cd "$(dirname "${0}")/../" || exit 1 ; pwd)"
TmpFile="/tmp/fasbashlib.sh"
OutFile="${MainDir}/fasbashlib.sh"

# Parse args
while [[ -n "${1-""}" ]]; do
    [[ "$1" == "-"* ]] || break
    case "${1}" in
        "o")
            [[ -n "${2-""}" ]] || { echo "No file is specified"; exit 1; }
            OutFile="${2}"
            shift 2 || break
            ;;
        "--")
            shift 1
            break
            ;;
        *)
            echo "Usage: $(basename "$0") [-o File] [Lib1] [Lib2] ..."
            [[ "${1}" = "-h" ]] && exit 0
            exit 1
            ;;
    esac
done
TargetLib=("$@")


# Ccnfigure dir
SrcDir="$MainDir/src"
StaticDir="$MainDir/static"
LibDir="$MainDir/lib"

# Check dir
for Dir in "$SrcDir" "$StaticDir" "$LibDir"; do
    [[ -d "$Dir" ]]  || {
        echo "Missing directory: $Dir"
        exit 1
    }
done


# Check function
while read -r Func; do
    echo "Unset $Func" >&2
    unset "$Func"
done < <(declare -F | cut -d " " -f 3)


# Load src
while read -r Dir; do
    echo "Load: ${Dir}/Main.sh" >&2
    source "${Dir}/Main.sh" || {
        echo "Failed to load shell file"
        exit 1
    }
done < <(
    if (( "${#TargetLib[@]}" > 0 )); then
        printf "${SrcDir}/%s\n" "${TargetLib[@]}"
    else
        find "$SrcDir" -type d -mindepth 1 -maxdepth 1
    fi )

# Output to temp
cat "$StaticDir/head.sh" > "$TmpFile"
typeset -f >> "$TmpFile"

# Minify
#bash "$LibDir/minifier/Minify.sh" -f="$TmpFile" > "$OutFile"
cat "$TmpFile" > "$OutFile"
