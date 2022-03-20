#!/usr/bin/env bash

Ntest(){
    (( "$@" )) || return 1
}

Calc(){
    echo "$(( "$@" ))"
}
