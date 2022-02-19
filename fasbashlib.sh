#!/usr/bin/env bash
# shellcheck disable=all
AddNewToArray () 
{ 
    eval "PrintArray \"\${$1[@]}\"" | grep -qx "$2" && return 0;
    eval "$1+=(\"$2\")"
}
ArrayAppend () 
{ 
    local _ArrName="$1";
    shift 1 || return 1;
    readarray -t -O "$(ArrayIndex "$_ArrName")" "$_ArrName" < <(cat)
}
ArrayIncludes () 
{ 
    PrintEvalArray "$1" | grep -qx "$2"
}
ArrayIndex () 
{ 
    PrintEvalArray "$1" | wc -l
}
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
        RunPacman -Qq "$p" > /dev/null 2>&1 || return 1;
    done;
    return 0
}
CreateCache () 
{ 
    CreateCacheDir > /dev/null;
    cat > "$(GetCacheDir)/${1}";
    cat "$(GetCacheDir)/$1"
}
CreateCacheDir () 
{ 
    [[ -z "${SCRIPTCACHEID-""}" ]] || { 
        echo "Set SCRIPTCACHEID variable" 1>&2;
        return 1
    };
    export SCRIPTCACHEID="$SCRIPTCACHEID";
    local TMPDIR="${TMPDIR-"/tmp"}";
    local _Dir="$TMPDIR/${SCRIPTCACHEID}";
    mkdir -p "$_Dir";
    echo "$_Dir";
    return 0
}
CsvToBashArray () 
{ 
    local _RawCsvLine=() _Line _ClmCnt=0;
    local ArrayPrefix="${ArrayPrefix-"{}"}";
    readarray -t _RawCsvLine < <(
        # 標準入力からCSVのみを抽出
        while read -r _Line; do
            # shellcheck disable=SC2031
            (( $(tr "${CSVDELIM-","}" "\n" <<< "$_Line" | wc -l) >= ${#} )) && echo "$_Line"
        done < <(grep -v "^#")
    );
    _ClmCnt=$(PrintArray "${_RawCsvLine[@]}" | GetCsvColumnCnt);
    while read -r _Cnt; do
        readarray -t "$(sed "s|{}|$(eval "echo \"\${${_Cnt}}\"")|g" <<< "$ArrayPrefix")" < <(
            # shellcheck disable=SC2031
            PrintArray "${_RawCsvLine[@]}" | cut -d "${CSVDELIM-","}" -f "$_Cnt"
        );
    done < <(seq 1 "$#")
}
CutLastString () 
{ 
    echo "${1%%"${2}"}";
    return 0
}
ExistCache () 
{ 
    local _File;
    _File="$(CreateCacheDir)/$1";
    [[ -e "$_File" ]] || return 1;
    (( "$(GetTimeDiffFromLastUpdate "$_File")" > "${KEEPCACHESEC-"86400"}" )) && return 2;
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
FormatSrcInfo () 
{ 
    RemoveBlank | sed "/^$/d" | grep -v "^#" | ForEach eval "ParseKeyValue Line <<< \"{}\""
}
GetAurAllDepends () 
{ 
    jq -r ".Depends[], .MakeDepends[]"
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
    GetRawAurInfo "$1" | CheckAurJson
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
GetAurRecursiveDepends () 
{ 
    local _Pkg;
    _Pkg="$(GetPacmanName <<< "$1")";
    _AurDependList=();
    SCRIPTCACHEID="FasBashLib_Aur";
    ExistCache "InstalledPackage" || RunPacman -Qq | CreateCache "InstalledPackage" > /dev/null;
    ExistCache "RepoPackage" || GetPacmanRepoPkgList | CreateCache "RepoPackage" > /dev/null;
    function _Resolve () 
    { 
        GetCache "RepoPackage" | grep -qx "$1" && return 0;
        while read -r _P; do
            ArrayIncludes _AurDependList "$_P" && continue;
            GetCache "RepoPackage" | grep -qx "$_P" && continue;
            _AurDependList+=("$_P");
            _Resolve "$_P";
        done < <(GetAurInfo "$1" | GetAurAllDepends | GetPacmanName)
    };
    _Resolve "$_Pkg";
    PrintEvalArray _AurDependList
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
GetCache () 
{ 
    cat "$(GetCacheDir)/$1" 2> /dev/null || return 1
}
GetCacheDir () 
{ 
    echo "${TMPDIR-"/tmp"}/$(GetCacheID)"
}
GetCacheID () 
{ 
    if [[ -z "${SCRIPTCACHEID-""}" ]]; then
        CreateCacheDir > /dev/null;
    fi;
    echo "$SCRIPTCACHEID"
}
GetCsvClm () 
{ 
    grep -v "^#" | sed "/^$/d" | cut -d "${CSVDELIM-","}" -f "$1"
}
GetCsvColumnCnt () 
{ 
    local _RawCsvLine=();
    local _Line _ClmCnt=0;
    readarray -t _RawCsvLine;
    while read -r _Line; do
        grep -qE "^#" <<< "$_Line" && continue;
        _CurrentClmCnt=$(tr "${CSVDELIM-","}" "\n" | wc -l);
        (( _CurrentClmCnt > _ClmCnt )) && _ClmCnt="$_CurrentClmCnt";
    done < <(PrintArray "${_RawCsvLine[@]}");
    RemoveBlank <<< "$_ClmCnt";
    return 0
}
GetFileExt () 
{ 
    GetBaseName | rev | cut -d "." -f 1 | rev
}
GetFileLastUpdate () 
{ 
    local _isGnu=false;
    date --help 2> /dev/null | grep -q "GNU" && _isGnu=true;
    if [[ "$_isGnu" = true ]]; then
        date +%s -r "$1";
    else
        { 
            eval "$(stat -s "$1")";
            echo "$st_mtime"
        };
    fi
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
GetKernelFileList () 
{ 
    find "/boot" -maxdepth 1 -mindepth 1 -name "vmlinuz-*"
}
GetKernelSrcList () 
{ 
    find "/usr/src" -mindepth 1 -maxdepth 1 -type l -name "linux*"
}
GetLine () 
{ 
    head -n "$1" | tail -n 1
}
GetMkinitcpioPresetList () 
{ 
    find "/etc/mkinitcpio.d/" -name "*.preset" -type f | GetBaseName | RemoveFileExt
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
GetPacmanKernelPkg () 
{ 
    echo "there is nothing"
}
GetPacmanKeyringDir () 
{ 
    local _KeyringDir="";
    _KeyringDir="$(LANG=C pacman-key -h | RemoveBlank | grep -A 1 -- "^--populate" | tail -n 1 | cut -d "/" -f 2- | sed "s|'$||g")";
    : "${_KeyringDir="usr/share/pacman/keyrings"}";
    _KeyringDir="$(GetPacmanRoot)/$_KeyringDir";
    _KeyringDir="$(sed -E "s|/+|/|g" <<< "$_KeyringDir")";
    if [[ -e "$_KeyringDir" ]]; then
        Readlinkf "$_KeyringDir";
    else
        echo "$_KeyringDir";
    fi
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
GetPacmanName () 
{ 
    cut -d "<" -f 1 | cut -d ">" -f 1 | cut -d "=" -f 1
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
GetPacmanRepoPkgList () 
{ 
    RunPacman -Slq
}
GetPacmanRepoServer () 
{ 
    ForEach eval 'GetPacmanConf -r {}' | grep "^Server" | ForEach eval 'ParseIniLine; printf "%s\n" ${VALUE}'
}
GetPacmanRoot () 
{ 
    GetPacmanConf RootDir
}
GetRawAurInfo () 
{ 
    curl -sL "https://aur.archlinux.org/rpc?v=5&type=info&arg=${1}"
}
GetSrcInfoKeyList () 
{ 
    FormatSrcInfo | cut -d "=" -f 1
}
GetSrcInfoPkgBase () 
{ 
    local _Line _Key _InSection=false;
    while read -r _Line; do
        _Key="$(ParseKeyValue Key <<< "$_Line")";
        case "$_Key" in 
            "pkgbase")
                _InSection=true
            ;;
            "pkgname")
                _InSection=false
            ;;
            *)
                if [[ "${_InSection}" = true ]]; then
                    echo "$_Line";
                fi
            ;;
        esac;
    done < <(FormatSrcInfo)
}
GetSrcInfoPkgName () 
{ 
    local _Line _Key _InSection=false _TargetPkgName="$1";
    while read -r _Line; do
        _Key="$(ParseKeyValue Key <<< "$_Line")";
        case "$_Key" in 
            "pkgname")
                if [[ "$(ParseKeyValue Value <<< "$_Line")" = "$_TargetPkgName" ]]; then
                    _InSection=true;
                else
                    _InSection=false;
                fi
            ;;
            "pkgbase")
                _InSection=false
            ;;
            *)
                if [[ "${_InSection}" = true ]]; then
                    echo "$_Line";
                fi
            ;;
        esac;
    done < <(FormatSrcInfo)
}
GetSrcInfoSectionList () 
{ 
    FormatSrcInfo | grep -e "^pkgbase" -e "^pkgname"
}
GetSrcInfoValue () 
{ 
    local _SrcInfo=();
    local _Output=();
    local _PkgBaseValues=("pkgver" "pkgrel" "epoch");
    local _AllValues=("pkgdesc" "url" "install" "changelog");
    local _AllArrays=("arch" "groups" "license" "noextract" "options" "backup" "validpgpkeys");
    local _AllArraysWithArch=("source" "depends" "checkdepends" "makedepends" "optdepends" "provides" "conflicts" "replaces" "md5sums" "sha1sums" "sha224sums" "sha256sums" "sha384sums" "sha512sums");
    ArrayAppend _SrcInfo;
    ArrayIncludes _PkgBaseValues "$1" && { 
        PrintEvalArray _SrcInfo | GetSrcInfoValueInPkgBase "$1";
        return 0
    };
    [[ -n "${2-""}" ]] || return 1;
    if ArrayIncludes _AllValues "$1" || ArrayIncludes _AllArrays "$1"; then
        ArrayAppend _Output < <(PrintEvalArray _SrcInfo | GetSrcInfoValueInPkgBase "$1");
        ArrayAppend _Output < <(PrintEvalArray _SrcInfo | GetSrcInfoValueInPkgName "$2" "$1");
        PrintEvalArray _Output;
        return 0;
    fi;
    ArrayIncludes _AllArraysWithArch "$1" || return 1;
    local _Arch _ArchList;
    if [[ -z "${3-""}" ]]; then
        ArrayAppend _ArchList < <(PrintEvalArray _SrcInfo | GetSrcInfoValue arch "$2");
    else
        ArrayAppend _ArchList < <(tr "," "\n" <<< "$3" | RemoveBlank);
    fi;
    ArrayAppend _Output < <(PrintEvalArray _SrcInfo | GetSrcInfoValueInPkgBase "$1");
    ArrayAppend _Output < <(PrintEvalArray _SrcInfo | GetSrcInfoValueInPkgName "$2" "$1");
    for _Arch in "${_ArchList[@]}";
    do
        ArrayAppend _Output < <(PrintEvalArray _SrcInfo | GetSrcInfoValueInPkgBase "$1_${_Arch}");
        ArrayAppend _Output < <(PrintEvalArray _SrcInfo | GetSrcInfoValueInPkgName "$2" "$1_${_Arch}");
    done;
    PrintEvalArray _Output;
    return 0
}
GetSrcInfoValueInPkgBase () 
{ 
    local _Line;
    while read -r _Line; do
        _Key="$(ParseKeyValue Key <<< "$_Line")";
        case "$_Key" in 
            "$1")
                ParseKeyValue Value <<< "$_Line"
            ;;
        esac;
    done < <(GetSrcInfoPkgBase)
}
GetSrcInfoValueInPkgName () 
{ 
    local _Line;
    while read -r _Line; do
        _Key="$(ParseKeyValue Key <<< "$_Line")";
        case "$_Key" in 
            "$2")
                ParseKeyValue Value <<< "$_Line"
            ;;
        esac;
    done < <(GetSrcInfoPkgName "$1")
}
GetTimeDiffFromLastUpdate () 
{ 
    local _Now _Last;
    _Now="$(date "+%s")";
    _Last="$(GetFileLastUpdate "$1")";
    echo "$(( _Now - _Last ))";
    return 0
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
PacmanGpg () 
{ 
    gpg --homedir "$(GetPacmanConf GPGDir)" "$@"
}
PacmanIsRepoPkg () 
{ 
    RunPacman -Slq | grep -qx "$(GetPacmanName <<< "$1")"
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
ParseKeyValue () 
{ 
    local _Output="${1-""}";
    [[ -n "${_Output}" ]] || return 1;
    shift 1;
    local _String _Key _Value;
    _String="$(cat)";
    _Key="$(cut -d "=" -f 1 <<<  "$_String" | RemoveBlank)";
    _Value="$(cut -d "=" -f 2- <<< "$_String" | RemoveBlank)";
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
    esac;
    return 0
}
PrintArray () 
{ 
    (( $# >= 1 )) || return 0;
    printf "%s\n" "${@}"
}
PrintEvalArray () 
{ 
    eval "PrintArray \"\${$1[@]}\""
}
RandomString () 
{ 
    base64 < "/dev/random" | fold -w "$1" | head -n 1
}
Readlinkf () 
{ 
    Readlinkf_Posix "$@"
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
    sed "s|^ *||g; s| *$||g; s|^	*||g; s|	*$||g; /^$/d"
}
RemoveFileExt () 
{ 
    local Ext;
    ForEach eval 'Ext=$(GetFileExt <<< {}); sed "s|.$Ext$||g" <<< {}; unset Ext'
}
RevArray () 
{ 
    readarray -t "$1" < <(PrintEvalArray "$1" | tac)
}
RunPacman () 
{ 
    pacman --noconfirm --config "${PACMAN_CONF-"/etc/pacman.conf"}" "$@"
}
