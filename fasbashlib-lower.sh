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
FSBLIB_FUNCLIST+=("Sqlite3.call" "Sqlite3.currentDb" "Sqlite3.existTable" "Sqlite3.insert" "Pm.checkPkg" "Pm.getConfig" "Pm.getInstalledPkgVer" "Pm.getLatestPkgVer" "Pm.getRepoServer" "Pm.getRepoVer" "Pm.getRoot" "Cache.getDir" "Pm.isRepoPkg" "parseArg" "Pm.pacmanGpg" "Pm.run" "Pm.runKey" "Sqlite3.delete" "printArray" "arrayIndex" "Pm.getName" "Pm.getRepoPkgList" "Pm.getPacmanKeyringDir" "getArrayIndex" "revArray" "arrayAppend" "printEvalArray" "Pm.getRepoConf" "arrayIncludes" "addNewToArray" "Sqlite3.existField" "Pm.getPacmanKernelPkg" "strToCharList" "Cache.getID" "Pm.getKeyringList" "Misskey.notes.Create" "Misskey.notes.Renotes" "Pm.getRepoListFromConf" "Sqlite3.selectAll" "Misskey.notes.Search" "Sqlite3.select" "Sqlite3.create" "Sqlite3.connect" "Cache.exist" "choice" "Cache.get" "Cache.getFileLastUpdate" "Cache.getTimeDiffFromLastUpdate" "Ini.getLastParam" "Ini.getParam" "Ini.getParamList" "Ini.parseLine" "Arch.getKernelFileList" "Arch.getKernelSrcList" "Arch.getMkinitcpioPresetList" "Ini.getSectionList" "Awk.tan" "Awk.print" "Csv.getClm" "Csv.toBashArray" "Awk.cos" "Awk.float" "Awk.log" "Awk.pi" "Awk.rad" "Awk.sin" "Fsblib.fsblibEnvCheck" "Fsblib.requireLib" "Csv.getClmCnt" "Fsblib.envCheck" "Em.getAllPkgList" "Em.getInstalledPkgList" "Em.getRepoConf" "Em.getRepoLocation" "Msg.common" "Em.getWorldPkgList" "Msg.err" "Msg.info" "Msg.warn" "Em.getDefaultRepoName" "SrcInfo.parse" "Msg.debug" "SrcInfo.getValueInPkgName" "SrcInfo.format" "SrcInfo.getKeyList" "SrcInfo.getPkgBase" "SrcInfo.getPkgName" "SrcInfo.getSectionList" "SrcInfo.getValue" "Em.getRepoPkgList" "SrcInfo.getValueInPkgBase" "Array.shift" "readlinkf_Posix" "readlinkf_Readlink" "Array.append" "Array.push" "Array.rev" "readlinkf" "Array.remove" "Array.fromStr" "Array.pop" "URL.authority" "URL.query" "URL.noScheme" "URL.path" "URL.pathAndQueryAndFragment" "URL.host" "URL.scheme" "URL.fragment" "URL.port" "URL.user" "getBaseName" "getFileExt" "removeFileExt" "fileType" "Misskey.users.GetFrequentlyRepliedUsers" "Misskey.users.Show" "Misskey.users.Notes" "Misskey.users.SearchByUsernameAndHost" "Misskey.users.Stats" "Misskey.users.Pages" "Cache.create" "Cache.createDir" "Pm.getDbNextSection" "Pm.getDbSection" "Pm.getDbSectionList" "Ini.newParam" "Ini.setValue" "Ini.newSection" "Em.noVersion" "Array.eval" "Array.print" "URL.hasPort" "URL.hasQuery" "URL.hasAuthority" "URL.hasFragment" "URL.hasUser" "Array.last" "Pm.createDbTmpDir" "Pm.deleteDbTmpDir" "Pm.getDbTmpDir" "Pm.getPkgArch" "Pm.getRepoListFromLocalDb" "Pm.getSyncAllDesc" "forEach" "Pm.getSyncDbDesc" "getLine" "Pm.openedSyncDbList" "isAvailable" "Pm.getVirtualPkgList" "Pm.parsePkgFileName" "Pm.getSyncDbDescPath" "loop" "checkFuncDefined" "Pm.isOpendSyncDb" "Pm.openSyncDb" "Misskey.admin.ServerInfo" "URL.parse" "Array.indexOf" "Array.lastIndex" "Array.length" "breakChar" "randomString" "cutLastString" "getLastSplitString" "removeBlank" "isUUID" "textBox" "toLower" "Misskey.setup" "printEval" "toLowerStdin" "Array.forEach" "Array.includes" "URL.getQuery" "URL.parseQuery" "sum" "calcInt" "ntest" "Misskey.i" "Misskey.meta" "Misskey.serverInfo" "bool" "Misskey.makeJson" "Misskey.sendReq" "Misskey.bindingBase" "unsetAllFunc" "getFuncList" "Misskey.isAdmin" "Misskey.myName" "Misskey.myId" "Misskey.myUserName" "removeMatchLine" "match")
declare -r FSBLIB_VERSION='v0.2.5.1.r393.g40bf0c7-lower'
declare -r FSBLIB_REQUIRE='ModernBash'

