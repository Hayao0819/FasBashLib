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

FSBLIB_VERSION="v0.2.3.r284.gb98a6cb-snake"
FSBLIB_REQUIRE="ModernBash"

msg.common () 
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
msg.debug () 
{ 
    msg.common "Debug:" "${*}" stderr
}
msg.err () 
{ 
    msg.common "Error:" "${*}" stderr
}
msg.info () 
{ 
    msg.common " Info:" "${*}" stdout
}
msg.warn () 
{ 
    msg.common " Warn:" "${*}" stderr
}
array.append () 
{ 
    local _ArrName="$1";
    shift 1 || return 1;
    readarray -t -O "$(ArrayIndex "$_ArrName")" "$_ArrName" < <(cat)
}
array.from_str () 
{ 
    declare -a -x "$1";
    readarray -t "$1" < <(BreakChar)
}
array.pop () 
{ 
    readarray -t "$1" < <(PrintEvalArray "$1" | sed -e '$d')
}
array.push () 
{ 
    eval "PrintArray \"\${$1[@]}\"" | grep -qx "$2" && return 0;
    eval "$1+=(\"$2\")"
}
array.remove () 
{ 
    readarray -t "$1" < <(PrintEvalArray "$1" | RemoveMatchLine "$2")
}
array.rev () 
{ 
    readarray -t "$1" < <(PrintEvalArray "$1" | tac)
}
array.shift () 
{ 
    readarray -t "$1" < <(PrintEvalArray "$1" | sed "1,${2-"1"}d")
}
array.eval () 
{ 
    eval "PrintArray \"\${$1[@]}\""
}
array.print () 
{ 
    (( $# >= 1 )) || return 0;
    printf "%s\n" "${@}"
}
array.index_of () 
{ 
    local n=();
    readarray -t n < <(grep -x -n "$1" | cut -d ":" -f 1 | ForEach eval echo '$(( {} - 1 ))');
    (( "${#n[@]}" >= 1 )) || return 1;
    PrintArray "${n[@]}";
    return 0
}
array.length () 
{ 
    PrintEvalArray "$1" | wc -l
}
array.includes () 
{ 
    PrintEvalArray "$1" | grep -qx "$2"
}
awk.cos () 
{ 
    awk.float "cos($*)"
}
awk.float () 
{ 
    local AWKSCALE="${AWKSCALE-"5"}";
    awk "BEGIN {printf (\"%4.${AWKSCALE}f\n\", $*)}"
}
awk.log () 
{ 
    local _Base="$1" _Number="$2";
    awk.float "log(${_Number}) / log($_Base)"
}
awk.pi () 
{ 
    awk.float "atan2(0, -0)"
}
awk.print () 
{ 
    awk "BEGIN {print $*}"
}
awk.rad () 
{ 
    awk.float "$1 * $(awk.pi) / 180 "
}
awk.sin () 
{ 
    awk.float "sin($*)"
}
awk.tan () 
{ 
    awk.float "sin($1)/tan($1)"
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
    ForEach pacman -Qq "{}" | cut -d " " -f 2;
    PrintArray "${PIPESTATUS[@]}" | grep -qx "1" && return 1;
    return 0
}
pm.get_keyring_list () 
{ 
    find "$(@GetKeyringDir)" -name "*.gpg" | GetBaseName | RemoveFileExt
}
pm.get_latest_pkg_ver () 
{ 
    local _LANG="${LANG-""}";
    export LANG=C;
    ForEach pm.run -Si "{}" | grep "^Version" | cut -d ":" -f 2 | RemoveBlank;
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
    _KeyringDir="$(LANG=C pacman-key -h | RemoveBlank | grep -A 1 -- "^--populate" | tail -n 1 | cut -d "/" -f 2- | sed "s|'$||g")";
    : "${_KeyringDir="usr/share/pacman/keyrings"}";
    _KeyringDir="$(pm.get_root)/$_KeyringDir";
    _KeyringDir="$(sed -E "s|/+|/|g" <<< "$_KeyringDir")";
    if [[ -e "$_KeyringDir" ]]; then
        Readlinkf "$_KeyringDir";
    else
        echo "$_KeyringDir";
    fi
}
pm.get_repo_conf () 
{ 
    ForEach eval 'echo [{}] && pm.get_config -r {}'
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
    ForEach eval 'pm.get_config -r {}' | grep "^Server" | ForEach eval "Ini.ParseLine <<< '{}' ; printf '%s\n' \${VALUE}"
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
    pm.get_db_section_list | grep -x -A 1 "^%$1%$" | GetLine 2 | sed "s|^%||g; s|%$||g"
}
pm.get_db_section () 
{ 
    readarray -t _Stdin;
    PrintArray "${_Stdin[@]}" | sed -ne "/^%$1%$/,/^%$(PrintEvalArray _Stdin | pm.get_db_next_section "$1")%$/p" | sed "1d; \$d"
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
    pm.get_sync_db_desc "$1" | pm.get_db_section ARCH | RemoveBlank
}
pm.get_repo_list_from_local_db () 
{ 
    find "$(pm.get_config DBPath)/sync" -mindepth 1 -maxdepth 1 -type f | GetBaseName | sed "s|.db$||g";
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
    pm.get_repo_list_from_local_db | ForEach pm.open_sync_db {};
    pm.get_sync_all_desc | ForEach eval "pm.get_db_section PROVIDES < {}" | RemoveBlank
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
misskey.setup () 
{ 
    export MISSKEY_DOMAIN="${1-"${MISSKEY_DOMAIN-""}"}";
    export MISSKEY_TOKEN="${2-"${MISSKEY_DOMAIN-""}"}";
    export MISSKEY_ENTRY="https://${MISSKEY_DOMAIN}/api"
}
misskey.binding_base () 
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
    misskey.send_req "$MISSKEY_ENTRY/$_API" "${_Args[@]}" "$@"
}
misskey.make_json () 
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
misskey.send_req () 
{ 
    local _Url="$1" _CurlArgs=();
    shift 1;
    _CurlArgs+=(-s -L);
    _CurlArgs+=(-X POST);
    _CurlArgs+=(-H "Content-Type: application/json");
    _CurlArgs+=(-d "$(misskey.make_json "$@")");
    _CurlArgs+=("$_Url");
    Msg.Debug "Run: ${_CurlArgs[*]//"${MISSKEY_TOKEN}"/"TOKEN"})";
    curl "${_CurlArgs[@]}"
}
misskey.notes._create () 
{ 
    misskey.binding_base "notes/create" text -- "$@"
}
misskey.notes._renotes () 
{ 
    misskey.binding_base "notes/renotes" noteId limit sinceId untilId -- "$@"
}
misskey.notes._search () 
{ 
    misskey.binding_base "notes/search" query limit -- "$@"
}
misskey.users._notes () 
{ 
    misskey.binding_base "users/notes" userId -- "$@"
}
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
    done < <(PrintArray "${_RawCsvLine[@]}");
    RemoveBlank <<< "$_ClmCnt";
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
    _ClmCnt=$(PrintArray "${_RawCsvLine[@]}" | csv.get_clm_cnt);
    while read -r _Cnt; do
        readarray -t "$(sed "s|{}|$(eval "echo \"\${${_Cnt}}\"")|g" <<< "$ArrayPrefix")" < <(
            # shellcheck disable=SC2031
            PrintArray "${_RawCsvLine[@]}" | cut -d "${CSVDELIM-","}" -f "$_Cnt"
        );
    done < <(seq 1 "$#")
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
    done < <(PrintArray "${_RawIniLine[@]}");
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
    done < <(PrintArray "${_RawIniLine[@]}");
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
    done < <(PrintArray "${_RawIniLine[@]}");
    return "$_Exit"
}
ini.parse_line () 
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
    local i;
    i="$(url.path_and_query_and_fragment)";
    [[ "$i" == *"#"* ]] || return 0;
    cut -d "#" -f 2- <<< "$i"
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
            continue
        };
        cut -d ":" -f 2 <<< "$i";
    done < <(url.authority)
}
url.query () 
{ 
    local i;
    while read -r i; do
        url.path_and_query_and_fragment <<< "$i" | sed "s|#$(url.fragment <<< "$i")||g" | cut -d "?" -f 2-;
    done
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
    local i="${1-""}";
    [[ -n "$i" ]] || read -r i;
    [[ "$(url.no_scheme <<< "$i")" = "//"* ]]
}
url.has_fragment () 
{ 
    local i="${1-""}";
    [[ -n "$i" ]] || read -r i;
    [[ "$(url.path_and_query_and_fragment <<< "$i")" = *"#"* ]]
}
url.has_port () 
{ 
    local i="${1-""}";
    [[ -n "$i" ]] || read -r i;
    [[ "$(url.authority <<< "$i")" = *":"* ]]
}
url.has_query () 
{ 
    local i="${1-""}";
    [[ -n "$i" ]] || read -r i;
    [[ "$(url.path_and_query_and_fragment <<< "$i")" = *"?"* ]]
}
url.has_user () 
{ 
    local i="${1-""}";
    [[ -n "$i" ]] || read -r i;
    [[ "$(url.authority <<< "$i")" = *"@"* ]]
}
url.parse () 
{ 
    local i="${1-""}";
    if [[ -z "${i}" ]]; then
        read -r i;
    fi;
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
url.get_query () 
{ 
    grep "^ *$1=" | cut -d "=" -f 2-
}
url.parse_query () 
{ 
    local i="${1-""}";
    if [[ -z "${i}" ]]; then
        read -r i;
    fi;
    if grep -q "[a-zA-Z]://" <<< "$i"; then
        i="$(url.query <<< "$i")";
    fi;
    i="$(sed "s|^\?||g" <<< "$i")";
    tr "&" "\n" <<< "$i" | cut -d "#" -f 1
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
    find "/etc/mkinitcpio.d/" -name "*.preset" -type f | GetBaseName | RemoveFileExt
}
fsblib.env_check () 
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
fsblib.fsblib_env_check () 
{ 
    fsblib.env_check
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
    FSBLIB_CACHEID="${FSBLIB_CACHEID-"$(RandomString "10")"}";
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
readlinkf () 
{ 
    Readlinkf_Posix "$@"
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
srcinfo.format () 
{ 
    RemoveBlank | sed "/^$/d" | grep -v "^#" | ForEach eval "srcinfo.parse Line <<< \"{}\""
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
    ArrayAppend _SrcInfo;
    ArrayIncludes _PkgBaseValues "$1" && { 
        PrintEvalArray _SrcInfo | srcinfo.get_value_in_pkg_base "$1";
        return 0
    };
    [[ -n "${2-""}" ]] || return 1;
    if ArrayIncludes _AllValues "$1" || ArrayIncludes _AllArrays "$1"; then
        ArrayAppend _Output < <(PrintEvalArray _SrcInfo | srcinfo.get_value_in_pkg_base "$1");
        ArrayAppend _Output < <(PrintEvalArray _SrcInfo | srcinfo.get_value_in_pkg_name "$2" "$1");
        PrintArray "${_Output[@]}" | tail -n 1;
        return 0;
    fi;
    ArrayIncludes _AllArraysWithArch "$1" || return 1;
    local _Arch _ArchList;
    if [[ -z "${3-""}" ]]; then
        ArrayAppend _ArchList < <(PrintEvalArray _SrcInfo | srcinfo.get_value arch "$2");
    else
        ArrayAppend _ArchList < <(tr "," "\n" <<< "$3" | RemoveBlank);
    fi;
    ArrayAppend _Output < <(PrintEvalArray _SrcInfo | srcinfo.get_value_in_pkg_base "$1");
    ArrayAppend _Output < <(PrintEvalArray _SrcInfo | srcinfo.get_value_in_pkg_name "$2" "$1");
    for _Arch in "${_ArchList[@]}";
    do
        ArrayAppend _Output < <(PrintEvalArray _SrcInfo | srcinfo.get_value_in_pkg_base "$1_${_Arch}");
        ArrayAppend _Output < <(PrintEvalArray _SrcInfo | srcinfo.get_value_in_pkg_name "$2" "$1_${_Arch}");
    done;
    PrintEvalArray _Output;
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
add_new_to_array () 
{ 
    Array.Push "$@"
}
array_append () 
{ 
    Array.Append "$1"
}
array_includes () 
{ 
    Array.Includes "$@"
}
array_index () 
{ 
    Array.Length "$1"
}
get_array_index () 
{ 
    Array.IndexOf "$1"
}
print_array () 
{ 
    Array.Print "$@"
}
print_eval_array () 
{ 
    Array.Eval "$1"
}
rev_array () 
{ 
    Array.Rev "$1"
}
str_to_char_list () 
{ 
    Array.FromStr "$1"
}
file_type () 
{ 
    file --mime-type -b "$1"
}
get_base_name () 
{ 
    ForEach basename "{}"
}
get_file_ext () 
{ 
    GetBaseName | rev | cut -d "." -f 1 | rev
}
remove_file_ext () 
{ 
    local Ext;
    ForEach eval 'Ext=$(GetFileExt <<< {}); sed "s|.$Ext$||g" <<< {}; unset Ext'
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
loop () 
{ 
    local _T="$1";
    shift 1 || return 1;
    ForEach "$@" < <(yes "" | head -n "$_T")
}
break_char () 
{ 
    grep -o "."
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
text_box () 
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
to_lower () 
{ 
    local _Str="${1,,}";
    [[ -z "${_Str-""}" ]] || echo "${_Str}"
}
to_lower_stdin () 
{ 
    local _Str;
    ForEach eval "_Str=\"{}\"; echo \"\${_Str,,}\"";
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
get_func_list () 
{ 
    declare -F | cut -d " " -f 3
}
unset_all_func () 
{ 
    local Func;
    while read -r Func; do
        unset "$Func";
    done < <(GetFuncList)
}
remove_match_line () 
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
