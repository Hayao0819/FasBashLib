#!/usr/bin/env bash
set -Eeu
source /dev/stdin < <(curl -sL https://raw.githubusercontent.com/Hayao0819/FasBashLib/build-dev/fasbashlib.sh)

ExampleArray=("Hello" "FasBashLib!")

IsAvailable "cowsay" || {
    MsgErr "Please install cowsay"
    exit 1
}

PrintArray "${ExampleArray[@]}" | ForEach "cowsay" "{}"
