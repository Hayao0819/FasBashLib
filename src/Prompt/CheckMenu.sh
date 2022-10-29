#!/usr/bin/env bash

CheckMenu(){
    local arg OPTARG OPTIND #getopts
    local Choices=() CurrentSelected=() Key="" CurrentChoice=0
    local _question="" _number=false _selected=()

    # 引数を解析
    while getopts "s:p:n" arg; do
        case "${arg}" in
            s) _selected+=("${OPTARG}") ;;
            p) _question="${OPTARG}" ;;
            n) _number=true ;;
            *) exit 1 ;;
        esac
    done

    # 解析済みの引数
    shift "$((OPTIND - 1))" || return 1
    Choices=("$@")

    # 例外処理
    [[ "${#Choices[@]}" -eq 0 ]] && return 1
    #[[ "${#Choices[@]}" -eq 1 ]] && { echo "${Choices[0]}" && return 0 ;}

    # デフォルト設定
    for i in "${!_selected[@]}"; do
        if Array.Include Choices "${Choices[$i]}"; then
            CurrentSelected+=("$i")
        fi
    done

    # プロンプト
    if [[ -n "$_question" ]]; then
        echo "$_question" >&2
    fi
    
    # メイン処理
    while [[ "$Key" != "Enter" ]]; do
        # メニューを表示
        for i in "${!Choices[@]}"; do
            [[ "$i" = "$CurrentChoice" ]] && { Esc.Bold && Esc.Underline; }
            #if Array.Include CurrentSelected "$i"; then
            if [[ "${CurrentSelected[*]}" =~ $i ]]; then
                echo " [X] $i: ${Choices[$i]}" >&2
            else
                echo " [ ] $i: ${Choices[$i]}" >&2
            fi
            Esc.ResetStyle
        done

        # キー検知
        Key="$(CaptureSpecialKeys)"
        case "$Key" in
            Up)
                (( "$CurrentChoice" != 0 )) && CurrentChoice=$((CurrentChoice - 1))
                ;;
            Down)
                (( "$CurrentChoice" != "${#Choices[@]}" - 1 )) && CurrentChoice=$((CurrentChoice + 1))
                ;;
            Space)
                if Array.Include CurrentSelected "$CurrentChoice"; then
                    Array.Remove CurrentSelected "$CurrentChoice"
                else
                    CurrentSelected+=("$CurrentChoice")
                fi
                ;;
        esac

        # メニューを削除
        Esc.ClearUpperLines "${#Choices[@]}"
    done 

    # 質問を削除
    if [[ -n "$_question" ]]; then
        Esc.ClearUpperLines 1
    fi

    if [[ "$_number" = true ]]; then
        Array.Eval CurrentSelected
    else
        # shellcheck disable=SC2016
        Array.ForEach CurrentSelected eval 'echo ${Choices[{}]}'
    fi
    return 0
}

