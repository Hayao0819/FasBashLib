#!/usr/bin/env bash
MainDir="$(cd "$(dirname "${0}")/../" || exit 1 ; pwd)"
SrcDir="$MainDir/src"
LibDir="$MainDir/lib"

if (( $# < 1 )); then
    echo "Usage: $(basename "$0") LibName"
    exit 1
fi
LibName="$1"
IgnoreFiles=()
FullPath=""

while read -r File; do
    IgnoreFiles+=("$SrcDir/$LibName/$File")
done < <("$LibDir/GetMeta.sh" -c "${LibName}" "IgnoreFiles")

while read -r File; do
    FullPath="${SrcDir}/$LibName/$File"
    printf "%s\n" "${IgnoreFiles[@]}" |  grep -qx "$FullPath" || echo "$FullPath"
done < <("$LibDir/GetMeta.sh" -c "${LibName}" "Files")
