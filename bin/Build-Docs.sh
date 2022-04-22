#!/usr/bin/env bash
# shellcheck disable=SC2154

# shellcheck source=/dev/null
source "$(cd "$(dirname "${0}")/../" || exit 1 ; pwd)/lib/Common.sh"

# Parse args
while [[ -n "${1-""}" ]]; do
    [[ "$1" == "-"* ]] || break
    case "${1}" in
        "-out")
            [[ -n "${2-""}" ]] || { echo "No file is specified"; exit 1; }
            DocsDir="${2}"
            shift 2 || break
            ;;
        "-debug")
            export SHDOC_DEBUG=1
            shift 1
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

LibList=("${@}")

mkdir -p "${DocsDir}"

if [[ ! -e "$LibDir/shdoc/shdoc" ]]; then
    echo "Error: Update git submodule" >&2
    exit 1
fi

if [[ -z "${LibList[*]}" ]]; then
    readarray -t LibList < <("${BinDir}/List.sh" -q)
fi

for Lib in "${LibList[@]}"; do
    echo > "${DocsDir}/${Lib}.md"

    # Get info
    readarray -t FileList < <("$LibDir/GetMeta.sh" "$Lib" Files | tr "," "\n" | sed "s|^ *||g; s| *$||g; s|^	*||g; s|	*$||g; /^$/d" )

    # Create Document
    printf "${SrcDir}/$Lib/%s\n" "${FileList[@]}" | xargs -I{} echo "Load: {}"
    printf "${SrcDir}/$Lib/%s\n" "${FileList[@]}" | xargs cat | gawk -f "$LibDir/shdoc/shdoc" >> "${DocsDir}/${Lib}.md"
done
