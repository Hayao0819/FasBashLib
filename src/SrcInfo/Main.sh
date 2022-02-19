#!/usr/bin/env bash

# shellcheck  disable=SC1091
source /dev/stdin < <(/home/hayao/Git/FasBashLib/bin/SingleFile.sh -out /dev/stdout Pacman Aur 2> /dev/null)

# ParseKeyValue Line
# ParseKeyValue Key
# ParseKeyValue Value
ParseKeyValue(){
    local _Output="${1-""}"
    [[ -n "${_Output}" ]] || return 1
    shift 1
    local _String _Key _Value
    _String="$(cat)"
    _Key="$(cut -d "=" -f 1 <<<  "$_String" | RemoveBlank)"
    _Value="$(cut -d "=" -f 2- <<< "$_String" | RemoveBlank)"
    case "$_Output" in
        "Line")
            echo "$_Key=$_Value"
            ;;
        "Key")
            echo "$_Key"
            ;;
        "Value")
            echo "$_Value"
            ;;
    esac
    return 0
}

FormatSrcInfo(){
    RemoveBlank | ForEach eval "ParseKeyValue Line <<< \"{}\"" 
}

GetSrcInfoKeyList(){
    FormatSrcInfo | cut -d "=" -f 1
}

GetSrcInfoSectionList(){
    FormatSrcInfo | grep -e "^pkgbase" -e "^pkgname"
}

# GetSrcInfoPkgBase
GetSrcInfoPkgBase(){
    local _Line _Key _InSection=false
    while read -r _Line; do
        _Key="$(ParseKeyValue Key <<< "$_Line")"
        case "$_Key" in
            "pkgbase")
                _InSection=true
                ;;
            "pkgname")
                _InSection=false
                ;;
            *)
                if [[ "${_InSection}" = true ]]; then
                    echo "$_Line"
                fi
                ;;
        esac
    done < <(FormatSrcInfo)
}

# GetSrcInfoPkgName <Name>
GetSrcInfoPkgName(){
    local _Line _Key _InSection=false _TargetPkgName="$1"
    while read -r _Line; do
        _Key="$(ParseKeyValue Key <<< "$_Line")"
        case "$_Key" in
            "pkgname")
                if [[ "$(ParseKeyValue Value <<< "$_Line")" = "$_TargetPkgName" ]]; then
                    _InSection=true
                else
                    _InSection=false
                fi
                ;;
            "pkgbase")
                _InSection=false
                ;;
            *)
                if [[ "${_InSection}" = true ]]; then
                    echo "$_Line"
                fi
                ;;
        esac
    done < <(FormatSrcInfo)
}

# Use it with GetSrcInfoPkgBase or GetSrcInfoPkgName
# 複数設定されるもの（dependsなど）は GetSrcInfoArrayを使用してください
GetSrcInfoValue(){
    :
}

GetSrcInfoPkgName fascode-gtk-bookmarks
