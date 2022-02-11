#!/usr/bin/env bash
# shellcheck disable=SC1090

CurrentDir="$(cd "$(dirname "${0}")" || exit 1 ; pwd)"
SrcDir="$CurrentDir/src"
StaticDir="$CurrentDir/static"
OutFile="${1-"${CurrentDir}/fasbashlib.sh"}"

for file in "${SrcDir}/"*".sh"; do
    echo "Load: $file"
    source "$file"
done

cat "$StaticDir/head.sh" > "$OutFile"
typeset -f >> "$OutFile"
