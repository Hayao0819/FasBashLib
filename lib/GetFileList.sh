#!/usr/bin/env bash
MainDir="$(cd "$(dirname "${0}")/../" || exit 1 ; pwd)"
SrcDir="$MainDir/src"
LibDir="$MainDir/lib"

if (( $# < 1 )); then
    echo "Usage: $(basename "$0") LibName"
    exit 1
fi
LibName="$1"

while read -r File; do
    echo "${SrcDir}/$LibName/$File"
done < <("$LibDir/GetMeta.sh" "${LibName}" "Files" | tr "," "\n")
