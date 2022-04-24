#!/usr/bin/env bash
# shellcheck disable=SC2154

# shellcheck source=/dev/null
source "$(cd "$(dirname "${0}")/../" || exit 1 ; pwd)/lib/Common.sh"
TargetTag="${1-""}"
HasSnakeCase=true

# Check git
if [[ ! -e "${MainDir}/.git" ]]; then
    echo "Please use $0 with git clone" >&2
    exit 1
fi

# Check args
[[ -n "${TargetTag}" ]] || {
    echo "Usage: $0 Tag" >&2
    exit 1
}
echo "対象のタグは${TargetTag}です。" >&2

# Check Tag
git tag | grep -qx "$TargetTag" || {
    echo "No such tag found" >&2
    exit 1
}

# Set variables
CurrentBranch="$(git rev-parse --abbrev-ref HEAD)"
HeadCommitID="$(git rev-parse HEAD)"
BeforeTag="$(git tag | grep -B 1 -x -- "${TargetTag}" | head -n 1)"
SourceURL="$("$BinDir/Release-Link.sh" "$TargetTag" | grep "fasbashlib.sh$")"
SourceURL_Snake="$("$BinDir/Release-Link.sh" "$TargetTag" | grep "fasbashlib-snake.sh$")" || HasSnakeCase=false
TempFile="$(mktemp)"

# Log
echo "1つ前のタグは${BeforeTag}です。" >&2
echo "ソースは\"${SourceURL}\"です。" >&2

# Replaces
SedArgs=(
    -e "s|%SOURCEURL%|${SourceURL}|g" 
    -e "s|%TAG%|${TargetTag}|g"
)

if [[ "${HasSnakeCase}" = true ]]; then
    SedArgs+=(-e "s|%SNAKESOURCEURL%|${SourceURL_Snake}|g")
else
    SedArgs+=(-e "s|%SNAKESOURCEURL%||g")
fi

# Checkout
echo "Checkout to Target source code" >&2
git checkout "$TargetTag" 2> /dev/null || {
    echo "Failed to checkout to target."
    git checkout "$TargetTag" || true
    exit 1
}

# %SOURCEURL% は リリースのURLへ置き換えられます
if [[ -e "$StaticDir/release-head.md" ]]; then
    sed "${SedArgs[@]}" "$StaticDir/release-head.md" >> "$TempFile"
fi
git log --pretty="%h - %s (%an)" "$BeforeTag".."$TargetTag" >> "$TempFile"
if [[ -e "$StaticDir/release-tail.md" ]]; then
    sed "${SedArgs[@]}" "$StaticDir/release-tail.md" >> "$TempFile"
fi

# 一時ファイルをオープン
cat "$TempFile"
rm -rf "$TempFile"

# Checkout
if [[ "$CurrentBranch" = "HEAD" ]]; then
    git checkout "$HeadCommitID" > /dev/null 2>&1
else
    git checkout "$CurrentBranch" > /dev/null 2>&1
fi
