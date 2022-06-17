#!/usr/bin/env bash

set -Eeu

LatestOnly=false

if [[ "${1-""}" = "-h" ]]; then
    echo "Usage: GetLink.sh [Tag]"
    exit 0
fi

if [[ "${1-""}" = "-latest" ]]; then
    LatestOnly=true
fi

if [[ "${LatestOnly}" = true ]]; then
    head -n 1
else
    cat
fi < <(curl -sL "https://api.github.com/repos/hayao0819/fasbashlib/releases" | jq -r ".[].tag_name")
