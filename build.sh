#!/usr/bin/env bash
# shellcheck disable=SC1090

# Init
CurrentDir="$(cd "$(dirname "${0}")" || exit 1 ; pwd)"
OutFile="${1-"${CurrentDir}/fasbashlib.sh"}"
TmpFile="/tmp/fasbashlib.sh"

# Ccnfigure dir
SrcDir="$CurrentDir/src"
StaticDir="$CurrentDir/static"
LibDir="$CurrentDir/lib"

# Load src
for file in "${SrcDir}/"*".sh"; do
    echo "Load: $file"
    source "$file"
done

# Output to temp
cat "$StaticDir/head.sh" > "$TmpFile"
typeset -f >> "$TmpFile"

# Minify
bash "$LibDir/minifier/Minify.sh" -f="$TmpFile" > "$OutFile"
