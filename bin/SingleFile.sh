#!/usr/bin/env bash
# Do not use FasBashLib in this file
# shellcheck disable=SC1090,SC1091

# Init
MainDir="$(cd "$(dirname "${0}")/../" || exit 1 ; pwd)"
TmpFile="/tmp/fasbashlib.sh"
OutFile="${MainDir}/fasbashlib.sh"
NoRequire=false

# Parse args
while [[ -n "${1-""}" ]]; do
    [[ "$1" == "-"* ]] || break
    case "${1}" in
        "-out")
            [[ -n "${2-""}" ]] || { echo "No file is specified"; exit 1; }
            OutFile="${2}"
            shift 2 || break
            ;;
        "-noreq")
            NoRequire=true
            ;;
        "--")
            shift 1
            break
            ;;
        *)
            echo "Usage: $(basename "$0") [-out File] [-noreq] [Lib1] [Lib2] ..."
            [[ "${1}" = "-h" ]] && exit 0
            exit 1
            ;;
    esac
done
TargetLib=("$@")
RequireLib=()

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
unset Func

# Solve require
if [[ "$NoRequire" = false ]]; then
    for Lib in "${TargetLib[@]}"; do
        readarray -O "${#RequireLib[@]}" -t RequireLib < <("$LibDir/SolveRequire.sh" "$Lib")
    done
    unset Lib
fi

# Load src
while read -r Dir; do
    while read -r File; do
        echo "Load: ${Dir}/${File}" >&2
        source "${Dir}/${File}" || {
            echo "Failed to load shell file"
            exit 1
        }
    done < <("$LibDir/GetMeta.sh" "$(basename "$Dir")" "Files")
done < <(
    if (( "${#TargetLib[@]}" > 0 )); then
        printf "${SrcDir}/%s\n" "${RequireLib[@]}" "${TargetLib[@]}"
    else
        find "$SrcDir" -type d -mindepth 1 -maxdepth 1
    fi )
unset Dir File

# Output to temp
cat "$StaticDir/head.sh" > "$TmpFile"
typeset -f >> "$TmpFile"

# Minify
#bash "$LibDir/minifier/Minify.sh" -f="$TmpFile" > "$OutFile"
cat "$TmpFile" > "$OutFile"
