#!/usr/bin/env bash

CaptureSpecialKeys(){
    local SELECTION rest

    IFS= read -r -n1 -s SELECTION
    if [[ $SELECTION == $'\x1b' ]]; then
        read -r -n2 -s rest
        SELECTION+="$rest"
    else
        case "$SELECTION" in
            "")
                echo "Enter"
                ;;
            $'\x7f')
                echo "Backspace"
                ;;
            $'\x20')
                echo "Space"
                ;;
            *)
                read -i "$SELECTION" -e -r rest
                echo "$rest"
                ;;
        esac
        return 0
    fi

    case $SELECTION in
        # backspace 
        $'\x1b\x5b\x41') #up arrow
            echo "Up"
            ;;
        $'\x1b\x5b\x42') #down arrow
            echo "Down"
            ;;
        $'\x1b\x5b\x43') #right arrow
            echo "Right"
            ;;
        $'\x1b\x5b\x44') #left arrow
            echo "Left"
            ;;
    esac
}
