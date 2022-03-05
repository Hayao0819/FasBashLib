#!/usr/bin/env bash

MainDir="$(cd "$(dirname "${0}")/../" || exit 1 ; pwd)"
LibDir="$MainDir/lib"
SrcDir="$MainDir/src"
BinDir="$MainDir/bin"

mkdir -p "$MainDir/docs"

if [[ ! -e "$LibDir/shdoc/shdoc" ]]; then
    echo "Error: Update git submodule" >&2
    exit 1
fi

while read -r Lib; do
    echo > "$MainDir/docs/${Lib}.md"
    readarray -t FileList < <("$LibDir/GetMeta.sh" "$Lib" Files | tr "," "\n")
    printf "${SrcDir}/$Lib/%s\n" "${FileList[@]}" | xargs cat | gawk -f "$LibDir/shdoc/shdoc" >> "$MainDir/docs/${Lib}.md"
done < <("${BinDir}/GetLibList.sh" -q)
