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

FSBLIB_LIBLIST+=("ArchLinux" "Array" "AwkForCalc" "BetterShell" "Cache" "Core" "Csv" "Emerge" "Ini" "Message" "Misskey" "Pacman" "ParseArg" "Prompt" "Readlink" "Sqlite3" "SrcInfo" "URL")
FSBLIB_FUNCLIST+=("SrcInfo.GetValueInPkgName" "SrcInfo.Format" "SrcInfo.Parse" "SrcInfo.GetPkgName" "SrcInfo.GetKeyList" "SrcInfo.GetValue" "SrcInfo.GetValueInPkgBase" "SrcInfo.GetSectionList" "SrcInfo.GetPkgBase" "Msg.Common" "Msg.Info" "Msg.Warn" "Msg.Debug" "Cache.Get" "Cache.GetID" "Cache.Exist" "Msg.Err" "Cache.GetFileLastUpdate" "Cache.GetDir" "Cache.GetTimeDiffFromLastUpdate" "Readlinkf" "Readlinkf_Posix" "Fsblib.EnvCheck" "Readlinkf_Readlink" "FsblibEnvCheck" "Fsblib.RequireLib" "ParseArg" "ChoiceLoop" "Choice" "Sqlite3.CurrentDb" "Sqlite3.Delete" "Arch.GetKernelFileList" "Sqlite3.ExistTable" "Arch.GetKernelSrcList" "Arch.GetMkinitcpioPresetList" "Sqlite3.Call" "Sqlite3.Connect" "Sqlite3.Create" "Sqlite3.Insert" "Sqlite3.SelectAll" "Sqlite3.ExistField" "Awk.Sin" "Awk.Tan" "Csv.GetClm" "Csv.GetClmCnt" "Csv.ToBashArray" "Awk.Cos" "Awk.Log" "Awk.Pi" "Awk.Rad" "Sqlite3.Select" "Awk.Float" "PrintArray" "PrintEvalArray" "RevArray" "AddNewToArray" "ArrayAppend" "ArrayIncludes" "Array.Append" "Array.FromStr" "Array.Pop" "Array.Remove" "Array.Shift" "StrToCharList" "ArrayIndex" "Array.Push" "Awk.Print" "Array.Rev" "URL.Authority" "URL.Path" "URL.Host" "URL.NoScheme" "URL.Query" "URL.Scheme" "GetArrayIndex" "URL.Port" "Em.GetAllPkgList" "Em.GetInstalledPkgList" "Em.GetRepoLocation" "Em.GetRepoPkgList" "Em.GetWorldPkgList" "Pm.GetLatestPkgVer" "Pm.GetPacmanKernelPkg" "Pm.GetConfig" "Pm.GetInstalledPkgVer" "Pm.GetRepoConf" "Pm.GetRepoListFromConf" "Pm.GetRepoPkgList" "Pm.GetRepoServer" "Pm.Run" "Pm.GetName" "Pm.GetRepoVer" "Pm.IsRepoPkg" "URL.User" "URL.Fragment" "Pm.RunKey" "Em.GetRepoConf" "URL.PathAndQueryAndFragment" "Pm.CheckPkg" "Pm.GetRoot" "Pm.PacmanGpg" "Pm.GetPacmanKeyringDir" "Pm.GetKeyringList" "Misskey.Notes.Create" "Misskey.Notes.Renotes" "Misskey.Notes.Search" "Em.GetDefaultRepoName" "Ini.GetSectionList" "Ini.GetLastParam" "Ini.GetParamList" "Ini.GetParam" "Ini.ParseLine" "Cache.Create" "Cache.CreateDir" "GetBaseName" "FileType" "Array.Eval" "Array.Print" "Array.Last" "RemoveFileExt" "GetFileExt" "Pm.GetDbSection" "Pm.GetDbNextSection" "Pm.GetDbSectionList" "Misskey.Users.Pages" "Misskey.Users.Stats" "Misskey.Users.SearchByUsernameAndHost" "Misskey.Users.GetFrequentlyRepliedUsers" "Misskey.Users.Show" "Misskey.Users.Notes" "Em.NoVersion" "Ini.SetValue" "URL.HasAuthority" "URL.HasFragment" "URL.HasQuery" "URL.HasUser" "Ini.NewSection" "URL.HasPort" "Ini.NewParam" "GetLine" "Loop" "Array.IndexOf" "CheckFuncDefined" "Array.LastIndex" "Array.Length" "IsAvailable" "Pm.OpenSyncDb" "Pm.GetDbTmpDir" "Pm.GetSyncDbDesc" "Pm.GetPkgArch" "Pm.GetSyncDbDescPath" "Pm.ParsePkgFileName" "ForEach" "Pm.GetVirtualPkgList" "Pm.GetRepoListFromLocalDb" "Pm.DeleteDbTmpDir" "Pm.IsOpendSyncDb" "Pm.CreateDbTmpDir" "Misskey.Admin.ServerInfo" "Pm.OpenedSyncDbList" "Pm.GetSyncAllDesc" "URL.Parse" "BreakChar" "CutLastString" "GetLastSplitString" "PrintEval" "IsUUID" "ToLowerStdin" "ToLower" "RemoveBlank" "RandomString" "TextBox" "Array.ForEach" "Misskey.Setup" "Array.Includes" "URL.ParseQuery" "URL.GetQuery" "Sum" "CalcInt" "Ntest" "Misskey.Meta" "Misskey.ServerInfo" "Misskey.I" "Bool" "Misskey.MakeJson" "Misskey.BindingBase" "Misskey.SendReq" "UnsetAllFunc" "GetFuncList" "Misskey.MyName" "Misskey.MyUserName" "Misskey.MyId" "Misskey.IsAdmin" "Match" "RemoveMatchLine")
declare -r FSBLIB_VERSION='v0.2.5.1.r430.g68efbeb-upper'
declare -r FSBLIB_REQUIRE='ModernBash'

