#!/usr/bin/env bash
#
# <FasBashLib>
# A collection of small but awasome functions for Bash
#
# <Document>
# You can read the document here.
# https://github.com/Hayao0819/FasBashLib/tree/build-0.2.x/docs
#
# <E-Mail>
# Yamada Hayao <hayao@fascode.net>
# Fascode Network <contact@fascode.net>
#
# <Twitter>
# Yamada Hayao <@Hayao0819>
# 
# <LICENSE>
# "THE MIT SUSHI-WARE LICENSE"
# based "SUSHI-WARE LICENSE" (https://github.com/MakeNowJust/sushi-ware)
# Copyright 2022 Yamada Hayao
#
# - You agree that "the author (copyright holder) is not responsible for the software".
# - You place a copyright notice or this permission notice on all copies of the Software or any other material part of the Software.
#   If the above two conditions are met, the following rights are granted.
# - The right to use, copy, modify and redistribute without charge and without restriction.
# - The right to buy the author (copyright holder) of the software a bowl of sushi🍣.
#
# shellcheck disable=all

FSBLIB_VERSION="v0.2.3.r343.gcc29d6b-upper"
FSBLIB_REQUIRE="ModernBash"

SrcInfo.Format () 
{ 
    RemoveBlank | sed "/^$/d" | grep -v "^#" | ForEach eval "SrcInfo.Parse Line <<< \"{}\""
}
SrcInfo.GetKeyList () 
{ 
    SrcInfo.Format | cut -d "=" -f 1
}
SrcInfo.GetPkgBase () 
{ 
    local _Line _Key _InSection=false;
    while read -r _Line; do
        _Key="$(SrcInfo.Parse Key <<< "$_Line")";
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
    done < <(SrcInfo.Format)
}
SrcInfo.GetPkgName () 
{ 
    local _Line _Key _InSection=false _TargetPkgName="$1";
    while read -r _Line; do
        _Key="$(SrcInfo.Parse Key <<< "$_Line")";
        case "$_Key" in 
            "pkgname")
                if [[ "$(SrcInfo.Parse Value <<< "$_Line")" = "$_TargetPkgName" ]]; then
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
    done < <(SrcInfo.Format)
}
SrcInfo.GetSectionList () 
{ 
    SrcInfo.Format | grep -e "^pkgbase" -e "^pkgname"
}
SrcInfo.GetValue () 
{ 
    local _SrcInfo=();
    local _Output=();
    local _PkgBaseValues=("pkgver" "pkgrel" "epoch");
    local _AllValues=("pkgdesc" "url" "install" "changelog");
    local _AllArrays=("arch" "groups" "license" "noextract" "options" "backup" "validpgpkeys");
    local _AllArraysWithArch=("source" "depends" "checkdepends" "makedepends" "optdepends" "provides" "conflicts" "replaces" "md5sums" "sha1sums" "sha224sums" "sha256sums" "sha384sums" "sha512sums");
    ArrayAppend _SrcInfo;
    ArrayIncludes _PkgBaseValues "$1" && { 
        PrintEvalArray _SrcInfo | SrcInfo.GetValueInPkgBase "$1";
        return 0
    };
    [[ -n "${2-""}" ]] || return 1;
    if ArrayIncludes _AllValues "$1" || ArrayIncludes _AllArrays "$1"; then
        ArrayAppend _Output < <(PrintEvalArray _SrcInfo | SrcInfo.GetValueInPkgBase "$1");
        ArrayAppend _Output < <(PrintEvalArray _SrcInfo | SrcInfo.GetValueInPkgName "$2" "$1");
        PrintArray "${_Output[@]}" | tail -n 1;
        return 0;
    fi;
    ArrayIncludes _AllArraysWithArch "$1" || return 1;
    local _Arch _ArchList;
    if [[ -z "${3-""}" ]]; then
        ArrayAppend _ArchList < <(PrintEvalArray _SrcInfo | SrcInfo.GetValue arch "$2");
    else
        ArrayAppend _ArchList < <(tr "," "\n" <<< "$3" | RemoveBlank);
    fi;
    ArrayAppend _Output < <(PrintEvalArray _SrcInfo | SrcInfo.GetValueInPkgBase "$1");
    ArrayAppend _Output < <(PrintEvalArray _SrcInfo | SrcInfo.GetValueInPkgName "$2" "$1");
    for _Arch in "${_ArchList[@]}";
    do
        ArrayAppend _Output < <(PrintEvalArray _SrcInfo | SrcInfo.GetValueInPkgBase "$1_${_Arch}");
        ArrayAppend _Output < <(PrintEvalArray _SrcInfo | SrcInfo.GetValueInPkgName "$2" "$1_${_Arch}");
    done;
    PrintEvalArray _Output;
    return 0
}
SrcInfo.GetValueInPkgBase () 
{ 
    local _Line;
    while read -r _Line; do
        _Key="$(SrcInfo.Parse Key <<< "$_Line")";
        case "$_Key" in 
            "$1")
                SrcInfo.Parse Value <<< "$_Line"
            ;;
        esac;
    done < <(SrcInfo.GetPkgBase)
}
SrcInfo.GetValueInPkgName () 
{ 
    local _Line;
    while read -r _Line; do
        _Key="$(SrcInfo.Parse Key <<< "$_Line")";
        case "$_Key" in 
            "$2")
                SrcInfo.Parse Value <<< "$_Line"
            ;;
        esac;
    done < <(SrcInfo.GetPkgName "$1")
}
SrcInfo.Parse () 
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
Msg.Common () 
{ 
    local i l="$1" string="$2" out="${3-""}";
    shift 2 || return 1;
    { 
        [[ -z "${out-""}" ]] && { 
            [[ "${l^^}" = *"ERR"* ]] || [[ "${l^^}" = *"WARN"* ]] || [[ "${l^^}" = *"DEBUG"* ]]
        }
    } && out="stderr";
    case "${FSBLIB_MSG-"${out:-"stdout"}"}" in 
        "stdout")
            for i in $(seq "$(echo -e "${string}" | wc -l)");
            do
                echo -n "$l ";
                echo -e "${string}" | head -n "${i}" | tail -n 1;
            done
        ;;
        "stderr")
            for i in $(seq "$(echo -e "${string}" | wc -l)");
            do
                echo -n "$l " 1>&2;
                echo -e "${string}" | head -n "${i}" | tail -n 1 1>&2;
            done
        ;;
    esac
}
Msg.Debug () 
{ 
    Msg.Common "Debug:" "${*}" stderr
}
Msg.Err () 
{ 
    Msg.Common "Error:" "${*}" stderr
}
Msg.Info () 
{ 
    Msg.Common " Info:" "${*}" stdout
}
Msg.Warn () 
{ 
    Msg.Common " Warn:" "${*}" stderr
}
AddNewToArray () 
{ 
    Array.Push "$@"
}
ArrayAppend () 
{ 
    Array.Append "$1"
}
ArrayIncludes () 
{ 
    Array.Includes "$@"
}
ArrayIndex () 
{ 
    Array.Length "$1"
}
GetArrayIndex () 
{ 
    Array.IndexOf "$1"
}
PrintArray () 
{ 
    Array.Print "$@"
}
PrintEvalArray () 
{ 
    Array.Eval "$1"
}
RevArray () 
{ 
    Array.Rev "$1"
}
StrToCharList () 
{ 
    Array.FromStr "$1"
}
FileType () 
{ 
    file --mime-type -b "$1"
}
GetBaseName () 
{ 
    ForEach basename "{}"
}
GetFileExt () 
{ 
    GetBaseName | rev | cut -d "." -f 1 | rev
}
RemoveFileExt () 
{ 
    local Ext;
    ForEach eval 'Ext=$(GetFileExt <<< {}); sed "s|.$Ext$||g" <<< {}; unset Ext'
}
CheckFuncDefined () 
{ 
    typeset -f "${1}" > /dev/null || return 1
}
ForEach () 
{ 
    local _Item;
    while read -r _Item; do
        "${@//"{}"/"${_Item}"}" || return "${?}";
    done
}
GetLine () 
{ 
    head -n "$1" | tail -n 1
}
IsAvailable () 
{ 
    type "$1" 2> /dev/null 1>&2
}
Loop () 
{ 
    local _T="$1";
    shift 1 || return 1;
    ForEach "$@" < <(yes "" | head -n "$_T")
}
BreakChar () 
{ 
    grep -o "."
}
CutLastString () 
{ 
    echo "${1%%"${2}"}";
    return 0
}
GetLastSplitString () 
{ 
    rev <<< "$2" | cut -d "$1" -f 1 | rev
}
IsUUID () 
{ 
    local _UUID="${1-""}";
    [[ "${_UUID//-/}" =~ ^[[:xdigit:]]{32}$ ]] && return 0;
    return 1
}
PrintEval () 
{ 
    eval echo "\${$1}"
}
RandomString () 
{ 
    base64 < "/dev/random" | fold -w "$1" | head -n 1;
    return 0
}
RemoveBlank () 
{ 
    sed "s|^ *||g; s| *$||g; s|^	*||g; s|	*$||g; /^$/d"
}
TextBox () 
{ 
    local _Content=() _Length _Vertical="|" _Line="=";
    readarray -t _Content;
    _Length="$(PrintArray "${_Content[@]}" | awk '{ if ( length > x ) { x = length } }END{ print x }')";
    echo "${_Vertical}${_Line}$(yes "${_Line}" | head -n "$_Length" | tr -d "\n")${_Vertical}";
    for _Str in "${_Content[@]}";
    do
        echo "${_Vertical}${_Str}$(yes " " | head -n "$(( _Length + 1 - "${#_Str}"))" | tr -d "\n")${_Vertical}";
    done;
    echo "${_Vertical}${_Line}$(yes "${_Line}" | head -n "$_Length" | tr -d "\n")${_Vertical}"
}
ToLower () 
{ 
    local _Str="${1,,}";
    [[ -z "${_Str-""}" ]] || echo "${_Str}"
}
ToLowerStdin () 
{ 
    local _Str;
    ForEach eval "_Str=\"{}\"; echo \"\${_Str,,}\"";
    unset _Str
}
CalcInt () 
{ 
    echo "$(( "$@" ))"
}
Ntest () 
{ 
    (( "$@" )) || return 1
}
Sum () 
{ 
    local _Arg=();
    ForEach eval '_Arg+=("{}" "+")' < <(PrintArray "$@");
    readarray -t _Arg < <(PrintArray "${_Arg[@]}" | sed "${#_Arg[@]}d");
    CalcInt "${_Arg[@]}"
}
Bool () 
{ 
    case "$(ToLower "$(PrintEval "${1}")")" in 
        "true")
            return 0
        ;;
        "" | "false")
            return 1
        ;;
        *)
            return 2
        ;;
    esac
}
GetFuncList () 
{ 
    declare -F | cut -d " " -f 3
}
UnsetAllFunc () 
{ 
    local Func;
    while read -r Func; do
        unset "$Func";
    done < <(GetFuncList)
}
RemoveMatchLine () 
{ 
    local i unseted=false;
    while read -r i; do
        if [[ "$i" != "${1}" ]] || [[ "${unseted}" = true ]]; then
            echo "$i";
        else
            unseted=true;
        fi;
    done;
    unset unseted i
}
Arch.GetKernelFileList () 
{ 
    find "/boot" -maxdepth 1 -mindepth 1 -name "vmlinuz-*"
}
Arch.GetKernelSrcList () 
{ 
    find "/usr/src" -mindepth 1 -maxdepth 1 -type l -name "linux*"
}
Arch.GetMkinitcpioPresetList () 
{ 
    find "/etc/mkinitcpio.d/" -name "*.preset" -type f | GetBaseName | RemoveFileExt
}
Pm.CheckPkg () 
{ 
    local p;
    for p in "$@";
    do
        Pm.Run -Qq "$p" > /dev/null 2>&1 || return 1;
    done;
    return 0
}
Pm.GetConfig () 
{ 
    LANG=C pacman-conf --config="${PACMAN_CONF-"/etc/pacman.conf"}" "$@"
}
Pm.GetInstalledPkgVer () 
{ 
    ForEach pacman -Qq "{}" | cut -d " " -f 2;
    PrintArray "${PIPESTATUS[@]}" | grep -qx "1" && return 1;
    return 0
}
Pm.GetKeyringList () 
{ 
    find "$(@GetKeyringDir)" -name "*.gpg" | GetBaseName | RemoveFileExt
}
Pm.GetLatestPkgVer () 
{ 
    local _LANG="${LANG-""}";
    export LANG=C;
    ForEach Pm.Run -Si "{}" | grep "^Version" | cut -d ":" -f 2 | RemoveBlank;
    [[ -n "$_LANG" ]] && export LANG="$_LANG";
    return 0
}
Pm.GetName () 
{ 
    cut -d "<" -f 1 | cut -d ">" -f 1 | cut -d "=" -f 1
}
Pm.GetPacmanKernelPkg () 
{ 
    echo "there is nothing"
}
Pm.GetPacmanKeyringDir () 
{ 
    local _KeyringDir="";
    _KeyringDir="$(LANG=C pacman-key -h | RemoveBlank | grep -A 1 -- "^--populate" | tail -n 1 | cut -d "/" -f 2- | sed "s|'$||g")";
    : "${_KeyringDir="usr/share/pacman/keyrings"}";
    _KeyringDir="$(Pm.GetRoot)/$_KeyringDir";
    _KeyringDir="$(sed -E "s|/+|/|g" <<< "$_KeyringDir")";
    if [[ -e "$_KeyringDir" ]]; then
        Readlinkf "$_KeyringDir";
    else
        echo "$_KeyringDir";
    fi
}
Pm.GetRepoConf () 
{ 
    ForEach eval 'echo [{}] && Pm.GetConfig -r {}'
}
Pm.GetRepoListFromConf () 
{ 
    Pm.GetConfig --repo-list
}
Pm.GetRepoPkgList () 
{ 
    Pm.Run -Slq "$@"
}
Pm.GetRepoServer () 
{ 
    ForEach eval 'Pm.GetConfig -r {}' | grep "^Server" | ForEach eval "Ini.ParseLine <<< '{}' ; printf '%s\n' \${VALUE}"
}
Pm.GetRepoVer () 
{ 
    Pm.Run -Sp --print-format '%v' "$1"
}
Pm.GetRoot () 
{ 
    Pm.GetConfig RootDir
}
Pm.IsRepoPkg () 
{ 
    Pm.Run -Slq | grep -qx "$(Pm.GetName <<< "$1")"
}
Pm.PacmanGpg () 
{ 
    gpg --homedir "$(Pm.GetConfig GPGDir)" "$@"
}
Pm.Run () 
{ 
    pacman --noconfirm --config "${PACMAN_CONF-"/etc/pacman.conf"}" "$@"
}
Pm.RunKey () 
{ 
    pacman-key --config "${PACMAN_CONF-"/etc/pacman.conf"}" "$@"
}
Pm.GetDbNextSection () 
{ 
    Pm.GetDbSectionList | grep -x -A 1 "^%$1%$" | GetLine 2 | sed "s|^%||g; s|%$||g"
}
Pm.GetDbSection () 
{ 
    readarray -t _Stdin;
    PrintArray "${_Stdin[@]}" | sed -ne "/^%$1%$/,/^%$(PrintEvalArray _Stdin | Pm.GetDbNextSection "$1")%$/p" | sed "1d; \$d"
}
Pm.GetDbSectionList () 
{ 
    grep -E "^%.*%$"
}
Pm.CreateDbTmpDir () 
{ 
    mkdir -p "$(Pm.GetDbTmpDir)"
}
Pm.DeleteDbTmpDir () 
{ 
    rm -rf "$(Pm.GetDbTmpDir)"
}
Pm.GetDbTmpDir () 
{ 
    echo "${TMPDIR-"/tmp"}/fasbashlib-pacman-db"
}
Pm.GetPkgArch () 
{ 
    Pm.GetSyncDbDesc "$1" | Pm.GetDbSection ARCH | RemoveBlank
}
Pm.GetRepoListFromLocalDb () 
{ 
    find "$(Pm.GetConfig DBPath)/sync" -mindepth 1 -maxdepth 1 -type f | GetBaseName | sed "s|.db$||g";
    return 0
}
Pm.GetSyncAllDesc () 
{ 
    find "$(Pm.GetDbTmpDir)" -mindepth 3 -maxdepth 3 -name "desc" -type f
}
Pm.GetSyncDbDesc () 
{ 
    local _path;
    _path="$(Pm.GetSyncDbDescPath "$1")";
    [[ -e "$_path" ]] || return 1;
    cat "$_path/desc"
}
Pm.GetSyncDbDescPath () 
{ 
    local _repo;
    _repo="$(pacman -Sp --print-format '%r' "$1")";
    { 
        IsPacmanSyncDbOpend "$_repo" || OpenPacmanSyncDb "$_repo"
    } || return 1;
    echo "$(Pm.GetDbTmpDir)/sync/$(pacman -Sp --print-format '%r/%n-%v' "$1")"
}
Pm.GetVirtualPkgList () 
{ 
    Pm.GetRepoListFromLocalDb | ForEach Pm.OpenSyncDb {};
    Pm.GetSyncAllDesc | ForEach eval "Pm.GetDbSection PROVIDES < {}" | RemoveBlank
}
Pm.IsOpendSyncDb () 
{ 
    readarray -t _PkgDbList < <(find "$(Pm.GetDbTmpDir)/sync/$1" -mindepth 1 -maxdepth 1 -type d );
    (( "${#_PkgDbList[@]}" > 0 )) && return 0;
    return 1
}
Pm.OpenSyncDb () 
{ 
    local _Dir _RepoDb;
    Pm.CreateDbTmpDir;
    _Dir="$(Pm.GetDbTmpDir)/sync/$1";
    mkdir -p "$_Dir";
    _RepoDb="$(Pm.GetConfig DBPath)/sync/$1.db";
    [[ -e "$_RepoDb" ]] || return 1;
    tar -xzf "${_RepoDb}" -C "$_Dir" || return 1
}
Pm.OpenedSyncDbList () 
{ 
    find "$(Pm.GetDbTmpDir)/sync/" -mindepth 1 -maxdepth 1 -type d
}
Pm.ParsePkgFileName () 
{ 
    local _Pkg="$1";
    local _PkgName _PkgVer _PkgRel _Arch _FileExt;
    local _PkgWithOutExt;
    if grep "/" <<< "$_Pkg"; then
        _Pkg="$(basename "$_Pkg")";
    fi;
    _FileExt="$(GetLastSplitString "-" "$_Pkg" | cut -d "." -f 2-)";
    _PkgWithOutExt="${_Pkg%%".${_FileExt}"}";
    _Arch=$(GetLastSplitString "-" "${_PkgWithOutExt}");
    _PkgRel=$(GetLastSplitString "-" "${_PkgWithOutExt%%"-${_Arch}"}");
    _PkgVer=$(GetLastSplitString "-" "${_PkgWithOutExt%%"-${_PkgRel}-${_Arch}"}");
    _PkgName="${_PkgWithOutExt%%"-${_PkgVer}-${_PkgRel}-${_Arch}"}";
    _ParsedPkg=("${_PkgName}" "-" "$_PkgVer" "-" "$_PkgRel" "-" "$_Arch" ".$_FileExt");
    if [[ ! "$(PrintArray "${_ParsedPkg[@]}" | tr -d "\n")" = "${_Pkg}" ]]; then
        return 1;
    fi;
    PrintArray "${_ParsedPkg[@]}"
}
Choice () 
{ 
    local arg OPTARG OPTIND;
    local _count _choice;
    local _default="" _question="" _returnstr="" _mark=" ";
    local _count=0 _digit=0 _returnint=;
    local _number=false;
    local _choice_list=();
    while getopts "ad:p:n" arg; do
        case "${arg}" in 
            d)
                _default="${OPTARG}"
            ;;
            p)
                _question="${OPTARG}"
            ;;
            n)
                _number=true
            ;;
            *)
                exit 1
            ;;
        esac;
    done;
    shift "$((OPTIND - 1))" || return 1;
    _choice_list=("${@}") _digit="${##}";
    (( ${#_choice_list[@]} <= 0 )) && echo "An exception error has occurred." 1>&2 && exit 1;
    (( ${#_choice_list[@]} == 1 )) && _returnint="${_returnint:="1"}" _returnstr="${_returnstr:="${_choice_list[*]}"}";
    [[ -n "${_question-""}" ]] && echo "   ${_question}" 1>&2;
    for ((_count=1; _count<=${#_choice_list[@]}; _count++))
    do
        _choice="${_choice_list[$(( _count - 1 ))]}" _mark=" ";
        { 
            [[ ! "${_default}" = "" ]] && [[ "${_choice}" = "${_default}" ]]
        } && _mark="*";
        printf " ${_mark} %${_digit}d: ${_choice}\n" "${_count}" 1>&2;
    done;
    echo -n "   (1 ~ ${#_choice_list[@]}) > " 1>&2 && read -r _input;
    { 
        [[ -z "${_input-""}" ]] && [[ -n "${_default-""}" ]]
    } && _returnint="${_returnint:="0"}" _returnstr="${_returnstr:="${_default}"}";
    { 
        printf "%s" "${_input}" | grep -qE "^[0-9]+$" && (( 1 <= _input)) && (( _input <= ${#_choice_list[@]} ))
    } && _returnint="${_returnint:="${_input}"}" _returnstr="${_returnstr:="${_choice_list[$(( _input - 1 ))]}"}";
    for ((i=0; i <= ${#_choice_list[@]} - 1 ; i++ ))
    do
        [[ "${_choice_list["${i}"],,}" = "${_input,,}" ]] && _returnint="${_returnint:="$(( i + 1 ))"}" _returnstr="${_returnstr:="${_choice_list["${i}"]}"}";
    done;
    { 
        [[ "${_number}" = true ]] && [[ -n "${_returnint+SET}" ]]
    } && { 
        echo "${_returnint}" && return 0
    };
    { 
        [[ "${_number}" = false ]] && [[ -n "${_returnstr+SET}" ]]
    } && { 
        echo "${_returnstr}" && return 0
    };
    return 1
}
Csv.GetClm () 
{ 
    grep -v "^#" | sed "/^$/d" | cut -d "${CSVDELIM-","}" -f "$1"
}
Csv.GetClmCnt () 
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
Csv.ToBashArray () 
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
    _ClmCnt=$(PrintArray "${_RawCsvLine[@]}" | Csv.GetClmCnt);
    while read -r _Cnt; do
        readarray -t "$(sed "s|{}|$(eval "echo \"\${${_Cnt}}\"")|g" <<< "$ArrayPrefix")" < <(
            # shellcheck disable=SC2031
            PrintArray "${_RawCsvLine[@]}" | cut -d "${CSVDELIM-","}" -f "$_Cnt"
        );
    done < <(seq 1 "$#")
}
Ini.GetParam () 
{ 
    local _RawIniLine=();
    local _Line _LineNo=1 _Exit=0 _InSection=false;
    readarray -t _RawIniLine;
    while read -r _Line; do
        Ini.ParseLine <<< "$_Line";
        case "$TYPE" in 
            "SECTION")
                if [[ "$SECTION" = "$1" ]]; then
                    _InSection=true;
                else
                    _InSection=false;
                fi
            ;;
            "PARAM-VALUE")
                [[ "$_InSection" = false ]] || echo "${VALUE}"
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
Ini.GetParamList () 
{ 
    local _RawIniLine=();
    local _Line _LineNo=1 _Exit=0 _InSection=false;
    readarray -t _RawIniLine;
    while read -r _Line; do
        Ini.ParseLine <<< "$_Line";
        case "$TYPE" in 
            "SECTION")
                if [[ "$SECTION" = "$1" ]]; then
                    _InSection=true;
                else
                    _InSection=false;
                fi
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
Ini.GetSectionList () 
{ 
    local _RawIniLine=();
    local _Line _LineNo=1 _Exit=0;
    readarray -t _RawIniLine;
    while read -r _Line; do
        Ini.ParseLine <<< "$_Line";
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
Ini.ParseLine () 
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
Misskey.Notes.Create () 
{ 
    Misskey.BindingBase "notes/create" text -- "$@"
}
Misskey.Notes.Renotes () 
{ 
    Misskey.BindingBase "notes/renotes" noteId limit sinceId untilId -- "$@"
}
Misskey.Notes.Search () 
{ 
    Misskey.BindingBase "notes/search" query limit -- "$@"
}
Misskey.Users.Notes () 
{ 
    Misskey.BindingBase "users/notes" userId -- "${1-"$(Misskey.MyId)"}" "${@:2}"
}
Misskey.Users.SearchByUsernameAndHost () 
{ 
    Misskey.BindingBase "users/search-by-username-and-host" username host limit detail -- "${1-"$(MyId)"}" "${2-"$MISSKEY_DOMAIN"}" "${@:3}"
}
Misskey.Admin.ServerInfo () 
{ 
    Misskey.BindingBase "/admin/server-info" -- "$@"
}
Misskey.Setup () 
{ 
    export MISSKEY_DOMAIN="${1-"${MISSKEY_DOMAIN-""}"}";
    export MISSKEY_TOKEN="${2-"${MISSKEY_TOKEN-""}"}";
    export MISSKEY_ENTRY="https://${MISSKEY_DOMAIN}/api"
}
Misskey.I () 
{ 
    Misskey.BindingBase "/i" -- "$@"
}
Misskey.Meta () 
{ 
    Misskey.BindingBase "/meta" -- "$@"
}
Misskey.ServerInfo () 
{ 
    Misskey.BindingBase "/server-info" -- "$@"
}
Misskey.BindingBase () 
{ 
    local _API="$1";
    shift 1;
    local i _APIArgs _Args;
    for i in "$@";
    do
        shift 1 2> /dev/null || true;
        if [[ "$i" = "--" ]]; then
            break;
        else
            _APIArgs+=("$i");
        fi;
    done;
    i=0;
    while true; do
        i="$(( i + 1 ))";
        _Args+=("${_APIArgs[$((i-1))]}=$(eval echo "\$$i" )");
        shift 1 2> /dev/null || true;
        if (( "$#" <= "$i" )) || [[ -z "${_APIArgs[$i]-""}" ]]; then
            break;
        fi;
    done;
    if [[ -z "${MISSKEY_ENTRY-""}" ]]; then
        Misskey.Setup "${MISSKEY_DOMAIN}" "$MISSKEY_TOKEN";
    fi;
    Misskey.SendReq "${MISSKEY_ENTRY%/}/${_API#/}" "${_Args[@]}" "$@"
}
Misskey.MakeJson () 
{ 
    local i _Key _Value;
    for i in "i=$MISSKEY_TOKEN" "$@";
    do
        _Key=$(cut -d "=" -f 1 <<< "$i");
        _Value=$(cut -d "=" -f 2- <<< "$i");
        if [[ "$_Value" =~ ^[0-9]+$ ]] || [[ "$_Value" = true ]] || [[ "$_Value" = false ]] || [[ "$_Value" = "{"*"}" ]] || [[ "$_Value" = "["*"]" ]]; then
            echo -n "{\"$_Key\": $_Value}";
        else
            echo -n "{\"$_Key\": \"$_Value\"}";
        fi;
    done | sed "s|}{|,|g" | jq -c -M
}
Misskey.SendReq () 
{ 
    local _Url="$1" _CurlArgs=();
    shift 1;
    _CurlArgs+=(-s -L);
    _CurlArgs+=(-X POST);
    _CurlArgs+=(-H "Content-Type: application/json");
    _CurlArgs+=(-d "$(Misskey.MakeJson "$@")");
    _CurlArgs+=("$_Url");
    Msg.Debug "Run: ${_CurlArgs[*]//"${MISSKEY_TOKEN}"/"TOKEN"})";
    curl "${_CurlArgs[@]}"
}
Misskey.IsAdmin () 
{ 
    Bool "$(Misskey.I | jq -r ".isAdmin")"
}
Misskey.MyId () 
{ 
    Misskey.I | jq -r ".id"
}
Misskey.MyName () 
{ 
    Misskey.I | jq -r ".name"
}
Misskey.MyUserName () 
{ 
    Misskey.I | jq -r ".username"
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
                        Msg.Err "${1} の引数が指定されていません";
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
                        Msg.Err "${1} は不正なオプションです。-hで使い方を確認してください。";
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
                                Msg.Err "-${_Chr} の引数が指定されていません";
                                return 2;
                            fi;
                        else
                            if printf "%s\n" "${_Short[@]}" | grep -qx "${_Chr}"; then
                                _OutArg+=("-${_Chr}");
                                _Shift=1;
                            else
                                Msg.Err "-${_Chr} は不正なオプションです。-hで使い方を確認してください。";
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
URL.Authority () 
{ 
    local i _NoScheme;
    while read -r i; do
        _NoScheme=$(URL.NoScheme <<< "$i");
        [[ "$_NoScheme" == "//"* ]] || return 1;
        cut -d "/" -f 1 < <(sed "s|^//||g" <<< "$_NoScheme");
    done
}
URL.Fragment () 
{ 
    local i;
    i="$(URL.PathAndQueryAndFragment)";
    [[ "$i" == *"#"* ]] || return 0;
    cut -d "#" -f 2- <<< "$i"
}
URL.Host () 
{ 
    URL.Authority | cut -d "@" -f 2- | cut -d ":" -f 1
}
URL.NoScheme () 
{ 
    cut -d ":" -f 2-
}
URL.Path () 
{ 
    URL.PathAndQueryAndFragment | cut -d "#" -f 1 | cut -d "?" -f 1
}
URL.PathAndQueryAndFragment () 
{ 
    local i;
    while read -r i; do
        sed "s|^//$(URL.Authority <<< "$i")||g" <<< "$(URL.NoScheme <<< "$i")";
    done
}
URL.Port () 
{ 
    local i;
    while read -r i; do
        [[ "$i" == *":"* ]] || { 
            continue
        };
        cut -d ":" -f 2 <<< "$i";
    done < <(URL.Authority)
}
URL.Query () 
{ 
    local i;
    while read -r i; do
        URL.PathAndQueryAndFragment <<< "$i" | sed "s|#$(URL.Fragment <<< "$i")||g" | cut -d "?" -f 2-;
    done
}
URL.Scheme () 
{ 
    cut -d ":" -f 1
}
URL.User () 
{ 
    local i;
    while read -r i; do
        [[ "$i" == *"@"* ]] || { 
            echo "";
            continue
        };
        cut -d "@" -f 1 <<< "$i";
    done < <(URL.Authority)
}
URL.HasAuthority () 
{ 
    local i="${1-""}";
    [[ -n "$i" ]] || read -r i;
    [[ "$(URL.NoScheme <<< "$i")" = "//"* ]]
}
URL.HasFragment () 
{ 
    local i="${1-""}";
    [[ -n "$i" ]] || read -r i;
    [[ "$(URL.PathAndQueryAndFragment <<< "$i")" = *"#"* ]]
}
URL.HasPort () 
{ 
    local i="${1-""}";
    [[ -n "$i" ]] || read -r i;
    [[ "$(URL.Authority <<< "$i")" = *":"* ]]
}
URL.HasQuery () 
{ 
    local i="${1-""}";
    [[ -n "$i" ]] || read -r i;
    [[ "$(URL.PathAndQueryAndFragment <<< "$i")" = *"?"* ]]
}
URL.HasUser () 
{ 
    local i="${1-""}";
    [[ -n "$i" ]] || read -r i;
    [[ "$(URL.Authority <<< "$i")" = *"@"* ]]
}
URL.Parse () 
{ 
    local i="${1-""}";
    if [[ -z "${i}" ]]; then
        read -r i;
    fi;
    URL.Scheme <<< "$i";
    echo ":";
    if URL.HasAuthority "$i"; then
        if URL.HasUser "$i"; then
            URL.User <<< "$i";
            echo "@";
        fi;
        URL.Host <<< "$i";
        if URL.HasPort "$i"; then
            echo ":";
            URL.Port <<< "$i";
        fi;
    fi;
    URL.Path <<< "$i";
    if URL.HasFragment "$i"; then
        echo "#";
        URL.Fragment <<< "$i";
    fi;
    if URL.HasQuery "$i"; then
        echo "?";
        URL.Query <<< "$i";
    fi
}
URL.GetQuery () 
{ 
    grep "^ *$1=" | cut -d "=" -f 2-
}
URL.ParseQuery () 
{ 
    local i="${1-""}";
    if [[ -z "${i}" ]]; then
        read -r i;
    fi;
    if grep -q "[a-zA-Z]://" <<< "$i"; then
        i="$(URL.Query <<< "$i")";
    fi;
    i="$(sed "s|^\?||g" <<< "$i")";
    tr "&" "\n" <<< "$i" | cut -d "#" -f 1
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
Fsblib.EnvCheck () 
{ 
    case "$FSBLIB_REQUIRE" in 
        "Any")
            return 0
        ;;
        "ModernShell")
            [[ "$(cut -d "." -f 1 <<< "$BASH_VERSION")" = "5" ]] && return 0
        ;;
    esac
}
FsblibEnvCheck () 
{ 
    Fsblib.EnvCheck
}
Awk.Cos () 
{ 
    Awk.Float "cos($*)"
}
Awk.Float () 
{ 
    local AWKSCALE="${AWKSCALE-"5"}";
    awk "BEGIN {printf (\"%4.${AWKSCALE}f\n\", $*)}"
}
Awk.Log () 
{ 
    local _Base="$1" _Number="$2";
    Awk.Float "log(${_Number}) / log($_Base)"
}
Awk.Pi () 
{ 
    Awk.Float "atan2(0, -0)"
}
Awk.Print () 
{ 
    awk "BEGIN {print $*}"
}
Awk.Rad () 
{ 
    Awk.Float "$1 * $(Awk.Pi) / 180 "
}
Awk.Sin () 
{ 
    Awk.Float "sin($*)"
}
Awk.Tan () 
{ 
    Awk.Float "sin($1)/tan($1)"
}
Cache.Exist () 
{ 
    local _File;
    _File="$(Cache.CreateDir)/$1";
    [[ -e "$_File" ]] || return 1;
    (( "$(Cache.GetTimeDiffFromLastUpdate "$_File")" > "${KEEPCACHESEC-"86400"}" )) && return 2;
    return 0
}
Cache.Get () 
{ 
    cat "$(Cache.GetDir)/$1" 2> /dev/null || return 1
}
Cache.GetDir () 
{ 
    echo "${TMPDIR-"/tmp"}/$(Cache.GetID)"
}
Cache.GetFileLastUpdate () 
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
Cache.GetID () 
{ 
    if [[ -z "${FSBLIB_CACHEID-""}" ]]; then
        Cache.CreateDir > /dev/null;
    fi;
    echo "$FSBLIB_CACHEID"
}
Cache.GetTimeDiffFromLastUpdate () 
{ 
    local _Now _Last;
    _Now="$(date "+%s")";
    _Last="$(Cache.GetFileLastUpdate "$1")";
    echo "$(( _Now - _Last ))";
    return 0
}
Cache.Create () 
{ 
    Cache.CreateDir > /dev/null;
    cat > "$(Cache.GetDir)/${1}";
    cat "$(Cache.GetDir)/$1"
}
Cache.CreateDir () 
{ 
    FSBLIB_CACHEID="${FSBLIB_CACHEID-"$(RandomString "10")"}";
    export FSBLIB_CACHEID="$FSBLIB_CACHEID";
    local TMPDIR="${TMPDIR-"/tmp"}";
    local _Dir="$TMPDIR/${FSBLIB_CACHEID}";
    mkdir -p "$_Dir";
    echo "$_Dir";
    return 0
}
Array.Append () 
{ 
    local _ArrName="$1";
    shift 1 || return 1;
    readarray -t -O "$(ArrayIndex "$_ArrName")" "$_ArrName" < <(cat)
}
Array.FromStr () 
{ 
    declare -a -x "$1";
    readarray -t "$1" < <(BreakChar)
}
Array.Pop () 
{ 
    readarray -t "$1" < <(PrintEvalArray "$1" | sed -e '$d')
}
Array.Push () 
{ 
    eval "PrintArray \"\${$1[@]}\"" | grep -qx "$2" && return 0;
    eval "$1+=(\"$2\")"
}
Array.Remove () 
{ 
    readarray -t "$1" < <(PrintEvalArray "$1" | RemoveMatchLine "$2")
}
Array.Rev () 
{ 
    readarray -t "$1" < <(PrintEvalArray "$1" | tac)
}
Array.Shift () 
{ 
    readarray -t "$1" < <(PrintEvalArray "$1" | sed "1,${2-"1"}d")
}
Array.Eval () 
{ 
    eval "PrintArray \"\${$1[@]}\""
}
Array.Print () 
{ 
    (( $# >= 1 )) || return 0;
    printf "%s\n" "${@}"
}
Array.IndexOf () 
{ 
    local n=();
    readarray -t n < <(grep -x -n "$1" | cut -d ":" -f 1 | ForEach eval echo '$(( {} - 1 ))');
    (( "${#n[@]}" >= 1 )) || return 1;
    PrintArray "${n[@]}";
    return 0
}
Array.Length () 
{ 
    PrintEvalArray "$1" | wc -l
}
Array.Includes () 
{ 
    PrintEvalArray "$1" | grep -qx "$2"
}
