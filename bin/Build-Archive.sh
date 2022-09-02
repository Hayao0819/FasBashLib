#!/usr/bin/env bash
# shellcheck disable=SC1090,SC1091,SC2154

# shellcheck source=/dev/null
source "$(cd "$(dirname "${0}")/../" || exit 1 ; pwd)/lib/Common.sh"

# Temp
TmpDir="$(mktemp -d -t "fasbashlib.XXXXX")"
OutDir="$MainDir/out"

TmpDocs="${TmpDir}/docs"
TmpUpper="${TmpDir}/upper"
TmpSnake="${TmpDir}/snake"
TmpLower="${TmpDir}/lower"


# Parse args
while [[ -n "${1-""}" ]]; do
    [[ "$1" == "-"* ]] || break
    case "${1}" in
        "-out")
            [[ -n "${2-""}" ]] || { echo "No file is specified"; exit 1; }
            OutDir="$(realpath "${2}")"
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

mkdir -p "$TmpDir" "$OutDir" "$TmpDocs" "$TmpLower" "$TmpUpper" "$TmpSnake"

make_tar(){
    local _file="$1"
    shift 1
    tar -c -v -f "$_file" "$@"
}


{
    # Document
    cd "$TmpDocs" || exit 1
    "${BinDir}/Build-Docs.sh" -out "$TmpDocs"
    #zip "$OutDir/fasbashlib-document.zip" ./*
    make_tar "$OutDir/fasbashlib-document.tar.gz" ./*".md"
}

{
    # upper
    cd "$TmpUpper" || exit 1
    "${BinDir}/Build-Multi.sh" -out "$TmpUpper" -- "$@"
    #zip "$OutDir/fasbashlib.zip" ./*
    make_tar "$OutDir/fasbashlib.tar.gz" ./*".sh"
}

{
    # Lower
    cd "$TmpLower" || exit 1
    "${BinDir}/Build-Multi.sh" -out "$TmpLower" -- "$@" -lower
    #zip "$OutDir/fasbashlib-lower.zip" ./*
    make_tar "$OutDir/fasbashlib-lower.tar.gz" ./*".sh"
}

{
    # Snake
    cd "$TmpSnake" || exit 1
    "${BinDir}/Build-Multi.sh" -out "$TmpSnake" -- "$@" -snake
    #zip "$OutDir/fasbashlib-snake.zip" ./*
    make_tar "$OutDir/fasbashlib-snake.tar.gz" ./*".sh"
}
