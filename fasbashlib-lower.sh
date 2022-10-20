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

FSBLIB_LIBLIST+=("ArchLinux" "Array" "AwkForCalc" "BetterShell" "Cache" "Core" "Csv" "Emerge" "Esc" "Ini" "LibreTranslate" "Message" "Misskey" "Pacman" "ParseArg" "Progress" "Prompt" "Readlink" "Sqlite3" "SrcInfo" "URL")
FSBLIB_FUNCLIST+=("addNewToArray" "Csv.getClm" "readlinkf" "arrayAppend" "Ini.getLastParam" "captureSpecialKeys" "Arch.getKernelFileList" "LibreTranslate.check" "Msg.common" "arrayIncludes" "Misskey.notes.Create" "readlinkf_Posix" "URL.authority" "Cache.exist" "choice" "Pm.checkPkg" "Awk.cos" "SrcInfo.format" "Array.append" "Fsblib.envCheck" "arrayIndex" "Ini.getParam" "Csv.getClmCnt" "readlinkf_Readlink" "choiceLoop" "Prog.kill" "Em.getAllPkgList" "Esc.clearLeft" "parseArg" "getArrayIndex" "selectMenu" "Arch.getKernelSrcList" "URL.fragment" "Misskey.notes.Renotes" "Msg.debug" "Pm.getConfig" "LibreTranslate.detect" "Cache.get" "Pm.getInstalledPkgVer" "SrcInfo.getKeyList" "Awk.float" "printArray" "Sqlite3.call" "Array.fromStr" "Cache.getDir" "Fsblib.fsblibEnvCheck" "SrcInfo.getPkgBase" "Ini.getParamList" "Prog.rotation" "Csv.toBashArray" "Pm.getKeyringList" "printEvalArray" "Em.getDefaultRepoName" "Msg.err" "Esc.clearLine" "Arch.getMkinitcpioPresetList" "Array.pop" "revArray" "LibreTranslate.languages" "Misskey.notes.Search" "Cache.getFileLastUpdate" "URL.host" "Awk.log" "SrcInfo.getPkgName" "Sqlite3.connect" "Fsblib.requireLib" "Pm.getLatestPkgVer" "Ini.getSectionList" "strToCharList" "Em.getInstalledPkgList" "Msg.info" "Esc.clearRight" "LibreTranslate.translate" "Array.push" "SrcInfo.getSectionList" "Cache.getID" "Awk.pi" "URL.noScheme" "Sqlite3.create" "Pm.getName" "Ini.parseLine" "Msg.warn" "Esc.clearScreen" "fileType" "Misskey.users.GetFrequentlyRepliedUsers" "Em.getRepoConf" "LibreTranslate.translateAuto" "Array.remove" "Awk.print" "Cache.getTimeDiffFromLastUpdate" "URL.path" "SrcInfo.getValue" "getBaseName" "Pm.getPacmanKernelPkg" "Sqlite3.currentDb" "getFileExt" "Misskey.users.Notes" "Array.rev" "Awk.rad" "URL.pathAndQueryAndFragment" "Pm.getPacmanKeyringDir" "removeFileExt" "Em.getRepoLocation" "Sqlite3.delete" "SrcInfo.getValueInPkgBase" "Esc.moveCursor" "Ini.newParam" "Array.shift" "Awk.sin" "Pm.getRepoConf" "URL.port" "Misskey.users.Pages" "Esc.moveCursorDown" "Cache.create" "Sqlite3.existField" "Em.getRepoPkgList" "SrcInfo.getValueInPkgName" "Ini.newSection" "checkFuncDefined" "Pm.getRepoListFromConf" "Misskey.users.SearchByUsernameAndHost" "Awk.tan" "forEach" "Esc.moveCursorLeft" "URL.query" "Sqlite3.existTable" "getLine" "SrcInfo.parse" "Ini.setValue" "Cache.createDir" "Array.eval" "Misskey.users.Show" "Em.getWorldPkgList" "isAvailable" "Pm.getRepoPkgList" "Esc.moveCursorRight" "URL.scheme" "loop" "Sqlite3.insert" "Array.last" "Misskey.users.Stats" "Pm.getRepoServer" "Esc.moveCursorUp" "Sqlite3.select" "URL.user" "Em.noVersion" "Array.print" "Pm.getRepoVer" "breakChar" "Sqlite3.selectAll" "cutLastString" "Misskey.admin.ServerInfo" "getLastSplitString" "Pm.getRoot" "Esc.clearUpperLines" "isUUID" "URL.hasAuthority" "printEval" "Array.indexOf" "randomString" "URL.hasFragment" "Pm.isRepoPkg" "removeBlank" "Misskey.setup" "Array.lastIndex" "textBox" "Esc.blackBackground" "URL.hasPort" "toLower" "Pm.pacmanGpg" "Array.length" "toLowerStdin" "Esc.blackText" "URL.hasQuery" "Pm.run" "Misskey.i" "calcInt" "URL.hasUser" "Pm.runKey" "Esc.blink" "Misskey.meta" "ntest" "Array.forEach" "sum" "Esc.blueBackground" "Misskey.serverInfo" "Array.includes" "Pm.getDbNextSection" "URL.parse" "Esc.blueText" "bool" "Esc.bold" "Pm.getDbSection" "Misskey.bindingBase" "getFuncList" "Esc.conceal" "unsetAllFunc" "Pm.getDbSectionList" "URL.getQuery" "Misskey.makeJson" "Esc.crossedOut" "match" "removeMatchLine" "URL.parseQuery" "Misskey.sendReq" "toArgs" "Pm.createDbTmpDir" "Esc.cyanBackground" "Esc.cyanText" "Pm.deleteDbTmpDir" "Esc.greenBackground" "Misskey.isAdmin" "Pm.getDbTmpDir" "Misskey.myId" "Esc.greenText" "Pm.getPkgArch" "Misskey.myName" "Esc.italic" "Pm.getRepoListFromLocalDb" "Esc.lowIntensity" "Misskey.myUserName" "Esc.magentaBackground" "Pm.getSyncAllDesc" "Esc.magentaText" "Pm.getSyncDbDesc" "Pm.getSyncDbDescPath" "Esc.rapidBlink" "Esc.redBackground" "Pm.getVirtualPkgList" "Esc.redText" "Pm.isOpendSyncDb" "Esc.resetStyle" "Pm.openSyncDb" "Esc.reverse" "Pm.openedSyncDbList" "Esc.underline" "Pm.parsePkgFileName" "Esc.whiteBackground" "Esc.whiteText" "Esc.yellowBackground" "Esc.yellowText")
declare -r FSBLIB_VERSION='v0.2.6.r412.g1fce987-lower'
declare -r FSBLIB_REQUIRE='ModernBash'
declare -r FSBLIB_PROG_PIDFILEPATH='FSBLIB_PROGRESS_PIDLIST'

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
readlinkf() {
	readlinkf_Posix "$@"
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
captureSpecialKeys() {
	local SELECTION rest
	IFS= read -r -n1 -s SELECTION
	if [[ $SELECTION == '' ]]; then
		read -r -n2 -s rest
		SELECTION+="$rest"
	else
		case "$SELECTION" in
		"")
			echo "Enter"
			;;
		'')
			echo "Backspace"
			;;
		*)
			read -i "$SELECTION" -e -r rest
			echo "$rest"
			;;
		esac
		return 0
	fi
	case $SELECTION in
	'[A')
		echo "Up"
		;;
	'[B')
		echo "Down"
		;;
	'[C')
		echo "Right"
		;;
	'[D')
		echo "Left"
		;;
	esac
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
choiceloop() {
	while true; do
		if choice "$@"; then
			break
		fi
	done
}
selectMenu() {
	local choices=("$@") Currentchoice=0 Key=""
	[[ ${#choices[@]} -eq 0 ]] && return 1
	[[ ${#choices[@]} -eq 1 ]] && {
		echo "${choices[0]}" && return 0
	}
	while [[ $Key != "Enter" ]]; do
		for i in "${!choices[@]}"; do
			if [[ $i == "$Currentchoice" ]]; then
				Esc.bold && Esc.underline
				echo " > $i: ${choices[$i]}"
			else
				echo "   $i: ${choices[$i]}"
			fi
			Esc.resetStyle
		done
		Key="$(captureSpecialKeys)"
		case "$Key" in
		Up)
			(("$Currentchoice" != 0)) && Currentchoice=$((Currentchoice - 1))
			;;
		Down)
			(("$Currentchoice" != "${#choices[@]}" - 1)) && Currentchoice=$((Currentchoice + 1))
			;;
		esac
		Esc.clearUpperLines "${#choices[@]}"
	done
	echo "${choices[$Currentchoice]}"
}
Prog.kill() {
	local AnimeID="${1-""}"
	[[ -z ${AnimeID} ]] && return 1
	local TargetPID
	TargetPID="$(grep -o "$$-${AnimeID}=[0-9]*" "$TMPDIR/${FSBLIB_PROG_PIDFILEPATH}" | cut -d "=" -f 2)"
	[[ -n ${TargetPID} ]] && kill -9 "${TargetPID}"
}
Prog.rotation() {
	local Chr AnimeID="${1-""}"
	[[ -z ${AnimeID} ]] && return 1
	[[ -n ${2-""} ]] && echo -n "${2}" 1>&2
	echo "${$}-${AnimeID}=$BASHPID" >>"$TMPDIR/$FSBLIB_PROG_PIDFILEPATH"
	while true; do
		for Chr in "-" '\' "|" "/"; do
			printf "%s" "$Chr" 1>&2
			sleep 0.1
			Esc.moveCursorLeft 1
		done
	done
}
Csv.getClm() {
	grep -v "^#" | sed "/^$/d" | cut -d "${CSVDELIM-","}" -f "$1"
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
Arch.getKernelFileList() {
	find "/boot" -maxdepth 1 -mindepth 1 -name "vmlinuz-*"
}
Arch.getKernelSrcList() {
	find "/usr/src" -mindepth 1 -maxdepth 1 -type l -name "linux*"
}
Arch.getMkinitcpioPresetList() {
	find "/etc/mkinitcpio.d/" -name "*.preset" -type f | getBaseName | removeFileExt
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
Msg.debug() {
	Msg.common "Debug:" "${*}" stderr
}
Msg.err() {
	Msg.common "Error:" "${*}" stderr
}
Msg.info() {
	Msg.common " Info:" "${*}" stdout
}
Msg.warn() {
	Msg.common " Warn:" "${*}" stderr
}
LibreTranslate.check() {
	export LIBRETRANSLATE_URL="${LIBRETRANSLATE_URL:-""}"
	export LIBRETRANSLATE_APIKEY="${LIBRETRANSLATE_APIKEY:-""}"
	if [ -z "$LIBRETRANSLATE_URL" ]; then
		echo "LIBRETRANSLATE_URL is not set"
		return 1
	fi
	if which jq >/dev/null; then
		return 0
	else
		echo "jq is not installed"
		return 1
	fi
	if which curl >/dev/null; then
		return 0
	else
		echo "curl is not installed"
		return 1
	fi
	return 0
}
LibreTranslate.detect() {
	LibreTranslate.check || return 2
	__libre_translate_return="$(curl -s "${LIBRETRANSLATE_URL}/detect" -X POST -d "q=${1:-""}&api_key=${LIBRETRANSLATE_APIKEY:-""}")"
	if [ "$(echo "${__libre_translate_return}" | jq -r '.[].error')" = "null" ]; then
		echo "${__libre_translate_return}" | jq -r '.[].language'
		return 0
	else
		echo "${__libre_translate_return}" | jq -r '.error'
		return 1
	fi
}
LibreTranslate.languages() {
	LibreTranslate.check || return 2
	curl -s "${LIBRETRANSLATE_URL}/languages" | jq -r '.[].code'
}
LibreTranslate.translate() {
	LibreTranslate.check || return 2
	__libre_translate_return="$(curl -s "$LIBRETRANSLATE_URL/translate" -X POST -d "q=${1:-""}&source=${2:-""}&target=${3:-""}&api_key=${LIBRETRANSLATE_APIKEY:-""}")"
	if [ "$(echo "${__libre_translate_return}" | jq -r '.error')" = "null" ]; then
		echo "${__libre_translate_return}" | jq -r '.translatedText'
		return 0
	else
		echo "${__libre_translate_return}" | jq -r '.error'
		return 1
	fi
}
LibreTranslate.translateAuto() {
	LibreTranslate.check || return 2
	LibreTranslate.translate "${1:-""}" "$(LibreTranslate.detect "${1:-""}")" "${2:-""}"
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
Cache.getDir() {
	echo "${TMPDIR-"/tmp"}/$(Cache.getID)"
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
Cache.getID() {
	if [[ -z ${FSBLIB_CACHEID-""} ]]; then
		Cache.createDir >/dev/null
	fi
	echo "$FSBLIB_CACHEID"
}
Cache.getTimeDiffFromLastUpdate() {
	local _Now _Last
	_Now="$(date "+%s")"
	_Last="$(Cache.getFileLastUpdate "$1")"
	echo "$((_Now - _Last))"
	return 0
}
Cache.create() {
	Cache.createDir >/dev/null
	cat >"$(Cache.getDir)/${1}"
	cat "$(Cache.getDir)/$1"
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
Awk.cos() {
	Awk.float "cos($*)"
}
Awk.float() {
	awk "BEGIN {printf (\"%4.${AWKSCALE-"5"}f\n\", $*)}"
}
Awk.log() {
	Awk.float "log(${2}) / log($1)"
}
Awk.pi() {
	Awk.float "atan2(0, -0)"
}
Awk.print() {
	awk "BEGIN {print $*}"
}
Awk.rad() {
	Awk.float "$1 * $(Awk.pi) / 180 "
}
Awk.sin() {
	Awk.float "sin($*)"
}
Awk.tan() {
	Awk.float "sin($1)/tan($1)"
}
SrcInfo.format() {
	removeBlank | sed "/^$/d" | grep -v "^#" | forEach eval 'SrcInfo.parse Line <<< "{}"'
}
SrcInfo.getKeyList() {
	SrcInfo.format | cut -d "=" -f 1
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
SrcInfo.getSectionList() {
	SrcInfo.format | grep -e "^pkgbase" -e "^pkgname"
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
Ini.getLastParam() {
	Ini.getParamList "$1" | tail -n 1
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
Ini.setValue() {
	local IniContents=()
	local Section="$1" Param="$2"
	readarray -t IniContents
	readarray -t IniContents < <(printArray "${IniContents[@]}" | Ini.newSection "$Section" | Ini.newParam "$Section" "$Param")
	printEvalArray IniContents
}
Em.getAllPkgList() {
	Em.getRepoConf | sed -e 's/^ *//' -e 's/ *$//' | grep "^ *location *=" | sed -e 's/^location *= *//' | xargs -L1 realpath | xargs -I{} bash -c "find '{}' -mindepth 3 -maxdepth 3 -type f -name '*.ebuild' | sed -e 's|{}/||g' -e 's|.ebuild$||g'" | awk -F "/" '{print $1"/"$3}'
}
Em.getDefaultRepoName() {
	Em.getRepoConf | Ini.getParam DEFAULT main-repo
}
Em.getInstalledPkgList() {
	find /var/db/pkg/ -mindepth 2 -maxdepth 2 -type d | sed 's|/var/db/pkg/||g'
}
Em.getRepoConf() {
	cat /etc/portage/repos.conf /etc/portage/repos.conf/* 2>/dev/null
}
Em.getRepoLocation() {
	Em.getRepoConf | Ini.getParam "$1" location
}
Em.getRepoPkgList() {
	local _RepoPath
	_RepoPath="$(Em.getRepoLocation "$1")"
	find "$_RepoPath" -mindepth 3 -maxdepth 3 -type f -name '*.ebuild' | sed -e "s|${_RepoPath%/}/||g" -e 's|.ebuild$||g' | awk -F "/" '{print $1"/"$3}'
}
Em.getWorldPkgList() {
	sed -E 's|:.+$||g' /var/lib/portage/world | xargs -I{} bash -c 'ls -d /var/db/pkg/{}-* | sed "s|/var/db/pkg/||g" | grep -E "{}-[0-9]"'
}
Em.noVersion() {
	sed -E 's|\-[0-9]+.+||g'
}
Sqlite3.call() {
	Msg.debug sqlite3 "${SQLITE3_OPTIONS[@]}" "$SQLITE3_DBPATH" "$@" 1>&2
	sqlite3 "${SQLITE3_OPTIONS[@]}" "$SQLITE3_DBPATH" "$@"
}
Sqlite3.connect() {
	export SQLITE3_DBPATH="$1"
	echo ".open \"$SQLITE3_DBPATH\"" | sqlite3
	return 0
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
Sqlite3.currentDb() {
	if [[ -z ${SQLITE3_DBPATH-""} ]]; then
		Msg.err "No datebase is connected."
		return 1
	fi
	echo "${SQLITE3_DBPATH}"
	return 0
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
Sqlite3.existField() {
	_result="$(Sqlite3.call "SELECT * FROM '$1' WHERE $2 = '$3' LIMIT 1;")"
	if [[ -n ${_result-""} ]]; then
		return 0
	fi
	return 1
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
Sqlite3.selectAll() {
	local _table="$1" _args=()
	shift 1 || return 1
	Sqlite3.call "select * from $_table"
}
addNewToArray() {
	Array.push "$@"
}
arrayAppend() {
	Array.append "$1"
}
arrayIncludes() {
	Array.includes "$@"
}
arrayIndex() {
	Array.length "$1"
}
GetarrayIndex() {
	Array.indexOf "$1"
}
printArray() {
	Array.print "$@"
}
printEvalArray() {
	Array.eval "$1"
}
revArray() {
	Array.rev "$1"
}
strToCharList() {
	Array.fromStr "$1"
}
fileType() {
	file --mime-type -b "$1"
}
getBaseName() {
	forEach basename "{}"
}
getFileExt() {
	getBaseName | rev | cut -d "." -f 1 | rev
}
removeFileExt() {
	local Ext
	forEach eval 'Ext=$(getFileExt <<< {}); sed "s|.$Ext$||g" <<< {}; unset Ext'
}
checkFuncDefined() {
	typeset -f "${1}" >/dev/null || return 1
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
loop() {
	local _T="$1"
	shift 1 || return 1
	((_T == 0)) && return 0
	forEach "$@" < <(yes "" | head -n "$_T")
}
breakChar() {
	grep -o "."
}
cutLastString() {
	echo "${1%%"${2}"}"
	return 0
}
getLastSplitString() {
	rev <<<"$2" | cut -d "$1" -f 1 | rev
}
isUUID() {
	local _UUID="${1-""}"
	[[ ${_UUID//-/} =~ ^[[:xdigit:]]{32}$ ]] && return 0
	return 1
}
printEval() {
	eval echo "\${$1}"
}
randomString() {
	base64 <"/dev/random" | fold -w "$1" | head -n 1
	return 0
}
removeBlank() {
	sed "s|^ *||g; s| *$||g; s|^	*||g; s|	*$||g; /^$/d"
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
toLower() {
	local _Str="${1,,}"
	[[ -z ${_Str-""} ]] || echo "${_Str}"
}
toLowerStdin() {
	local _Str
	forEach eval '_Str="{}"; echo "${_Str,,}"'
	unset _Str
}
calcInt() {
	echo "$(("$@"))"
}
ntest() {
	(("$@")) || return 1
}
sum() {
	local _Arg=()
	forEach eval '_Arg+=("{}" "+")' < <(printArray "$@")
	readarray -t _Arg < <(printArray "${_Arg[@]}" | sed "${#_Arg[@]}d")
	calcInt "${_Arg[@]}"
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
getFuncList() {
	declare -F | cut -d " " -f 3
}
unsetAllFunc() {
	local Func
	while read -r Func; do
		unset "$Func"
	done < <(getFuncList)
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
RemovematchLine() {
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
toArgs() {
	readarray -t args
	"$@" "${args[@]}"
}
Array.append() {
	local _ArrName="$1"
	shift 1 || return 1
	readarray -t -O "$(arrayIndex "$_ArrName")" "$_ArrName" < <(cat)
}
Array.fromStr() {
	declare -a -x "$1"
	readarray -t "$1" < <(breakChar)
}
Array.pop() {
	readarray -t "$1" < <(printEvalArray "$1" | sed -e '$d')
}
Array.push() {
	eval "printArray \"\${$1[@]}\"" | grep -qx "$2" && return 0
	eval "$1+=(\"$2\")"
}
Array.remove() {
	readarray -t "$1" < <(printEvalArray "$1" | RemovematchLine "$2")
}
Array.rev() {
	readarray -t "$1" < <(printEvalArray "$1" | tac)
}
Array.shift() {
	readarray -t "$1" < <(printEvalArray "$1" | sed "1,${2-"1"}d")
}
Array.eval() {
	eval "printArray \"\${$1[@]}\""
}
Array.last() {
	printEval "$1[$(Array.lastIndex "$1")]"
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
Array.forEach() {
	printEvalArray "$1" | forEach "${@:2}"
}
Array.includes() {
	printEvalArray "$1" | grep -qx "$2"
}
URL.authority() {
	local i _NoScheme
	while read -r i; do
		_NoScheme=$(URL.noScheme <<<"$i")
		[[ $_NoScheme == "//"* ]] || return 1
		cut -d "/" -f 1 < <(sed "s|^//||g" <<<"$_NoScheme")
	done
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
URL.noScheme() {
	cut -d ":" -f 2-
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
URL.port() {
	local i
	while read -r i; do
		[[ $i == *":"* ]] || {
			continue
		}
		cut -d ":" -f 2 <<<"$i"
	done < <(URL.authority)
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
URL.hasAuthority() {
	local i="${1-""}"
	[[ -n $i ]] || read -r i
	[[ "$(URL.noScheme <<<"$i")" == "//"* ]]
}
URL.hasFragment() {
	local i="${1-""}"
	[[ -n $i ]] || read -r i
	[[ "$(URL.pathAndQueryAndFragment <<<"$i")" == *"#"* ]]
}
URL.hasPort() {
	local i="${1-""}"
	[[ -n $i ]] || read -r i
	[[ "$(URL.authority <<<"$i")" == *":"* ]]
}
URL.hasQuery() {
	local i="${1-""}"
	[[ -n $i ]] || read -r i
	[[ "$(URL.pathAndQueryAndFragment <<<"$i")" == *"?"* ]]
}
URL.hasUser() {
	local i="${1-""}"
	[[ -n $i ]] || read -r i
	[[ "$(URL.authority <<<"$i")" == *"@"* ]]
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
Misskey.notes.Create() {
	Misskey.bindingBase "notes/create" text -- "$@"
}
Misskey.notes.Renotes() {
	Misskey.bindingBase "notes/renotes" noteId limit sinceId untilId -- "$@"
}
Misskey.notes.Search() {
	Misskey.bindingBase "notes/search" query limit -- "$@"
}
Misskey.users.GetFrequentlyRepliedUsers() {
	Misskey.bindingBase "users/get-frequently-replied-users" userId -- "${1:-"$(Misskey.myId)"}" "${@:2}"
}
Misskey.users.Notes() {
	Misskey.bindingBase "users/notes" userId -- "${1:-"$(Misskey.myId)"}" "${@:2}"
}
Misskey.users.Pages() {
	Misskey.bindingBase "users/pages" userId -- "${1:-"$(Misskey.myId)"}" "${@:2}"
}
Misskey.users.SearchByUsernameAndHost() {
	Misskey.bindingBase "users/search-by-username-and-host" username -- "${1:-"$(Misskey.myUserName)"}" "${@:2}"
}
Misskey.users.Show() {
	Misskey.bindingBase "users/show" userId -- "${1:-"$(Misskey.myId)"}" "${@:2}"
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
Misskey.i() {
	Misskey.bindingBase "/i" -- "$@"
}
Misskey.meta() {
	Misskey.bindingBase "/meta" -- "$@"
}
Misskey.serverInfo() {
	Misskey.bindingBase "/server-info" -- "$@"
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
Pm.checkPkg() {
	local p
	for p in "$@"; do
		Pm.run -Qq "$p" >/dev/null 2>&1 || return 1
	done
	return 0
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
Pm.getKeyringList() {
	find "$(@GetKeyringDir)" -name "*.gpg" | getBaseName | removeFileExt
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
Pm.getName() {
	cut -d "<" -f 1 | cut -d ">" -f 1 | cut -d "=" -f 1
}
Pm.getPacmanKernelPkg() {
	echo "there is nothing"
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
Pm.getRepoConf() {
	forEach eval 'echo [{}] && Pm.getConfig -r {}'
}
Pm.getRepoListFromConf() {
	Pm.getConfig --repo-list
}
Pm.getRepoPkgList() {
	Pm.run -Slq "$@"
}
Pm.getRepoServer() {
	forEach eval 'Pm.getConfig -r {}' | grep "^Server" | forEach eval "Ini.parseLine <<< '{}' ; printf '%s\n' \${VALUE}"
}
Pm.getRepoVer() {
	Pm.run -Sp --print-format '%v' "$1"
}
Pm.getRoot() {
	Pm.getConfig RootDir
}
Pm.isRepoPkg() {
	Pm.run -Slq | grep -qx "$(Pm.getName <<<"$1")"
}
Pm.pacmanGpg() {
	gpg --homedir "$(Pm.getConfig GPGDir)" "$@"
}
Pm.run() {
	pacman --noconfirm --config "${PACMAN_CONF-"/etc/pacman.conf"}" "$@"
}
Pm.runKey() {
	pacman-key --config "${PACMAN_CONF-"/etc/pacman.conf"}" "$@"
}
Pm.getDbNextSection() {
	Pm.getDbSectionList | grep -x -A 1 "^%$1%$" | getLine 2 | sed "s|^%||g; s|%$||g"
}
Pm.getDbSection() {
	readarray -t _Stdin
	printArray "${_Stdin[@]}" | sed -ne "/^%$1%$/,/^%$(printEvalArray _Stdin | Pm.getDbNextSection "$1")%$/p" | sed '1d; $d'
}
Pm.getDbSectionList() {
	grep -E "^%.*%$"
}
Pm.createDbTmpDir() {
	mkdir -p "$(Pm.getDbTmpDir)"
}
Pm.deleteDbTmpDir() {
	rm -rf "$(Pm.getDbTmpDir)"
}
Pm.getDbTmpDir() {
	echo "${TMPDIR-"/tmp"}/fasbashlib-pacman-db"
}
Pm.getPkgArch() {
	Pm.getSyncDbDesc "$1" | Pm.getDbSection ARCH | removeBlank
}
Pm.getRepoListFromLocalDb() {
	find "$(Pm.getConfig DBPath)/sync" -mindepth 1 -maxdepth 1 -type f | getBaseName | sed "s|.db$||g"
	return 0
}
Pm.getSyncAllDesc() {
	find "$(Pm.getDbTmpDir)" -mindepth 3 -maxdepth 3 -name "desc" -type f
}
Pm.getSyncDbDesc() {
	local _path
	_path="$(Pm.getSyncDbDescPath "$1")"
	[[ -e $_path ]] || return 1
	cat "$_path/desc"
}
Pm.getSyncDbDescPath() {
	local _repo
	_repo="$(pacman -Sp --print-format '%r' "$1")"
	{
		IsPacmanSyncDbOpend "$_repo" || OpenPacmanSyncDb "$_repo"
	} || return 1
	echo "$(Pm.getDbTmpDir)/sync/$(pacman -Sp --print-format '%r/%n-%v' "$1")"
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
Esc.clearLeft() {
	printf "\033[1K"
}
Esc.clearLine() {
	printf "\033[2K"
}
Esc.clearRight() {
	printf "\033[0K"
}
Esc.clearScreen() {
	printf "\033[2J"
}
Esc.moveCursor() {
	printf "\033[%d;%dH" "$1" "$2"
}
Esc.moveCursorDown() {
	printf "\033[%dB" "$1"
}
Esc.moveCursorLeft() {
	printf "\033[%dD" "$1"
}
Esc.moveCursorRight() {
	printf "\033[%dC" "$1"
}
Esc.moveCursorUp() {
	printf "\033[%dA" "$1"
}
Esc.clearUpperLines() {
	for i in $(seq 1 "$1"); do
		Esc.moveCursorUp 1
		Esc.clearLine
	done
}
Esc.blackBackground() {
	printf "\033[40m"
}
Esc.blackText() {
	printf "\033[30m"
}
Esc.blink() {
	printf "\033[5m"
}
Esc.blueBackground() {
	printf "\033[44m"
}
Esc.blueText() {
	printf "\033[34m"
}
Esc.bold() {
	printf "\033[1m"
}
Esc.conceal() {
	printf "\033[8m"
}
Esc.crossedOut() {
	printf "\033[9m"
}
Esc.cyanBackground() {
	printf "\033[46m"
}
Esc.cyanText() {
	printf "\033[36m"
}
Esc.greenBackground() {
	printf "\033[42m"
}
Esc.greenText() {
	printf "\033[32m"
}
Esc.italic() {
	printf "\033[3m"
}
Esc.lowIntensity() {
	printf "\033[2m"
}
Esc.magentaBackground() {
	printf "\033[45m"
}
Esc.magentaText() {
	printf "\033[35m"
}
Esc.rapidBlink() {
	printf "\033[6m"
}
Esc.redBackground() {
	printf "\033[41m"
}
Esc.redText() {
	printf "\033[31m"
}
Esc.resetStyle() {
	printf "\033[0m"
}
Esc.reverse() {
	printf "\033[7m"
}
Esc.underline() {
	printf "\033[4m"
}
Esc.whiteBackground() {
	printf "\033[47m"
}
Esc.whiteText() {
	printf "\033[37m"
}
Esc.yellowBackground() {
	printf "\033[43m"
}
Esc.yellowText() {
	printf "\033[33m"
}
