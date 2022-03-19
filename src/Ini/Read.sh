#!/usr/bin/env bash
# shellcheck disable=SC2034
# @file IniRead
# @brief Iniファイルを解析し、内容を出力します
# @description
#    Ini設定ファイルを読み取り、以下のものを出力します
#      - セクションの一覧
#      - パラメータの一覧
#      - 指定されたパラメータの値

#@internal
#@set TYPE    SECTION/PARAM-VALUE/NOTHING/ERROR
#@set PARAM   変数名
#@set VALUE   値
#@set SECTION セクション名
ParseLine(){
    local _Line #="$1"
    TYPE="" PARAM="" VALUE="" SECTION=""
    _Line="$(RemoveBlank <<< "$(cat)")"
    case "$_Line" in
        "["*"]")
            TYPE="SECTION"
            SECTION=$(sed "s|^\[||g; s|\]$||g" <<< "$_Line")
            ;;
        "" | "#"*)
            TYPE="NOTHING"
            ;;
        *"="*)
            TYPE="PARAM-VALUE"
            PARAM="$(RemoveBlank <<< "$(cut -d "=" -f 1 <<< "$_Line")")"
            VALUE="$(RemoveBlank <<< "$(cut -d "=" -f 2- <<< "$_Line")")"
            ;;
        *)
            TYPE="ERROR"
            ;;
    esac
    return 0
}


# @description Iniのセクションの一覧を取得します
# Iniファイルは標準入力から受け取ります。
#
# @example
#    cat config.ini | GetIniSectionList
#
# @noargs
#
# @stdout セクションのリストを返します
#
# @exitcode 0 正常に出力されました
# @exitcode 1 一部の行で解析に失敗しました
GetSectionList(){
    local _RawIniLine=()
    local _Line _LineNo=1 _Exit=0
    readarray -t _RawIniLine

    while read -r _Line;do
        @ParseLine <<< "$_Line"
        case "$TYPE" in
            "SECTION")
                echo "$SECTION"
                ;;
            "ERROR")
                echo "Line $_LineNo: Failed to parse Ini" >&2
                _Exit=1
                ;;
        esac
        _LineNo=$(( _LineNo + 1  ))
    done < <(PrintArray "${_RawIniLine[@]}")
    return "$_Exit"
}


# @description 指定されたセクション内のパラメータの一覧を表示します
# Iniファイルは標準入力から受け取ります。
#
# @example
#    cat chromium.desktop | GetIniParamList desktop
#
# @noargs
#
# @stdout パラメータのリストを返します
#
# @exitcode 0 正常に出力されました
# @exitcode 1 一部の行で解析に失敗しました
GetParamList(){
    local _RawIniLine=()
    local _Line _LineNo=1 _Exit=0 _InSection=false
    readarray -t _RawIniLine

    while read -r _Line;do
        @ParseLine <<< "$_Line"
        case "$TYPE" in
            "SECTION")
                ! [[ "$SECTION" = "$1" ]] || _InSection=true
                ;;
            "PARAM-VALUE")

                [[ "$_InSection" = false ]] || echo "$PARAM"
                ;;
            "ERROR")
                echo "Line $_LineNo: Failed to parse Ini" >&2
                _Exit=1
                ;;
        esac
        _LineNo=$(( _LineNo + 1  ))
    done < <(PrintArray "${_RawIniLine[@]}")
    return "$_Exit"
}
