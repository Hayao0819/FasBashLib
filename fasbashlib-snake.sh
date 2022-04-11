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

FSBLIB_VERSION="v0.1.5.r111.gd7cab1e"
FSBLIB_REQUIRE="ModernBash"

csv.get_clm () 
{ 
    grep -v "^#" | sed "/^$/d" | cut -d "${CSVDELIM-","}" -f "$1"
}
csv.get_clm_cnt () 
{ 
    local _RawCsvLine=();
    local _Line _ClmCnt=0;
    readarray -t _RawCsvLine;
    while read -r _Line; do
        grep -qE "^#" <<< "$_Line" && continue;
        _CurrentClmCnt=$(tr "${CSVDELIM-","}" "\n" | wc -l);
        (( _CurrentClmCnt > _ClmCnt )) && _ClmCnt="$_CurrentClmCnt";
    done < <(print_array "${_RawCsvLine[@]}");
    remove_blank <<< "$_ClmCnt";
    return 0
}
csv.to_bash_array () 
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
    _ClmCnt=$(print_array "${_RawCsvLine[@]}" | csv.get_clm_cnt);
    while read -r _Cnt; do
        readarray -t "$(sed "s|{}|$(eval "echo \"\${${_Cnt}}\"")|g" <<< "$ArrayPrefix")" < <(
            # shellcheck disable=SC2031
            print_array "${_RawCsvLine[@]}" | cut -d "${CSVDELIM-","}" -f "$_Cnt"
        );
    done < <(seq 1 "$#")
}
add_new_to_array () 
{ 
    eval "print_array \"\${$1[@]}\"" | grep -qx "$2" && return 0;
    eval "$1+=(\"$2\")"
}
array_append () 
{ 
    local _ArrName="$1";
    shift 1 || return 1;
    readarray -t -O "$(array_index "$_ArrName")" "$_ArrName" < <(cat)
}
array_includes () 
{ 
    print_eval_array "$1" | grep -qx "$2"
}
array_index () 
{ 
    print_eval_array "$1" | wc -l
}
get_array_index () 
{ 
    local n=();
    readarray -t n < <(grep -x -n "$1" | cut -d ":" -f 1 | for_each eval echo '$(( {} - 1 ))');
    (( "${#n[@]}" >= 1 )) || return 1;
    print_array "${n[@]}";
    return 0
}
print_array () 
{ 
    (( $# >= 1 )) || return 0;
    printf "%s\n" "${@}"
}
print_eval_array () 
{ 
    eval "print_array \"\${$1[@]}\""
}
rev_array () 
{ 
    readarray -t "$1" < <(print_eval_array "$1" | tac)
}
file_type () 
{ 
    file --mime-type -b "$1"
}
get_base_name () 
{ 
    xargs -L 1 basename
}
get_file_ext () 
{ 
    get_base_name | rev | cut -d "." -f 1 | rev
}
remove_file_ext () 
{ 
    local Ext;
    for_each eval 'Ext=$(get_file_ext <<< {}); sed "s|.$Ext$||g" <<< {}; unset Ext'
}
check_func_defined () 
{ 
    typeset -f "${1}" > /dev/null || return 1
}
for_each () 
{ 
    local _Item;
    while read -r _Item; do
        "${@//"{}"/"${_Item}"}" || return "${?}";
    done
}
get_line () 
{ 
    head -n "$1" | tail -n 1
}
is_available () 
{ 
    type "$1" 2> /dev/null 1>&2
}
cut_last_string () 
{ 
    echo "${1%%"${2}"}";
    return 0
}
get_last_split_string () 
{ 
    rev <<< "$2" | cut -d "$1" -f 1 | rev
}
is_uu_id () 
{ 
    local _UUID="${1-""}";
    [[ "${_UUID//-/}" =~ ^[[:xdigit:]]{32}$ ]] && return 0;
    return 1
}
print_eval () 
{ 
    eval echo "\${$1}"
}
random_string () 
{ 
    base64 < "/dev/random" | fold -w "$1" | head -n 1;
    return 0
}
remove_blank () 
{ 
    sed "s|^ *||g; s| *$||g; s|^	*||g; s|	*$||g; /^$/d"
}
to_lower () 
{ 
    local _Str="${1,,}";
    [[ -z "${_Str-""}" ]] || echo "${_Str}"
}
to_lower_stdin () 
{ 
    local _Str;
    for_each eval "_Str=\"{}\"; echo \"\${_Str,,}\"";
    unset _Str
}
calc_int () 
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
    for_each eval '_Arg+=("{}" "+")' < <(print_array "$@");
    readarray -t _Arg < <(print_array "${_Arg[@]}" | sed "${#_Arg[@]}d");
    calc_int "${_Arg[@]}"
}
bool () 
{ 
    case "$(to_lower "$(print_eval "${1}")")" in 
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
get_func_list () 
{ 
    declare -F | cut -d " " -f 3
}
unset_all_func () 
{ 
    local Func;
    while read -r Func; do
        unset "$Func";
    done < <(get_func_list)
}
msg.common () 
{ 
    local i l="$1";
    shift 1 || return 1;
    for i in $(seq "$(echo -e "${*}" | wc -l)");
    do
        echo -n "$l ";
        echo -e "${*}" | head -n "${i}" | tail -n 1;
    done
}
msg.debug () 
{ 
    msg.common "Debug:" "${*}" 1>&2
}
msg.err () 
{ 
    msg.common "Error:" "${*}" 1>&2
}
msg.info () 
{ 
    msg.common " Info:" "${*}" 1>&1
}
msg.warn () 
{ 
    msg.common " Warn:" "${*}" 1>&2
}
aur.check_json () 
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
aur.get_all_depends () 
{ 
    jq -r ".Depends[], .MakeDepends[]"
}
aur.get_depends () 
{ 
    jq -r ".Depends[]"
}
aur.get_description () 
{ 
    jq -r ".Description"
}
aur.get_first_submitted () 
{ 
    jq -r ".FirstSubmitted"
}
aur.get_id () 
{ 
    jq -r ".ID"
}
aur.get_info () 
{ 
    GetRawAurInfo "$1" | aur.check_json
}
aur.get_keywords () 
{ 
    jq -r ".Keywords[]"
}
aur.get_last_modified () 
{ 
    jq -r ".LastModified"
}
aur.get_license () 
{ 
    jq -r ".License[]"
}
aur.get_maintainer () 
{ 
    jq -r ".Maintainer"
}
aur.get_make_depends () 
{ 
    jq -r ".MakeDepends[]"
}
aur.get_num_votes () 
{ 
    jq -r ".NumVotes"
}
aur.get_opt_depends () 
{ 
    jq -r ".OptDepends[]"
}
aur.get_package_base () 
{ 
    jq -r ".PackageBase"
}
aur.get_package_base_id () 
{ 
    jq -r ".PackageBaseID"
}
aur.get_popularity () 
{ 
    jq -r ".Popularity"
}
aur.get_raw_info () 
{ 
    curl -sL "https://aur.archlinux.org/rpc?v=5&type=info&arg=${1}"
}
aur.get_recursive_depends () 
{ 
    local _Pkg;
    _Pkg="$(pm.get_name <<< "$1")";
    _AurDependList=();
    export FSBLIB_CACHEID="FasBashLib_Aur";
    ExistCache "InstalledPackage" || RunPacman -Qq | CreateCache "InstalledPackage" > /dev/null;
    ExistCache "RepoPackage" || GetPacmanRepoPkgList | CreateCache "RepoPackage" > /dev/null;
    function _Resolve () 
    { 
        GetCache "RepoPackage" | grep -qx "$1" && return 0;
        while read -r _P; do
            array_includes _AurDependList "$_P" && continue;
            GetCache "RepoPackage" | grep -qx "$_P" && continue;
            _AurDependList+=("$_P");
            _Resolve "$_P";
        done < <(aur.get_info "$1" | aur.get_all_depends | pm.get_name)
    };
    _Resolve "$_Pkg";
    print_eval_array _AurDependList
}
aur.get_search () 
{ 
    local _Field="${1-"name-desc"}" _Keywords="$2";
    curl -sL "https://aur.archlinux.org/rpc?v=5&type=search&by=$_Field&arg=${_Keywords}" | aur.check_json
}
aur.get_ur_l () 
{ 
    jq -r ".URL"
}
aur.get_ur_lpath () 
{ 
    jq -r ".URLPath"
}
aur.get_version () 
{ 
    jq -r ".Version"
}
aur.info_to_bash () 
{ 
    local _Prefix="${AurPrefix-"{}"}" _Json;
    local _ArrName _VarName;
    _Json="$(cat)";
    for _JsonKey in "Depends" "Keywords" "License" "MakeDepends" "OptDepends";
    do
        _ArrName=$(sed "s|{}|$_JsonKey|g" <<< "$_Prefix");
        echo "${_ArrName}=($(Aur.Get$_JsonKey <<< "$_Json" | sed "s|^|\"|g; s|$|\" |g" | tr -d "\n"))";
    done;
    for _JsonKey in "Description" "FirstSubmitted" "ID" "LastModified" "Maintainer" "NumVotes" "PackageBase" "PackageBaseID" "Popularity" "URL" "URLPath" "Version";
    do
        _VarName=$(sed "s|{}|$_JsonKey|g" <<< "$_Prefix");
        echo "${_VarName}=\"$(Aur.Get$_JsonKey <<< "$_Json")\"";
    done
}
aur.is_pkg_out_of_dated () 
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
cache.exist () 
{ 
    local _File;
    _File="$(cache.create_dir)/$1";
    [[ -e "$_File" ]] || return 1;
    (( "$(cache.get_time_diff_from_last_update "$_File")" > "${KEEPCACHESEC-"86400"}" )) && return 2;
    return 0
}
cache.get () 
{ 
    cat "$(cache.get_dir)/$1" 2> /dev/null || return 1
}
cache.get_dir () 
{ 
    echo "${TMPDIR-"/tmp"}/$(cache.get_id)"
}
cache.get_file_last_update () 
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
cache.get_id () 
{ 
    if [[ -z "${FSBLIB_CACHEID-""}" ]]; then
        cache.create_dir > /dev/null;
    fi;
    echo "$FSBLIB_CACHEID"
}
cache.get_time_diff_from_last_update () 
{ 
    local _Now _Last;
    _Now="$(date "+%s")";
    _Last="$(cache.get_file_last_update "$1")";
    echo "$(( _Now - _Last ))";
    return 0
}
cache.create () 
{ 
    cache.create_dir > /dev/null;
    cat > "$(cache.get_dir)/${1}";
    cat "$(cache.get_dir)/$1"
}
cache.create_dir () 
{ 
    FSBLIB_CACHEID="${FSBLIB_CACHEID-"$(random_string "10")"}";
    export FSBLIB_CACHEID="$FSBLIB_CACHEID";
    local TMPDIR="${TMPDIR-"/tmp"}";
    local _Dir="$TMPDIR/${FSBLIB_CACHEID}";
    mkdir -p "$_Dir";
    echo "$_Dir";
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
parse_arg () 
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
                        msg.err "${1} の引数が指定されていません";
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
                        msg.err "${1} は不正なオプションです。-hで使い方を確認してください。";
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
                                msg.err "-${_Chr} の引数が指定されていません";
                                return 2;
                            fi;
                        else
                            if printf "%s\n" "${_Short[@]}" | grep -qx "${_Chr}"; then
                                _OutArg+=("-${_Chr}");
                                _Shift=1;
                            else
                                msg.err "-${_Chr} は不正なオプションです。-hで使い方を確認してください。";
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
awk.awk_print () 
{ 
    awk "BEGIN {print $*}"
}
awk.cos () 
{ 
    @Calc "cos($*)"
}
awk.log () 
{ 
    local _Base="$1" _Number="$2";
    @Calc "log(${_Number}) / log($_Base)"
}
awk.pi () 
{ 
    @Calc "atan2(0, -0)"
}
awk.rad () 
{ 
    @Calc "$1 * $(awk.pi) / 180 "
}
awk.sin () 
{ 
    @Calc "sin($*)"
}
awk.tan () 
{ 
    @Calc "sin($1)/tan($1)"
}
ini.get_param () 
{ 
    local _RawIniLine=();
    local _Line _LineNo=1 _Exit=0 _InSection=false;
    readarray -t _RawIniLine;
    while read -r _Line; do
        ini.parse_line <<< "$_Line";
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
    done < <(print_array "${_RawIniLine[@]}");
    return "$_Exit"
}
ini.get_param_list () 
{ 
    local _RawIniLine=();
    local _Line _LineNo=1 _Exit=0 _InSection=false;
    readarray -t _RawIniLine;
    while read -r _Line; do
        ini.parse_line <<< "$_Line";
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
    done < <(print_array "${_RawIniLine[@]}");
    return "$_Exit"
}
ini.get_section_list () 
{ 
    local _RawIniLine=();
    local _Line _LineNo=1 _Exit=0;
    readarray -t _RawIniLine;
    while read -r _Line; do
        ini.parse_line <<< "$_Line";
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
    done < <(print_array "${_RawIniLine[@]}");
    return "$_Exit"
}
ini.parse_line () 
{ 
    local _Line;
    TYPE="" PARAM="" VALUE="" SECTION="";
    _Line="$(remove_blank <<< "$(cat)")";
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
            PARAM="$(remove_blank <<< "$(cut -d "=" -f 1 <<< "$_Line")")";
            VALUE="$(remove_blank <<< "$(cut -d "=" -f 2- <<< "$_Line")")"
        ;;
        *)
            TYPE="ERROR"
        ;;
    esac;
    return 0
}
pm.check_pkg () 
{ 
    local p;
    for p in "$@";
    do
        pm.run -Qq "$p" > /dev/null 2>&1 || return 1;
    done;
    return 0
}
pm.get_config () 
{ 
    LANG=C pacman-conf --config="${PACMAN_CONF-"/etc/pacman.conf"}" "$@"
}
pm.get_installed_pkg_ver () 
{ 
    for_each pacman -Qq "{}" | cut -d " " -f 2;
    print_array "${PIPESTATUS[@]}" | grep -qx "1" && return 1;
    return 0
}
pm.get_keyring_list () 
{ 
    find "$(@GetKeyringDir)" -name "*.gpg" | get_base_name | remove_file_ext
}
pm.get_latest_pkg_ver () 
{ 
    local _LANG="${LANG-""}";
    export LANG=C;
    for_each pm.run -Si "{}" | grep "^Version" | cut -d ":" -f 2 | remove_blank;
    [[ -n "$_LANG" ]] && export LANG="$_LANG";
    return 0
}
pm.get_name () 
{ 
    cut -d "<" -f 1 | cut -d ">" -f 1 | cut -d "=" -f 1
}
pm.get_pacman_kernel_pkg () 
{ 
    echo "there is nothing"
}
pm.get_pacman_keyring_dir () 
{ 
    local _KeyringDir="";
    _KeyringDir="$(LANG=C pacman-key -h | remove_blank | grep -A 1 -- "^--populate" | tail -n 1 | cut -d "/" -f 2- | sed "s|'$||g")";
    : "${_KeyringDir="usr/share/pacman/keyrings"}";
    _KeyringDir="$(pm.get_root)/$_KeyringDir";
    _KeyringDir="$(sed -E "s|/+|/|g" <<< "$_KeyringDir")";
    if [[ -e "$_KeyringDir" ]]; then
        readlinkf "$_KeyringDir";
    else
        echo "$_KeyringDir";
    fi
}
pm.get_repo_conf () 
{ 
    for_each eval 'echo [{}] && pm.get_config -r {}'
}
pm.get_repo_list_from_conf () 
{ 
    pm.get_config --repo-list
}
pm.get_repo_pkg_list () 
{ 
    pm.run -Slq "$@"
}
pm.get_repo_server () 
{ 
    for_each eval 'pm.get_config -r {}' | grep "^Server" | for_each eval "ini.parse_line <<< '{}' ; printf '%s\n' \${VALUE}"
}
pm.get_repo_ver () 
{ 
    pm.run -Sp --print-format '%v' "$1"
}
pm.get_root () 
{ 
    pm.get_config RootDir
}
pm.is_repo_pkg () 
{ 
    pm.run -Slq | grep -qx "$(pm.get_name <<< "$1")"
}
pm.pacman_gpg () 
{ 
    gpg --homedir "$(pm.get_config GPGDir)" "$@"
}
pm.run () 
{ 
    pacman --noconfirm --config "${PACMAN_CONF-"/etc/pacman.conf"}" "$@"
}
pm.run_key () 
{ 
    pacman-key --config "${PACMAN_CONF-"/etc/pacman.conf"}" "$@"
}
pm.get_db_next_section () 
{ 
    pm.get_db_section_list | grep -x -A 1 "^%$1%$" | get_line 2 | sed "s|^%||g; s|%$||g"
}
pm.get_db_section () 
{ 
    readarray -t _Stdin;
    print_array "${_Stdin[@]}" | sed -ne "/^%$1%$/,/^%$(print_eval_array _Stdin | pm.get_db_next_section "$1")%$/p" | sed "1d; \$d"
}
pm.get_db_section_list () 
{ 
    grep -E "^%.*%$"
}
pm.create_db_tmp_dir () 
{ 
    mkdir -p "$(pm.get_db_tmp_dir)"
}
pm.delete_db_tmp_dir () 
{ 
    rm -rf "$(pm.get_db_tmp_dir)"
}
pm.get_db_tmp_dir () 
{ 
    echo "${TMPDIR-"/tmp"}/fasbashlib-pacman-db"
}
pm.get_pkg_arch () 
{ 
    pm.get_sync_db_desc "$1" | pm.get_db_section ARCH | remove_blank
}
pm.get_repo_list_from_local_db () 
{ 
    find "$(pm.get_config DBPath)/sync" -mindepth 1 -maxdepth 1 -type f | get_base_name | sed "s|.db$||g";
    return 0
}
pm.get_sync_all_desc () 
{ 
    find "$(pm.get_db_tmp_dir)" -mindepth 3 -maxdepth 3 -name "desc" -type f
}
pm.get_sync_db_desc () 
{ 
    local _path;
    _path="$(pm.get_sync_db_desc_path "$1")";
    [[ -e "$_path" ]] || return 1;
    cat "$_path/desc"
}
pm.get_sync_db_desc_path () 
{ 
    local _repo;
    _repo="$(pacman -Sp --print-format '%r' "$1")";
    { 
        IsPacmanSyncDbOpend "$_repo" || OpenPacmanSyncDb "$_repo"
    } || return 1;
    echo "$(pm.get_db_tmp_dir)/sync/$(pacman -Sp --print-format '%r/%n-%v' "$1")"
}
pm.get_virtual_pkg_list () 
{ 
    pm.get_repo_list_from_local_db | for_each pm.open_sync_db {};
    pm.get_sync_all_desc | for_each eval "pm.get_db_section PROVIDES < {}" | remove_blank
}
pm.is_opend_sync_db () 
{ 
    readarray -t _PkgDbList < <(find "$(pm.get_db_tmp_dir)/sync/$1" -mindepth 1 -maxdepth 1 -type d );
    (( "${#_PkgDbList[@]}" > 0 )) && return 0;
    return 1
}
pm.open_sync_db () 
{ 
    local _Dir _RepoDb;
    pm.create_db_tmp_dir;
    _Dir="$(pm.get_db_tmp_dir)/sync/$1";
    mkdir -p "$_Dir";
    _RepoDb="$(pm.get_config DBPath)/sync/$1.db";
    [[ -e "$_RepoDb" ]] || return 1;
    tar -xzf "${_RepoDb}" -C "$_Dir" || return 1
}
pm.opened_sync_db_list () 
{ 
    find "$(pm.get_db_tmp_dir)/sync/" -mindepth 1 -maxdepth 1 -type d
}
pm.parse_pkg_file_name () 
{ 
    local _Pkg="$1";
    local _PkgName _PkgVer _PkgRel _Arch _FileExt;
    local _PkgWithOutExt;
    if grep "/" <<< "$_Pkg"; then
        _Pkg="$(basename "$_Pkg")";
    fi;
    _FileExt="$(get_last_split_string "-" "$_Pkg" | cut -d "." -f 2-)";
    _PkgWithOutExt="${_Pkg%%".${_FileExt}"}";
    _Arch=$(get_last_split_string "-" "${_PkgWithOutExt}");
    _PkgRel=$(get_last_split_string "-" "${_PkgWithOutExt%%"-${_Arch}"}");
    _PkgVer=$(get_last_split_string "-" "${_PkgWithOutExt%%"-${_PkgRel}-${_Arch}"}");
    _PkgName="${_PkgWithOutExt%%"-${_PkgVer}-${_PkgRel}-${_Arch}"}";
    _ParsedPkg=("${_PkgName}" "-" "$_PkgVer" "-" "$_PkgRel" "-" "$_Arch" ".$_FileExt");
    if [[ ! "$(print_array "${_ParsedPkg[@]}" | tr -d "\n")" = "${_Pkg}" ]]; then
        return 1;
    fi;
    print_array "${_ParsedPkg[@]}"
}
readlinkf () 
{ 
    readlinkf_Posix "$@"
}
readlinkf__posix () 
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
readlinkf__readlink () 
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
url.authority () 
{ 
    local i _NoScheme;
    while read -r i; do
        _NoScheme=$(url.no_scheme <<< "$i");
        [[ "$_NoScheme" == "//"* ]] || return 1;
        cut -d "/" -f 1 < <(sed "s|^//||g" <<< "$_NoScheme");
    done
}
url.fragment () 
{ 
    url.path_and_query_and_fragment | cut -d "#" -f 2-
}
url.host () 
{ 
    url.authority | cut -d "@" -f 2- | cut -d ":" -f 1
}
url.no_scheme () 
{ 
    cut -d ":" -f 2-
}
url.path () 
{ 
    url.path_and_query_and_fragment | cut -d "#" -f 1 | cut -d "?" -f 1
}
url.path_and_query_and_fragment () 
{ 
    local i;
    while read -r i; do
        sed "s|^//$(url.authority <<< "$i")||g" <<< "$(url.no_scheme <<< "$i")";
    done
}
url.port () 
{ 
    local i;
    while read -r i; do
        [[ "$i" == *":"* ]] || { 
            echo "80";
            continue
        };
        cut -d ":" -f 2 <<< "$i";
    done < <(url.authority)
}
url.query () 
{ 
    url.path_and_query_and_fragment | cut -d "?" -f 2-
}
url.scheme () 
{ 
    cut -d ":" -f 1
}
url.user () 
{ 
    local i;
    while read -r i; do
        [[ "$i" == *"@"* ]] || { 
            echo "";
            continue
        };
        cut -d "@" -f 1 <<< "$i";
    done < <(url.authority)
}
url.has_authority () 
{ 
    [[ "$(url.no_scheme <<< "$1")" = "//"* ]]
}
url.has_fragment () 
{ 
    [[ "$(url.path_and_query_and_fragment <<< "$1")" = *"#"* ]]
}
url.has_port () 
{ 
    [[ "$(url.authority <<< "$1")" = *":"* ]]
}
url.has_query () 
{ 
    [[ "$(url.path_and_query_and_fragment <<< "$1")" = *"?"* ]]
}
url.has_user () 
{ 
    [[ "$(url.authority <<< "$1")" = *"@"* ]]
}
url.parse () 
{ 
    local i="$1";
    url.scheme <<< "$i";
    echo ":";
    if url.has_authority "$i"; then
        if url.has_user "$i"; then
            url.user <<< "$i";
            echo "@";
        fi;
        url.host <<< "$i";
        if url.has_port "$i"; then
            echo ":";
            url.port <<< "$i";
        fi;
    fi;
    url.path <<< "$i";
    if url.has_fragment "$i"; then
        echo "#";
        url.fragment <<< "$i";
    fi;
    if url.has_query "$i"; then
        echo "?";
        url.query <<< "$i";
    fi
}
srcinfo.format () 
{ 
    remove_blank | sed "/^$/d" | grep -v "^#" | for_each eval "srcinfo.parse Line <<< \"{}\""
}
srcinfo.get_key_list () 
{ 
    srcinfo.format | cut -d "=" -f 1
}
srcinfo.get_pkg_base () 
{ 
    local _Line _Key _InSection=false;
    while read -r _Line; do
        _Key="$(srcinfo.parse Key <<< "$_Line")";
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
    done < <(srcinfo.format)
}
srcinfo.get_pkg_name () 
{ 
    local _Line _Key _InSection=false _TargetPkgName="$1";
    while read -r _Line; do
        _Key="$(srcinfo.parse Key <<< "$_Line")";
        case "$_Key" in 
            "pkgname")
                if [[ "$(srcinfo.parse Value <<< "$_Line")" = "$_TargetPkgName" ]]; then
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
    done < <(srcinfo.format)
}
srcinfo.get_section_list () 
{ 
    srcinfo.format | grep -e "^pkgbase" -e "^pkgname"
}
srcinfo.get_value () 
{ 
    local _SrcInfo=();
    local _Output=();
    local _PkgBaseValues=("pkgver" "pkgrel" "epoch");
    local _AllValues=("pkgdesc" "url" "install" "changelog");
    local _AllArrays=("arch" "groups" "license" "noextract" "options" "backup" "validpgpkeys");
    local _AllArraysWithArch=("source" "depends" "checkdepends" "makedepends" "optdepends" "provides" "conflicts" "replaces" "md5sums" "sha1sums" "sha224sums" "sha256sums" "sha384sums" "sha512sums");
    array_append _SrcInfo;
    array_includes _PkgBaseValues "$1" && { 
        print_eval_array _SrcInfo | srcinfo.get_value_in_pkg_base "$1";
        return 0
    };
    [[ -n "${2-""}" ]] || return 1;
    if array_includes _AllValues "$1" || array_includes _AllArrays "$1"; then
        array_append _Output < <(print_eval_array _SrcInfo | srcinfo.get_value_in_pkg_base "$1");
        array_append _Output < <(print_eval_array _SrcInfo | srcinfo.get_value_in_pkg_name "$2" "$1");
        print_array "${_Output[@]}" | tail -n 1;
        return 0;
    fi;
    array_includes _AllArraysWithArch "$1" || return 1;
    local _Arch _ArchList;
    if [[ -z "${3-""}" ]]; then
        array_append _ArchList < <(print_eval_array _SrcInfo | srcinfo.get_value arch "$2");
    else
        array_append _ArchList < <(tr "," "\n" <<< "$3" | remove_blank);
    fi;
    array_append _Output < <(print_eval_array _SrcInfo | srcinfo.get_value_in_pkg_base "$1");
    array_append _Output < <(print_eval_array _SrcInfo | srcinfo.get_value_in_pkg_name "$2" "$1");
    for _Arch in "${_ArchList[@]}";
    do
        array_append _Output < <(print_eval_array _SrcInfo | srcinfo.get_value_in_pkg_base "$1_${_Arch}");
        array_append _Output < <(print_eval_array _SrcInfo | srcinfo.get_value_in_pkg_name "$2" "$1_${_Arch}");
    done;
    print_eval_array _Output;
    return 0
}
srcinfo.get_value_in_pkg_base () 
{ 
    local _Line;
    while read -r _Line; do
        _Key="$(srcinfo.parse Key <<< "$_Line")";
        case "$_Key" in 
            "$1")
                srcinfo.parse Value <<< "$_Line"
            ;;
        esac;
    done < <(srcinfo.get_pkg_base)
}
srcinfo.get_value_in_pkg_name () 
{ 
    local _Line;
    while read -r _Line; do
        _Key="$(srcinfo.parse Key <<< "$_Line")";
        case "$_Key" in 
            "$2")
                srcinfo.parse Value <<< "$_Line"
            ;;
        esac;
    done < <(srcinfo.get_pkg_name "$1")
}
srcinfo.parse () 
{ 
    local _Output="${1-""}";
    [[ -n "${_Output}" ]] || return 1;
    shift 1;
    local _String _Key _Value;
    _String="$(cat)";
    _Key="$(cut -d "=" -f 1 <<<  "$_String" | remove_blank)";
    _Value="$(cut -d "=" -f 2- <<< "$_String" | remove_blank)";
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
fsblib_env_check () 
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
arch.get_kernel_file_list () 
{ 
    find "/boot" -maxdepth 1 -mindepth 1 -name "vmlinuz-*"
}
arch.get_kernel_src_list () 
{ 
    find "/usr/src" -mindepth 1 -maxdepth 1 -type l -name "linux*"
}
arch.get_mkinitcpio_preset_list () 
{ 
    find "/etc/mkinitcpio.d/" -name "*.preset" -type f | get_base_name | remove_file_ext
}
