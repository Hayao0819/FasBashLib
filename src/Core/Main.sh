#!/usr/bin/env bash

FsblibEnvCheck(){
    case "$FSBLIB_REQUIRE" in
        "Any")
            return 0
            ;;
        "ModernShell")
            [[ "$(cut -d "." -f 1 <<< "$BASH_VERSION")" = "5" ]] && return 0
            ;;
    esac
}
