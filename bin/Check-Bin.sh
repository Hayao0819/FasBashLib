#!/usr/bin/env bash
# shellcheck disable=SC2154

# shellcheck source=/dev/null
source "$(cd "$(dirname "${0}")/../" || exit 1 ; pwd)/lib/Common.sh"

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
