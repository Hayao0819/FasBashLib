#!/usr/bin/env bash
# shellcheck disable=SC1090,SC1091,SC2154

# shellcheck source=/dev/null
source "$(cd "$(dirname "${0}")/../" || exit 1 ; pwd)/lib/Common.sh"

# Temp
TmpDir="$(mktemp -d -t "fasbashlib.XXXXX")"
OutDir="$MainDir/out"

TmpDocs="${TmpDir}/docs"
TmpUpper="${TmpDir}/upper"
TmpSnake="${TmpDir}/snake"
TmpLower="${TmpDir}/lower"

mkdir -p "$TmpDir" "$OutDir"

# Document
"${BinDir}/Build-Docs.sh" -out "$TmpDocs"
zip "$OutDir/fasbashlib-document.zip" "${TmpDocs}/"*

# Upper
"${BinDir}/Build-Multi.sh" -out "$TmpUpper"
zip "$OutDir/fasbashlib.zip" "${TmpUpper}/"*

# Lower
"${BinDir}/Build-Multi.sh" -out "$TmpLower" -- -lower
zip "$OutDir/fasbashlib-lower.zip" "${TmpLower}/"*

# Snake
"${BinDir}/Build-Multi.sh" -out "$TmpSnake" -- -snake
zip "$OutDir/fasbashlib-snake.zip" "${TmpSnake}/"*
