#!/usr/bin/env bash
# shellcheck disable=all

# 今後マルチカラムな選択メニューを作るときに参考になるかもしれない

Table(){
    local Choices=("$@") CurrentChoice=0 Key=""
    local Column=5 BoxSize=0 CurrentLineItems=0
    BoxSize="$(( "$(Array.Print "$@" | GetMaxWidth)" + 2 ))"

    local i
    for i in "${!Choices[@]}"; do
        # 一番長い文字列の長さに合わせて文字列を整形
        local _str="${Choices[$i]}"
        local _space="$(( BoxSize - "${#_str}" ))"
        echo -n "${_str}$(yes " " | head -n "$_space" | tr -d "\n")"
        (( (i + 1) % 5 == 0 )) && echo
    done
}
