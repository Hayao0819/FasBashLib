#!/usr/bin/env bash

# 矢印キーで選択できるメニュー
# Returns only the selected result to standard output
# SelectMenu -n -d <デフォルト値> -p <質問文> <選択肢1> <選択肢2> ...
# -n: Return with number
SelectMenu(){
    local arg OPTARG OPTIND #getopts
    local Choices=() CurrentChoice=0 Key=""
    local _question="" _default="" _number=false

    # 引数を解析
    while getopts "ad:p:n" arg; do
        case "${arg}" in
            d) _default="${OPTARG}" ;;
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
    [[ "${#Choices[@]}" -eq 1 ]] && { echo "${Choices[0]}" && return 0 ;}

    # デフォルト設定
    if [[ -n "$_default" ]] && Array.Include Choices "$_default"; then
        CurrentChoice="$(Array.Eval Choices | Array.IndexOf "$_default")"
    fi

    # プロンプト
    if [[ -n "$_question" ]]; then
        echo "$_question" >&2
    fi
    
    # メイン処理
    while [[ "$Key" != "Enter" ]]; do
        # メニューを表示
        for i in "${!Choices[@]}"; do
            if [[ "$i" = "$CurrentChoice" ]]; then
                Esc.Bold && Esc.Underline
                echo " > $i: ${Choices[$i]}" >&2
            else
                #Esc.LowIntensity
                echo "   $i: ${Choices[$i]}" >&2
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
        esac

        # メニューを削除
        Esc.ClearUpperLines "${#Choices[@]}"
    done 

    # 質問を削除
    if [[ -n "$_question" ]]; then
        Esc.ClearUpperLines 1
    fi

    if [[ "$_number" = true ]]; then
        echo "$CurrentChoice"
    else
        echo "${Choices[$CurrentChoice]}"
    fi
    return 0
}
