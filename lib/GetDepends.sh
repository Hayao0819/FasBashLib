#!/usr/bin/env bash

set -Eeu

MainDir="$(cd "$(dirname "${0}")/../" || exit 1 ; pwd)"
LibDir="$MainDir/lib"

if (( $# < 1 )); then
    echo "Usage: $(basename "$0") LibName"
    exit 1
fi

while read -r Lib; do
    "$LibDir/GetMeta.sh" "$Lib" Depends | tr "," "\n"
done < <("$LibDir/SolveRequire.sh" "$1") | sort | uniq | grep -v "^$" || true
