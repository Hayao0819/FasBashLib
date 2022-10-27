#!/usr/bin/env bash

# 質問を行う関数
# Returns only the selected result to standard output
# Choice -n -d <デフォルト値> -p <質問文> <選択肢1> <選択肢2> ...
# -n: Return with number
Choice(){
    local arg OPTARG OPTIND #getopts
    local  _count _choice # forループ用変数
    local _default="" _question="" _returnstr="" _mark=" " #文字列
    local _count=0 _digit=0 _returnint= #整数値
    local _number=false #Bool値
    local _choice_list=() #配列

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
    _choice_list=("${@}") _digit="${##}"

    # 選択肢が1つもない場合
    (( ${#_choice_list[@]} <= 0 )) && echo "An exception error has occurred." >&2 && exit 1
    # 選択肢が1つの場合→結果を出力して終了
    (( ${#_choice_list[@]} == 1 )) && _returnint="${_returnint:="1"}" _returnstr="${_returnstr:="${_choice_list[*]}"}"

    # 質問文が定義されているなら表示
    [[ -n "${_question-""}" ]] && echo "   ${_question}" >&2

    # 選択肢を表示
    for (( _count=1; _count<=${#_choice_list[@]}; _count++)); do
        # _choice: 選択肢の文字列 _mark: 選択肢の左がわに表示される記号
        _choice="${_choice_list[$(( _count - 1 ))]}" _mark=" "
        # 選択肢がデフォルト値なら左側に記号をつける
        { [[ ! "${_default}" = "" ]] && [[ "${_choice}" = "${_default}" ]]; } && _mark="*"
        # 選択肢を表示
        printf " ${_mark} %${_digit}d: ${_choice}\n" "${_count}" >&2
    done

    # プロンプトを表示
    echo -n "   (1 ~ ${#_choice_list[@]}) > " >&2 && read -r _input

    # 入力された文字が空で、デフォルト値が設定されている場合に、返す値をデフォルト値に設定する
    { [[ -z "${_input-""}" ]] && [[ -n "${_default-""}" ]]; } && _returnint="${_returnint:="0"}" _returnstr="${_returnstr:="${_default}"}"

    # 入力されたのが整数値かつ、値が選択肢の範囲なら、その数値に対応する選択肢を返す値に設定する
    { printf "%s" "${_input}" | grep -qE "^[0-9]+$" && (( 1 <= _input)) && (( _input <= ${#_choice_list[@]} )); } && _returnint="${_returnint:="${_input}"}" _returnstr="${_returnstr:="${_choice_list[$(( _input - 1 ))]}"}"

    # 入力されたのが文字列なら、該当する選択肢を探す
    for (( i=0; i <= ${#_choice_list[@]} - 1 ;i++ )); do
        [[ "${_choice_list["${i}"],,}" = "${_input,,}" ]] && _returnint="${_returnint:="$(( i + 1 ))"}" _returnstr="${_returnstr:="${_choice_list["${i}"]}"}"
    done

    # 返り値が設定されている場合、結果を出力後、終了
    { [[ "${_number}"  = true ]] && [[ -n "${_returnint:-""}" ]]; } && { echo "${_returnint}" && return 0 ;}
    { [[ "${_number}" = false ]] && [[ -n "${_returnstr:-""}" ]]; } && { echo "${_returnstr}" && return 0 ;}

    # ここまでで、返り値が設定されていない場合
    # 該当する選択肢が存在しなかった場合
    # デフォルト値が設定されず、何も入力されなかった場合
    return 1
}


ChoiceLoop(){
    while true; do
        if Choice "$@"; then
            break
        fi
    done
}

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
