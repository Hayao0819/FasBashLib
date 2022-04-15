#!/usr/bin/env bash
# shellcheck disable=SC1090,SC1091

set -Eeu

# Directory
MainDir="$(cd "$(dirname "${0}")/../" || exit 1 ; pwd)"
SrcDir="$MainDir/src"
LibDir="$MainDir/lib"
BinDir="$MainDir/bin"
TestDir="$MainDir/tests"


RemoveFile(){
    echo "Remove $1" >&2
    rm -rf "$1"
}

# Remove empty file
while read -r File; do
    # shellcheck disable=SC2143
    if [[ -z "$(grep -v "^$" "$File" | grep -v "^#")" ]]; then
        RemoveFile "$File"
    fi
done < <(find "${TestDir}" -type f)
