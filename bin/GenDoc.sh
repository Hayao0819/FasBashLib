#!/usr/bin/env bash

MainDir="$(cd "$(dirname "${0}")/../" || exit 1 ; pwd)"
LibDir="$MainDir/lib"
SrcDir="$MainDir/src"
BinDir="$MainDir/bin"
DocsDir="$MainDir/docs"


# Parse args
while [[ -n "${1-""}" ]]; do
    [[ "$1" == "-"* ]] || break
    case "${1}" in
        "-out")
            [[ -n "${2-""}" ]] || { echo "No file is specified"; exit 1; }
            DocsDir="${2}"
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

mkdir -p "${DocsDir}"

if [[ ! -e "$LibDir/shdoc/shdoc" ]]; then
    echo "Error: Update git submodule" >&2
    exit 1
fi

while read -r Lib; do
    echo > "${DocsDir}/${Lib}.md"
    readarray -t FileList < <("$LibDir/GetMeta.sh" "$Lib" Files | tr "," "\n" | sed "s|^ *||g; s| *$||g; s|^	*||g; s|	*$||g; /^$/d" )
    printf "${SrcDir}/$Lib/%s\n" "${FileList[@]}" | xargs -I{} echo "Load: {}"
    printf "${SrcDir}/$Lib/%s\n" "${FileList[@]}" | xargs cat | gawk -f "$LibDir/shdoc/shdoc" >> "${DocsDir}/${Lib}.md"
done < <("${BinDir}/GetLibList.sh" -q)
