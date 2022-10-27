#!/bin/sh

ClearUpperLines(){
    # shellcheck disable=SC2034
    for i in $(seq 1 "$1"); do
        @MoveCursorUp 1
        @ClearLine
    done
}

ClearLineAndReturn(){
    @ClearLine
    @Return
}
