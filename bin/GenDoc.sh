#!/usr/bin/env bash

MainDir="$(cd "$(dirname "${0}")/../" || exit 1 ; pwd)"
LibDir="$MainDir/lib"
SrcDir="$MainDir/src"
BinDir="$MainDir/bin"

mkdir -p "$MainDir/docs"

#while read -r File; do
    # shellcheck disable=SC2002
#    cat "$File" | gawk -f "$LibDir/shdoc/shdoc" > "$MainDir/docs/$(basename "$(dirname "$File")").md"
#done < <(find "${SrcDir}" -name "*.sh" -type f -mindepth 1)

while read -r Lib; do
    echo > "$MainDir/docs/${Lib}.md"
    readarray -t FileList < <("$LibDir/GetMeta.sh" "$Lib" Files | tr "," "\n")
    printf "${SrcDir}/$Lib/%s\n" "${FileList[@]}" | xargs cat | gawk -f "$LibDir/shdoc/shdoc" >> "$MainDir/docs/${Lib}.md"
done < <("${BinDir}/GetLibList.sh" -q)
