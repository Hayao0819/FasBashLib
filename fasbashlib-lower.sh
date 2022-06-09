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

FSBLIB_VERSION="v0.2.3.r158.gd7a5005-lower"
FSBLIB_REQUIRE="ModernBash"

Ini.getParam () 
{ 
    local _RawIniLine=();
    local _Line _LineNo=1 _Exit=0 _InSection=false;
    readarray -t _RawIniLine;
    while read -r _Line; do
        Ini.parseLine <<< "$_Line";
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
Ini.getParamList () 
{ 
    local _RawIniLine=();
    local _Line _LineNo=1 _Exit=0 _InSection=false;
    readarray -t _RawIniLine;
    while read -r _Line; do
        Ini.parseLine <<< "$_Line";
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
Ini.getSectionList () 
{ 
    local _RawIniLine=();
    local _Line _LineNo=1 _Exit=0;
    readarray -t _RawIniLine;
    while read -r _Line; do
        Ini.parseLine <<< "$_Line";
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
Ini.parseLine () 
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
choice () 
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
Cache.exist () 
{ 
    local _File;
    _File="$(Cache.createDir)/$1";
    [[ -e "$_File" ]] || return 1;
    (( "$(Cache.getTimeDiffFromLastUpdate "$_File")" > "${KEEPCACHESEC-"86400"}" )) && return 2;
    return 0
}
Cache.get () 
{ 
    cat "$(Cache.getDir)/$1" 2> /dev/null || return 1
}
Cache.getDir () 
{ 
    echo "${TMPDIR-"/tmp"}/$(Cache.getID)"
}
Cache.getFileLastUpdate () 
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
Cache.getID () 
{ 
    if [[ -z "${FSBLIB_CACHEID-""}" ]]; then
        Cache.createDir > /dev/null;
    fi;
    echo "$FSBLIB_CACHEID"
}
Cache.getTimeDiffFromLastUpdate () 
{ 
    local _Now _Last;
    _Now="$(date "+%s")";
    _Last="$(Cache.getFileLastUpdate "$1")";
    echo "$(( _Now - _Last ))";
    return 0
}
Cache.create () 
{ 
    Cache.createDir > /dev/null;
    cat > "$(Cache.getDir)/${1}";
    cat "$(Cache.getDir)/$1"
}
Cache.createDir () 
{ 
    FSBLIB_CACHEID="${FSBLIB_CACHEID-"$(RandomString "10")"}";
    export FSBLIB_CACHEID="$FSBLIB_CACHEID";
    local TMPDIR="${TMPDIR-"/tmp"}";
    local _Dir="$TMPDIR/${FSBLIB_CACHEID}";
    mkdir -p "$_Dir";
    echo "$_Dir";
    return 0
}
addNewToArray () 
{ 
    Array.Push "$@"
}
arrayAppend () 
{ 
    Array.Append "$1"
}
arrayIncludes () 
{ 
    Array.Includes "$@"
}
arrayIndex () 
{ 
    Array.Length "$1"
}
getArrayIndex () 
{ 
    Array.IndexOf "$1"
}
printArray () 
{ 
    Array.Print "$@"
}
printEvalArray () 
{ 
    Array.Eval "$1"
}
revArray () 
{ 
    Array.Rev "$1"
}
strToCharList () 
{ 
    Array.FromStr "$1"
}
fileType () 
{ 
    file --mime-type -b "$1"
}
getBaseName () 
{ 
    ForEach basename "{}"
}
getFileExt () 
{ 
    GetBaseName | rev | cut -d "." -f 1 | rev
}
removeFileExt () 
{ 
    local Ext;
    ForEach eval 'Ext=$(GetFileExt <<< {}); sed "s|.$Ext$||g" <<< {}; unset Ext'
}
checkFuncDefined () 
{ 
    typeset -f "${1}" > /dev/null || return 1
}
forEach () 
{ 
    local _Item;
    while read -r _Item; do
        "${@//"{}"/"${_Item}"}" || return "${?}";
    done
}
getLine () 
{ 
    head -n "$1" | tail -n 1
}
isAvailable () 
{ 
    type "$1" 2> /dev/null 1>&2
}
loop () 
{ 
    local _T="$1";
    shift 1 || return 1;
    ForEach "$@" < <(yes "" | head -n "$_T")
}
breakChar () 
{ 
    grep -o "."
}
cutLastString () 
{ 
    echo "${1%%"${2}"}";
    return 0
}
getLastSplitString () 
{ 
    rev <<< "$2" | cut -d "$1" -f 1 | rev
}
isUUID () 
{ 
    local _UUID="${1-""}";
    [[ "${_UUID//-/}" =~ ^[[:xdigit:]]{32}$ ]] && return 0;
    return 1
}
printEval () 
{ 
    eval echo "\${$1}"
}
randomString () 
{ 
    base64 < "/dev/random" | fold -w "$1" | head -n 1;
    return 0
}
removeBlank () 
{ 
    sed "s|^ *||g; s| *$||g; s|^	*||g; s|	*$||g; /^$/d"
}
textBox () 
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
toLower () 
{ 
    local _Str="${1,,}";
    [[ -z "${_Str-""}" ]] || echo "${_Str}"
}
toLowerStdin () 
{ 
    local _Str;
    ForEach eval "_Str=\"{}\"; echo \"\${_Str,,}\"";
    unset _Str
}
calcInt () 
{ 
    echo "$(( "$@" ))"
}
ntest () 
{ 
    (( "$@" )) || return 1
}
sum () 
{ 
    local _Arg=();
    ForEach eval '_Arg+=("{}" "+")' < <(PrintArray "$@");
    readarray -t _Arg < <(PrintArray "${_Arg[@]}" | sed "${#_Arg[@]}d");
    CalcInt "${_Arg[@]}"
}
bool () 
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
getFuncList () 
{ 
    declare -F | cut -d " " -f 3
}
unsetAllFunc () 
{ 
    local Func;
    while read -r Func; do
        unset "$Func";
    done < <(GetFuncList)
}
removeMatchLine () 
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
Csv.getClm () 
{ 
    grep -v "^#" | sed "/^$/d" | cut -d "${CSVDELIM-","}" -f "$1"
}
Csv.getClmCnt () 
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
Csv.toBashArray () 
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
    _ClmCnt=$(PrintArray "${_RawCsvLine[@]}" | Csv.getClmCnt);
    while read -r _Cnt; do
        readarray -t "$(sed "s|{}|$(eval "echo \"\${${_Cnt}}\"")|g" <<< "$ArrayPrefix")" < <(
            # shellcheck disable=SC2031
            PrintArray "${_RawCsvLine[@]}" | cut -d "${CSVDELIM-","}" -f "$_Cnt"
        );
    done < <(seq 1 "$#")
}
fsblibEnvCheck () 
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
Misskey.setup () 
{ 
    export MISSKEY_DOMAIN="${1-"${MISSKEY_DOMAIN-""}"}";
    export MISSKEY_TOKEN="${2-"${MISSKEY_DOMAIN-""}"}";
    export MISSKEY_ENTRY="https://${MISSKEY_DOMAIN}/api"
}
Misskey.bindingBase () 
{ 
    local _API="$1";
    shift 1;
    local i _APIArgs _Args;
    for i in "$@";
    do
        shift 1;
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
        shift 1;
        if (( "$#" <= "$i" )) || [[ -z "${_APIArgs[$i]-""}" ]]; then
            break;
        fi;
    done;
    Misskey.sendReq "$MISSKEY_ENTRY/$_API" "${_Args[@]}" "$@"
}
Misskey.makeJson () 
{ 
    local i _Key _Value;
    for i in "i=$MISSKEY_TOKEN" "$@";
    do
        _Key=$(cut -d "=" -f 1 <<< "$i");
        _Value=$(cut -d "=" -f 2- <<< "$i");
        if [[ "$_Value" =~ ^[0-9]+$ ]] || [[ "$_Value" = true ]] || [[ "$_Value" = false ]] || [[ "$_Value" = "{"*"}" ]]; then
            echo -n "{\"$_Key\": $_Value}";
        else
            echo -n "{\"$_Key\": \"$_Value\"}";
        fi;
    done | sed "s|}{|,|g" | jq -c -M
}
Misskey.sendReq () 
{ 
    local _Url="$1" _CurlArgs=();
    shift 1;
    _CurlArgs+=(-s -L);
    _CurlArgs+=(-X POST);
    _CurlArgs+=(-H "Content-Type: application/json");
    _CurlArgs+=(-d "$(Misskey.makeJson "$@")");
    _CurlArgs+=("$_Url");
    Msg.Debug "Run: ${_CurlArgs[*]//"${MISSKEY_TOKEN}"/"TOKEN"})";
    curl "${_CurlArgs[@]}"
}
Misskey.notes.Create () 
{ 
    Misskey.bindingBase "notes/create" text -- "$@"
}
Misskey.notes.Renotes () 
{ 
    Misskey.bindingBase "notes/renotes" noteId limit sinceId untilId -- "$@"
}
Misskey.notes.Search () 
{ 
    Misskey.bindingBase "notes/search" query limit -- "$@"
}
Misskey.users.Notes () 
{ 
    Misskey.bindingBase "users/notes" userId -- "$@"
}
Awk.awkPrint () 
{ 
    awk "BEGIN {print $*}"
}
Awk.cos () 
{ 
    @Calc "cos($*)"
}
Awk.log () 
{ 
    local _Base="$1" _Number="$2";
    @Calc "log(${_Number}) / log($_Base)"
}
Awk.pi () 
{ 
    @Calc "atan2(0, -0)"
}
Awk.rad () 
{ 
    @Calc "$1 * $(Awk.pi) / 180 "
}
Awk.sin () 
{ 
    @Calc "sin($*)"
}
Awk.tan () 
{ 
    @Calc "sin($1)/tan($1)"
}
Arch.getKernelFileList () 
{ 
    find "/boot" -maxdepth 1 -mindepth 1 -name "vmlinuz-*"
}
Arch.getKernelSrcList () 
{ 
    find "/usr/src" -mindepth 1 -maxdepth 1 -type l -name "linux*"
}
Arch.getMkinitcpioPresetList () 
{ 
    find "/etc/mkinitcpio.d/" -name "*.preset" -type f | GetBaseName | RemoveFileExt
}
Pm.checkPkg () 
{ 
    local p;
    for p in "$@";
    do
        Pm.run -Qq "$p" > /dev/null 2>&1 || return 1;
    done;
    return 0
}
Pm.getConfig () 
{ 
    LANG=C pacman-conf --config="${PACMAN_CONF-"/etc/pacman.conf"}" "$@"
}
Pm.getInstalledPkgVer () 
{ 
    ForEach pacman -Qq "{}" | cut -d " " -f 2;
    PrintArray "${PIPESTATUS[@]}" | grep -qx "1" && return 1;
    return 0
}
Pm.getKeyringList () 
{ 
    find "$(@GetKeyringDir)" -name "*.gpg" | GetBaseName | RemoveFileExt
}
Pm.getLatestPkgVer () 
{ 
    local _LANG="${LANG-""}";
    export LANG=C;
    ForEach Pm.run -Si "{}" | grep "^Version" | cut -d ":" -f 2 | RemoveBlank;
    [[ -n "$_LANG" ]] && export LANG="$_LANG";
    return 0
}
Pm.getName () 
{ 
    cut -d "<" -f 1 | cut -d ">" -f 1 | cut -d "=" -f 1
}
Pm.getPacmanKernelPkg () 
{ 
    echo "there is nothing"
}
Pm.getPacmanKeyringDir () 
{ 
    local _KeyringDir="";
    _KeyringDir="$(LANG=C pacman-key -h | RemoveBlank | grep -A 1 -- "^--populate" | tail -n 1 | cut -d "/" -f 2- | sed "s|'$||g")";
    : "${_KeyringDir="usr/share/pacman/keyrings"}";
    _KeyringDir="$(Pm.getRoot)/$_KeyringDir";
    _KeyringDir="$(sed -E "s|/+|/|g" <<< "$_KeyringDir")";
    if [[ -e "$_KeyringDir" ]]; then
        Readlinkf "$_KeyringDir";
    else
        echo "$_KeyringDir";
    fi
}
Pm.getRepoConf () 
{ 
    ForEach eval 'echo [{}] && Pm.getConfig -r {}'
}
Pm.getRepoListFromConf () 
{ 
    Pm.getConfig --repo-list
}
Pm.getRepoPkgList () 
{ 
    Pm.run -Slq "$@"
}
Pm.getRepoServer () 
{ 
    ForEach eval 'Pm.getConfig -r {}' | grep "^Server" | ForEach eval "Ini.ParseLine <<< '{}' ; printf '%s\n' \${VALUE}"
}
Pm.getRepoVer () 
{ 
    Pm.run -Sp --print-format '%v' "$1"
}
Pm.getRoot () 
{ 
    Pm.getConfig RootDir
}
Pm.isRepoPkg () 
{ 
    Pm.run -Slq | grep -qx "$(Pm.getName <<< "$1")"
}
Pm.pacmanGpg () 
{ 
    gpg --homedir "$(Pm.getConfig GPGDir)" "$@"
}
Pm.run () 
{ 
    pacman --noconfirm --config "${PACMAN_CONF-"/etc/pacman.conf"}" "$@"
}
Pm.runKey () 
{ 
    pacman-key --config "${PACMAN_CONF-"/etc/pacman.conf"}" "$@"
}
Pm.getDbNextSection () 
{ 
    Pm.getDbSectionList | grep -x -A 1 "^%$1%$" | GetLine 2 | sed "s|^%||g; s|%$||g"
}
Pm.getDbSection () 
{ 
    readarray -t _Stdin;
    PrintArray "${_Stdin[@]}" | sed -ne "/^%$1%$/,/^%$(PrintEvalArray _Stdin | Pm.getDbNextSection "$1")%$/p" | sed "1d; \$d"
}
Pm.getDbSectionList () 
{ 
    grep -E "^%.*%$"
}
Pm.createDbTmpDir () 
{ 
    mkdir -p "$(Pm.getDbTmpDir)"
}
Pm.deleteDbTmpDir () 
{ 
    rm -rf "$(Pm.getDbTmpDir)"
}
Pm.getDbTmpDir () 
{ 
    echo "${TMPDIR-"/tmp"}/fasbashlib-pacman-db"
}
Pm.getPkgArch () 
{ 
    Pm.getSyncDbDesc "$1" | Pm.getDbSection ARCH | RemoveBlank
}
Pm.getRepoListFromLocalDb () 
{ 
    find "$(Pm.getConfig DBPath)/sync" -mindepth 1 -maxdepth 1 -type f | GetBaseName | sed "s|.db$||g";
    return 0
}
Pm.getSyncAllDesc () 
{ 
    find "$(Pm.getDbTmpDir)" -mindepth 3 -maxdepth 3 -name "desc" -type f
}
Pm.getSyncDbDesc () 
{ 
    local _path;
    _path="$(Pm.getSyncDbDescPath "$1")";
    [[ -e "$_path" ]] || return 1;
    cat "$_path/desc"
}
Pm.getSyncDbDescPath () 
{ 
    local _repo;
    _repo="$(pacman -Sp --print-format '%r' "$1")";
    { 
        IsPacmanSyncDbOpend "$_repo" || OpenPacmanSyncDb "$_repo"
    } || return 1;
    echo "$(Pm.getDbTmpDir)/sync/$(pacman -Sp --print-format '%r/%n-%v' "$1")"
}
Pm.getVirtualPkgList () 
{ 
    Pm.getRepoListFromLocalDb | ForEach Pm.openSyncDb {};
    Pm.getSyncAllDesc | ForEach eval "Pm.getDbSection PROVIDES < {}" | RemoveBlank
}
Pm.isOpendSyncDb () 
{ 
    readarray -t _PkgDbList < <(find "$(Pm.getDbTmpDir)/sync/$1" -mindepth 1 -maxdepth 1 -type d );
    (( "${#_PkgDbList[@]}" > 0 )) && return 0;
    return 1
}
Pm.openSyncDb () 
{ 
    local _Dir _RepoDb;
    Pm.createDbTmpDir;
    _Dir="$(Pm.getDbTmpDir)/sync/$1";
    mkdir -p "$_Dir";
    _RepoDb="$(Pm.getConfig DBPath)/sync/$1.db";
    [[ -e "$_RepoDb" ]] || return 1;
    tar -xzf "${_RepoDb}" -C "$_Dir" || return 1
}
Pm.openedSyncDbList () 
{ 
    find "$(Pm.getDbTmpDir)/sync/" -mindepth 1 -maxdepth 1 -type d
}
Pm.parsePkgFileName () 
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
readlinkf () 
{ 
    Readlinkf_Posix "$@"
}
readlinkf_Posix () 
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
readlinkf_Readlink () 
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
Array.append () 
{ 
    local _ArrName="$1";
    shift 1 || return 1;
    readarray -t -O "$(ArrayIndex "$_ArrName")" "$_ArrName" < <(cat)
}
Array.fromStr () 
{ 
    declare -a -x "$1";
    readarray -t "$1" < <(BreakChar)
}
Array.pop () 
{ 
    readarray -t "$1" < <(PrintEvalArray "$1" | sed -e '$d')
}
Array.push () 
{ 
    eval "PrintArray \"\${$1[@]}\"" | grep -qx "$2" && return 0;
    eval "$1+=(\"$2\")"
}
Array.remove () 
{ 
    readarray -t "$1" < <(PrintEvalArray "$1" | RemoveMatchLine "$2")
}
Array.rev () 
{ 
    readarray -t "$1" < <(PrintEvalArray "$1" | tac)
}
Array.shift () 
{ 
    readarray -t "$1" < <(PrintEvalArray "$1" | sed "1,${2-"1"}d")
}
Array.eval () 
{ 
    eval "PrintArray \"\${$1[@]}\""
}
Array.print () 
{ 
    (( $# >= 1 )) || return 0;
    printf "%s\n" "${@}"
}
Array.indexOf () 
{ 
    local n=();
    readarray -t n < <(grep -x -n "$1" | cut -d ":" -f 1 | ForEach eval echo '$(( {} - 1 ))');
    (( "${#n[@]}" >= 1 )) || return 1;
    PrintArray "${n[@]}";
    return 0
}
Array.length () 
{ 
    PrintEvalArray "$1" | wc -l
}
Array.includes () 
{ 
    PrintEvalArray "$1" | grep -qx "$2"
}
URL.authority () 
{ 
    local i _NoScheme;
    while read -r i; do
        _NoScheme=$(URL.noScheme <<< "$i");
        [[ "$_NoScheme" == "//"* ]] || return 1;
        cut -d "/" -f 1 < <(sed "s|^//||g" <<< "$_NoScheme");
    done
}
URL.fragment () 
{ 
    URL.pathAndQueryAndFragment | cut -d "#" -f 2-
}
URL.host () 
{ 
    URL.authority | cut -d "@" -f 2- | cut -d ":" -f 1
}
URL.noScheme () 
{ 
    cut -d ":" -f 2-
}
URL.path () 
{ 
    URL.pathAndQueryAndFragment | cut -d "#" -f 1 | cut -d "?" -f 1
}
URL.pathAndQueryAndFragment () 
{ 
    local i;
    while read -r i; do
        sed "s|^//$(URL.authority <<< "$i")||g" <<< "$(URL.noScheme <<< "$i")";
    done
}
URL.port () 
{ 
    local i;
    while read -r i; do
        [[ "$i" == *":"* ]] || { 
            echo "80";
            continue
        };
        cut -d ":" -f 2 <<< "$i";
    done < <(URL.authority)
}
URL.query () 
{ 
    URL.pathAndQueryAndFragment | cut -d "?" -f 2-
}
URL.scheme () 
{ 
    cut -d ":" -f 1
}
URL.user () 
{ 
    local i;
    while read -r i; do
        [[ "$i" == *"@"* ]] || { 
            echo "";
            continue
        };
        cut -d "@" -f 1 <<< "$i";
    done < <(URL.authority)
}
URL.hasAuthority () 
{ 
    [[ "$(URL.noScheme <<< "$1")" = "//"* ]]
}
URL.hasFragment () 
{ 
    [[ "$(URL.pathAndQueryAndFragment <<< "$1")" = *"#"* ]]
}
URL.hasPort () 
{ 
    [[ "$(URL.authority <<< "$1")" = *":"* ]]
}
URL.hasQuery () 
{ 
    [[ "$(URL.pathAndQueryAndFragment <<< "$1")" = *"?"* ]]
}
URL.hasUser () 
{ 
    [[ "$(URL.authority <<< "$1")" = *"@"* ]]
}
URL.parse () 
{ 
    local i="$1";
    URL.scheme <<< "$i";
    echo ":";
    if URL.hasAuthority "$i"; then
        if URL.hasUser "$i"; then
            URL.user <<< "$i";
            echo "@";
        fi;
        URL.host <<< "$i";
        if URL.hasPort "$i"; then
            echo ":";
            URL.port <<< "$i";
        fi;
    fi;
    URL.path <<< "$i";
    if URL.hasFragment "$i"; then
        echo "#";
        URL.fragment <<< "$i";
    fi;
    if URL.hasQuery "$i"; then
        echo "?";
        URL.query <<< "$i";
    fi
}
parseArg () 
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
SrcInfo.format () 
{ 
    RemoveBlank | sed "/^$/d" | grep -v "^#" | ForEach eval "SrcInfo.parse Line <<< \"{}\""
}
SrcInfo.getKeyList () 
{ 
    SrcInfo.format | cut -d "=" -f 1
}
SrcInfo.getPkgBase () 
{ 
    local _Line _Key _InSection=false;
    while read -r _Line; do
        _Key="$(SrcInfo.parse Key <<< "$_Line")";
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
    done < <(SrcInfo.format)
}
SrcInfo.getPkgName () 
{ 
    local _Line _Key _InSection=false _TargetPkgName="$1";
    while read -r _Line; do
        _Key="$(SrcInfo.parse Key <<< "$_Line")";
        case "$_Key" in 
            "pkgname")
                if [[ "$(SrcInfo.parse Value <<< "$_Line")" = "$_TargetPkgName" ]]; then
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
    done < <(SrcInfo.format)
}
SrcInfo.getSectionList () 
{ 
    SrcInfo.format | grep -e "^pkgbase" -e "^pkgname"
}
SrcInfo.getValue () 
{ 
    local _SrcInfo=();
    local _Output=();
    local _PkgBaseValues=("pkgver" "pkgrel" "epoch");
    local _AllValues=("pkgdesc" "url" "install" "changelog");
    local _AllArrays=("arch" "groups" "license" "noextract" "options" "backup" "validpgpkeys");
    local _AllArraysWithArch=("source" "depends" "checkdepends" "makedepends" "optdepends" "provides" "conflicts" "replaces" "md5sums" "sha1sums" "sha224sums" "sha256sums" "sha384sums" "sha512sums");
    ArrayAppend _SrcInfo;
    ArrayIncludes _PkgBaseValues "$1" && { 
        PrintEvalArray _SrcInfo | SrcInfo.getValueInPkgBase "$1";
        return 0
    };
    [[ -n "${2-""}" ]] || return 1;
    if ArrayIncludes _AllValues "$1" || ArrayIncludes _AllArrays "$1"; then
        ArrayAppend _Output < <(PrintEvalArray _SrcInfo | SrcInfo.getValueInPkgBase "$1");
        ArrayAppend _Output < <(PrintEvalArray _SrcInfo | SrcInfo.getValueInPkgName "$2" "$1");
        PrintArray "${_Output[@]}" | tail -n 1;
        return 0;
    fi;
    ArrayIncludes _AllArraysWithArch "$1" || return 1;
    local _Arch _ArchList;
    if [[ -z "${3-""}" ]]; then
        ArrayAppend _ArchList < <(PrintEvalArray _SrcInfo | SrcInfo.getValue arch "$2");
    else
        ArrayAppend _ArchList < <(tr "," "\n" <<< "$3" | RemoveBlank);
    fi;
    ArrayAppend _Output < <(PrintEvalArray _SrcInfo | SrcInfo.getValueInPkgBase "$1");
    ArrayAppend _Output < <(PrintEvalArray _SrcInfo | SrcInfo.getValueInPkgName "$2" "$1");
    for _Arch in "${_ArchList[@]}";
    do
        ArrayAppend _Output < <(PrintEvalArray _SrcInfo | SrcInfo.getValueInPkgBase "$1_${_Arch}");
        ArrayAppend _Output < <(PrintEvalArray _SrcInfo | SrcInfo.getValueInPkgName "$2" "$1_${_Arch}");
    done;
    PrintEvalArray _Output;
    return 0
}
SrcInfo.getValueInPkgBase () 
{ 
    local _Line;
    while read -r _Line; do
        _Key="$(SrcInfo.parse Key <<< "$_Line")";
        case "$_Key" in 
            "$1")
                SrcInfo.parse Value <<< "$_Line"
            ;;
        esac;
    done < <(SrcInfo.getPkgBase)
}
SrcInfo.getValueInPkgName () 
{ 
    local _Line;
    while read -r _Line; do
        _Key="$(SrcInfo.parse Key <<< "$_Line")";
        case "$_Key" in 
            "$2")
                SrcInfo.parse Value <<< "$_Line"
            ;;
        esac;
    done < <(SrcInfo.getPkgName "$1")
}
SrcInfo.parse () 
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
Msg.common () 
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
Msg.debug () 
{ 
    Msg.common "Debug:" "${*}" stderr
}
Msg.err () 
{ 
    Msg.common "Error:" "${*}" stderr
}
Msg.info () 
{ 
    Msg.common " Info:" "${*}" stdout
}
Msg.warn () 
{ 
    Msg.common " Warn:" "${*}" stderr
}
