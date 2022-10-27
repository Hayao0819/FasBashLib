#!/usr/bin/env bash

MoveCursor(){
    printf "\033[%d;%dH" "$1" "$2" > /dev/tty
}
MoveCursorUp(){
    printf "\033[%dA" "$1" > /dev/tty
}
MoveCursorDown(){
    printf "\033[%dB" "$1" > /dev/tty
}
MoveCursorRight(){
    printf "\033[%dC" "$1" > /dev/tty
}
MoveCursorLeft(){
    printf "\033[%dD" "$1" > /dev/tty
}
GetX(){
    local _POS
    printf "\033[6n" >> /dev/tty
    #shellcheck disable=SC2034
    read -r -s -d "R" _POS
    echo $(( "$(printf "%s\n" "${_POS:2}" | cut -d";" -f2)" - 1))
}

GetY(){
    local _POS
    printf "\033[6n" >> /dev/tty
    #shellcheck disable=SC2034
    read -r -s -d "R" _POS
    echo $(( "$(printf "%s\n" "${_POS:2}" | cut -d";" -f1)" - 1))
}

GetTermX(){
    [[ -n ${COLUMNS-""} ]] && echo "$COLUMNS" && return 0
    tput cols
}

GetTermY(){
    [[ -n ${LINES-""} ]] && echo "$LINES" && return 0
    tput lines
}
