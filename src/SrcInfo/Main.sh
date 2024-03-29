#!/usr/bin/env bash
#shellcheck disable=SC2034

# @Parse Line
# @Parse Key
# @Parse Value
Parse(){
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

Format(){
    RemoveBlank | sed "/^$/d" | grep -v "^#" | ForEach eval "@Parse Line <<< \"{}\"" 
}

GetKeyList(){
    @Format | cut -d "=" -f 1
}

GetSectionList(){
    @Format | grep -e "^pkgbase" -e "^pkgname"
}

GetPkgBase(){
    local _Line _Key _InSection=false
    while read -r _Line; do
        _Key="$(@Parse Key <<< "$_Line")"
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
    done < <(@Format)
}

GetPkgName(){
    local _Line _Key _InSection=false _TargetPkgName="$1"
    while read -r _Line; do
        _Key="$(@Parse Key <<< "$_Line")"
        case "$_Key" in
            "pkgname")
                if [[ "$(@Parse Value <<< "$_Line")" = "$_TargetPkgName" ]]; then
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
    done < <(@Format)
}

# @GetValueInPkgBase <Key>
# Support key: pkgver, pkgrel, epoch
GetValueInPkgBase(){
    local _Line
    while read -r _Line; do
        _Key="$(@Parse Key <<< "$_Line")"
        case "$_Key" in
            "$1")
                @Parse Value <<< "$_Line"
                ;;
        esac
    done < <(@GetPkgBase)
}

#@GetValueInPkgName <PkgName> <Key>
GetValueInPkgName(){
    local _Line
    while read -r _Line; do
        _Key="$(@Parse Key <<< "$_Line")"
        case "$_Key" in
            "$2")
                @Parse Value <<< "$_Line"
                ;;
        esac
    done < <(@GetPkgName "$1")
}

# @GetValue <Key> <PkgName> <Arch1,Arch2>
GetValue(){
    local _SrcInfo=()
    local _Output=()
    local _PkgBaseValues=("pkgver" "pkgrel" "epoch")
    local _AllValues=("pkgdesc" "url" "install" "changelog")
    local _AllArrays=("arch" "groups" "license" "noextract" "options" "backup" "validpgpkeys")
    local _AllArraysWithArch=("source" "depends" "checkdepends" "makedepends" "optdepends" "provides" "conflicts" "replaces" "md5sums" "sha1sums" "sha224sums" "sha256sums" "sha384sums" "sha512sums")

    # stdinから取得
    ArrayAppend _SrcInfo
    
    # PkgBase内で1度だけ指定可能
    ArrayIncludes _PkgBaseValues "$1" && {
        PrintEvalArray _SrcInfo | @GetValueInPkgBase "$1" 
        return 0
    }

    # 全てのセクション内で1度もしくは複数指定可能
    [[ -n "${2-""}" ]] || {
        echo "No pkgname or pkgbase is specified" >&2
        return 1
    }
    if ArrayIncludes _AllValues "$1" || ArrayIncludes _AllArrays "$1"; then
        ArrayAppend _Output < <(PrintEvalArray _SrcInfo | @GetValueInPkgBase "$1")
        ArrayAppend _Output < <(PrintEvalArray _SrcInfo | @GetValueInPkgName "$2" "$1")
        PrintArray "${_Output[@]}" | tail -n 1
        return 0
    fi

    # 予期しないキーの場合は異常終了する
    ArrayIncludes _AllArraysWithArch "$1" || return 1

    # 全てのセクション内で複数指定可能かつアーキテクチャごとの設定が可能
    local _Arch _ArchList=()
    if [[ -z "${3-""}" ]]; then
        ArrayAppend _ArchList < <(PrintEvalArray _SrcInfo | @GetValue arch "$2")
    else
        ArrayAppend _ArchList < <(tr "," "\n" <<< "$3" | RemoveBlank)
    fi
    ArrayAppend _Output < <(PrintEvalArray _SrcInfo | @GetValueInPkgBase "$1")
    ArrayAppend _Output < <(PrintEvalArray _SrcInfo | @GetValueInPkgName "$2" "$1")
    for _Arch in "${_ArchList[@]}"; do
        ArrayAppend _Output < <(PrintEvalArray _SrcInfo | @GetValueInPkgBase "$1_${_Arch}")
        ArrayAppend _Output < <(PrintEvalArray _SrcInfo | @GetValueInPkgName "$2" "$1_${_Arch}")
    done
    PrintEvalArray _Output
    return 0
}
