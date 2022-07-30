#!/bin/sh

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
