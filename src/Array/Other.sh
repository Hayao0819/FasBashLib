#!/usr/bin/env bash

# Array.Includes "namelist" "hayao"
Includes(){
    PrintEvalArray "$1" | grep -qx "$2"
}


# Array.ForEach namelist echo "{}"
ForEach(){
    # shellcheck disable=SC2264
    PrintEvalArray "$1" | ForEach "${@:2}"
}
