#!/usr/bin/env bash
set -Eeu

# shellcheck source=/dev/null
source /dev/stdin < <(
    fasbashlib 2> /dev/null || curl -sL https://raw.githubusercontent.com/Hayao0819/FasBashLib/build-dev/fasbashlib.sh
)

ExampleArray=("Hello" "FasBashLib!")

IsAvailable "cowsay" || {
    Msg.Err "Please install cowsay"
    exit 1
}

PrintArray "${ExampleArray[@]}" | ForEach "cowsay" "{}"
