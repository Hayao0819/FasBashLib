#!/usr/bin/env bash
# Do not use FasBashLib in this file
# shellcheck disable=SC1090,SC1091,SC2154

# shellcheck source=/dev/null
source "$(cd "$(dirname "${0}")/../" || exit 1 ; pwd)/lib/Common.sh"

# Ccnfigure dir
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
    echo "Run: " "$MainDir/bin/Build-Single.sh" "${@}" -out "$OutDir/$_Lib.sh" -noreq "$_Lib"
    "$MainDir/bin/Build-Single.sh" "${@}" -out "$OutDir/$_Lib.sh" -noreq "$_Lib"
done < <("$BinDir/List.sh" -q)
unset Dir File
