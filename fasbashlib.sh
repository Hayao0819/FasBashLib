#!/usr/bin/env bash
# shellcheck disable=all
AurInfoToBash () 
{ 
    local _Prefix="${AurPrefix-"{}"}" _Json;
    local _ArrName _VarName;
    _Json="$(cat)";
    for _JsonKey in "Depends" "Keywords" "License" "MakeDepends" "OptDepends";
    do
        _ArrName=$(sed "s|{}|$_JsonKey|g" <<< "$_Prefix");
        echo "${_ArrName}=($(Get$_JsonKey <<< "$_Json" | sed "s|^|\"|g; s|$|\" |g" | tr -d "\n"))";
    done;
    for _JsonKey in "Description" "FirstSubmitted" "ID" "LastModified" "Maintainer" "NumVotes" "PackageBase" "PackageBaseID" "Popularity" "URL" "URLPath" "Version";
    do
        _VarName=$(sed "s|{}|$_JsonKey|g" <<< "$_Prefix");
        echo "${_VarName}=\"$(Get$_JsonKey <<< "$_Json")\"";
    done
}
CheckAurJson () 
{ 
    local _ResultCount _Json _Type;
    _Json="$(cat)";
    _ResultCount=$(jq -r ".resultcount" <<< "$_Json");
    _Type=$(jq -r ".type" <<< "$_Json");
    (( _ResultCount > 0 )) && [[ "$_Type" != "error" ]] && { 
        jq -r ".results[]" <<< "$_Json";
        return 0
    };
    return 1
}
CheckFunctionDefined () 
{ 
    typeset -f "${1}" > /dev/null
}
CheckPacmanPkg () 
{ 
    local p;
    for p in "$@";
    do
        RunPacman -Qq "$p" || return 1;
    done;
    return 0
}
CsvToBashArray () 
{ 
    local _RawCsvLine=() _Line _ClmCnt=0;
    local ArrayPrefix="${ArrayPrefix-"{}"}";
    readarray -t _RawCsvLine < <(
        # 標準入力からCSVのみを抽出
        while read -r _Line; do
            (( $(tr "," "\n" <<< "$_Line" | wc -l) >= ${#} )) && echo "$_Line"
        done < <(grep -v "^#")
    );
    _ClmCnt=$(PrintArray "${_RawCsvLine[@]}" | GetCsvColumnCnt);
    while read -r _Cnt; do
        readarray -t "$(sed "s|{}|$(eval "echo \"\${${_Cnt}}\"")|g" <<< "$ArrayPrefix")" < <(
            PrintArray "${_RawCsvLine[@]}" | cut -d "," -f "$_Cnt"
        );
    done < <(seq 1 "$#")
}
CutLastString () 
{ 
    echo "${1%%"${2}"}";
    return 0
}
FileType () 
{ 
    file --mime-type -b "$1"
}
ForEach () 
{ 
    local _Item _Cmd _C;
    while read -r _Item; do
        for _C in "$@";
        do
            _Cmd+=("$(sed "s|{}|${_Item}|g" <<< "$_C")");
        done;
        "${_Cmd[@]}" || return 1;
        _Cmd=();
    done
}
GetAurDepends () 
{ 
    jq -r ".Depends[]"
}
GetAurDescription () 
{ 
    jq -r ".Description"
}
GetAurFirstSubmitted () 
{ 
    jq -r ".FirstSubmitted"
}
GetAurID () 
{ 
    jq -r ".ID"
}
GetAurInfo () 
{ 
    local _Pkg="$1" _Json;
    curl -sL "https://aur.archlinux.org/rpc?v=5&type=info&arg=${_Pkg}" | CheckAurJson
}
GetAurKeywords () 
{ 
    jq -r ".Keywords[]"
}
GetAurLastModified () 
{ 
    jq -r ".LastModified"
}
GetAurLicense () 
{ 
    jq -r ".License[]"
}
GetAurMaintainer () 
{ 
    jq -r ".Maintainer"
}
GetAurMakeDepends () 
{ 
    jq -r ".MakeDepends[]"
}
GetAurNumVotes () 
{ 
    jq -r ".NumVotes"
}
GetAurOptDepends () 
{ 
    jq -r ".OptDepends[]"
}
GetAurPackageBase () 
{ 
    jq -r ".PackageBase"
}
GetAurPackageBaseID () 
{ 
    jq -r ".PackageBaseID"
}
GetAurPopularity () 
{ 
    jq -r ".Popularity"
}
GetAurSearch () 
{ 
    local _Field="${1-"name-desc"}" _Keywords="$2";
    curl -sL "https://aur.archlinux.org/rpc?v=5&type=search&by=$_Field&arg=${_Keywords}" | CheckAurJson
}
GetAurURL () 
{ 
    jq -r ".URL"
}
GetAurURLPath () 
{ 
    jq -r ".URLPath"
}
GetAurVersion () 
{ 
    jq -r ".Version"
}
GetBaseName () 
{ 
    xargs -L 1 basename
}
GetCsvColumnCnt () 
{ 
    local _RawCsvLine=();
    local _Line _ClmCnt=0;
    readarray -t _RawCsvLine;
    while read -r _Line; do
        grep -qE "^#" <<< "$_Line" && continue;
        _CurrentClmCnt=$(tr "," "\n" | wc -l);
        (( _CurrentClmCnt > _ClmCnt )) && _ClmCnt="$_CurrentClmCnt";
    done < <(PrintArray "${_RawCsvLine[@]}");
    RemoveBlank <<< "$_ClmCnt";
    return 0
}
GetFileExt () 
{ 
    GetBaseName | rev | cut -d "." -f 1 | rev
}
GetIniParamList () 
{ 
    local _RawIniLine=();
    local _Line _LineNo=1 _Exit=0 _InSection=false;
    readarray -t _RawIniLine;
    while read -r _Line; do
        ParseIniLine <<< "$_Line";
        case "$TYPE" in 
            "SECTION")
                ! [[ "$SECTION" = "$1" ]] || _InSection=true
            ;;
            "PARAM-VALUE")
                [[ "$_InSection" = false ]] || echo "$PARAM"
            ;;
            "ERROR")
                echo "Line $_LineNo: Failed to parse Ini" 1>&2;
                _Exit=1
            ;;
        esac;
        _LineNo=$(( _LineNo + 1  ));
    done < <(PrintArray "${_RawIniLine[@]}");
    return "$_Exit"
}
GetIniSectionList () 
{ 
    local _RawIniLine=();
    local _Line _LineNo=1 _Exit=0;
    readarray -t _RawIniLine;
    while read -r _Line; do
        ParseIniLine <<< "$_Line";
        case "$TYPE" in 
            "SECTION")
                echo "$SECTION"
            ;;
            "ERROR")
                echo "Line $_LineNo: Failed to parse Ini" 1>&2;
                _Exit=1
            ;;
        esac;
        _LineNo=$(( _LineNo + 1  ));
    done < <(PrintArray "${_RawIniLine[@]}");
    return "$_Exit"
}
GetLine () 
{ 
    head -n "$1" | tail -n 1
}
GetPacmanConf () 
{ 
    LANG=C pacman-conf --config="${PACMAN_CONF-"/etc/pacman.conf"}" "$@"
}
GetPacmanInstalledPkgVer () 
{ 
    ForEach pacman -Qq "{}" | cut -d " " -f 2;
    PrintArray "${PIPESTATUS[@]}" | grep -qx "1" && return 1;
    return 0
}
GetPacmanKeyringDir () 
{ 
    local _KeyringDir="";
    _KeyringDir="$(LANG=C pacman-key -h | RemoveBlank | grep -A 1 -- "^--populate" | tail -n 1 | cut -d "/" -f 2-)";
    : "${_KeyringDir="usr/share/pacman/keyrings"}";
    echo "$(GetPacmanRoot)/$_KeyringDir"
}
GetPacmanKeyringList () 
{ 
    find "$(GetPacmanKeyringDir)" -name "*.gpg" | GetBaseName | RemoveFileExt
}
GetPacmanLatestPkgVer () 
{ 
    local _LANG="${LANG-""}";
    export LANG=C;
    ForEach RunPacman -Si "{}" | grep "^Version" | cut -d ":" -f 2 | RemoveBlank;
    [[ -n "$_LANG" ]] && export LANG="$_LANG";
    return 0
}
GetPacmanRepoConf () 
{ 
    ForEach eval 'echo [{}] && GetPacmanConf -r {}'
}
GetPacmanRepoListFromConf () 
{ 
    GetPacmanConf --repo-list
}
GetPacmanRepoListFromLocalDb () 
{ 
    find "$(GetPacmanConf DBPath)/sync" -mindepth 1 -maxdepth 1 -type f | GetBaseName | sed "s|.db$||g";
    return 0
}
GetPacmanRepoServer () 
{ 
    ForEach eval 'GetPacmanConf -r {}' | grep "^Server" | ForEach eval 'ParseIniLine; printf "%s\n" ${VALUE}'
}
GetPacmanRoot () 
{ 
    GetPacmanConf RootDir
}
IsAurPkgOutOfDated () 
{ 
    local _Status;
    _Status=$(jq -r ".OutOfDate");
    case "$_Status" in 
        "null")
            return 1
        ;;
        *)
            echo "$_Status";
            return 0
        ;;
    esac
}
IsAvailable () 
{ 
    type "$1" 2> /dev/null 1>&2
}
IsUUID () 
{ 
    local _UUID="${1-""}";
    [[ "${_UUID//-/}" =~ ^[[:xdigit:]]{32}$ ]] && return 0;
    return 1
}
MsgCommon () 
{ 
    local i;
    for i in $(seq "$(echo -e "${*}" | wc -l)");
    do
        echo -e "${*}" | head -n "${i}" | tail -n 1;
    done
}
MsgDebug () 
{ 
    MsgCommon "Debug: ${*}" 1>&2
}
MsgErr () 
{ 
    MsgCommon "Error: ${*}" 1>&2
}
MsgInfo () 
{ 
    MsgCommon " Info: ${*}" 1>&1
}
MsgWarn () 
{ 
    MsgCommon " Warn: ${*}" 1>&2
}
ParseArg () 
{ 
    local _Arg _Chr _Cnt;
    local _Long=() _LongWithArg=() _Short=() _ShortWithArg=();
    local _OutArg=() _NoArg=();
    for _Arg in "${@}";
    do
        local _TempArray=();
        case "${_Arg}" in 
            "LONG="*)
                readarray -t _TempArray < <(tr -d "\"" <<< "${_Arg#LONG=}" | tr "," "\n");
                for _Chr in "${_TempArray[@]}";
                do
                    if [[ "${_Chr}" = *":" ]]; then
                        _LongWithArg+=("${_Chr%":"}");
                    else
                        _Long+=("${_Chr}");
                    fi;
                done;
                shift 1
            ;;
            "SHORT="*)
                readarray -t _TempArray < <(tr -d "\"" <<< "${_Arg#SHORT=}" | grep -o .);
                for ((_Cnt=0; _Cnt<= "${#_TempArray[@]}" - 1; _Cnt++ ))
                do
                    if [[ "${_TempArray["$(( _Cnt + 1))"]-""}" = ":" ]]; then
                        _ShortWithArg+=("${_TempArray["${_Cnt}"]}");
                        _Cnt=$(( _Cnt + 1 ));
                    else
                        _Short+=("${_TempArray["${_Cnt}"]}");
                    fi;
                done;
                shift 1
            ;;
            "--")
                shift 1;
                break
            ;;
        esac;
    done;
    while (( "$#" > 0 )); do
        if [[ "${1}" = "--" ]]; then
            shift 1;
            _NoArg+=("${@}");
            shift "$#";
            break;
        else
            if [[ "${1}" = "--"* ]]; then
                if printf "%s\n" "${_LongWithArg[@]}" | grep -qx "${1#--}"; then
                    if [[ "${2}" = "-"* ]]; then
                        MsgError "${1} の引数が指定されていません";
                        return 2;
                    else
                        _OutArg+=("${1}" "${2}");
                        shift 2;
                    fi;
                else
                    if printf "%s\n" "${_Long[@]}" | grep -qx "${1#--}"; then
                        _OutArg+=("${1}");
                        shift 1;
                    else
                        MsgError "${1} は不正なオプションです。-hで使い方を確認してください。";
                        return 1;
                    fi;
                fi;
            else
                if [[ "${1}" = "-"* ]]; then
                    local _Shift=0;
                    while read -r _Chr; do
                        if printf "%s\n" "${_ShortWithArg[@]}" | grep -qx "${_Chr}"; then
                            if [[ "${1}" = *"${_Chr}" ]] && [[ ! "${2}" = "-"* ]]; then
                                _OutArg+=("-${_Chr}" "${2}");
                                _Shift=2;
                            else
                                MsgError "-${_Chr} の引数が指定されていません";
                                return 2;
                            fi;
                        else
                            if printf "%s\n" "${_Short[@]}" | grep -qx "${_Chr}"; then
                                _OutArg+=("-${_Chr}");
                                _Shift=1;
                            else
                                MsgError "-${_Chr} は不正なオプションです。-hで使い方を確認してください。";
                                return 1;
                            fi;
                        fi;
                    done < <(grep -o . <<< "${1#-}");
                    shift "${_Shift}";
                else
                    _NoArg+=("${1}");
                    shift 1;
                fi;
            fi;
        fi;
    done;
    OPTRET=("${_OutArg[@]}" -- "${_NoArg[@]}");
    return 0
}
ParseIniLine () 
{ 
    local _Line;
    TYPE="" PARAM="" VALUE="" SECTION="";
    _Line="$(RemoveBlank <<< "$(cat)")";
    case "$_Line" in 
        "["*"]")
            TYPE="SECTION";
            SECTION=$(sed "s|^\[||g; s|\]$||g" <<< "$_Line")
        ;;
        "" | "#"*)
            TYPE="NOTHING"
        ;;
        *"="*)
            TYPE="PARAM-VALUE";
            PARAM="$(RemoveBlank <<< "$(cut -d "=" -f 1 <<< "$_Line")")";
            VALUE="$(RemoveBlank <<< "$(cut -d "=" -f 2- <<< "$_Line")")"
        ;;
        *)
            TYPE="ERROR"
        ;;
    esac;
    return 0
}
PrintArray () 
{ 
    (( $# >= 1 )) || return 0;
    printf "%s\n" "${@}"
}
Readlinkf_Posix () 
{ 
    [ "${1:-}" ] || return 1;
    max_symlinks=40;
    CDPATH='';
    target=$1;
    [ -e "${target%/}" ] || target=${1%"${1##*[!/]}"};
    [ -d "${target:-/}" ] && target="$target/";
    cd -P . 2> /dev/null || return 1;
    while [ "$max_symlinks" -ge 0 ] && max_symlinks=$((max_symlinks - 1)); do
        if [ ! "$target" = "${target%/*}" ]; then
            case $target in 
                /*)
                    cd -P "${target%/*}/" 2> /dev/null || break
                ;;
                *)
                    cd -P "./${target%/*}" 2> /dev/null || break
                ;;
            esac;
            target=${target##*/};
        fi;
        if [ ! -L "$target" ]; then
            target="${PWD%/}${target:+/}${target}";
            printf '%s\n' "${target:-/}";
            return 0;
        fi;
        link=$(ls -dl -- "$target" 2>/dev/null) || break;
        target=${link#*" $target -> "};
    done;
    return 1
}
Readlinkf_Readlink () 
{ 
    [ "${1:-}" ] || return 1;
    max_symlinks=40;
    CDPATH='';
    target=$1;
    [ -e "${target%/}" ] || target=${1%"${1##*[!/]}"};
    [ -d "${target:-/}" ] && target="$target/";
    cd -P . 2> /dev/null || return 1;
    while [ "$max_symlinks" -ge 0 ] && max_symlinks=$((max_symlinks - 1)); do
        if [ ! "$target" = "${target%/*}" ]; then
            case $target in 
                /*)
                    cd -P "${target%/*}/" 2> /dev/null || break
                ;;
                *)
                    cd -P "./${target%/*}" 2> /dev/null || break
                ;;
            esac;
            target=${target##*/};
        fi;
        if [ ! -L "$target" ]; then
            target="${PWD%/}${target:+/}${target}";
            printf '%s\n' "${target:-/}";
            return 0;
        fi;
        target=$(readlink -- "$target" 2>/dev/null) || break;
    done;
    return 1
}
RemoveBlank () 
{ 
    sed "s|^ *||g; s| *$||g"
}
RemoveFileExt () 
{ 
    local Ext;
    ForEach eval 'Ext=$(GetFileExt <<< {}); sed "s|.$Ext$||g" <<< {}; unset Ext'
}
RunPacman () 
{ 
    pacman --noconfirm --config "${PACMAN_CONF-"/etc/pacman.conf"}" "$@"
}
readlinkf () 
{ 
    Readlinkf_Posix "$@"
}
