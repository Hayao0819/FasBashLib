#!/usr/bin/env bash

set -Eeu

if [[ "${1-""}" = "-h" ]]; then
    echo "Usage: GetLink.sh [Tag]"
    exit 0
fi

Release="${1-""}"

if [[ -z "$Release" ]]; then
    curl -sL "https://api.github.com/repos/hayao0819/fasbashlib/releases/latest" | jq -r ".assets[].browser_download_url"
else
    Status="$(curl -sL -o /dev/null -w '%{http_code}\n' "https://api.github.com/repos/hayao0819/fasbashlib/releases/tags/${Release}")"
    (( Status == 200 )) || {
        echo "${Release}: No such tag was found"
        exit 1
    }
    curl -sL "https://api.github.com/repos/hayao0819/fasbashlib/releases" | jq -r ".[] | select(.tag_name == \"${Release}\") | .assets[].browser_download_url"
fi
