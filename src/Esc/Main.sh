#!/usr/bin/env bash


# 参考文献
# http://7ujm.net/etc/esc.html
# https://zariganitosh.hatenablog.jp/entry/20150224/escape_sequence
# https://www.mm2d.net/main/prog/c/console-02.html
# https://qiita.com/PruneMazui/items/8a023347772620025ad6
# https://gist.github.com/shinyaoguri/782adf1c6765dba0717745578aa9c85f

ClearScreen(){
    printf "\033[2J"
}
ClearRight(){
    printf "\033[0K"
}
ClearLeft(){
    printf "\033[1K"
}
ClearLine(){
    printf "\033[2K"
}
MoveCursor(){
    printf "\033[%d;%dH" "$1" "$2"
}
MoveCursorUp(){
    printf "\033[%dA" "$1"
}
MoveCursorDown(){
    printf "\033[%dB" "$1"
}
MoveCursorRight(){
    printf "\033[%dC" "$1"
}
MoveCursorLeft(){
    printf "\033[%dD" "$1"
}
ResetStyle(){
    printf "\033[0m"
}

ClearUpperLines(){
    # shellcheck disable=SC2034
    for i in $(seq 1 "$1"); do
        @MoveCursorUp 1
        @ClearLine
    done
}
