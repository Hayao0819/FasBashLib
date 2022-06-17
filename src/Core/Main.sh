#!/usr/bin/env bash

EnvCheck(){
    case "$FSBLIB_REQUIRE" in
        "Any")
            return 0
            ;;
        "ModernShell")
            [[ "$(cut -d "." -f 1 <<< "$BASH_VERSION")" = "5" ]] && return 0
            ;;
    esac
}

FsblibEnvCheck(){
    @EnvCheck
}
