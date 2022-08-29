#!/usr/bin/env bash

EnvCheck(){
    case "$FSBLIB_REQUIRE" in
        "Any")
            return 0
            ;;
        "ModernShell")
            [ "$(echo "$BASH_VERSION" | cut -d "." -f 1)" = "5" ] && return 0
            ;;
    esac
    return 1
}

FsblibEnvCheck(){
    @EnvCheck
}

RequireLib(){
    local lib missing=() return=0
    for lib in "$@"; do
        if ! [[ "${FSBLIB_LIBLIST[*]}" == *" $lib "* ]]; then
            missing+=("$lib")
            return=1
        fi
    done
    return "$return"
}
