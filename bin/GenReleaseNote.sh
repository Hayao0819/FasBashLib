#!/usr/bin/env bash

MainDir="$(cd "$(dirname "${0}")/../" || exit 1 ; pwd)"
StaticDir="$MainDir/static"
BinDir="$MainDir/bin"
TargetTag="${1-""}"

# Check git
if [[ ! -e "${MainDir}/.git" ]]; then
    echo "Please use $0 with git clone" >&2
    exit 1
fi

# Check args
echo "対象のタグは${TargetTag}です。" >&2
[[ -n "$TargetTag" ]] || {
    echo "Usage: $0 Tag" >&2
    exit 1
}

# Check Tag
git tag | grep -qx "$TargetTag" || {
    echo "No such tag found" >&2
    exit 1
}

# Set variables
BeforeTag="$(git tag | grep -B 1 -x -- "${TargetTag}" | head -n 1)"
SourceURL=$("$BinDir/GetLink.sh" "$TargetTag" | grep "fasbashlib.sh$")
SourceURL_Snake=$("$BinDir/GetLink.sh" "$TargetTag" | grep "fasbashlib-snake.sh$")
TempFile="$(mktemp)"

# Log
echo "1つ前のタグは${BeforeTag}です。" >&2
echo "ソースは\"${SourceURL}\"です。" >&2

# Replaces
SedCode="s|%SOURCEURL%|${SourceURL}|g; s|%TAG%|${TargetTag}|g; s|%SNAKESOURCEURL%|${SourceURL_Snake}|g"

# %SOURCEURL% は リリースのURLへ置き換えられます
if [[ -e "$StaticDir/release-head.md" ]]; then
    sed "${SedCode}" "$StaticDir/release-head.md" >> "$TempFile"
fi
git log --pretty="%h - %s (%an)" "$BeforeTag".."$TargetTag" >> "$TempFile"
if [[ -e "$StaticDir/release-tail.md" ]]; then
    sed "${SedCode}" "$StaticDir/release-tail.md" >> "$TempFile"
fi

# 一時ファイルをオープン
cat "$TempFile"
rm -rf "$TempFile"