parseArg() {
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
						Msg.err "${1} の引数が指定されていません"
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
						Msg.err "${1} は不正なオプションです。-hで使い方を確認してください。"
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
								Msg.err "-${_Chr} の引数が指定されていません"
								return 2
							fi
						else
							if printf "%s\n" "${_Short[@]}" | grep -qx "${_Chr}"; then
								_OutArg+=("-${_Chr}")
								_Shift=1
							else
								Msg.err "-${_Chr} は不正なオプションです。-hで使い方を確認してください。"
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
choice() {
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
		[[ ${_number} == true ]] && [[ -n ${_returnint+SET} ]]
	} && {
		echo "${_returnint}" && return 0
	}
	{
		[[ ${_number} == false ]] && [[ -n ${_returnstr+SET} ]]
	} && {
		echo "${_returnstr}" && return 0
	}
	return 1
}
readlinkf_Posix() {
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
readlinkf_Readlink() {
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
readlinkf() {
	readlinkf_Posix "$@"
}
Fsblib.fsblibEnvCheck() {
	Fsblib.envCheck
}
Fsblib.requireLib() {
	local lib missing=() return=0
	for lib in "$@"; do
		if ! [[ ${FSBLIB_LIBLIST[*]} == *" $lib "* ]]; then
			missing+=("$lib")
			return=1
		fi
	done
	return "$return"
}
Fsblib.envCheck() {
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
Arch.getKernelFileList() {
	find "/boot" -maxdepth 1 -mindepth 1 -name "vmlinuz-*"
}
Arch.getKernelSrcList() {
	find "/usr/src" -mindepth 1 -maxdepth 1 -type l -name "linux*"
}
Arch.getMkinitcpioPresetList() {
	find "/etc/mkinitcpio.d/" -name "*.preset" -type f | getBaseName | removeFileExt
}
Csv.toBashArray() {
	local _RawCsvLine=() _Line _ClmCnt=0
	local ArrayPrefix="${ArrayPrefix-"{}"}"
	readarray -t _RawCsvLine < <(
		while read -r _Line; do
			(($(tr "${CSVDELIM-","}" "\n" <<<"$_Line" | wc -l) >= ${#})) && echo "$_Line"
		done < <(grep -v "^#")
	)
	_ClmCnt=$(printArray "${_RawCsvLine[@]}" | Csv.getClmCnt)
	while read -r _Cnt; do
		readarray -t "$(sed "s|{}|$(eval "echo \"\${${_Cnt}}\"")|g" <<<"$ArrayPrefix")" < <(
			printArray "${_RawCsvLine[@]}" | cut -d "${CSVDELIM-","}" -f "$_Cnt"
		)
	done < <(seq 1 "$#")
}
Csv.getClmCnt() {
	local _RawCsvLine=()
	local _Line _ClmCnt=0
	readarray -t _RawCsvLine
	while read -r _Line; do
		grep -qE "^#" <<<"$_Line" && continue
		_CurrentClmCnt=$(tr "${CSVDELIM-","}" "\n" | wc -l)
		((_CurrentClmCnt > _ClmCnt)) && _ClmCnt="$_CurrentClmCnt"
	done < <(printArray "${_RawCsvLine[@]}")
	removeBlank <<<"$_ClmCnt"
	return 0
}
Csv.getClm() {
	grep -v "^#" | sed "/^$/d" | cut -d "${CSVDELIM-","}" -f "$1"
}
Msg.err() {
	Msg.common "Error:" "${*}" stderr
}
Msg.debug() {
	Msg.common "Debug:" "${*}" stderr
}
Msg.info() {
	Msg.common " Info:" "${*}" stdout
}
Msg.warn() {
	Msg.common " Warn:" "${*}" stderr
}
Msg.common() {
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
Awk.tan() {
	Awk.float "sin($1)/tan($1)"
}
Awk.print() {
	awk "BEGIN {print $*}"
}
Awk.log() {
	Awk.float "log(${2}) / log($1)"
}
Awk.float() {
	awk "BEGIN {printf (\"%4.${AWKSCALE-"5"}f\n\", $*)}"
}
Awk.sin() {
	Awk.float "sin($*)"
}
Awk.rad() {
	Awk.float "$1 * $(Awk.pi) / 180 "
}
Awk.cos() {
	Awk.float "cos($*)"
}
Awk.pi() {
	Awk.float "atan2(0, -0)"
}
SrcInfo.getValueInPkgName() {
	local _Line
	while read -r _Line; do
		_Key="$(SrcInfo.parse Key <<<"$_Line")"
		case "$_Key" in
		"$2")
			SrcInfo.parse Value <<<"$_Line"
			;;
		esac
	done < <(SrcInfo.getPkgName "$1")
}
SrcInfo.getPkgBase() {
	local _Line _Key _InSection=false
	while read -r _Line; do
		_Key="$(SrcInfo.parse Key <<<"$_Line")"
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
	done < <(SrcInfo.format)
}
SrcInfo.getSectionList() {
	SrcInfo.format | grep -e "^pkgbase" -e "^pkgname"
}
SrcInfo.format() {
	removeBlank | sed "/^$/d" | grep -v "^#" | forEach eval 'SrcInfo.parse Line <<< "{}"'
}
SrcInfo.getPkgName() {
	local _Line _Key _InSection=false _TargetPkgName="$1"
	while read -r _Line; do
		_Key="$(SrcInfo.parse Key <<<"$_Line")"
		case "$_Key" in
		"pkgname")
			if [[ "$(SrcInfo.parse Value <<<"$_Line")" == "$_TargetPkgName" ]]; then
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
	done < <(SrcInfo.format)
}
SrcInfo.parse() {
	local _Output="${1-""}"
	[[ -n ${_Output} ]] || return 1
	shift 1
	local _String _Key _Value
	_String="$(cat)"
	_Key="$(cut -d "=" -f 1 <<<"$_String" | removeBlank)"
	_Value="$(cut -d "=" -f 2- <<<"$_String" | removeBlank)"
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
SrcInfo.getKeyList() {
	SrcInfo.format | cut -d "=" -f 1
}
SrcInfo.getValueInPkgBase() {
	local _Line
	while read -r _Line; do
		_Key="$(SrcInfo.parse Key <<<"$_Line")"
		case "$_Key" in
		"$1")
			SrcInfo.parse Value <<<"$_Line"
			;;
		esac
	done < <(SrcInfo.getPkgBase)
}
SrcInfo.getValue() {
	local _SrcInfo=()
	local _Output=()
	local _PkgBaseValues=("pkgver" "pkgrel" "epoch")
	local _AllValues=("pkgdesc" "url" "install" "changelog")
	local _AllArrays=("arch" "groups" "license" "noextract" "options" "backup" "validpgpkeys")
	local _AllArraysWithArch=("source" "depends" "checkdepends" "makedepends" "optdepends" "provides" "conflicts" "replaces" "md5sums" "sha1sums" "sha224sums" "sha256sums" "sha384sums" "sha512sums")
	arrayAppend _SrcInfo
	arrayIncludes _PkgBaseValues "$1" && {
		printEvalArray _SrcInfo | SrcInfo.getValueInPkgBase "$1"
		return 0
	}
	[[ -n ${2-""} ]] || {
		echo "No pkgname or pkgbase is specified" 1>&2
		return 1
	}
	if arrayIncludes _AllValues "$1" || arrayIncludes _AllArrays "$1"; then
		arrayAppend _Output < <(printEvalArray _SrcInfo | SrcInfo.getValueInPkgBase "$1")
		arrayAppend _Output < <(printEvalArray _SrcInfo | SrcInfo.getValueInPkgName "$2" "$1")
		printArray "${_Output[@]}" | tail -n 1
		return 0
	fi
	arrayIncludes _AllArraysWithArch "$1" || return 1
	local _Arch _ArchList=()
	if [[ -z ${3-""} ]]; then
		arrayAppend _ArchList < <(printEvalArray _SrcInfo | SrcInfo.getValue arch "$2")
	else
		arrayAppend _ArchList < <(tr "," "\n" <<<"$3" | removeBlank)
	fi
	arrayAppend _Output < <(printEvalArray _SrcInfo | SrcInfo.getValueInPkgBase "$1")
	arrayAppend _Output < <(printEvalArray _SrcInfo | SrcInfo.getValueInPkgName "$2" "$1")
	for _Arch in "${_ArchList[@]}"; do
		arrayAppend _Output < <(printEvalArray _SrcInfo | SrcInfo.getValueInPkgBase "$1_${_Arch}")
		arrayAppend _Output < <(printEvalArray _SrcInfo | SrcInfo.getValueInPkgName "$2" "$1_${_Arch}")
	done
	printEvalArray _Output
	return 0
}
Sqlite3.insert() {
	local _table="$1" _args=()
	shift 1 || return 1
	local _values=("$@")
	_args+=(insert into "$_table" values '(')
	forEach eval '_args+=("\"{}\"" ,)' < <(printEvalArray _values)
	Array.pop _args
	_args+=(");")
	Sqlite3.call "${_args[*]}"
}
Sqlite3.call() {
	Msg.debug sqlite3 "${SQLITE3_OPTIONS[@]}" "$SQLITE3_DBPATH" "$@" 1>&2
	sqlite3 "${SQLITE3_OPTIONS[@]}" "$SQLITE3_DBPATH" "$@"
}
Sqlite3.currentDb() {
	if [[ -z ${SQLITE3_DBPATH-""} ]]; then
		Msg.err "No datebase is connected."
		return 1
	fi
	echo "${SQLITE3_DBPATH}"
	return 0
}
Sqlite3.existField() {
	_result="$(Sqlite3.call "SELECT * FROM '$1' WHERE $2 = '$3' LIMIT 1;")"
	if [[ -n ${_result-""} ]]; then
		return 0
	fi
	return 1
}
Sqlite3.selectAll() {
	local _table="$1" _args=()
	shift 1 || return 1
	Sqlite3.call "select * from $_table"
}
Sqlite3.delete() {
	local _table="$1" _args=()
	shift 1 || return 1
	if (($# < 1)) && ((${SQLITE3_ALLOWDELETEALL-"0"} != 1)); then
		Msg.err "Cannot delete all data.\nIf you really want that, Please set environment-variable \"SQLITE3_ALLOWDELETEALL=1\""
		return 1
	fi
	_args+=(delete from "$_table")
	if (($# > 0)); then
		_args+=(where "${@}")
	fi
	Sqlite3.call "${_args[*]}"
}
Sqlite3.existTable() {
	local _result
	_result="$(Sqlite3.call "SELECT COUNT(*) 
                            FROM sqlite_master 
                            WHERE TYPE='table' AND name='$1';
            ")"
	if ((_result > 0)); then
		return 0
	fi
	return 1
}
Sqlite3.create() {
	local _table="$1" _args=() _columns=()
	shift 1 || return 1
	_columns=("$@")
	_args+=(create table "$_table" "(")
	forEach eval '_args+=("\"{}\"" ,)' < <(printEvalArray _columns)
	Array.pop _args
	_args+=(")")
	Sqlite3.call "${_args[*]}"
}
Sqlite3.select() {
	local _table="$1" _args=()
	shift 1 || return 1
	local _values=("$@")
	_args+=(select)
	forEach eval '_args+=("\"{}\"" ,)' < <(printEvalArray _values)
	Array.pop _args
	_args+=("from" "$_table" ";")
	Sqlite3.call "${_args[*]}"
}
Sqlite3.connect() {
	export SQLITE3_DBPATH="$1"
	echo ".open \"$SQLITE3_DBPATH\"" | sqlite3
	return 0
}
Cache.getDir() {
	echo "${TMPDIR-"/tmp"}/$(Cache.getID)"
}
Cache.getID() {
	if [[ -z ${FSBLIB_CACHEID-""} ]]; then
		Cache.createDir >/dev/null
	fi
	echo "$FSBLIB_CACHEID"
}
Cache.getFileLastUpdate() {
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
Cache.getTimeDiffFromLastUpdate() {
	local _Now _Last
	_Now="$(date "+%s")"
	_Last="$(Cache.getFileLastUpdate "$1")"
	echo "$((_Now - _Last))"
	return 0
}
Cache.exist() {
	local _File
	_File="$(Cache.createDir)/$1"
	[[ -e $_File ]] || return 1
	(("$(Cache.getTimeDiffFromLastUpdate "$_File")" > "${KEEPCACHESEC-"86400"}")) && return 2
	return 0
}
Cache.get() {
	cat "$(Cache.getDir)/$1" 2>/dev/null || return 1
}
Cache.createDir() {
	FSBLIB_CACHEID="${FSBLIB_CACHEID-"$(randomString "10")"}"
	export FSBLIB_CACHEID="$FSBLIB_CACHEID"
	local TMPDIR="${TMPDIR-"/tmp"}"
	local _Dir="$TMPDIR/${FSBLIB_CACHEID}"
	mkdir -p "$_Dir"
	echo "$_Dir"
	return 0
}
Cache.create() {
	Cache.createDir >/dev/null
	cat >"$(Cache.getDir)/${1}"
	cat "$(Cache.getDir)/$1"
}
Ini.getSectionList() {
	local _RawIniLine=()
	local _Line _LineNo=1 _Exit=0
	readarray -t _RawIniLine
	while read -r _Line; do
		Ini.parseLine <<<"$_Line"
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
	done < <(printArray "${_RawIniLine[@]}")
	return "$_Exit"
}
Ini.getParam() {
	local _RawIniLine=()
	local _Line _LineNo=1 _Exit=0 _InSection=false
	readarray -t _RawIniLine
	while read -r _Line; do
		Ini.parseLine <<<"$_Line"
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
	done < <(printArray "${_RawIniLine[@]}")
	return "$_Exit"
}
Ini.getLastParam() {
	Ini.getParamList "$1" | tail -n 1
}
Ini.parseLine() {
	local _Line
	TYPE="" PARAM="" VALUE="" SECTION=""
	_Line="$(removeBlank <<<"$(cat)")"
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
		PARAM="$(removeBlank <<<"$(cut -d "=" -f 1 <<<"$_Line")")"
		VALUE="$(removeBlank <<<"$(cut -d "=" -f 2- <<<"$_Line")")"
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
Ini.getParamList() {
	local _RawIniLine=()
	local _Line _LineNo=1 _Exit=0 _InSection=false
	readarray -t _RawIniLine
	while read -r _Line; do
		Ini.parseLine <<<"$_Line"
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
	done < <(printArray "${_RawIniLine[@]}")
	return "$_Exit"
}
Ini.newParam() {
	local IniContents=() Line
	local Section="$1" Param="$2"
	local InSection=false LineNo=0
	local NewIniContents=()
	readarray -t IniContents
	local BeforeParam
	local SectionLastParam
	local ParamAdded=false
	if ! printArray "${IniContents[@]}" | Ini.getParamList "$Section" | grep -qx "$Param"; then
		SectionLastParam="$(printEvalArray IniContents | Ini.getLastParam "$Section")"
		for Line in "${IniContents[@]}"; do
			LineNo=$((LineNo + 1))
			Ini.parseLine <<<"$Line"
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
				! bool "$ParamAdded"
			} && bool "$InSection" && [[ $SectionLastParam == "${BeforeParam-""}" ]]; then
				NewIniContents+=("$Param=")
				ParamAdded=true
			fi
		done
	fi
	printEvalArray NewIniContents
	return 0
}
Ini.setValue() {
	local IniContents=()
	local Section="$1" Param="$2"
	readarray -t IniContents
	readarray -t IniContents < <(printArray "${IniContents[@]}" | Ini.newSection "$Section" | Ini.newParam "$Section" "$Param")
	printEvalArray IniContents
}
Ini.newSection() {
	local IniContents=()
	local Section="$1"
	readarray -t IniContents
	if printArray "${IniContents[@]}" | Ini.getSectionList | grep -x "$Section" >/dev/null; then
		printEvalArray IniContents
		return 0
	fi
	if [[ -z "$(Array.last IniContents)" ]]; then
		Array.pop IniContents
	fi
	IniContents+=("" "[$Section]")
	printEvalArray IniContents
	return 0
}
Em.getRepoConf() {
	cat /etc/portage/repos.conf /etc/portage/repos.conf/* 2>/dev/null
}
Em.getRepoLocation() {
	Em.getRepoConf | Ini.getParam "$1" location
}
Em.getAllPkgList() {
	Em.getRepoConf | sed -e 's/^ *//' -e 's/ *$//' | grep "^ *location *=" | sed -e 's/^location *= *//' | xargs -L1 realpath | xargs -I{} bash -c "find '{}' -mindepth 3 -maxdepth 3 -type f -name '*.ebuild' | sed -e 's|{}/||g' -e 's|.ebuild$||g'" | awk -F "/" '{print $1"/"$3}'
}
Em.getWorldPkgList() {
	sed -E 's|:.+$||g' /var/lib/portage/world | xargs -I{} bash -c 'ls -d /var/db/pkg/{}-* | sed "s|/var/db/pkg/||g" | grep -E "{}-[0-9]"'
}
Em.getDefaultRepoName() {
	Em.getRepoConf | Ini.getParam DEFAULT main-repo
}
Em.getInstalledPkgList() {
	find /var/db/pkg/ -mindepth 2 -maxdepth 2 -type d | sed 's|/var/db/pkg/||g'
}
Em.getRepoPkgList() {
	local _RepoPath
	_RepoPath="$(Em.getRepoLocation "$1")"
	find "$_RepoPath" -mindepth 3 -maxdepth 3 -type f -name '*.ebuild' | sed -e "s|${_RepoPath%/}/||g" -e 's|.ebuild$||g' | awk -F "/" '{print $1"/"$3}'
}
Em.noVersion() {
	sed -E 's|\-[0-9]+.+||g'
}
Array.push() {
	eval "printArray \"\${$1[@]}\"" | grep -qx "$2" && return 0
	eval "$1+=(\"$2\")"
}
Array.append() {
	local _ArrName="$1"
	shift 1 || return 1
	readarray -t -O "$(arrayIndex "$_ArrName")" "$_ArrName" < <(cat)
}
Array.shift() {
	readarray -t "$1" < <(printEvalArray "$1" | sed "1,${2-"1"}d")
}
Array.remove() {
	readarray -t "$1" < <(printEvalArray "$1" | removematchLine "$2")
}
Array.rev() {
	readarray -t "$1" < <(printEvalArray "$1" | tac)
}
Array.pop() {
	readarray -t "$1" < <(printEvalArray "$1" | sed -e '$d')
}
Array.fromStr() {
	declare -a -x "$1"
	readarray -t "$1" < <(breakChar)
}
Array.last() {
	printEval "$1[$(Array.lastIndex "$1")]"
}
Array.eval() {
	eval "printArray \"\${$1[@]}\""
}
Array.print() {
	(($# >= 1)) || return 0
	printf "%s\n" "${@}"
}
Array.indexOf() {
	local n=()
	readarray -t n < <(grep -x -n "$1" | cut -d ":" -f 1 | forEach eval echo '$(( {} - 1 ))')
	(("${#n[@]}" >= 1)) || return 1
	printArray "${n[@]}"
	return 0
}
Array.lastIndex() {
	calcInt "$(Array.length "$1")" - 1
}
Array.length() {
	printEval "#${1}[@]"
}
Array.includes() {
	printEvalArray "$1" | grep -qx "$2"
}
Array.forEach() {
	printEvalArray "$1" | forEach "${@:2}"
}
arrayIndex() {
	Array.length "$1"
}
revArray() {
	Array.rev "$1"
}
arrayAppend() {
	Array.append "$1"
}
printEvalArray() {
	Array.eval "$1"
}
arrayIncludes() {
	Array.includes "$@"
}
addNewToArray() {
	Array.push "$@"
}
getarrayIndex() {
	Array.indexOf "$1"
}
strToCharList() {
	Array.fromStr "$1"
}
printArray() {
	Array.print "$@"
}
getFileExt() {
	getBaseName | rev | cut -d "." -f 1 | rev
}
fileType() {
	file --mime-type -b "$1"
}
removeFileExt() {
	local Ext
	forEach eval 'Ext=$(getFileExt <<< {}); sed "s|.$Ext$||g" <<< {}; unset Ext'
}
getBaseName() {
	forEach basename "{}"
}
loop() {
	local _T="$1"
	shift 1 || return 1
	((_T == 0)) && return 0
	forEach "$@" < <(yes "" | head -n "$_T")
}
forEach() {
	local _Item
	while read -r _Item; do
		"${@//"{}"/"${_Item}"}" || return "${?}"
	done
}
getLine() {
	head -n "$1" | tail -n 1
}
isAvailable() {
	type "$1" 2>/dev/null 1>&2
}
checkFuncDefined() {
	typeset -f "${1}" >/dev/null || return 1
}
cutLastString() {
	echo "${1%%"${2}"}"
	return 0
}
isUUID() {
	local _UUID="${1-""}"
	[[ ${_UUID//-/} =~ ^[[:xdigit:]]{32}$ ]] && return 0
	return 1
}
getLastSplitString() {
	rev <<<"$2" | cut -d "$1" -f 1 | rev
}
textBox() {
	local _Content=() _Length _Vertical="|" _Line="=" _Header="${1-""}"
	readarray -t _Content
	_Length="$(printArray "${_Content[@]}" "$_Header" | awk '{ if ( length > x && length > 0 ) { x = length } }END{ print x }')"
	if [[ -z ${_Header:-""} ]]; then
		echo "${_Vertical}$(loop "$((_Length + 1))" echo -n "${_Line}")${_Vertical}"
	else
		((_Length % 2 == 0)) || ((_Length++))
		((${#_Header} % 2 == 0)) && ((_Length++))
		echo "${_Vertical}$(loop "$(((_Length - ${#_Header}) / 2))" echo -n "${_Line}")${_Header+" ${_Header} "}$(loop "$(((_Length - ${#_Header}) / 2))" echo -n "${_Line}")${_Vertical}"
	fi
	for _Str in "${_Content[@]}"; do
		echo "${_Vertical}${_Str}$(loop "$((_Length + 1 - "${#_Str}"))" echo -n " ")${_Vertical}"
	done
	echo "${_Vertical}$(loop "$((_Length + 1))" echo -n "${_Line}")${_Vertical}"
}
breakChar() {
	grep -o "."
}
toLower() {
	local _Str="${1,,}"
	[[ -z ${_Str-""} ]] || echo "${_Str}"
}
randomString() {
	base64 <"/dev/random" | fold -w "$1" | head -n 1
	return 0
}
printEval() {
	eval echo "\${$1}"
}
removeBlank() {
	sed "s|^ *||g; s| *$||g; s|^	*||g; s|	*$||g; /^$/d"
}
toLowerStdin() {
	local _Str
	forEach eval '_Str="{}"; echo "${_Str,,}"'
	unset _Str
}
sum() {
	local _Arg=()
	forEach eval '_Arg+=("{}" "+")' < <(printArray "$@")
	readarray -t _Arg < <(printArray "${_Arg[@]}" | sed "${#_Arg[@]}d")
	calcInt "${_Arg[@]}"
}
calcInt() {
	echo "$(("$@"))"
}
ntest() {
	(("$@")) || return 1
}
bool() {
	case "$(removeBlank <<<"$(toLower "$1")")" in
	"true")
		return 0
		;;
	"false")
		return 1
		;;
	esac
	case "$(toLower "$(printEval "${1}")")" in
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
unsetAllFunc() {
	local Func
	while read -r Func; do
		unset "$Func"
	done < <(getFuncList)
}
getFuncList() {
	declare -F | cut -d " " -f 3
}
match() {
	local stdin str
	read -r stdin
	for str in "$@"; do
		if [[ $str == "$stdin" ]]; then
			return 0
		fi
	done
	return 1
}
removematchLine() {
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
URL.path() {
	URL.pathAndQueryAndFragment | cut -d "#" -f 1 | cut -d "?" -f 1
}
URL.pathAndQueryAndFragment() {
	local i
	while read -r i; do
		sed "s|^//$(URL.authority <<<"$i")||g" <<<"$(URL.noScheme <<<"$i")"
	done
}
URL.authority() {
	local i _NoScheme
	while read -r i; do
		_NoScheme=$(URL.noScheme <<<"$i")
		[[ $_NoScheme == "//"* ]] || return 1
		cut -d "/" -f 1 < <(sed "s|^//||g" <<<"$_NoScheme")
	done
}
URL.query() {
	local i
	while read -r i; do
		URL.pathAndQueryAndFragment <<<"$i" | sed "s|#$(URL.fragment <<<"$i")||g" | cut -d "?" -f 2-
	done
}
URL.scheme() {
	cut -d ":" -f 1
}
URL.port() {
	local i
	while read -r i; do
		[[ $i == *":"* ]] || {
			continue
		}
		cut -d ":" -f 2 <<<"$i"
	done < <(URL.authority)
}
URL.noScheme() {
	cut -d ":" -f 2-
}
URL.user() {
	local i
	while read -r i; do
		[[ $i == *"@"* ]] || {
			echo ""
			continue
		}
		cut -d "@" -f 1 <<<"$i"
	done < <(URL.authority)
}
URL.fragment() {
	local i
	i="$(URL.pathAndQueryAndFragment)"
	[[ $i == *"#"* ]] || return 0
	cut -d "#" -f 2- <<<"$i"
}
URL.host() {
	URL.authority | cut -d "@" -f 2- | cut -d ":" -f 1
}
URL.hasUser() {
	local i="${1-""}"
	[[ -n $i ]] || read -r i
	[[ "$(URL.authority <<<"$i")" == *"@"* ]]
}
URL.hasPort() {
	local i="${1-""}"
	[[ -n $i ]] || read -r i
	[[ "$(URL.authority <<<"$i")" == *":"* ]]
}
URL.hasFragment() {
	local i="${1-""}"
	[[ -n $i ]] || read -r i
	[[ "$(URL.pathAndQueryAndFragment <<<"$i")" == *"#"* ]]
}
URL.hasQuery() {
	local i="${1-""}"
	[[ -n $i ]] || read -r i
	[[ "$(URL.pathAndQueryAndFragment <<<"$i")" == *"?"* ]]
}
URL.hasAuthority() {
	local i="${1-""}"
	[[ -n $i ]] || read -r i
	[[ "$(URL.noScheme <<<"$i")" == "//"* ]]
}
URL.parse() {
	local i="${1-""}"
	if [[ -z ${i} ]]; then
		read -r i
	fi
	URL.scheme <<<"$i"
	echo ":"
	if URL.hasAuthority "$i"; then
		if URL.hasUser "$i"; then
			URL.user <<<"$i"
			echo "@"
		fi
		URL.host <<<"$i"
		if URL.hasPort "$i"; then
			echo ":"
			URL.port <<<"$i"
		fi
	fi
	URL.path <<<"$i"
	if URL.hasFragment "$i"; then
		echo "#"
		URL.fragment <<<"$i"
	fi
	if URL.hasQuery "$i"; then
		echo "?"
		URL.query <<<"$i"
	fi
}
URL.getQuery() {
	grep "^ *$1=" | cut -d "=" -f 2-
}
URL.parseQuery() {
	local i="${1-""}"
	if [[ -z ${i} ]]; then
		read -r i
	fi
	if grep -q "[a-zA-Z]://" <<<"$i"; then
		i="$(URL.query <<<"$i")"
	fi
	i="$(sed "s|^\?||g" <<<"$i")"
	tr "&" "\n" <<<"$i" | cut -d "#" -f 1
}
Pm.getName() {
	cut -d "<" -f 1 | cut -d ">" -f 1 | cut -d "=" -f 1
}
Pm.getPacmanKeyringDir() {
	local _KeyringDir=""
	_KeyringDir="$(LANG=C pacman-key -h | removeBlank | grep -A 1 -- "^--populate" | tail -n 1 | cut -d "/" -f 2- | sed "s|'$||g")"
	: "${_KeyringDir="usr/share/pacman/keyrings"}"
	_KeyringDir="$(Pm.getRoot)/$_KeyringDir"
	_KeyringDir="$(sed -E "s|/+|/|g" <<<"$_KeyringDir")"
	if [[ -e $_KeyringDir ]]; then
		readlinkf "$_KeyringDir"
	else
		echo "$_KeyringDir"
	fi
}
Pm.getRepoPkgList() {
	Pm.run -Slq "$@"
}
Pm.getRepoConf() {
	forEach eval 'echo [{}] && Pm.getConfig -r {}'
}
Pm.getRoot() {
	Pm.getConfig RootDir
}
Pm.getKeyringList() {
	find "$(@GetKeyringDir)" -name "*.gpg" | getBaseName | removeFileExt
}
Pm.getRepoServer() {
	forEach eval 'Pm.getConfig -r {}' | grep "^Server" | forEach eval "Ini.parseLine <<< '{}' ; printf '%s\n' \${VALUE}"
}
Pm.getRepoVer() {
	Pm.run -Sp --print-format '%v' "$1"
}
Pm.getConfig() {
	LANG=C pacman-conf --config="${PACMAN_CONF-"/etc/pacman.conf"}" "$@"
}
Pm.getInstalledPkgVer() {
	if [[ -z ${*} ]]; then
		cat
	else
		printArray "$@"
	fi | forEach pacman -Q "{}" | cut -d " " -f 2
	printArray "${PIPESTATUS[@]}" | grep -qx "1" && return 1
	return 0
}
Pm.getLatestPkgVer() {
	local _LANG="${LANG-""}"
	export LANG=C
	if [[ -z ${*} ]]; then
		cat
	else
		printArray "$@"
	fi | forEach Pm.run -Si "{}" | grep "^Version" | cut -d ":" -f 2 | removeBlank
	[[ -n $_LANG ]] && export LANG="$_LANG"
	return 0
}
Pm.isRepoPkg() {
	Pm.run -Slq | grep -qx "$(Pm.getName <<<"$1")"
}
Pm.run() {
	pacman --noconfirm --config "${PACMAN_CONF-"/etc/pacman.conf"}" "$@"
}
Pm.getRepoListFromConf() {
	Pm.getConfig --repo-list
}
Pm.runKey() {
	pacman-key --config "${PACMAN_CONF-"/etc/pacman.conf"}" "$@"
}
Pm.getPacmanKernelPkg() {
	echo "there is nothing"
}
Pm.pacmanGpg() {
	gpg --homedir "$(Pm.getConfig GPGDir)" "$@"
}
Pm.checkPkg() {
	local p
	for p in "$@"; do
		Pm.run -Qq "$p" >/dev/null 2>&1 || return 1
	done
	return 0
}
Pm.getDbSectionList() {
	grep -E "^%.*%$"
}
Pm.getDbSection() {
	readarray -t _Stdin
	printArray "${_Stdin[@]}" | sed -ne "/^%$1%$/,/^%$(printEvalArray _Stdin | Pm.getDbNextSection "$1")%$/p" | sed '1d; $d'
}
Pm.getDbNextSection() {
	Pm.getDbSectionList | grep -x -A 1 "^%$1%$" | getLine 2 | sed "s|^%||g; s|%$||g"
}
Pm.getRepoListFromLocalDb() {
	find "$(Pm.getConfig DBPath)/sync" -mindepth 1 -maxdepth 1 -type f | getBaseName | sed "s|.db$||g"
	return 0
}
Pm.deleteDbTmpDir() {
	rm -rf "$(Pm.getDbTmpDir)"
}
Pm.getSyncDbDescPath() {
	local _repo
	_repo="$(pacman -Sp --print-format '%r' "$1")"
	{
		IsPacmanSyncDbOpend "$_repo" || OpenPacmanSyncDb "$_repo"
	} || return 1
	echo "$(Pm.getDbTmpDir)/sync/$(pacman -Sp --print-format '%r/%n-%v' "$1")"
}
Pm.getSyncDbDesc() {
	local _path
	_path="$(Pm.getSyncDbDescPath "$1")"
	[[ -e $_path ]] || return 1
	cat "$_path/desc"
}
Pm.getSyncAllDesc() {
	find "$(Pm.getDbTmpDir)" -mindepth 3 -maxdepth 3 -name "desc" -type f
}
Pm.getDbTmpDir() {
	echo "${TMPDIR-"/tmp"}/fasbashlib-pacman-db"
}
Pm.createDbTmpDir() {
	mkdir -p "$(Pm.getDbTmpDir)"
}
Pm.getPkgArch() {
	Pm.getSyncDbDesc "$1" | Pm.getDbSection ARCH | removeBlank
}
Pm.openedSyncDbList() {
	find "$(Pm.getDbTmpDir)/sync/" -mindepth 1 -maxdepth 1 -type d
}
Pm.parsePkgFileName() {
	local _Pkg="$1"
	local _PkgName _PkgVer _PkgRel _Arch _FileExt
	local _PkgWithOutExt
	if grep "/" <<<"$_Pkg"; then
		_Pkg="$(basename "$_Pkg")"
	fi
	_FileExt="$(getLastSplitString "-" "$_Pkg" | cut -d "." -f 2-)"
	_PkgWithOutExt="${_Pkg%%".${_FileExt}"}"
	_Arch=$(getLastSplitString "-" "${_PkgWithOutExt}")
	_PkgRel=$(getLastSplitString "-" "${_PkgWithOutExt%%"-${_Arch}"}")
	_PkgVer=$(getLastSplitString "-" "${_PkgWithOutExt%%"-${_PkgRel}-${_Arch}"}")
	_PkgName="${_PkgWithOutExt%%"-${_PkgVer}-${_PkgRel}-${_Arch}"}"
	_ParsedPkg=("${_PkgName}" "-" "$_PkgVer" "-" "$_PkgRel" "-" "$_Arch" ".$_FileExt")
	if [[ ! "$(printArray "${_ParsedPkg[@]}" | tr -d "\n")" == "${_Pkg}" ]]; then
		return 1
	fi
	printArray "${_ParsedPkg[@]}"
}
Pm.getVirtualPkgList() {
	Pm.getRepoListFromLocalDb | forEach Pm.openSyncDb {}
	Pm.getSyncAllDesc | forEach eval "Pm.getDbSection PROVIDES < {}" | removeBlank
}
Pm.isOpendSyncDb() {
	readarray -t _PkgDbList < <(find "$(Pm.getDbTmpDir)/sync/$1" -mindepth 1 -maxdepth 1 -type d)
	(("${#_PkgDbList[@]}" > 0)) && return 0
	return 1
}
Pm.openSyncDb() {
	local _Dir _RepoDb
	Pm.createDbTmpDir
	_Dir="$(Pm.getDbTmpDir)/sync/$1"
	mkdir -p "$_Dir"
	_RepoDb="$(Pm.getConfig DBPath)/sync/$1.db"
	[[ -e $_RepoDb ]] || return 1
	tar -xzf "${_RepoDb}" -C "$_Dir" || return 1
}
Misskey.notes.Search() {
	Misskey.bindingBase "notes/search" query limit -- "$@"
}
Misskey.notes.Renotes() {
	Misskey.bindingBase "notes/renotes" noteId limit sinceId untilId -- "$@"
}
Misskey.notes.Create() {
	Misskey.bindingBase "notes/create" text -- "$@"
}
Misskey.users.GetFrequentlyRepliedUsers() {
	Misskey.bindingBase "users/get-frequently-replied-users" userId -- "${1:-"$(Misskey.myId)"}" "${@:2}"
}
Misskey.users.Show() {
	Misskey.bindingBase "users/show" userId -- "${1:-"$(Misskey.myId)"}" "${@:2}"
}
Misskey.users.SearchByUsernameAndHost() {
	Misskey.bindingBase "users/search-by-username-and-host" username -- "${1:-"$(Misskey.myUserName)"}" "${@:2}"
}
Misskey.users.Pages() {
	Misskey.bindingBase "users/pages" userId -- "${1:-"$(Misskey.myId)"}" "${@:2}"
}
Misskey.users.Notes() {
	Misskey.bindingBase "users/notes" userId -- "${1:-"$(Misskey.myId)"}" "${@:2}"
}
Misskey.users.Stats() {
	Misskey.bindingBase "users/stats" userId -- "${1:-"$(Misskey.myId)"}" "${@:2}"
}
Misskey.admin.ServerInfo() {
	Misskey.bindingBase "/admin/server-info" -- "$@"
}
Misskey.setup() {
	export MISSKEY_DOMAIN="${1-"${MISSKEY_DOMAIN-""}"}"
	export MISSKEY_TOKEN="${2-"${MISSKEY_TOKEN-""}"}"
	export MISSKEY_ENTRY="https://${MISSKEY_DOMAIN}/api"
}
Misskey.serverInfo() {
	Misskey.bindingBase "/server-info" -- "$@"
}
Misskey.i() {
	Misskey.bindingBase "/i" -- "$@"
}
Misskey.meta() {
	Misskey.bindingBase "/meta" -- "$@"
}
Misskey.makeJson() {
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
Misskey.sendReq() {
	local _Url="$1" _CurlArgs=()
	shift 1
	_CurlArgs+=(-s -L)
	_CurlArgs+=(-X POST)
	_CurlArgs+=(-H "Content-Type: application/json")
	_CurlArgs+=(-d "$(Misskey.makeJson "$@")")
	_CurlArgs+=("$_Url")
	Msg.debug "Run: ${_CurlArgs[*]//"${MISSKEY_TOKEN}"/"TOKEN"}"
	curl "${_CurlArgs[@]}"
}
Misskey.bindingBase() {
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
	if ! bool _Shifted; then
		_Shifted=true
		shift "$((${#_APIArgs[@]} - 1))"
	fi
	if [[ -z ${MISSKEY_ENTRY-""} ]]; then
		Misskey.setup "${MISSKEY_DOMAIN}" "$MISSKEY_TOKEN"
	fi
	Misskey.sendReq "${MISSKEY_ENTRY%/}/${_API#/}" "${_Args[@]}" "$@"
}
Misskey.isAdmin() {
	bool "$(Misskey.i | jq -r ".isAdmin")"
}
Misskey.myId() {
	Misskey.i | jq -r ".id"
}
Misskey.myName() {
	Misskey.i | jq -r ".name"
}
Misskey.myUserName() {
	Misskey.i | jq -r ".username"
}
