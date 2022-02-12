#!/usr/bin/env bash

CheckPacmanPkg(){
    local p
    for p in "$@"; do
        pacman -Qq "$p" || return 1
    done
    return 0
}

