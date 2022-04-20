#!/usr/bin/env bash

set -Eeu

MainDir="$(cd "$(dirname "${0}")/../" || exit 1 ; pwd)"
BinDir="$MainDir/bin"
Errors=0

for File in "$BinDir/"*".sh"; do
    echo "Run shell check $File" >&2
    shellcheck -s bash "$File" || Errors=$(( Errors + 1 ))
done

if (( Errors == 0 )); then
    exit 0
else
    echo "$Errors つのエラーが見つかりました" >&2
    exit 1
fi