ParseArg() {
	local _Arg _Chr _Cnt
	local _Long=() _LongWithArg=() _Short=() _ShortWithArg=()
	local _OutArg=() _NoArg=()
	for _Arg in "${@}"; do
		local _TempArray=()
		case "${_Arg}" in
		"LONG="*)
			readarray -t _TempArray < <(tr -d '"' <<<"${_Arg#LONG=}" | tr "," "\n")
			for _Chr in "${_TempArray[@]}"; do
				if [[ ${_Chr} == *":" ]]; then
					_LongWithArg+=("${_Chr%":"}")
				else
					_Long+=("${_Chr}")
				fi
			done
			shift 1
			;;
		"SHORT="*)
			readarray -t _TempArray < <(tr -d '"' <<<"${_Arg#SHORT=}" | grep -o .)
			for ((_Cnt = 0; _Cnt <= "${#_TempArray[@]}" - 1; _Cnt++)); do
				if [[ ${_TempArray["$((_Cnt + 1))"]-""} == ":" ]]; then
					_ShortWithArg+=("${_TempArray["${_Cnt}"]}")
					_Cnt=$((_Cnt + 1))
				else
					_Short+=("${_TempArray["${_Cnt}"]}")
				fi
			done
			shift 1
			;;
		"--")
			shift 1
			break
			;;
		esac
	done
	while (("$#" > 0)); do
		if [[ ${1} == "--" ]]; then
			shift 1
			_NoArg+=("${@}")
			shift "$#"
			break
		else
			if [[ ${1} == "--"* ]]; then
				if printf "%s\n" "${_LongWithArg[@]}" | grep -qx "${1#--}"; then
					if [[ ${2} == "-"* ]]; then
						Msg.Err "${1} の引数が指定されていません"
						return 2
					else
						_OutArg+=("${1}" "${2}")
						shift 2
					fi
				else
					if printf "%s\n" "${_Long[@]}" | grep -qx "${1#--}"; then
						_OutArg+=("${1}")
						shift 1
					else
						Msg.Err "${1} は不正なオプションです。-hで使い方を確認してください。"
						return 1
					fi
				fi
			else
				if [[ ${1} == "-"* ]]; then
					local _Shift=0
					while read -r _Chr; do
						if printf "%s\n" "${_ShortWithArg[@]}" | grep -qx "${_Chr}"; then
							if [[ ${1} == *"${_Chr}" ]] && [[ ! ${2} == "-"* ]]; then
								_OutArg+=("-${_Chr}" "${2}")
								_Shift=2
							else
								Msg.Err "-${_Chr} の引数が指定されていません"
								return 2
							fi
						else
							if printf "%s\n" "${_Short[@]}" | grep -qx "${_Chr}"; then
								_OutArg+=("-${_Chr}")
								_Shift=1
							else
								Msg.Err "-${_Chr} は不正なオプションです。-hで使い方を確認してください。"
								return 1
							fi
						fi
					done < <(grep -o . <<<"${1#-}")
					shift "${_Shift}"
				else
					_NoArg+=("${1}")
					shift 1
				fi
			fi
		fi
	done
	OPTRET=("${_OutArg[@]}" -- "${_NoArg[@]}")
	return 0
}
ChoiceLoop() {
	while true; do
		if Choice "$@"; then
			break
		fi
	done
}
Choice() {
	local arg OPTARG OPTIND
	local _count _choice
	local _default="" _question="" _returnstr="" _mark=" "
	local _count=0 _digit=0 _returnint=
	local _number=false
	local _choice_list=()
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
		esac
	done
	shift "$((OPTIND - 1))" || return 1
	_choice_list=("${@}") _digit="${##}"
	((${#_choice_list[@]} <= 0)) && echo "An exception error has occurred." 1>&2 && exit 1
	((${#_choice_list[@]} == 1)) && _returnint="${_returnint:="1"}" _returnstr="${_returnstr:="${_choice_list[*]}"}"
	[[ -n ${_question-""} ]] && echo "   ${_question}" 1>&2
	for ((_count = 1; _count <= ${#_choice_list[@]}; _count++)); do
		_choice="${_choice_list[$((_count - 1))]}" _mark=" "
		{
			[[ ! ${_default} == "" ]] && [[ ${_choice} == "${_default}" ]]
		} && _mark="*"
		printf " ${_mark} %${_digit}d: ${_choice}\n" "${_count}" 1>&2
	done
	echo -n "   (1 ~ ${#_choice_list[@]}) > " 1>&2 && read -r _input
	{
		[[ -z ${_input-""} ]] && [[ -n ${_default-""} ]]
	} && _returnint="${_returnint:="0"}" _returnstr="${_returnstr:="${_default}"}"
	{
		printf "%s" "${_input}" | grep -qE "^[0-9]+$" && ((1 <= _input)) && ((_input <= ${#_choice_list[@]}))
	} && _returnint="${_returnint:="${_input}"}" _returnstr="${_returnstr:="${_choice_list[$((_input - 1))]}"}"
	for ((i = 0; i <= ${#_choice_list[@]} - 1; i++)); do
		[[ ${_choice_list["${i}"],,} == "${_input,,}" ]] && _returnint="${_returnint:="$((i + 1))"}" _returnstr="${_returnstr:="${_choice_list["${i}"]}"}"
	done
	{
		[[ ${_number} == true ]] && [[ -n ${_returnint:-""} ]]
	} && {
		echo "${_returnint}" && return 0
	}
	{
		[[ ${_number} == false ]] && [[ -n ${_returnstr:-""} ]]
	} && {
		echo "${_returnstr}" && return 0
	}
	return 1
}
Readlinkf() {
	Readlinkf_Posix "$@"
}
Readlinkf_Readlink() {
	[ "${1:-}" ] || return 1
	max_symlinks=40
	CDPATH=''
	target=$1
	[ -e "${target%/}" ] || target=${1%"${1##*[!/]}"}
	[ -d "${target:-/}" ] && target="$target/"
	cd -P . 2>/dev/null || return 1
	while [ "$max_symlinks" -ge 0 ] && max_symlinks=$((max_symlinks - 1)); do
		if [ ! "$target" = "${target%/*}" ]; then
			case $target in
			/*)
				cd -P "${target%/*}/" 2>/dev/null || break
				;;
			*)
				cd -P "./${target%/*}" 2>/dev/null || break
				;;
			esac
			target=${target##*/}
		fi
		if [ ! -L "$target" ]; then
			target="${PWD%/}${target:+/}${target}"
			printf '%s\n' "${target:-/}"
			return 0
		fi
		target=$(readlink -- "$target" 2>/dev/null) || break
	done
	return 1
}
Readlinkf_Posix() {
	[ "${1:-}" ] || return 1
	max_symlinks=40
	CDPATH=''
	target=$1
	[ -e "${target%/}" ] || target=${1%"${1##*[!/]}"}
	[ -d "${target:-/}" ] && target="$target/"
	cd -P . 2>/dev/null || return 1
	while [ "$max_symlinks" -ge 0 ] && max_symlinks=$((max_symlinks - 1)); do
		if [ ! "$target" = "${target%/*}" ]; then
			case $target in
			/*)
				cd -P "${target%/*}/" 2>/dev/null || break
				;;
			*)
				cd -P "./${target%/*}" 2>/dev/null || break
				;;
			esac
			target=${target##*/}
		fi
		if [ ! -L "$target" ]; then
			target="${PWD%/}${target:+/}${target}"
			printf '%s\n' "${target:-/}"
			return 0
		fi
		link=$(ls -dl -- "$target" 2>/dev/null) || break
		target=${link#*" $target -> "}
	done
	return 1
}
FsblibEnvCheck() {
	Fsblib.EnvCheck
}
Fsblib.EnvCheck() {
	case "$FSBLIB_REQUIRE" in
	"Any")
		return 0
		;;
	"ModernShell")
		[ "$(echo "$BASH_VERSION" | cut -d "." -f 1)" = "5" ] && return 0
		;;
	esac
	return 1
}
Fsblib.RequireLib() {
	local lib missing=() return=0
	for lib in "$@"; do
		if ! [[ ${FSBLIB_LIBLIST[*]} == *" $lib "* ]]; then
			missing+=("$lib")
			return=1
		fi
	done
	return "$return"
}
Csv.GetClm() {
	grep -v "^#" | sed "/^$/d" | cut -d "${CSVDELIM-","}" -f "$1"
}
Csv.GetClmCnt() {
	local _RawCsvLine=()
	local _Line _ClmCnt=0
	readarray -t _RawCsvLine
	while read -r _Line; do
		grep -qE "^#" <<<"$_Line" && continue
		_CurrentClmCnt=$(tr "${CSVDELIM-","}" "\n" | wc -l)
		((_CurrentClmCnt > _ClmCnt)) && _ClmCnt="$_CurrentClmCnt"
	done < <(PrintArray "${_RawCsvLine[@]}")
	RemoveBlank <<<"$_ClmCnt"
	return 0
}
Csv.ToBashArray() {
	local _RawCsvLine=() _Line _ClmCnt=0
	local ArrayPrefix="${ArrayPrefix-"{}"}"
	readarray -t _RawCsvLine < <(
		while read -r _Line; do
			(($(tr "${CSVDELIM-","}" "\n" <<<"$_Line" | wc -l) >= ${#})) && echo "$_Line"
		done < <(grep -v "^#")
	)
	_ClmCnt=$(PrintArray "${_RawCsvLine[@]}" | Csv.GetClmCnt)
	while read -r _Cnt; do
		readarray -t "$(sed "s|{}|$(eval "echo \"\${${_Cnt}}\"")|g" <<<"$ArrayPrefix")" < <(
			PrintArray "${_RawCsvLine[@]}" | cut -d "${CSVDELIM-","}" -f "$_Cnt"
		)
	done < <(seq 1 "$#")
}
Arch.GetKernelSrcList() {
	find "/usr/src" -mindepth 1 -maxdepth 1 -type l -name "linux*"
}
Arch.GetMkinitcpioPresetList() {
	find "/etc/mkinitcpio.d/" -name "*.preset" -type f | GetBaseName | RemoveFileExt
}
Arch.GetKernelFileList() {
	find "/boot" -maxdepth 1 -mindepth 1 -name "vmlinuz-*"
}
Msg.Common() {
	local i l="$1" string="$2" out="${3-""}"
	shift 2 || return 1
	{
		[[ -z ${out-""} ]] && {
			[[ ${l^^} == *"ERR"* ]] || [[ ${l^^} == *"WARN"* ]] || [[ ${l^^} == *"DEBUG"* ]]
		}
	} && out="stderr"
	case "${FSBLIB_MSG-"${out:-"stdout"}"}" in
	"stdout")
		for i in $(seq "$(echo -e "${string}" | wc -l)"); do
			echo -n "$l "
			echo -e "${string}" | head -n "${i}" | tail -n 1
		done
		;;
	"stderr")
		for i in $(seq "$(echo -e "${string}" | wc -l)"); do
			echo -n "$l " 1>&2
			echo -e "${string}" | head -n "${i}" | tail -n 1 1>&2
		done
		;;
	esac
}
Msg.Warn() {
	Msg.Common " Warn:" "${*}" stderr
}
Msg.Info() {
	Msg.Common " Info:" "${*}" stdout
}
Msg.Debug() {
	Msg.Common "Debug:" "${*}" stderr
}
Msg.Err() {
	Msg.Common "Error:" "${*}" stderr
}
SrcInfo.GetPkgName() {
	local _Line _Key _InSection=false _TargetPkgName="$1"
	while read -r _Line; do
		_Key="$(SrcInfo.Parse Key <<<"$_Line")"
		case "$_Key" in
		"pkgname")
			if [[ "$(SrcInfo.Parse Value <<<"$_Line")" == "$_TargetPkgName" ]]; then
				_InSection=true
			else
				_InSection=false
			fi
			;;
		"pkgbase")
			_InSection=false
			;;
		*)
			if [[ ${_InSection} == true ]]; then
				echo "$_Line"
			fi
			;;
		esac
	done < <(SrcInfo.Format)
}
SrcInfo.GetKeyList() {
	SrcInfo.Format | cut -d "=" -f 1
}
SrcInfo.GetValueInPkgBase() {
	local _Line
	while read -r _Line; do
		_Key="$(SrcInfo.Parse Key <<<"$_Line")"
		case "$_Key" in
		"$1")
			SrcInfo.Parse Value <<<"$_Line"
			;;
		esac
	done < <(SrcInfo.GetPkgBase)
}
SrcInfo.Format() {
	RemoveBlank | sed "/^$/d" | grep -v "^#" | ForEach eval 'SrcInfo.Parse Line <<< "{}"'
}
SrcInfo.GetValue() {
	local _SrcInfo=()
	local _Output=()
	local _PkgBaseValues=("pkgver" "pkgrel" "epoch")
	local _AllValues=("pkgdesc" "url" "install" "changelog")
	local _AllArrays=("arch" "groups" "license" "noextract" "options" "backup" "validpgpkeys")
	local _AllArraysWithArch=("source" "depends" "checkdepends" "makedepends" "optdepends" "provides" "conflicts" "replaces" "md5sums" "sha1sums" "sha224sums" "sha256sums" "sha384sums" "sha512sums")
	ArrayAppend _SrcInfo
	ArrayIncludes _PkgBaseValues "$1" && {
		PrintEvalArray _SrcInfo | SrcInfo.GetValueInPkgBase "$1"
		return 0
	}
	[[ -n ${2-""} ]] || {
		echo "No pkgname or pkgbase is specified" 1>&2
		return 1
	}
	if ArrayIncludes _AllValues "$1" || ArrayIncludes _AllArrays "$1"; then
		ArrayAppend _Output < <(PrintEvalArray _SrcInfo | SrcInfo.GetValueInPkgBase "$1")
		ArrayAppend _Output < <(PrintEvalArray _SrcInfo | SrcInfo.GetValueInPkgName "$2" "$1")
		PrintArray "${_Output[@]}" | tail -n 1
		return 0
	fi
	ArrayIncludes _AllArraysWithArch "$1" || return 1
	local _Arch _ArchList=()
	if [[ -z ${3-""} ]]; then
		ArrayAppend _ArchList < <(PrintEvalArray _SrcInfo | SrcInfo.GetValue arch "$2")
	else
		ArrayAppend _ArchList < <(tr "," "\n" <<<"$3" | RemoveBlank)
	fi
	ArrayAppend _Output < <(PrintEvalArray _SrcInfo | SrcInfo.GetValueInPkgBase "$1")
	ArrayAppend _Output < <(PrintEvalArray _SrcInfo | SrcInfo.GetValueInPkgName "$2" "$1")
	for _Arch in "${_ArchList[@]}"; do
		ArrayAppend _Output < <(PrintEvalArray _SrcInfo | SrcInfo.GetValueInPkgBase "$1_${_Arch}")
		ArrayAppend _Output < <(PrintEvalArray _SrcInfo | SrcInfo.GetValueInPkgName "$2" "$1_${_Arch}")
	done
	PrintEvalArray _Output
	return 0
}
SrcInfo.Parse() {
	local _Output="${1-""}"
	[[ -n ${_Output} ]] || return 1
	shift 1
	local _String _Key _Value
	_String="$(cat)"
	_Key="$(cut -d "=" -f 1 <<<"$_String" | RemoveBlank)"
	_Value="$(cut -d "=" -f 2- <<<"$_String" | RemoveBlank)"
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
SrcInfo.GetSectionList() {
	SrcInfo.Format | grep -e "^pkgbase" -e "^pkgname"
}
SrcInfo.GetValueInPkgName() {
	local _Line
	while read -r _Line; do
		_Key="$(SrcInfo.Parse Key <<<"$_Line")"
		case "$_Key" in
		"$2")
			SrcInfo.Parse Value <<<"$_Line"
			;;
		esac
	done < <(SrcInfo.GetPkgName "$1")
}
SrcInfo.GetPkgBase() {
	local _Line _Key _InSection=false
	while read -r _Line; do
		_Key="$(SrcInfo.Parse Key <<<"$_Line")"
		case "$_Key" in
		"pkgbase")
			_InSection=true
			;;
		"pkgname")
			_InSection=false
			;;
		*)
			if [[ ${_InSection} == true ]]; then
				echo "$_Line"
			fi
			;;
		esac
	done < <(SrcInfo.Format)
}
Awk.Sin() {
	Awk.Float "sin($*)"
}
Awk.Tan() {
	Awk.Float "sin($1)/tan($1)"
}
Awk.Cos() {
	Awk.Float "cos($*)"
}
Awk.Pi() {
	Awk.Float "atan2(0, -0)"
}
Awk.Rad() {
	Awk.Float "$1 * $(Awk.Pi) / 180 "
}
Awk.Float() {
	awk "BEGIN {printf (\"%4.${AWKSCALE-"5"}f\n\", $*)}"
}
Awk.Log() {
	Awk.Float "log(${2}) / log($1)"
}
Awk.Print() {
	awk "BEGIN {print $*}"
}
Sqlite3.CurrentDb() {
	if [[ -z ${SQLITE3_DBPATH-""} ]]; then
		Msg.Err "No datebase is connected."
		return 1
	fi
	echo "${SQLITE3_DBPATH}"
	return 0
}
Sqlite3.ExistTable() {
	local _result
	_result="$(Sqlite3.Call "SELECT COUNT(*) 
                            FROM sqlite_master 
                            WHERE TYPE='table' AND name='$1';
            ")"
	if ((_result > 0)); then
		return 0
	fi
	return 1
}
Sqlite3.Insert() {
	local _table="$1" _args=()
	shift 1 || return 1
	local _values=("$@")
	_args+=(insert into "$_table" values '(')
	ForEach eval '_args+=("\"{}\"" ,)' < <(PrintEvalArray _values)
	Array.Pop _args
	_args+=(");")
	Sqlite3.Call "${_args[*]}"
}
Sqlite3.Connect() {
	export SQLITE3_DBPATH="$1"
	echo ".open \"$SQLITE3_DBPATH\"" | sqlite3
	return 0
}
Sqlite3.ExistField() {
	_result="$(Sqlite3.Call "SELECT * FROM '$1' WHERE $2 = '$3' LIMIT 1;")"
	if [[ -n ${_result-""} ]]; then
		return 0
	fi
	return 1
}
Sqlite3.Delete() {
	local _table="$1" _args=()
	shift 1 || return 1
	if (($# < 1)) && ((${SQLITE3_ALLOWDELETEALL-"0"} != 1)); then
		Msg.Err "Cannot delete all data.\nIf you really want that, Please set environment-variable \"SQLITE3_ALLOWDELETEALL=1\""
		return 1
	fi
	_args+=(delete from "$_table")
	if (($# > 0)); then
		_args+=(where "${@}")
	fi
	Sqlite3.Call "${_args[*]}"
}
Sqlite3.Create() {
	local _table="$1" _args=() _columns=()
	shift 1 || return 1
	_columns=("$@")
	_args+=(create table "$_table" "(")
	ForEach eval '_args+=("\"{}\"" ,)' < <(PrintEvalArray _columns)
	Array.Pop _args
	_args+=(")")
	Sqlite3.Call "${_args[*]}"
}
Sqlite3.SelectAll() {
	local _table="$1" _args=()
	shift 1 || return 1
	Sqlite3.Call "select * from $_table"
}
Sqlite3.Select() {
	local _table="$1" _args=()
	shift 1 || return 1
	local _values=("$@")
	_args+=(select)
	ForEach eval '_args+=("\"{}\"" ,)' < <(PrintEvalArray _values)
	Array.Pop _args
	_args+=("from" "$_table" ";")
	Sqlite3.Call "${_args[*]}"
}
Sqlite3.Call() {
	Msg.Debug sqlite3 "${SQLITE3_OPTIONS[@]}" "$SQLITE3_DBPATH" "$@" 1>&2
	sqlite3 "${SQLITE3_OPTIONS[@]}" "$SQLITE3_DBPATH" "$@"
}
Cache.Get() {
	cat "$(Cache.GetDir)/$1" 2>/dev/null || return 1
}
Cache.GetID() {
	if [[ -z ${FSBLIB_CACHEID-""} ]]; then
		Cache.CreateDir >/dev/null
	fi
	echo "$FSBLIB_CACHEID"
}
Cache.GetTimeDiffFromLastUpdate() {
	local _Now _Last
	_Now="$(date "+%s")"
	_Last="$(Cache.GetFileLastUpdate "$1")"
	echo "$((_Now - _Last))"
	return 0
}
Cache.Exist() {
	local _File
	_File="$(Cache.CreateDir)/$1"
	[[ -e $_File ]] || return 1
	(("$(Cache.GetTimeDiffFromLastUpdate "$_File")" > "${KEEPCACHESEC-"86400"}")) && return 2
	return 0
}
Cache.GetFileLastUpdate() {
	local _isGnu=false
	date --help 2>/dev/null | grep -q "GNU" && _isGnu=true
	if [[ $_isGnu == true ]]; then
		date +%s -r "$1"
	else
		{
			eval "$(stat -s "$1")"
			echo "$st_mtime"
		}
	fi
}
Cache.GetDir() {
	echo "${TMPDIR-"/tmp"}/$(Cache.GetID)"
}
Cache.CreateDir() {
	FSBLIB_CACHEID="${FSBLIB_CACHEID-"$(RandomString "10")"}"
	export FSBLIB_CACHEID="$FSBLIB_CACHEID"
	local TMPDIR="${TMPDIR-"/tmp"}"
	local _Dir="$TMPDIR/${FSBLIB_CACHEID}"
	mkdir -p "$_Dir"
	echo "$_Dir"
	return 0
}
Cache.Create() {
	Cache.CreateDir >/dev/null
	cat >"$(Cache.GetDir)/${1}"
	cat "$(Cache.GetDir)/$1"
}
Em.GetRepoPkgList() {
	local _RepoPath
	_RepoPath="$(Em.GetRepoLocation "$1")"
	find "$_RepoPath" -mindepth 3 -maxdepth 3 -type f -name '*.ebuild' | sed -e "s|${_RepoPath%/}/||g" -e 's|.ebuild$||g' | awk -F "/" '{print $1"/"$3}'
}
Em.GetInstalledPkgList() {
	find /var/db/pkg/ -mindepth 2 -maxdepth 2 -type d | sed 's|/var/db/pkg/||g'
}
Em.GetWorldPkgList() {
	sed -E 's|:.+$||g' /var/lib/portage/world | xargs -I{} bash -c 'ls -d /var/db/pkg/{}-* | sed "s|/var/db/pkg/||g" | grep -E "{}-[0-9]"'
}
Em.GetRepoConf() {
	cat /etc/portage/repos.conf /etc/portage/repos.conf/* 2>/dev/null
}
Em.GetDefaultRepoName() {
	Em.GetRepoConf | Ini.GetParam DEFAULT main-repo
}
Em.GetRepoLocation() {
	Em.GetRepoConf | Ini.GetParam "$1" location
}
Em.GetAllPkgList() {
	Em.GetRepoConf | sed -e 's/^ *//' -e 's/ *$//' | grep "^ *location *=" | sed -e 's/^location *= *//' | xargs -L1 realpath | xargs -I{} bash -c "find '{}' -mindepth 3 -maxdepth 3 -type f -name '*.ebuild' | sed -e 's|{}/||g' -e 's|.ebuild$||g'" | awk -F "/" '{print $1"/"$3}'
}
Em.NoVersion() {
	sed -E 's|\-[0-9]+.+||g'
}
Ini.GetLastParam() {
	Ini.GetParamList "$1" | tail -n 1
}
Ini.GetSectionList() {
	local _RawIniLine=()
	local _Line _LineNo=1 _Exit=0
	readarray -t _RawIniLine
	while read -r _Line; do
		Ini.ParseLine <<<"$_Line"
		case "$TYPE" in
		"SECTION")
			echo "$SECTION"
			;;
		"ERROR")
			echo "Line $_LineNo: Failed to parse Ini" 1>&2
			_Exit=1
			;;
		esac
		_LineNo=$((_LineNo + 1))
	done < <(PrintArray "${_RawIniLine[@]}")
	return "$_Exit"
}
Ini.GetParamList() {
	local _RawIniLine=()
	local _Line _LineNo=1 _Exit=0 _InSection=false
	readarray -t _RawIniLine
	while read -r _Line; do
		Ini.ParseLine <<<"$_Line"
		case "$TYPE" in
		"SECTION")
			if [[ $SECTION == "$1" ]]; then
				_InSection=true
			else
				_InSection=false
			fi
			;;
		"PARAM-VALUE")
			[[ $_InSection == false ]] || echo "$PARAM"
			;;
		"ERROR")
			echo "Line $_LineNo: Failed to parse Ini" 1>&2
			_Exit=1
			;;
		esac
		_LineNo=$((_LineNo + 1))
	done < <(PrintArray "${_RawIniLine[@]}")
	return "$_Exit"
}
Ini.ParseLine() {
	local _Line
	TYPE="" PARAM="" VALUE="" SECTION=""
	_Line="$(RemoveBlank <<<"$(cat)")"
	case "$_Line" in
	"["*"]")
		TYPE="SECTION"
		SECTION=$(sed "s|^\[||g; s|\]$||g" <<<"$_Line")
		FSBLIB_INI_PARSED_TYPE="$TYPE"
		FSBLIB_INI_PARSED_SECTION="$SECTION"
		;;
	"" | "#"*)
		TYPE="NOTHING"
		FSBLIB_INI_PARSED_TYPE="$TYPE"
		;;
	*"="*)
		TYPE="PARAM-VALUE"
		PARAM="$(RemoveBlank <<<"$(cut -d "=" -f 1 <<<"$_Line")")"
		VALUE="$(RemoveBlank <<<"$(cut -d "=" -f 2- <<<"$_Line")")"
		FSBLIB_INI_PARSED_TYPE="$TYPE"
		FSBLIB_INI_PARSED_PARAM="$PARAM"
		FSBLIB_INI_PARSED_VALUE="$VALUE"
		;;
	*)
		TYPE="ERROR"
		FSBLIB_INI_PARSED_TYPE="$TYPE"
		;;
	esac
	return 0
}
Ini.GetParam() {
	local _RawIniLine=()
	local _Line _LineNo=1 _Exit=0 _InSection=false
	readarray -t _RawIniLine
	while read -r _Line; do
		Ini.ParseLine <<<"$_Line"
		case "$TYPE" in
		"SECTION")
			if [[ $SECTION == "$1" ]]; then
				_InSection=true
			else
				_InSection=false
			fi
			;;
		"PARAM-VALUE")
			[[ $_InSection == false ]] && continue
			[[ ${FSBLIB_INI_PARSED_PARAM} == "$2" ]] && echo "$FSBLIB_INI_PARSED_VALUE"
			;;
		"ERROR")
			echo "Line $_LineNo: Failed to parse Ini" 1>&2
			_Exit=1
			;;
		esac
		_LineNo=$((_LineNo + 1))
	done < <(PrintArray "${_RawIniLine[@]}")
	return "$_Exit"
}
Ini.NewParam() {
	local IniContents=() Line
	local Section="$1" Param="$2"
	local InSection=false LineNo=0
	local NewIniContents=()
	readarray -t IniContents
	local BeforeParam
	local SectionLastParam
	local ParamAdded=false
	if ! PrintArray "${IniContents[@]}" | Ini.GetParamList "$Section" | grep -qx "$Param"; then
		SectionLastParam="$(PrintEvalArray IniContents | Ini.GetLastParam "$Section")"
		for Line in "${IniContents[@]}"; do
			LineNo=$((LineNo + 1))
			Ini.ParseLine <<<"$Line"
			case "$FSBLIB_INI_PARSED_TYPE" in
			"SECTION")
				if [[ $FSBLIB_INI_PARSED_SECTION == "$Section" ]]; then
					InSection=true
				else
					InSection=false
				fi
				;;
			"PARAM-VALUE")
				if [[ $InSection == true ]]; then
					BeforeParam="$FSBLIB_INI_PARSED_PARAM"
				fi
				;;
			"ERROR")
				echo "Line $LineNo: Failed to parse Ini" 1>&2
				return 1
				;;
			esac
			NewIniContents+=("$Line")
			if {
				! Bool "$ParamAdded"
			} && Bool "$InSection" && [[ $SectionLastParam == "${BeforeParam-""}" ]]; then
				NewIniContents+=("$Param=")
				ParamAdded=true
			fi
		done
	fi
	PrintEvalArray NewIniContents
	return 0
}
Ini.SetValue() {
	local IniContents=()
	local Section="$1" Param="$2"
	readarray -t IniContents
	readarray -t IniContents < <(PrintArray "${IniContents[@]}" | Ini.NewSection "$Section" | Ini.NewParam "$Section" "$Param")
	PrintEvalArray IniContents
}
Ini.NewSection() {
	local IniContents=()
	local Section="$1"
	readarray -t IniContents
	if PrintArray "${IniContents[@]}" | Ini.GetSectionList | grep -x "$Section" >/dev/null; then
		PrintEvalArray IniContents
		return 0
	fi
	if [[ -z "$(Array.Last IniContents)" ]]; then
		Array.Pop IniContents
	fi
	IniContents+=("" "[$Section]")
	PrintEvalArray IniContents
	return 0
}
Array.FromStr() {
	declare -a -x "$1"
	readarray -t "$1" < <(BreakChar)
}
Array.Pop() {
	readarray -t "$1" < <(PrintEvalArray "$1" | sed -e '$d')
}
Array.Append() {
	local _ArrName="$1"
	shift 1 || return 1
	readarray -t -O "$(ArrayIndex "$_ArrName")" "$_ArrName" < <(cat)
}
Array.Push() {
	eval "PrintArray \"\${$1[@]}\"" | grep -qx "$2" && return 0
	eval "$1+=(\"$2\")"
}
Array.Remove() {
	readarray -t "$1" < <(PrintEvalArray "$1" | RemoveMatchLine "$2")
}
Array.Rev() {
	readarray -t "$1" < <(PrintEvalArray "$1" | tac)
}
Array.Shift() {
	readarray -t "$1" < <(PrintEvalArray "$1" | sed "1,${2-"1"}d")
}
Array.Eval() {
	eval "PrintArray \"\${$1[@]}\""
}
Array.Last() {
	PrintEval "$1[$(Array.LastIndex "$1")]"
}
Array.Print() {
	(($# >= 1)) || return 0
	printf "%s\n" "${@}"
}
Array.IndexOf() {
	local n=()
	readarray -t n < <(grep -x -n "$1" | cut -d ":" -f 1 | ForEach eval echo '$(( {} - 1 ))')
	(("${#n[@]}" >= 1)) || return 1
	PrintArray "${n[@]}"
	return 0
}
Array.Length() {
	PrintEval "#${1}[@]"
}
Array.LastIndex() {
	CalcInt "$(Array.Length "$1")" - 1
}
Array.ForEach() {
	PrintEvalArray "$1" | ForEach "${@:2}"
}
Array.Includes() {
	PrintEvalArray "$1" | grep -qx "$2"
}
PrintEvalArray() {
	Array.Eval "$1"
}
RevArray() {
	Array.Rev "$1"
}
ArrayIncludes() {
	Array.Includes "$@"
}
PrintArray() {
	Array.Print "$@"
}
AddNewToArray() {
	Array.Push "$@"
}
StrToCharList() {
	Array.FromStr "$1"
}
ArrayAppend() {
	Array.Append "$1"
}
ArrayIndex() {
	Array.Length "$1"
}
GetArrayIndex() {
	Array.IndexOf "$1"
}
FileType() {
	file --mime-type -b "$1"
}
GetBaseName() {
	ForEach basename "{}"
}
RemoveFileExt() {
	local Ext
	ForEach eval 'Ext=$(GetFileExt <<< {}); sed "s|.$Ext$||g" <<< {}; unset Ext'
}
GetFileExt() {
	GetBaseName | rev | cut -d "." -f 1 | rev
}
GetLine() {
	head -n "$1" | tail -n 1
}
Loop() {
	local _T="$1"
	shift 1 || return 1
	((_T == 0)) && return 0
	ForEach "$@" < <(yes "" | head -n "$_T")
}
ForEach() {
	local _Item
	while read -r _Item; do
		"${@//"{}"/"${_Item}"}" || return "${?}"
	done
}
CheckFuncDefined() {
	typeset -f "${1}" >/dev/null || return 1
}
IsAvailable() {
	type "$1" 2>/dev/null 1>&2
}
GetLastSplitString() {
	rev <<<"$2" | cut -d "$1" -f 1 | rev
}
CutLastString() {
	echo "${1%%"${2}"}"
	return 0
}
BreakChar() {
	grep -o "."
}
IsUUID() {
	local _UUID="${1-""}"
	[[ ${_UUID//-/} =~ ^[[:xdigit:]]{32}$ ]] && return 0
	return 1
}
ToLower() {
	local _Str="${1,,}"
	[[ -z ${_Str-""} ]] || echo "${_Str}"
}
RandomString() {
	base64 <"/dev/random" | fold -w "$1" | head -n 1
	return 0
}
PrintEval() {
	eval echo "\${$1}"
}
ToLowerStdin() {
	local _Str
	ForEach eval '_Str="{}"; echo "${_Str,,}"'
	unset _Str
}
RemoveBlank() {
	sed "s|^ *||g; s| *$||g; s|^	*||g; s|	*$||g; /^$/d"
}
TextBox() {
	local _Content=() _Length _Vertical="|" _Line="=" _Header="${1-""}"
	readarray -t _Content
	_Length="$(PrintArray "${_Content[@]}" "$_Header" | awk '{ if ( length > x && length > 0 ) { x = length } }END{ print x }')"
	if [[ -z ${_Header:-""} ]]; then
		echo "${_Vertical}$(Loop "$((_Length + 1))" echo -n "${_Line}")${_Vertical}"
	else
		((_Length % 2 == 0)) || ((_Length++))
		((${#_Header} % 2 == 0)) && ((_Length++))
		echo "${_Vertical}$(Loop "$(((_Length - ${#_Header}) / 2))" echo -n "${_Line}")${_Header+" ${_Header} "}$(Loop "$(((_Length - ${#_Header}) / 2))" echo -n "${_Line}")${_Vertical}"
	fi
	for _Str in "${_Content[@]}"; do
		echo "${_Vertical}${_Str}$(Loop "$((_Length + 1 - "${#_Str}"))" echo -n " ")${_Vertical}"
	done
	echo "${_Vertical}$(Loop "$((_Length + 1))" echo -n "${_Line}")${_Vertical}"
}
Ntest() {
	(("$@")) || return 1
}
Sum() {
	local _Arg=()
	ForEach eval '_Arg+=("{}" "+")' < <(PrintArray "$@")
	readarray -t _Arg < <(PrintArray "${_Arg[@]}" | sed "${#_Arg[@]}d")
	CalcInt "${_Arg[@]}"
}
CalcInt() {
	echo "$(("$@"))"
}
Bool() {
	case "$(RemoveBlank <<<"$(ToLower "$1")")" in
	"true")
		return 0
		;;
	"false")
		return 1
		;;
	esac
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
GetFuncList() {
	declare -F | cut -d " " -f 3
}
UnsetAllFunc() {
	local Func
	while read -r Func; do
		unset "$Func"
	done < <(GetFuncList)
}
Match() {
	local stdin str
	read -r stdin
	for str in "$@"; do
		if [[ $str == "$stdin" ]]; then
			return 0
		fi
	done
	return 1
}
RemoveMatchLine() {
	local i unseted=false
	while read -r i; do
		if [[ $i != "${1}" ]] || [[ ${unseted} == true ]]; then
			echo "$i"
		else
			unseted=true
		fi
	done
	unset unseted i
}
URL.Authority() {
	local i _NoScheme
	while read -r i; do
		_NoScheme=$(URL.NoScheme <<<"$i")
		[[ $_NoScheme == "//"* ]] || return 1
		cut -d "/" -f 1 < <(sed "s|^//||g" <<<"$_NoScheme")
	done
}
URL.Path() {
	URL.PathAndQueryAndFragment | cut -d "#" -f 1 | cut -d "?" -f 1
}
URL.Query() {
	local i
	while read -r i; do
		URL.PathAndQueryAndFragment <<<"$i" | sed "s|#$(URL.Fragment <<<"$i")||g" | cut -d "?" -f 2-
	done
}
URL.Host() {
	URL.Authority | cut -d "@" -f 2- | cut -d ":" -f 1
}
URL.Scheme() {
	cut -d ":" -f 1
}
URL.Port() {
	local i
	while read -r i; do
		[[ $i == *":"* ]] || {
			continue
		}
		cut -d ":" -f 2 <<<"$i"
	done < <(URL.Authority)
}
URL.Fragment() {
	local i
	i="$(URL.PathAndQueryAndFragment)"
	[[ $i == *"#"* ]] || return 0
	cut -d "#" -f 2- <<<"$i"
}
URL.NoScheme() {
	cut -d ":" -f 2-
}
URL.User() {
	local i
	while read -r i; do
		[[ $i == *"@"* ]] || {
			echo ""
			continue
		}
		cut -d "@" -f 1 <<<"$i"
	done < <(URL.Authority)
}
URL.PathAndQueryAndFragment() {
	local i
	while read -r i; do
		sed "s|^//$(URL.Authority <<<"$i")||g" <<<"$(URL.NoScheme <<<"$i")"
	done
}
URL.HasAuthority() {
	local i="${1-""}"
	[[ -n $i ]] || read -r i
	[[ "$(URL.NoScheme <<<"$i")" == "//"* ]]
}
URL.HasQuery() {
	local i="${1-""}"
	[[ -n $i ]] || read -r i
	[[ "$(URL.PathAndQueryAndFragment <<<"$i")" == *"?"* ]]
}
URL.HasFragment() {
	local i="${1-""}"
	[[ -n $i ]] || read -r i
	[[ "$(URL.PathAndQueryAndFragment <<<"$i")" == *"#"* ]]
}
URL.HasUser() {
	local i="${1-""}"
	[[ -n $i ]] || read -r i
	[[ "$(URL.Authority <<<"$i")" == *"@"* ]]
}
URL.HasPort() {
	local i="${1-""}"
	[[ -n $i ]] || read -r i
	[[ "$(URL.Authority <<<"$i")" == *":"* ]]
}
URL.Parse() {
	local i="${1-""}"
	if [[ -z ${i} ]]; then
		read -r i
	fi
	URL.Scheme <<<"$i"
	echo ":"
	if URL.HasAuthority "$i"; then
		if URL.HasUser "$i"; then
			URL.User <<<"$i"
			echo "@"
		fi
		URL.Host <<<"$i"
		if URL.HasPort "$i"; then
			echo ":"
			URL.Port <<<"$i"
		fi
	fi
	URL.Path <<<"$i"
	if URL.HasFragment "$i"; then
		echo "#"
		URL.Fragment <<<"$i"
	fi
	if URL.HasQuery "$i"; then
		echo "?"
		URL.Query <<<"$i"
	fi
}
URL.GetQuery() {
	grep "^ *$1=" | cut -d "=" -f 2-
}
URL.ParseQuery() {
	local i="${1-""}"
	if [[ -z ${i} ]]; then
		read -r i
	fi
	if grep -q "[a-zA-Z]://" <<<"$i"; then
		i="$(URL.Query <<<"$i")"
	fi
	i="$(sed "s|^\?||g" <<<"$i")"
	tr "&" "\n" <<<"$i" | cut -d "#" -f 1
}
Pm.GetInstalledPkgVer() {
	if [[ -z ${*} ]]; then
		cat
	else
		PrintArray "$@"
	fi | ForEach pacman -Q "{}" | cut -d " " -f 2
	PrintArray "${PIPESTATUS[@]}" | grep -qx "1" && return 1
	return 0
}
Pm.GetRepoConf() {
	ForEach eval 'echo [{}] && Pm.GetConfig -r {}'
}
Pm.GetLatestPkgVer() {
	local _LANG="${LANG-""}"
	export LANG=C
	if [[ -z ${*} ]]; then
		cat
	else
		PrintArray "$@"
	fi | ForEach Pm.Run -Si "{}" | grep "^Version" | cut -d ":" -f 2 | RemoveBlank
	[[ -n $_LANG ]] && export LANG="$_LANG"
	return 0
}
Pm.GetRepoServer() {
	ForEach eval 'Pm.GetConfig -r {}' | grep "^Server" | ForEach eval "Ini.ParseLine <<< '{}' ; printf '%s\n' \${VALUE}"
}
Pm.Run() {
	pacman --noconfirm --config "${PACMAN_CONF-"/etc/pacman.conf"}" "$@"
}
Pm.GetRepoVer() {
	Pm.Run -Sp --print-format '%v' "$1"
}
Pm.IsRepoPkg() {
	Pm.Run -Slq | grep -qx "$(Pm.GetName <<<"$1")"
}
Pm.GetName() {
	cut -d "<" -f 1 | cut -d ">" -f 1 | cut -d "=" -f 1
}
Pm.GetRepoListFromConf() {
	Pm.GetConfig --repo-list
}
Pm.GetPacmanKeyringDir() {
	local _KeyringDir=""
	_KeyringDir="$(LANG=C pacman-key -h | RemoveBlank | grep -A 1 -- "^--populate" | tail -n 1 | cut -d "/" -f 2- | sed "s|'$||g")"
	: "${_KeyringDir="usr/share/pacman/keyrings"}"
	_KeyringDir="$(Pm.GetRoot)/$_KeyringDir"
	_KeyringDir="$(sed -E "s|/+|/|g" <<<"$_KeyringDir")"
	if [[ -e $_KeyringDir ]]; then
		Readlinkf "$_KeyringDir"
	else
		echo "$_KeyringDir"
	fi
}
Pm.CheckPkg() {
	local p
	for p in "$@"; do
		Pm.Run -Qq "$p" >/dev/null 2>&1 || return 1
	done
	return 0
}
Pm.GetConfig() {
	LANG=C pacman-conf --config="${PACMAN_CONF-"/etc/pacman.conf"}" "$@"
}
Pm.RunKey() {
	pacman-key --config "${PACMAN_CONF-"/etc/pacman.conf"}" "$@"
}
Pm.GetRepoPkgList() {
	Pm.Run -Slq "$@"
}
Pm.GetPacmanKernelPkg() {
	echo "there is nothing"
}
Pm.PacmanGpg() {
	gpg --homedir "$(Pm.GetConfig GPGDir)" "$@"
}
Pm.GetKeyringList() {
	find "$(@GetKeyringDir)" -name "*.gpg" | GetBaseName | RemoveFileExt
}
Pm.GetRoot() {
	Pm.GetConfig RootDir
}
Pm.GetDbSection() {
	readarray -t _Stdin
	PrintArray "${_Stdin[@]}" | sed -ne "/^%$1%$/,/^%$(PrintEvalArray _Stdin | Pm.GetDbNextSection "$1")%$/p" | sed '1d; $d'
}
Pm.GetDbSectionList() {
	grep -E "^%.*%$"
}
Pm.GetDbNextSection() {
	Pm.GetDbSectionList | grep -x -A 1 "^%$1%$" | GetLine 2 | sed "s|^%||g; s|%$||g"
}
Pm.GetDbTmpDir() {
	echo "${TMPDIR-"/tmp"}/fasbashlib-pacman-db"
}
Pm.GetSyncDbDesc() {
	local _path
	_path="$(Pm.GetSyncDbDescPath "$1")"
	[[ -e $_path ]] || return 1
	cat "$_path/desc"
}
Pm.GetPkgArch() {
	Pm.GetSyncDbDesc "$1" | Pm.GetDbSection ARCH | RemoveBlank
}
Pm.GetSyncDbDescPath() {
	local _repo
	_repo="$(pacman -Sp --print-format '%r' "$1")"
	{
		IsPacmanSyncDbOpend "$_repo" || OpenPacmanSyncDb "$_repo"
	} || return 1
	echo "$(Pm.GetDbTmpDir)/sync/$(pacman -Sp --print-format '%r/%n-%v' "$1")"
}
Pm.GetVirtualPkgList() {
	Pm.GetRepoListFromLocalDb | ForEach Pm.OpenSyncDb {}
	Pm.GetSyncAllDesc | ForEach eval "Pm.GetDbSection PROVIDES < {}" | RemoveBlank
}
Pm.GetRepoListFromLocalDb() {
	find "$(Pm.GetConfig DBPath)/sync" -mindepth 1 -maxdepth 1 -type f | GetBaseName | sed "s|.db$||g"
	return 0
}
Pm.DeleteDbTmpDir() {
	rm -rf "$(Pm.GetDbTmpDir)"
}
Pm.IsOpendSyncDb() {
	readarray -t _PkgDbList < <(find "$(Pm.GetDbTmpDir)/sync/$1" -mindepth 1 -maxdepth 1 -type d)
	(("${#_PkgDbList[@]}" > 0)) && return 0
	return 1
}
Pm.ParsePkgFileName() {
	local _Pkg="$1"
	local _PkgName _PkgVer _PkgRel _Arch _FileExt
	local _PkgWithOutExt
	if grep "/" <<<"$_Pkg"; then
		_Pkg="$(basename "$_Pkg")"
	fi
	_FileExt="$(GetLastSplitString "-" "$_Pkg" | cut -d "." -f 2-)"
	_PkgWithOutExt="${_Pkg%%".${_FileExt}"}"
	_Arch=$(GetLastSplitString "-" "${_PkgWithOutExt}")
	_PkgRel=$(GetLastSplitString "-" "${_PkgWithOutExt%%"-${_Arch}"}")
	_PkgVer=$(GetLastSplitString "-" "${_PkgWithOutExt%%"-${_PkgRel}-${_Arch}"}")
	_PkgName="${_PkgWithOutExt%%"-${_PkgVer}-${_PkgRel}-${_Arch}"}"
	_ParsedPkg=("${_PkgName}" "-" "$_PkgVer" "-" "$_PkgRel" "-" "$_Arch" ".$_FileExt")
	if [[ ! "$(PrintArray "${_ParsedPkg[@]}" | tr -d "\n")" == "${_Pkg}" ]]; then
		return 1
	fi
	PrintArray "${_ParsedPkg[@]}"
}
Pm.OpenSyncDb() {
	local _Dir _RepoDb
	Pm.CreateDbTmpDir
	_Dir="$(Pm.GetDbTmpDir)/sync/$1"
	mkdir -p "$_Dir"
	_RepoDb="$(Pm.GetConfig DBPath)/sync/$1.db"
	[[ -e $_RepoDb ]] || return 1
	tar -xzf "${_RepoDb}" -C "$_Dir" || return 1
}
Pm.CreateDbTmpDir() {
	mkdir -p "$(Pm.GetDbTmpDir)"
}
Pm.GetSyncAllDesc() {
	find "$(Pm.GetDbTmpDir)" -mindepth 3 -maxdepth 3 -name "desc" -type f
}
Pm.OpenedSyncDbList() {
	find "$(Pm.GetDbTmpDir)/sync/" -mindepth 1 -maxdepth 1 -type d
}
Misskey.Notes.Renotes() {
	Misskey.BindingBase "notes/renotes" noteId limit sinceId untilId -- "$@"
}
Misskey.Notes.Search() {
	Misskey.BindingBase "notes/search" query limit -- "$@"
}
Misskey.Notes.Create() {
	Misskey.BindingBase "notes/create" text -- "$@"
}
Misskey.Users.Pages() {
	Misskey.BindingBase "users/pages" userId -- "${1:-"$(Misskey.MyId)"}" "${@:2}"
}
Misskey.Users.SearchByUsernameAndHost() {
	Misskey.BindingBase "users/search-by-username-and-host" username -- "${1:-"$(Misskey.MyUserName)"}" "${@:2}"
}
Misskey.Users.Stats() {
	Misskey.BindingBase "users/stats" userId -- "${1:-"$(Misskey.MyId)"}" "${@:2}"
}
Misskey.Users.Show() {
	Misskey.BindingBase "users/show" userId -- "${1:-"$(Misskey.MyId)"}" "${@:2}"
}
Misskey.Users.Notes() {
	Misskey.BindingBase "users/notes" userId -- "${1:-"$(Misskey.MyId)"}" "${@:2}"
}
Misskey.Users.GetFrequentlyRepliedUsers() {
	Misskey.BindingBase "users/get-frequently-replied-users" userId -- "${1:-"$(Misskey.MyId)"}" "${@:2}"
}
Misskey.Admin.ServerInfo() {
	Misskey.BindingBase "/admin/server-info" -- "$@"
}
Misskey.Setup() {
	export MISSKEY_DOMAIN="${1-"${MISSKEY_DOMAIN-""}"}"
	export MISSKEY_TOKEN="${2-"${MISSKEY_TOKEN-""}"}"
	export MISSKEY_ENTRY="https://${MISSKEY_DOMAIN}/api"
}
Misskey.Meta() {
	Misskey.BindingBase "/meta" -- "$@"
}
Misskey.I() {
	Misskey.BindingBase "/i" -- "$@"
}
Misskey.ServerInfo() {
	Misskey.BindingBase "/server-info" -- "$@"
}
Misskey.MakeJson() {
	local i _Key _Value
	for i in "i=$MISSKEY_TOKEN" "$@"; do
		_Key=$(cut -d "=" -f 1 <<<"$i")
		_Value=$(cut -d "=" -f 2- <<<"$i")
		if [[ $_Value =~ ^[0-9]+$ ]] || [[ $_Value == true ]] || [[ $_Value == false ]] || [[ $_Value == "{"*"}" ]] || [[ $_Value == "["*"]" ]]; then
			echo -n "{\"$_Key\": $_Value}"
		else
			echo -n "{\"$_Key\": \"$_Value\"}"
		fi
	done | sed "s|}{|,|g" | jq -c -M
}
Misskey.BindingBase() {
	local _API="$1"
	shift 1
	local i _APIArgs=("") _Args
	for i in "$@"; do
		shift 1 2>/dev/null || true
		if [[ $i == "--" ]]; then
			break
		else
			_APIArgs+=("$i")
		fi
	done
	local _Cnt _Shifted=false
	for ((_Cnt = 1; _Cnt <= "${#_APIArgs[@]} - 1"; _Cnt++)); do
		_Args+=("${_APIArgs[$_Cnt]}=$(eval echo "\${${_Cnt}:-""}")")
		if [[ -z "$(eval echo "\${$((_Cnt + 1)):-""}")" ]]; then
			shift "$_Cnt"
			_Shifted=true
			break
		fi
	done
	if ! Bool _Shifted; then
		_Shifted=true
		shift "$((${#_APIArgs[@]} - 1))"
	fi
	if [[ -z ${MISSKEY_ENTRY-""} ]]; then
		Misskey.Setup "${MISSKEY_DOMAIN}" "$MISSKEY_TOKEN"
	fi
	Misskey.SendReq "${MISSKEY_ENTRY%/}/${_API#/}" "${_Args[@]}" "$@"
}
Misskey.SendReq() {
	local _Url="$1" _CurlArgs=()
	shift 1
	_CurlArgs+=(-s -L)
	_CurlArgs+=(-X POST)
	_CurlArgs+=(-H "Content-Type: application/json")
	_CurlArgs+=(-d "$(Misskey.MakeJson "$@")")
	_CurlArgs+=("$_Url")
	Msg.Debug "Run: ${_CurlArgs[*]//"${MISSKEY_TOKEN}"/"TOKEN"}"
	curl "${_CurlArgs[@]}"
}
Misskey.MyId() {
	Misskey.I | jq -r ".id"
}
Misskey.MyName() {
	Misskey.I | jq -r ".name"
}
Misskey.MyUserName() {
	Misskey.I | jq -r ".username"
}
Misskey.IsAdmin() {
	Bool "$(Misskey.I | jq -r ".isAdmin")"
}
