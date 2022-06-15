#!/usr/bin/env bash
# shellcheck disable=SC1090,SC1091,SC2154

# shellcheck source=/dev/null
source "$(cd "$(dirname "${0}")/../" || exit 1 ; pwd)/lib/Common.sh"

while read -r File; do
    echo "RUN: rm -f \"$File\""
    rm -f "$File"
done < <("$BinDir/Test-Junk.sh")
