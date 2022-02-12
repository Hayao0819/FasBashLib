#!/usr/bin/env bash

MainDir="$(cd "$(dirname "${0}")/../" || exit 1 ; pwd)"
LibDir="$MainDir/lib"
SrcDir="$MainDir/src"

mkdir -p "$MainDir/docs"
while read -r File; do
    # shellcheck disable=SC2002
    cat "$File" | gawk -f "$LibDir/shdoc/shdoc" > "$MainDir/docs/$(basename "$(dirname "$File")").md"
done < <(find "${SrcDir}" -name "*.sh" -type f -mindepth 1)

