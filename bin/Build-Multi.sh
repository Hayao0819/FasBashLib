#!/usr/bin/env bash
# Do not use FasBashLib in this file
# shellcheck disable=SC1090,SC1091

set -Eeu

# Init
MainDir="$(cd "$(dirname "${0}")/../" || exit 1 ; pwd)"
OutDir="$MainDir/out"

# Parse args
while [[ -n "${1-""}" ]]; do
    [[ "$1" == "-"* ]] || break
    case "${1}" in
        "-out")
            [[ -n "${2-""}" ]] || { echo "No file is specified"; exit 1; }
            OutDir="${2}"
            shift 2 || break
            ;;
        "--")
            shift 1
            break
            ;;
        *)
            echo "Usage: $(basename "$0") [-out Dir]"
            [[ "${1}" = "-h" ]] && exit 0
            exit 1
            ;;
    esac
done

# Ccnfigure dir
SrcDir="$MainDir/src"
StaticDir="$MainDir/static"
LibDir="$MainDir/lib"
BinDir="$MainDir/bin"

# Check dir
mkdir -p "$OutDir"
for Dir in "$SrcDir" "$StaticDir" "$LibDir"; do
    [[ -d "$Dir" ]]  || {
        echo "Missing directory: $Dir"
        exit 1
    }
done

# Build
# Load src
while read -r Dir; do
    _Lib="$(basename "$Dir")"
    "$MainDir/bin/SingleFile.sh" -out "$OutDir/$_Lib.sh" -noreq "$_Lib"
done < <("$BinDir/GetLibList.sh" -q)
unset Dir File
