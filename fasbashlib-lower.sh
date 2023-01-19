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

FSBLIB_LIBLIST+=("ArchLinux" "Array" "AwkForCalc" "BetterShell" "Cache" "Core" "Csv" "Emerge" "Esc" "Ini" "LibreTranslate" "Message" "Misskey" "Pacman" "ParseArg" "Progress" "Prompt" "Readlink" "Readlink-new" "Sqlite3" "SrcInfo" "URL")
FSBLIB_FUNCLIST+=()
FSBLIB_VERSION='v0.2.7.1.r437.g22e9944-lower'
FSBLIB_REQUIRE='ModernBash'
FSBLIB_PROG_PIDFILEPATH='FSBLIB_PROGRESS_PIDLIST'

Arch.getKernelFileList() {
	find "/boot" -maxdepth 1 -mindepth 1 -name "vmlinuz-*"
}
Arch.getKernelSrcList() {
	find "/usr/src" -mindepth 1 -maxdepth 1 -type l -name "linux*"
}
Arch.getMkinitcpioPresetList() {
	find "/etc/mkinitcpio.d/" -name "*.preset" -type f | GetBaseName | RemoveFileExt
}
Arch.getKernelFileList() {
	find "/boot" -maxdepth 1 -mindepth 1 -name "vmlinuz-*"
}
Arch.getKernelSrcList() {
	find "/usr/src" -mindepth 1 -maxdepth 1 -type l -name "linux*"
}
Arch.getMkinitcpioPresetList() {
	find "/etc/mkinitcpio.d/" -name "*.preset" -type f | GetBaseName | RemoveFileExt
}
Array.shift() {
	readarray -t "$1" < <(PrintEvalArray "$1" | sed "1,${2-"1"}d")
}
Array.push() {
	eval "PrintArray \"\${$1[@]}\"" | grep -qx "$2" && return 0
	eval "$1+=(\"$2\")"
}
Array.append() {
	local _ArrName="$1"
	shift 1 || return 1
	readarray -t -O "$(ArrayIndex "$_ArrName")" "$_ArrName" < <(cat)
}
Array.remove() {
	readarray -t "$1" < <(PrintEvalArray "$1" | RemoveMatchLine "$2")
}
Array.pop() {
	readarray -t "$1" < <(PrintEvalArray "$1" | sed -e '$d')
}
Array.fromStr() {
	declare -a -x "$1"
	readarray -t "$1" < <(BreakChar)
}
Array.rev() {
	readarray -t "$1" < <(PrintEvalArray "$1" | tac)
}
Array.eval() {
	eval "PrintArray \"\${$1[@]}\""
}
Array.last() {
	PrintEval "$1[$(Array.lastIndex "$1")]"
}
Array.print() {
	(($# >= 1)) || return 0
	printf "%s\n" "${@}"
}
Array.length() {
	PrintEval "#${1}[@]"
}
Array.indexOf() {
	local n=()
	readarray -t n < <(grep -x -n "$1" | cut -d ":" -f 1 | ForEach eval echo '$(( {} - 1 ))')
	(("${#n[@]}" >= 1)) || return 1
	PrintArray "${n[@]}"
	return 0
}
Array.lastIndex() {
	CalcInt "$(Array.length "$1")" - 1
}
Array.forEach() {
	PrintEvalArray "$1" | ForEach "${@:2}"
}
Array.includes() {
	PrintEvalArray "$1" | grep -qx "$2"
}
Array.include() {
	Array.includes "$@"
}
Arch.getKernelFileList() {
	find "/boot" -maxdepth 1 -mindepth 1 -name "vmlinuz-*"
}
Arch.getKernelSrcList() {
	find "/usr/src" -mindepth 1 -maxdepth 1 -type l -name "linux*"
}
Arch.getMkinitcpioPresetList() {
	find "/etc/mkinitcpio.d/" -name "*.preset" -type f | GetBaseName | RemoveFileExt
}
Array.shift() {
	readarray -t "$1" < <(PrintEvalArray "$1" | sed "1,${2-"1"}d")
}
Array.push() {
	eval "PrintArray \"\${$1[@]}\"" | grep -qx "$2" && return 0
	eval "$1+=(\"$2\")"
}
Array.append() {
	local _ArrName="$1"
	shift 1 || return 1
	readarray -t -O "$(ArrayIndex "$_ArrName")" "$_ArrName" < <(cat)
}
Array.remove() {
	readarray -t "$1" < <(PrintEvalArray "$1" | RemoveMatchLine "$2")
}
Array.pop() {
	readarray -t "$1" < <(PrintEvalArray "$1" | sed -e '$d')
}
Array.fromStr() {
	declare -a -x "$1"
	readarray -t "$1" < <(BreakChar)
}
Array.rev() {
	readarray -t "$1" < <(PrintEvalArray "$1" | tac)
}
Array.eval() {
	eval "PrintArray \"\${$1[@]}\""
}
Array.last() {
	PrintEval "$1[$(Array.lastIndex "$1")]"
}
Array.print() {
	(($# >= 1)) || return 0
	printf "%s\n" "${@}"
}
Array.length() {
	PrintEval "#${1}[@]"
}
Array.indexOf() {
	local n=()
	readarray -t n < <(grep -x -n "$1" | cut -d ":" -f 1 | ForEach eval echo '$(( {} - 1 ))')
	(("${#n[@]}" >= 1)) || return 1
	PrintArray "${n[@]}"
	return 0
}
Array.lastIndex() {
	CalcInt "$(Array.length "$1")" - 1
}
Array.forEach() {
	PrintEvalArray "$1" | ForEach "${@:2}"
}
Array.includes() {
	PrintEvalArray "$1" | grep -qx "$2"
}
Array.include() {
	Array.includes "$@"
}
Awk.print() {
	awk "BEGIN {print $*}"
}
Awk.pi() {
	Awk.float "atan2(0, -0)"
}
Awk.log() {
	Awk.float "log(${2}) / log($1)"
}
Awk.float() {
	awk "BEGIN {printf (\"%4.${AWKSCALE-"5"}f\n\", $*)}"
}
Awk.tan() {
	Awk.float "sin($1)/tan($1)"
}
Awk.sin() {
	Awk.float "sin($*)"
}
Awk.cos() {
	Awk.float "cos($*)"
}
Awk.rad() {
	Awk.float "$1 * $(Awk.pi) / 180 "
}
Arch.getKernelFileList() {
	find "/boot" -maxdepth 1 -mindepth 1 -name "vmlinuz-*"
}
Arch.getKernelSrcList() {
	find "/usr/src" -mindepth 1 -maxdepth 1 -type l -name "linux*"
}
Arch.getMkinitcpioPresetList() {
	find "/etc/mkinitcpio.d/" -name "*.preset" -type f | GetBaseName | RemoveFileExt
}
Array.shift() {
	readarray -t "$1" < <(PrintEvalArray "$1" | sed "1,${2-"1"}d")
}
Array.push() {
	eval "PrintArray \"\${$1[@]}\"" | grep -qx "$2" && return 0
	eval "$1+=(\"$2\")"
}
Array.append() {
	local _ArrName="$1"
	shift 1 || return 1
	readarray -t -O "$(ArrayIndex "$_ArrName")" "$_ArrName" < <(cat)
}
Array.remove() {
	readarray -t "$1" < <(PrintEvalArray "$1" | RemoveMatchLine "$2")
}
Array.pop() {
	readarray -t "$1" < <(PrintEvalArray "$1" | sed -e '$d')
}
Array.fromStr() {
	declare -a -x "$1"
	readarray -t "$1" < <(BreakChar)
}
Array.rev() {
	readarray -t "$1" < <(PrintEvalArray "$1" | tac)
}
Array.eval() {
	eval "PrintArray \"\${$1[@]}\""
}
Array.last() {
	PrintEval "$1[$(Array.lastIndex "$1")]"
}
Array.print() {
	(($# >= 1)) || return 0
	printf "%s\n" "${@}"
}
Array.length() {
	PrintEval "#${1}[@]"
}
Array.indexOf() {
	local n=()
	readarray -t n < <(grep -x -n "$1" | cut -d ":" -f 1 | ForEach eval echo '$(( {} - 1 ))')
	(("${#n[@]}" >= 1)) || return 1
	PrintArray "${n[@]}"
	return 0
}
Array.lastIndex() {
	CalcInt "$(Array.length "$1")" - 1
}
Array.forEach() {
	PrintEvalArray "$1" | ForEach "${@:2}"
}
Array.includes() {
	PrintEvalArray "$1" | grep -qx "$2"
}
Array.include() {
	Array.includes "$@"
}
Awk.print() {
	awk "BEGIN {print $*}"
}
Awk.pi() {
	Awk.float "atan2(0, -0)"
}
Awk.log() {
	Awk.float "log(${2}) / log($1)"
}
Awk.float() {
	awk "BEGIN {printf (\"%4.${AWKSCALE-"5"}f\n\", $*)}"
}
Awk.tan() {
	Awk.float "sin($1)/tan($1)"
}
Awk.sin() {
	Awk.float "sin($*)"
}
Awk.cos() {
	Awk.float "cos($*)"
}
Awk.rad() {
	Awk.float "$1 * $(Awk.pi) / 180 "
}
StrToCharList() {
	Array.FromStr "$1"
}
GetArrayIndex() {
	Array.IndexOf "$1"
}
ArrayIndex() {
	Array.Length "$1"
}
RevArray() {
	Array.Rev "$1"
}
ArrayAppend() {
	Array.Append "$1"
}
ArrayIncludes() {
	Array.Includes "$@"
}
PrintEvalArray() {
	Array.Eval "$1"
}
PrintArray() {
	Array.Print "$@"
}
AddNewToArray() {
	Array.Push "$@"
}
FileType() {
	file --mime-type -b "$1"
}
GetFileExt() {
	GetBaseName | rev | cut -d "." -f 1 | rev
}
RemoveFileExt() {
	local Ext
	ForEach eval 'Ext=$(GetFileExt <<< {}); sed "s|.$Ext$||g" <<< {}; unset Ext'
}
GetBaseName() {
	ForEach basename "{}"
}
CheckFuncDefined() {
	typeset -f "${1}" >/dev/null || return 1
}
IsAvailable() {
	type "$1" 2>/dev/null 1>&2
}
Loop() {
	local _T="$1"
	shift 1 || return 1
	((_T == 0)) && return 0
	ForEach "$@" < <(yes "" | head -n "$_T")
}
GetLine() {
	head -n "$1" | tail -n 1
}
ForEach() {
	local _Item
	while read -r _Item; do
		"${@//"{}"/"${_Item}"}" || return "${?}"
	done
}
BreakChar() {
	grep -o "."
}
ToLowerStdin() {
	local _Str
	ForEach eval '_Str="{}"; echo "${_Str,,}"'
	unset _Str
}
IsUUID() {
	local _UUID="${1-""}"
	[[ ${_UUID//-/} =~ ^[[:xdigit:]]{32}$ ]] && return 0
	return 1
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
GetMaxWidth() {
	awk '{ if ( length > x && length > 0 ) { x = length } }END{ print x }'
}
CutLastString() {
	echo "${1%%"${2}"}"
	return 0
}
GetLastSplitString() {
	rev <<<"$2" | cut -d "$1" -f 1 | rev
}
CalcInt() {
	echo "$(("$@"))"
}
Sum() {
	local _Arg=()
	ForEach eval '_Arg+=("{}" "+")' < <(PrintArray "$@")
	readarray -t _Arg < <(PrintArray "${_Arg[@]}" | sed "${#_Arg[@]}d")
	CalcInt "${_Arg[@]}"
}
Ntest() {
	(("$@")) || return 1
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
ToArgs() {
	readarray -t args
	"$@" "${args[@]}"
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
Arch.getKernelFileList() {
	find "/boot" -maxdepth 1 -mindepth 1 -name "vmlinuz-*"
}
Arch.getKernelSrcList() {
	find "/usr/src" -mindepth 1 -maxdepth 1 -type l -name "linux*"
}
Arch.getMkinitcpioPresetList() {
	find "/etc/mkinitcpio.d/" -name "*.preset" -type f | GetBaseName | RemoveFileExt
}
Array.shift() {
	readarray -t "$1" < <(PrintEvalArray "$1" | sed "1,${2-"1"}d")
}
Array.push() {
	eval "PrintArray \"\${$1[@]}\"" | grep -qx "$2" && return 0
	eval "$1+=(\"$2\")"
}
Array.append() {
	local _ArrName="$1"
	shift 1 || return 1
	readarray -t -O "$(ArrayIndex "$_ArrName")" "$_ArrName" < <(cat)
}
Array.remove() {
	readarray -t "$1" < <(PrintEvalArray "$1" | RemoveMatchLine "$2")
}
Array.pop() {
	readarray -t "$1" < <(PrintEvalArray "$1" | sed -e '$d')
}
Array.fromStr() {
	declare -a -x "$1"
	readarray -t "$1" < <(BreakChar)
}
Array.rev() {
	readarray -t "$1" < <(PrintEvalArray "$1" | tac)
}
Array.eval() {
	eval "PrintArray \"\${$1[@]}\""
}
Array.last() {
	PrintEval "$1[$(Array.lastIndex "$1")]"
}
Array.print() {
	(($# >= 1)) || return 0
	printf "%s\n" "${@}"
}
Array.length() {
	PrintEval "#${1}[@]"
}
Array.indexOf() {
	local n=()
	readarray -t n < <(grep -x -n "$1" | cut -d ":" -f 1 | ForEach eval echo '$(( {} - 1 ))')
	(("${#n[@]}" >= 1)) || return 1
	PrintArray "${n[@]}"
	return 0
}
Array.lastIndex() {
	CalcInt "$(Array.length "$1")" - 1
}
Array.forEach() {
	PrintEvalArray "$1" | ForEach "${@:2}"
}
Array.includes() {
	PrintEvalArray "$1" | grep -qx "$2"
}
Array.include() {
	Array.includes "$@"
}
Awk.print() {
	awk "BEGIN {print $*}"
}
Awk.pi() {
	Awk.float "atan2(0, -0)"
}
Awk.log() {
	Awk.float "log(${2}) / log($1)"
}
Awk.float() {
	awk "BEGIN {printf (\"%4.${AWKSCALE-"5"}f\n\", $*)}"
}
Awk.tan() {
	Awk.float "sin($1)/tan($1)"
}
Awk.sin() {
	Awk.float "sin($*)"
}
Awk.cos() {
	Awk.float "cos($*)"
}
Awk.rad() {
	Awk.float "$1 * $(Awk.pi) / 180 "
}
StrToCharList() {
	Array.FromStr "$1"
}
GetArrayIndex() {
	Array.IndexOf "$1"
}
ArrayIndex() {
	Array.Length "$1"
}
RevArray() {
	Array.Rev "$1"
}
ArrayAppend() {
	Array.Append "$1"
}
ArrayIncludes() {
	Array.Includes "$@"
}
PrintEvalArray() {
	Array.Eval "$1"
}
PrintArray() {
	Array.Print "$@"
}
AddNewToArray() {
	Array.Push "$@"
}
FileType() {
	file --mime-type -b "$1"
}
GetFileExt() {
	GetBaseName | rev | cut -d "." -f 1 | rev
}
RemoveFileExt() {
	local Ext
	ForEach eval 'Ext=$(GetFileExt <<< {}); sed "s|.$Ext$||g" <<< {}; unset Ext'
}
GetBaseName() {
	ForEach basename "{}"
}
CheckFuncDefined() {
	typeset -f "${1}" >/dev/null || return 1
}
IsAvailable() {
	type "$1" 2>/dev/null 1>&2
}
Loop() {
	local _T="$1"
	shift 1 || return 1
	((_T == 0)) && return 0
	ForEach "$@" < <(yes "" | head -n "$_T")
}
GetLine() {
	head -n "$1" | tail -n 1
}
ForEach() {
	local _Item
	while read -r _Item; do
		"${@//"{}"/"${_Item}"}" || return "${?}"
	done
}
BreakChar() {
	grep -o "."
}
ToLowerStdin() {
	local _Str
	ForEach eval '_Str="{}"; echo "${_Str,,}"'
	unset _Str
}
IsUUID() {
	local _UUID="${1-""}"
	[[ ${_UUID//-/} =~ ^[[:xdigit:]]{32}$ ]] && return 0
	return 1
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
GetMaxWidth() {
	awk '{ if ( length > x && length > 0 ) { x = length } }END{ print x }'
}
CutLastString() {
	echo "${1%%"${2}"}"
	return 0
}
GetLastSplitString() {
	rev <<<"$2" | cut -d "$1" -f 1 | rev
}
CalcInt() {
	echo "$(("$@"))"
}
Sum() {
	local _Arg=()
	ForEach eval '_Arg+=("{}" "+")' < <(PrintArray "$@")
	readarray -t _Arg < <(PrintArray "${_Arg[@]}" | sed "${#_Arg[@]}d")
	CalcInt "${_Arg[@]}"
}
Ntest() {
	(("$@")) || return 1
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
ToArgs() {
	readarray -t args
	"$@" "${args[@]}"
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
Cache.getTimeDiffFromLastUpdate() {
	local _Now _Last
	_Now="$(date "+%s")"
	_Last="$(Cache.getFileLastUpdate "$1")"
	echo "$((_Now - _Last))"
	return 0
}
Cache.get() {
	cat "$(Cache.getDir)/$1" 2>/dev/null || return 1
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
Cache.exist() {
	local _File
	_File="$(Cache.createDir)/$1"
	[[ -e $_File ]] || return 1
	(("$(Cache.getTimeDiffFromLastUpdate "$_File")" > "${KEEPCACHESEC-"86400"}")) && return 2
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
Cache.create() {
	Cache.createDir >/dev/null
	cat >"$(Cache.getDir)/${1}"
	cat "$(Cache.getDir)/$1"
}
Cache.createDir() {
	FSBLIB_CACHEID="${FSBLIB_CACHEID-"$(RandomString "10")"}"
	export FSBLIB_CACHEID="$FSBLIB_CACHEID"
	local TMPDIR="${TMPDIR-"/tmp"}"
	local _Dir="$TMPDIR/${FSBLIB_CACHEID}"
	mkdir -p "$_Dir"
	echo "$_Dir"
	return 0
}
Arch.getKernelFileList() {
	find "/boot" -maxdepth 1 -mindepth 1 -name "vmlinuz-*"
}
Arch.getKernelSrcList() {
	find "/usr/src" -mindepth 1 -maxdepth 1 -type l -name "linux*"
}
Arch.getMkinitcpioPresetList() {
	find "/etc/mkinitcpio.d/" -name "*.preset" -type f | GetBaseName | RemoveFileExt
}
Array.shift() {
	readarray -t "$1" < <(PrintEvalArray "$1" | sed "1,${2-"1"}d")
}
Array.push() {
	eval "PrintArray \"\${$1[@]}\"" | grep -qx "$2" && return 0
	eval "$1+=(\"$2\")"
}
Array.append() {
	local _ArrName="$1"
	shift 1 || return 1
	readarray -t -O "$(ArrayIndex "$_ArrName")" "$_ArrName" < <(cat)
}
Array.remove() {
	readarray -t "$1" < <(PrintEvalArray "$1" | RemoveMatchLine "$2")
}
Array.pop() {
	readarray -t "$1" < <(PrintEvalArray "$1" | sed -e '$d')
}
Array.fromStr() {
	declare -a -x "$1"
	readarray -t "$1" < <(BreakChar)
}
Array.rev() {
	readarray -t "$1" < <(PrintEvalArray "$1" | tac)
}
Array.eval() {
	eval "PrintArray \"\${$1[@]}\""
}
Array.last() {
	PrintEval "$1[$(Array.lastIndex "$1")]"
}
Array.print() {
	(($# >= 1)) || return 0
	printf "%s\n" "${@}"
}
Array.length() {
	PrintEval "#${1}[@]"
}
Array.indexOf() {
	local n=()
	readarray -t n < <(grep -x -n "$1" | cut -d ":" -f 1 | ForEach eval echo '$(( {} - 1 ))')
	(("${#n[@]}" >= 1)) || return 1
	PrintArray "${n[@]}"
	return 0
}
Array.lastIndex() {
	CalcInt "$(Array.length "$1")" - 1
}
Array.forEach() {
	PrintEvalArray "$1" | ForEach "${@:2}"
}
Array.includes() {
	PrintEvalArray "$1" | grep -qx "$2"
}
Array.include() {
	Array.includes "$@"
}
Awk.print() {
	awk "BEGIN {print $*}"
}
Awk.pi() {
	Awk.float "atan2(0, -0)"
}
Awk.log() {
	Awk.float "log(${2}) / log($1)"
}
Awk.float() {
	awk "BEGIN {printf (\"%4.${AWKSCALE-"5"}f\n\", $*)}"
}
Awk.tan() {
	Awk.float "sin($1)/tan($1)"
}
Awk.sin() {
	Awk.float "sin($*)"
}
Awk.cos() {
	Awk.float "cos($*)"
}
Awk.rad() {
	Awk.float "$1 * $(Awk.pi) / 180 "
}
StrToCharList() {
	Array.FromStr "$1"
}
GetArrayIndex() {
	Array.IndexOf "$1"
}
ArrayIndex() {
	Array.Length "$1"
}
RevArray() {
	Array.Rev "$1"
}
ArrayAppend() {
	Array.Append "$1"
}
ArrayIncludes() {
	Array.Includes "$@"
}
PrintEvalArray() {
	Array.Eval "$1"
}
PrintArray() {
	Array.Print "$@"
}
AddNewToArray() {
	Array.Push "$@"
}
FileType() {
	file --mime-type -b "$1"
}
GetFileExt() {
	GetBaseName | rev | cut -d "." -f 1 | rev
}
RemoveFileExt() {
	local Ext
	ForEach eval 'Ext=$(GetFileExt <<< {}); sed "s|.$Ext$||g" <<< {}; unset Ext'
}
GetBaseName() {
	ForEach basename "{}"
}
CheckFuncDefined() {
	typeset -f "${1}" >/dev/null || return 1
}
IsAvailable() {
	type "$1" 2>/dev/null 1>&2
}
Loop() {
	local _T="$1"
	shift 1 || return 1
	((_T == 0)) && return 0
	ForEach "$@" < <(yes "" | head -n "$_T")
}
GetLine() {
	head -n "$1" | tail -n 1
}
ForEach() {
	local _Item
	while read -r _Item; do
		"${@//"{}"/"${_Item}"}" || return "${?}"
	done
}
BreakChar() {
	grep -o "."
}
ToLowerStdin() {
	local _Str
	ForEach eval '_Str="{}"; echo "${_Str,,}"'
	unset _Str
}
IsUUID() {
	local _UUID="${1-""}"
	[[ ${_UUID//-/} =~ ^[[:xdigit:]]{32}$ ]] && return 0
	return 1
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
GetMaxWidth() {
	awk '{ if ( length > x && length > 0 ) { x = length } }END{ print x }'
}
CutLastString() {
	echo "${1%%"${2}"}"
	return 0
}
GetLastSplitString() {
	rev <<<"$2" | cut -d "$1" -f 1 | rev
}
CalcInt() {
	echo "$(("$@"))"
}
Sum() {
	local _Arg=()
	ForEach eval '_Arg+=("{}" "+")' < <(PrintArray "$@")
	readarray -t _Arg < <(PrintArray "${_Arg[@]}" | sed "${#_Arg[@]}d")
	CalcInt "${_Arg[@]}"
}
Ntest() {
	(("$@")) || return 1
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
ToArgs() {
	readarray -t args
	"$@" "${args[@]}"
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
Cache.getTimeDiffFromLastUpdate() {
	local _Now _Last
	_Now="$(date "+%s")"
	_Last="$(Cache.getFileLastUpdate "$1")"
	echo "$((_Now - _Last))"
	return 0
}
Cache.get() {
	cat "$(Cache.getDir)/$1" 2>/dev/null || return 1
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
Cache.exist() {
	local _File
	_File="$(Cache.createDir)/$1"
	[[ -e $_File ]] || return 1
	(("$(Cache.getTimeDiffFromLastUpdate "$_File")" > "${KEEPCACHESEC-"86400"}")) && return 2
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
Cache.create() {
	Cache.createDir >/dev/null
	cat >"$(Cache.getDir)/${1}"
	cat "$(Cache.getDir)/$1"
}
Cache.createDir() {
	FSBLIB_CACHEID="${FSBLIB_CACHEID-"$(RandomString "10")"}"
	export FSBLIB_CACHEID="$FSBLIB_CACHEID"
	local TMPDIR="${TMPDIR-"/tmp"}"
	local _Dir="$TMPDIR/${FSBLIB_CACHEID}"
	mkdir -p "$_Dir"
	echo "$_Dir"
	return 0
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
fsblibEnvCheck() {
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
	find "/etc/mkinitcpio.d/" -name "*.preset" -type f | GetBaseName | RemoveFileExt
}
Array.shift() {
	readarray -t "$1" < <(PrintEvalArray "$1" | sed "1,${2-"1"}d")
}
Array.push() {
	eval "PrintArray \"\${$1[@]}\"" | grep -qx "$2" && return 0
	eval "$1+=(\"$2\")"
}
Array.append() {
	local _ArrName="$1"
	shift 1 || return 1
	readarray -t -O "$(ArrayIndex "$_ArrName")" "$_ArrName" < <(cat)
}
Array.remove() {
	readarray -t "$1" < <(PrintEvalArray "$1" | RemoveMatchLine "$2")
}
Array.pop() {
	readarray -t "$1" < <(PrintEvalArray "$1" | sed -e '$d')
}
Array.fromStr() {
	declare -a -x "$1"
	readarray -t "$1" < <(BreakChar)
}
Array.rev() {
	readarray -t "$1" < <(PrintEvalArray "$1" | tac)
}
Array.eval() {
	eval "PrintArray \"\${$1[@]}\""
}
Array.last() {
	PrintEval "$1[$(Array.lastIndex "$1")]"
}
Array.print() {
	(($# >= 1)) || return 0
	printf "%s\n" "${@}"
}
Array.length() {
	PrintEval "#${1}[@]"
}
Array.indexOf() {
	local n=()
	readarray -t n < <(grep -x -n "$1" | cut -d ":" -f 1 | ForEach eval echo '$(( {} - 1 ))')
	(("${#n[@]}" >= 1)) || return 1
	PrintArray "${n[@]}"
	return 0
}
Array.lastIndex() {
	CalcInt "$(Array.length "$1")" - 1
}
Array.forEach() {
	PrintEvalArray "$1" | ForEach "${@:2}"
}
Array.includes() {
	PrintEvalArray "$1" | grep -qx "$2"
}
Array.include() {
	Array.includes "$@"
}
Awk.print() {
	awk "BEGIN {print $*}"
}
Awk.pi() {
	Awk.float "atan2(0, -0)"
}
Awk.log() {
	Awk.float "log(${2}) / log($1)"
}
Awk.float() {
	awk "BEGIN {printf (\"%4.${AWKSCALE-"5"}f\n\", $*)}"
}
Awk.tan() {
	Awk.float "sin($1)/tan($1)"
}
Awk.sin() {
	Awk.float "sin($*)"
}
Awk.cos() {
	Awk.float "cos($*)"
}
Awk.rad() {
	Awk.float "$1 * $(Awk.pi) / 180 "
}
StrToCharList() {
	Array.FromStr "$1"
}
GetArrayIndex() {
	Array.IndexOf "$1"
}
ArrayIndex() {
	Array.Length "$1"
}
RevArray() {
	Array.Rev "$1"
}
ArrayAppend() {
	Array.Append "$1"
}
ArrayIncludes() {
	Array.Includes "$@"
}
PrintEvalArray() {
	Array.Eval "$1"
}
PrintArray() {
	Array.Print "$@"
}
AddNewToArray() {
	Array.Push "$@"
}
FileType() {
	file --mime-type -b "$1"
}
GetFileExt() {
	GetBaseName | rev | cut -d "." -f 1 | rev
}
RemoveFileExt() {
	local Ext
	ForEach eval 'Ext=$(GetFileExt <<< {}); sed "s|.$Ext$||g" <<< {}; unset Ext'
}
GetBaseName() {
	ForEach basename "{}"
}
CheckFuncDefined() {
	typeset -f "${1}" >/dev/null || return 1
}
IsAvailable() {
	type "$1" 2>/dev/null 1>&2
}
Loop() {
	local _T="$1"
	shift 1 || return 1
	((_T == 0)) && return 0
	ForEach "$@" < <(yes "" | head -n "$_T")
}
GetLine() {
	head -n "$1" | tail -n 1
}
ForEach() {
	local _Item
	while read -r _Item; do
		"${@//"{}"/"${_Item}"}" || return "${?}"
	done
}
BreakChar() {
	grep -o "."
}
ToLowerStdin() {
	local _Str
	ForEach eval '_Str="{}"; echo "${_Str,,}"'
	unset _Str
}
IsUUID() {
	local _UUID="${1-""}"
	[[ ${_UUID//-/} =~ ^[[:xdigit:]]{32}$ ]] && return 0
	return 1
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
GetMaxWidth() {
	awk '{ if ( length > x && length > 0 ) { x = length } }END{ print x }'
}
CutLastString() {
	echo "${1%%"${2}"}"
	return 0
}
GetLastSplitString() {
	rev <<<"$2" | cut -d "$1" -f 1 | rev
}
CalcInt() {
	echo "$(("$@"))"
}
Sum() {
	local _Arg=()
	ForEach eval '_Arg+=("{}" "+")' < <(PrintArray "$@")
	readarray -t _Arg < <(PrintArray "${_Arg[@]}" | sed "${#_Arg[@]}d")
	CalcInt "${_Arg[@]}"
}
Ntest() {
	(("$@")) || return 1
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
ToArgs() {
	readarray -t args
	"$@" "${args[@]}"
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
Cache.getTimeDiffFromLastUpdate() {
	local _Now _Last
	_Now="$(date "+%s")"
	_Last="$(Cache.getFileLastUpdate "$1")"
	echo "$((_Now - _Last))"
	return 0
}
Cache.get() {
	cat "$(Cache.getDir)/$1" 2>/dev/null || return 1
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
Cache.exist() {
	local _File
	_File="$(Cache.createDir)/$1"
	[[ -e $_File ]] || return 1
	(("$(Cache.getTimeDiffFromLastUpdate "$_File")" > "${KEEPCACHESEC-"86400"}")) && return 2
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
Cache.create() {
	Cache.createDir >/dev/null
	cat >"$(Cache.getDir)/${1}"
	cat "$(Cache.getDir)/$1"
}
Cache.createDir() {
	FSBLIB_CACHEID="${FSBLIB_CACHEID-"$(RandomString "10")"}"
	export FSBLIB_CACHEID="$FSBLIB_CACHEID"
	local TMPDIR="${TMPDIR-"/tmp"}"
	local _Dir="$TMPDIR/${FSBLIB_CACHEID}"
	mkdir -p "$_Dir"
	echo "$_Dir"
	return 0
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
fsblibEnvCheck() {
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
Csv.toBashArray() {
	local _RawCsvLine=() _Line _ClmCnt=0
	local ArrayPrefix="${ArrayPrefix-"{}"}"
	readarray -t _RawCsvLine < <(
		while read -r _Line; do
			(($(tr "${CSVDELIM-","}" "\n" <<<"$_Line" | wc -l) >= ${#})) && echo "$_Line"
		done < <(grep -v "^#")
	)
	_ClmCnt=$(PrintArray "${_RawCsvLine[@]}" | Csv.getClmCnt)
	while read -r _Cnt; do
		readarray -t "$(sed "s|{}|$(eval "echo \"\${${_Cnt}}\"")|g" <<<"$ArrayPrefix")" < <(
			PrintArray "${_RawCsvLine[@]}" | cut -d "${CSVDELIM-","}" -f "$_Cnt"
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
	done < <(PrintArray "${_RawCsvLine[@]}")
	RemoveBlank <<<"$_ClmCnt"
	return 0
}
Csv.getClm() {
	grep -v "^#" | sed "/^$/d" | cut -d "${CSVDELIM-","}" -f "$1"
}
Arch.getKernelFileList() {
	find "/boot" -maxdepth 1 -mindepth 1 -name "vmlinuz-*"
}
Arch.getKernelSrcList() {
	find "/usr/src" -mindepth 1 -maxdepth 1 -type l -name "linux*"
}
Arch.getMkinitcpioPresetList() {
	find "/etc/mkinitcpio.d/" -name "*.preset" -type f | GetBaseName | RemoveFileExt
}
Array.shift() {
	readarray -t "$1" < <(PrintEvalArray "$1" | sed "1,${2-"1"}d")
}
Array.push() {
	eval "PrintArray \"\${$1[@]}\"" | grep -qx "$2" && return 0
	eval "$1+=(\"$2\")"
}
Array.append() {
	local _ArrName="$1"
	shift 1 || return 1
	readarray -t -O "$(ArrayIndex "$_ArrName")" "$_ArrName" < <(cat)
}
Array.remove() {
	readarray -t "$1" < <(PrintEvalArray "$1" | RemoveMatchLine "$2")
}
Array.pop() {
	readarray -t "$1" < <(PrintEvalArray "$1" | sed -e '$d')
}
Array.fromStr() {
	declare -a -x "$1"
	readarray -t "$1" < <(BreakChar)
}
Array.rev() {
	readarray -t "$1" < <(PrintEvalArray "$1" | tac)
}
Array.eval() {
	eval "PrintArray \"\${$1[@]}\""
}
Array.last() {
	PrintEval "$1[$(Array.lastIndex "$1")]"
}
Array.print() {
	(($# >= 1)) || return 0
	printf "%s\n" "${@}"
}
Array.length() {
	PrintEval "#${1}[@]"
}
Array.indexOf() {
	local n=()
	readarray -t n < <(grep -x -n "$1" | cut -d ":" -f 1 | ForEach eval echo '$(( {} - 1 ))')
	(("${#n[@]}" >= 1)) || return 1
	PrintArray "${n[@]}"
	return 0
}
Array.lastIndex() {
	CalcInt "$(Array.length "$1")" - 1
}
Array.forEach() {
	PrintEvalArray "$1" | ForEach "${@:2}"
}
Array.includes() {
	PrintEvalArray "$1" | grep -qx "$2"
}
Array.include() {
	Array.includes "$@"
}
Awk.print() {
	awk "BEGIN {print $*}"
}
Awk.pi() {
	Awk.float "atan2(0, -0)"
}
Awk.log() {
	Awk.float "log(${2}) / log($1)"
}
Awk.float() {
	awk "BEGIN {printf (\"%4.${AWKSCALE-"5"}f\n\", $*)}"
}
Awk.tan() {
	Awk.float "sin($1)/tan($1)"
}
Awk.sin() {
	Awk.float "sin($*)"
}
Awk.cos() {
	Awk.float "cos($*)"
}
Awk.rad() {
	Awk.float "$1 * $(Awk.pi) / 180 "
}
StrToCharList() {
	Array.FromStr "$1"
}
GetArrayIndex() {
	Array.IndexOf "$1"
}
ArrayIndex() {
	Array.Length "$1"
}
RevArray() {
	Array.Rev "$1"
}
ArrayAppend() {
	Array.Append "$1"
}
ArrayIncludes() {
	Array.Includes "$@"
}
PrintEvalArray() {
	Array.Eval "$1"
}
PrintArray() {
	Array.Print "$@"
}
AddNewToArray() {
	Array.Push "$@"
}
FileType() {
	file --mime-type -b "$1"
}
GetFileExt() {
	GetBaseName | rev | cut -d "." -f 1 | rev
}
RemoveFileExt() {
	local Ext
	ForEach eval 'Ext=$(GetFileExt <<< {}); sed "s|.$Ext$||g" <<< {}; unset Ext'
}
GetBaseName() {
	ForEach basename "{}"
}
CheckFuncDefined() {
	typeset -f "${1}" >/dev/null || return 1
}
IsAvailable() {
	type "$1" 2>/dev/null 1>&2
}
Loop() {
	local _T="$1"
	shift 1 || return 1
	((_T == 0)) && return 0
	ForEach "$@" < <(yes "" | head -n "$_T")
}
GetLine() {
	head -n "$1" | tail -n 1
}
ForEach() {
	local _Item
	while read -r _Item; do
		"${@//"{}"/"${_Item}"}" || return "${?}"
	done
}
BreakChar() {
	grep -o "."
}
ToLowerStdin() {
	local _Str
	ForEach eval '_Str="{}"; echo "${_Str,,}"'
	unset _Str
}
IsUUID() {
	local _UUID="${1-""}"
	[[ ${_UUID//-/} =~ ^[[:xdigit:]]{32}$ ]] && return 0
	return 1
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
GetMaxWidth() {
	awk '{ if ( length > x && length > 0 ) { x = length } }END{ print x }'
}
CutLastString() {
	echo "${1%%"${2}"}"
	return 0
}
GetLastSplitString() {
	rev <<<"$2" | cut -d "$1" -f 1 | rev
}
CalcInt() {
	echo "$(("$@"))"
}
Sum() {
	local _Arg=()
	ForEach eval '_Arg+=("{}" "+")' < <(PrintArray "$@")
	readarray -t _Arg < <(PrintArray "${_Arg[@]}" | sed "${#_Arg[@]}d")
	CalcInt "${_Arg[@]}"
}
Ntest() {
	(("$@")) || return 1
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
ToArgs() {
	readarray -t args
	"$@" "${args[@]}"
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
Cache.getTimeDiffFromLastUpdate() {
	local _Now _Last
	_Now="$(date "+%s")"
	_Last="$(Cache.getFileLastUpdate "$1")"
	echo "$((_Now - _Last))"
	return 0
}
Cache.get() {
	cat "$(Cache.getDir)/$1" 2>/dev/null || return 1
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
Cache.exist() {
	local _File
	_File="$(Cache.createDir)/$1"
	[[ -e $_File ]] || return 1
	(("$(Cache.getTimeDiffFromLastUpdate "$_File")" > "${KEEPCACHESEC-"86400"}")) && return 2
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
Cache.create() {
	Cache.createDir >/dev/null
	cat >"$(Cache.getDir)/${1}"
	cat "$(Cache.getDir)/$1"
}
Cache.createDir() {
	FSBLIB_CACHEID="${FSBLIB_CACHEID-"$(RandomString "10")"}"
	export FSBLIB_CACHEID="$FSBLIB_CACHEID"
	local TMPDIR="${TMPDIR-"/tmp"}"
	local _Dir="$TMPDIR/${FSBLIB_CACHEID}"
	mkdir -p "$_Dir"
	echo "$_Dir"
	return 0
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
fsblibEnvCheck() {
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
Csv.toBashArray() {
	local _RawCsvLine=() _Line _ClmCnt=0
	local ArrayPrefix="${ArrayPrefix-"{}"}"
	readarray -t _RawCsvLine < <(
		while read -r _Line; do
			(($(tr "${CSVDELIM-","}" "\n" <<<"$_Line" | wc -l) >= ${#})) && echo "$_Line"
		done < <(grep -v "^#")
	)
	_ClmCnt=$(PrintArray "${_RawCsvLine[@]}" | Csv.getClmCnt)
	while read -r _Cnt; do
		readarray -t "$(sed "s|{}|$(eval "echo \"\${${_Cnt}}\"")|g" <<<"$ArrayPrefix")" < <(
			PrintArray "${_RawCsvLine[@]}" | cut -d "${CSVDELIM-","}" -f "$_Cnt"
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
	done < <(PrintArray "${_RawCsvLine[@]}")
	RemoveBlank <<<"$_ClmCnt"
	return 0
}
Csv.getClm() {
	grep -v "^#" | sed "/^$/d" | cut -d "${CSVDELIM-","}" -f "$1"
}
Em.getWorldPkgList() {
	sed -E 's|:.+$||g' /var/lib/portage/world | xargs -I{} bash -c 'ls -d /var/db/pkg/{}-* | sed "s|/var/db/pkg/||g" | grep -E "{}-[0-9]"'
}
Em.getInstalledPkgList() {
	find /var/db/pkg/ -mindepth 2 -maxdepth 2 -type d | sed 's|/var/db/pkg/||g'
}
Em.getDefaultRepoName() {
	Em.getRepoConf | Ini.GetParam DEFAULT main-repo
}
Em.getRepoLocation() {
	Em.getRepoConf | Ini.GetParam "$1" location
}
Em.getAllPkgList() {
	Em.getRepoConf | sed -e 's/^ *//' -e 's/ *$//' | grep "^ *location *=" | sed -e 's/^location *= *//' | xargs -L1 realpath | xargs -I{} bash -c "find '{}' -mindepth 3 -maxdepth 3 -type f -name '*.ebuild' | sed -e 's|{}/||g' -e 's|.ebuild$||g'" | awk -F "/" '{print $1"/"$3}'
}
Em.getRepoPkgList() {
	local _RepoPath
	_RepoPath="$(Em.getRepoLocation "$1")"
	find "$_RepoPath" -mindepth 3 -maxdepth 3 -type f -name '*.ebuild' | sed -e "s|${_RepoPath%/}/||g" -e 's|.ebuild$||g' | awk -F "/" '{print $1"/"$3}'
}
Em.getRepoConf() {
	cat /etc/portage/repos.conf /etc/portage/repos.conf/* 2>/dev/null
}
Em.noVersion() {
	sed -E 's|\-[0-9]+.+||g'
}
Arch.getKernelFileList() {
	find "/boot" -maxdepth 1 -mindepth 1 -name "vmlinuz-*"
}
Arch.getKernelSrcList() {
	find "/usr/src" -mindepth 1 -maxdepth 1 -type l -name "linux*"
}
Arch.getMkinitcpioPresetList() {
	find "/etc/mkinitcpio.d/" -name "*.preset" -type f | GetBaseName | RemoveFileExt
}
Array.shift() {
	readarray -t "$1" < <(PrintEvalArray "$1" | sed "1,${2-"1"}d")
}
Array.push() {
	eval "PrintArray \"\${$1[@]}\"" | grep -qx "$2" && return 0
	eval "$1+=(\"$2\")"
}
Array.append() {
	local _ArrName="$1"
	shift 1 || return 1
	readarray -t -O "$(ArrayIndex "$_ArrName")" "$_ArrName" < <(cat)
}
Array.remove() {
	readarray -t "$1" < <(PrintEvalArray "$1" | RemoveMatchLine "$2")
}
Array.pop() {
	readarray -t "$1" < <(PrintEvalArray "$1" | sed -e '$d')
}
Array.fromStr() {
	declare -a -x "$1"
	readarray -t "$1" < <(BreakChar)
}
Array.rev() {
	readarray -t "$1" < <(PrintEvalArray "$1" | tac)
}
Array.eval() {
	eval "PrintArray \"\${$1[@]}\""
}
Array.last() {
	PrintEval "$1[$(Array.lastIndex "$1")]"
}
Array.print() {
	(($# >= 1)) || return 0
	printf "%s\n" "${@}"
}
Array.length() {
	PrintEval "#${1}[@]"
}
Array.indexOf() {
	local n=()
	readarray -t n < <(grep -x -n "$1" | cut -d ":" -f 1 | ForEach eval echo '$(( {} - 1 ))')
	(("${#n[@]}" >= 1)) || return 1
	PrintArray "${n[@]}"
	return 0
}
Array.lastIndex() {
	CalcInt "$(Array.length "$1")" - 1
}
Array.forEach() {
	PrintEvalArray "$1" | ForEach "${@:2}"
}
Array.includes() {
	PrintEvalArray "$1" | grep -qx "$2"
}
Array.include() {
	Array.includes "$@"
}
Awk.print() {
	awk "BEGIN {print $*}"
}
Awk.pi() {
	Awk.float "atan2(0, -0)"
}
Awk.log() {
	Awk.float "log(${2}) / log($1)"
}
Awk.float() {
	awk "BEGIN {printf (\"%4.${AWKSCALE-"5"}f\n\", $*)}"
}
Awk.tan() {
	Awk.float "sin($1)/tan($1)"
}
Awk.sin() {
	Awk.float "sin($*)"
}
Awk.cos() {
	Awk.float "cos($*)"
}
Awk.rad() {
	Awk.float "$1 * $(Awk.pi) / 180 "
}
StrToCharList() {
	Array.FromStr "$1"
}
GetArrayIndex() {
	Array.IndexOf "$1"
}
ArrayIndex() {
	Array.Length "$1"
}
RevArray() {
	Array.Rev "$1"
}
ArrayAppend() {
	Array.Append "$1"
}
ArrayIncludes() {
	Array.Includes "$@"
}
PrintEvalArray() {
	Array.Eval "$1"
}
PrintArray() {
	Array.Print "$@"
}
AddNewToArray() {
	Array.Push "$@"
}
FileType() {
	file --mime-type -b "$1"
}
GetFileExt() {
	GetBaseName | rev | cut -d "." -f 1 | rev
}
RemoveFileExt() {
	local Ext
	ForEach eval 'Ext=$(GetFileExt <<< {}); sed "s|.$Ext$||g" <<< {}; unset Ext'
}
GetBaseName() {
	ForEach basename "{}"
}
CheckFuncDefined() {
	typeset -f "${1}" >/dev/null || return 1
}
IsAvailable() {
	type "$1" 2>/dev/null 1>&2
}
Loop() {
	local _T="$1"
	shift 1 || return 1
	((_T == 0)) && return 0
	ForEach "$@" < <(yes "" | head -n "$_T")
}
GetLine() {
	head -n "$1" | tail -n 1
}
ForEach() {
	local _Item
	while read -r _Item; do
		"${@//"{}"/"${_Item}"}" || return "${?}"
	done
}
BreakChar() {
	grep -o "."
}
ToLowerStdin() {
	local _Str
	ForEach eval '_Str="{}"; echo "${_Str,,}"'
	unset _Str
}
IsUUID() {
	local _UUID="${1-""}"
	[[ ${_UUID//-/} =~ ^[[:xdigit:]]{32}$ ]] && return 0
	return 1
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
GetMaxWidth() {
	awk '{ if ( length > x && length > 0 ) { x = length } }END{ print x }'
}
CutLastString() {
	echo "${1%%"${2}"}"
	return 0
}
GetLastSplitString() {
	rev <<<"$2" | cut -d "$1" -f 1 | rev
}
CalcInt() {
	echo "$(("$@"))"
}
Sum() {
	local _Arg=()
	ForEach eval '_Arg+=("{}" "+")' < <(PrintArray "$@")
	readarray -t _Arg < <(PrintArray "${_Arg[@]}" | sed "${#_Arg[@]}d")
	CalcInt "${_Arg[@]}"
}
Ntest() {
	(("$@")) || return 1
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
ToArgs() {
	readarray -t args
	"$@" "${args[@]}"
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
Cache.getTimeDiffFromLastUpdate() {
	local _Now _Last
	_Now="$(date "+%s")"
	_Last="$(Cache.getFileLastUpdate "$1")"
	echo "$((_Now - _Last))"
	return 0
}
Cache.get() {
	cat "$(Cache.getDir)/$1" 2>/dev/null || return 1
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
Cache.exist() {
	local _File
	_File="$(Cache.createDir)/$1"
	[[ -e $_File ]] || return 1
	(("$(Cache.getTimeDiffFromLastUpdate "$_File")" > "${KEEPCACHESEC-"86400"}")) && return 2
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
Cache.create() {
	Cache.createDir >/dev/null
	cat >"$(Cache.getDir)/${1}"
	cat "$(Cache.getDir)/$1"
}
Cache.createDir() {
	FSBLIB_CACHEID="${FSBLIB_CACHEID-"$(RandomString "10")"}"
	export FSBLIB_CACHEID="$FSBLIB_CACHEID"
	local TMPDIR="${TMPDIR-"/tmp"}"
	local _Dir="$TMPDIR/${FSBLIB_CACHEID}"
	mkdir -p "$_Dir"
	echo "$_Dir"
	return 0
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
fsblibEnvCheck() {
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
Csv.toBashArray() {
	local _RawCsvLine=() _Line _ClmCnt=0
	local ArrayPrefix="${ArrayPrefix-"{}"}"
	readarray -t _RawCsvLine < <(
		while read -r _Line; do
			(($(tr "${CSVDELIM-","}" "\n" <<<"$_Line" | wc -l) >= ${#})) && echo "$_Line"
		done < <(grep -v "^#")
	)
	_ClmCnt=$(PrintArray "${_RawCsvLine[@]}" | Csv.getClmCnt)
	while read -r _Cnt; do
		readarray -t "$(sed "s|{}|$(eval "echo \"\${${_Cnt}}\"")|g" <<<"$ArrayPrefix")" < <(
			PrintArray "${_RawCsvLine[@]}" | cut -d "${CSVDELIM-","}" -f "$_Cnt"
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
	done < <(PrintArray "${_RawCsvLine[@]}")
	RemoveBlank <<<"$_ClmCnt"
	return 0
}
Csv.getClm() {
	grep -v "^#" | sed "/^$/d" | cut -d "${CSVDELIM-","}" -f "$1"
}
Em.getWorldPkgList() {
	sed -E 's|:.+$||g' /var/lib/portage/world | xargs -I{} bash -c 'ls -d /var/db/pkg/{}-* | sed "s|/var/db/pkg/||g" | grep -E "{}-[0-9]"'
}
Em.getInstalledPkgList() {
	find /var/db/pkg/ -mindepth 2 -maxdepth 2 -type d | sed 's|/var/db/pkg/||g'
}
Em.getDefaultRepoName() {
	Em.getRepoConf | Ini.GetParam DEFAULT main-repo
}
Em.getRepoLocation() {
	Em.getRepoConf | Ini.GetParam "$1" location
}
Em.getAllPkgList() {
	Em.getRepoConf | sed -e 's/^ *//' -e 's/ *$//' | grep "^ *location *=" | sed -e 's/^location *= *//' | xargs -L1 realpath | xargs -I{} bash -c "find '{}' -mindepth 3 -maxdepth 3 -type f -name '*.ebuild' | sed -e 's|{}/||g' -e 's|.ebuild$||g'" | awk -F "/" '{print $1"/"$3}'
}
Em.getRepoPkgList() {
	local _RepoPath
	_RepoPath="$(Em.getRepoLocation "$1")"
	find "$_RepoPath" -mindepth 3 -maxdepth 3 -type f -name '*.ebuild' | sed -e "s|${_RepoPath%/}/||g" -e 's|.ebuild$||g' | awk -F "/" '{print $1"/"$3}'
}
Em.getRepoConf() {
	cat /etc/portage/repos.conf /etc/portage/repos.conf/* 2>/dev/null
}
Em.noVersion() {
	sed -E 's|\-[0-9]+.+||g'
}
Esc.return() {
	printf "\r" >/dev/tty
}
Esc.clearLeft() {
	printf "\033[1K" >/dev/tty
}
Esc.clearLine() {
	printf "\033[2K" >/dev/tty
}
Esc.clearScreen() {
	printf "\033[2J" >/dev/tty
}
Esc.clearRight() {
	printf "\033[0K" >/dev/tty
}
Esc.getTermY() {
	[[ -n ${LINES-""} ]] && echo "$LINES" && return 0
	tput lines
}
Esc.getX() {
	local _POS
	printf "\033[6n" >>/dev/tty
	read -r -s -d "R" _POS
	echo $(("$(printf "%s\n" "${_POS:2}" | cut -d";" -f2)" - 1))
}
Esc.getTermX() {
	[[ -n ${COLUMNS-""} ]] && echo "$COLUMNS" && return 0
	tput cols
}
Esc.moveCursorLeft() {
	printf "\033[%dD" "$1" >/dev/tty
}
Esc.getY() {
	local _POS
	printf "\033[6n" >>/dev/tty
	read -r -s -d "R" _POS
	echo $(("$(printf "%s\n" "${_POS:2}" | cut -d";" -f1)" - 1))
}
Esc.moveCursorDown() {
	printf "\033[%dB" "$1" >/dev/tty
}
Esc.moveCursorRight() {
	printf "\033[%dC" "$1" >/dev/tty
}
Esc.moveCursor() {
	printf "\033[%d;%dH" "$1" "$2" >/dev/tty
}
Esc.moveCursorUp() {
	printf "\033[%dA" "$1" >/dev/tty
}
Esc.clearLineAndReturn() {
	Esc.clearLine
	Esc.return
}
Esc.clearUpperLines() {
	for i in $(seq 1 "$1"); do
		Esc.moveCursorUp 1
		Esc.clearLine
	done
}
Esc.blackBackground() {
	printf "\033[40m" >/dev/tty
}
Esc.cyanBackground() {
	printf "\033[46m" >/dev/tty
}
Esc.greenBackground() {
	printf "\033[42m" >/dev/tty
}
Esc.magentaText() {
	printf "\033[35m" >/dev/tty
}
Esc.lowIntensity() {
	printf "\033[2m" >/dev/tty
}
Esc.blueText() {
	printf "\033[34m" >/dev/tty
}
Esc.redBackground() {
	printf "\033[41m" >/dev/tty
}
Esc.magentaBackground() {
	printf "\033[45m" >/dev/tty
}
Esc.greenText() {
	printf "\033[32m" >/dev/tty
}
Esc.italic() {
	printf "\033[3m" >/dev/tty
}
Esc.blink() {
	printf "\033[5m" >/dev/tty
}
Esc.yellowText() {
	printf "\033[33m" >/dev/tty
}
Esc.whiteBackground() {
	printf "\033[47m" >/dev/tty
}
Esc.reverse() {
	printf "\033[7m" >/dev/tty
}
Esc.redText() {
	printf "\033[31m" >/dev/tty
}
Esc.conceal() {
	printf "\033[8m" >/dev/tty
}
Esc.yellowBackground() {
	printf "\033[43m" >/dev/tty
}
Esc.crossedOut() {
	printf "\033[9m" >/dev/tty
}
Esc.underline() {
	printf "\033[4m" >/dev/tty
}
Esc.resetStyle() {
	printf "\033[0m" >/dev/tty
}
Esc.rapidBlink() {
	printf "\033[6m" >/dev/tty
}
Esc.cyanText() {
	printf "\033[36m" >/dev/tty
}
Esc.blueBackground() {
	printf "\033[44m" >/dev/tty
}
Esc.bold() {
	printf "\033[1m" >/dev/tty
}
Esc.whiteText() {
	printf "\033[37m" >/dev/tty
}
Esc.blackText() {
	printf "\033[30m" >/dev/tty
}
Arch.getKernelFileList() {
	find "/boot" -maxdepth 1 -mindepth 1 -name "vmlinuz-*"
}
Arch.getKernelSrcList() {
	find "/usr/src" -mindepth 1 -maxdepth 1 -type l -name "linux*"
}
Arch.getMkinitcpioPresetList() {
	find "/etc/mkinitcpio.d/" -name "*.preset" -type f | GetBaseName | RemoveFileExt
}
Array.shift() {
	readarray -t "$1" < <(PrintEvalArray "$1" | sed "1,${2-"1"}d")
}
Array.push() {
	eval "PrintArray \"\${$1[@]}\"" | grep -qx "$2" && return 0
	eval "$1+=(\"$2\")"
}
Array.append() {
	local _ArrName="$1"
	shift 1 || return 1
	readarray -t -O "$(ArrayIndex "$_ArrName")" "$_ArrName" < <(cat)
}
Array.remove() {
	readarray -t "$1" < <(PrintEvalArray "$1" | RemoveMatchLine "$2")
}
Array.pop() {
	readarray -t "$1" < <(PrintEvalArray "$1" | sed -e '$d')
}
Array.fromStr() {
	declare -a -x "$1"
	readarray -t "$1" < <(BreakChar)
}
Array.rev() {
	readarray -t "$1" < <(PrintEvalArray "$1" | tac)
}
Array.eval() {
	eval "PrintArray \"\${$1[@]}\""
}
Array.last() {
	PrintEval "$1[$(Array.lastIndex "$1")]"
}
Array.print() {
	(($# >= 1)) || return 0
	printf "%s\n" "${@}"
}
Array.length() {
	PrintEval "#${1}[@]"
}
Array.indexOf() {
	local n=()
	readarray -t n < <(grep -x -n "$1" | cut -d ":" -f 1 | ForEach eval echo '$(( {} - 1 ))')
	(("${#n[@]}" >= 1)) || return 1
	PrintArray "${n[@]}"
	return 0
}
Array.lastIndex() {
	CalcInt "$(Array.length "$1")" - 1
}
Array.forEach() {
	PrintEvalArray "$1" | ForEach "${@:2}"
}
Array.includes() {
	PrintEvalArray "$1" | grep -qx "$2"
}
Array.include() {
	Array.includes "$@"
}
Awk.print() {
	awk "BEGIN {print $*}"
}
Awk.pi() {
	Awk.float "atan2(0, -0)"
}
Awk.log() {
	Awk.float "log(${2}) / log($1)"
}
Awk.float() {
	awk "BEGIN {printf (\"%4.${AWKSCALE-"5"}f\n\", $*)}"
}
Awk.tan() {
	Awk.float "sin($1)/tan($1)"
}
Awk.sin() {
	Awk.float "sin($*)"
}
Awk.cos() {
	Awk.float "cos($*)"
}
Awk.rad() {
	Awk.float "$1 * $(Awk.pi) / 180 "
}
StrToCharList() {
	Array.FromStr "$1"
}
GetArrayIndex() {
	Array.IndexOf "$1"
}
ArrayIndex() {
	Array.Length "$1"
}
RevArray() {
	Array.Rev "$1"
}
ArrayAppend() {
	Array.Append "$1"
}
ArrayIncludes() {
	Array.Includes "$@"
}
PrintEvalArray() {
	Array.Eval "$1"
}
PrintArray() {
	Array.Print "$@"
}
AddNewToArray() {
	Array.Push "$@"
}
FileType() {
	file --mime-type -b "$1"
}
GetFileExt() {
	GetBaseName | rev | cut -d "." -f 1 | rev
}
RemoveFileExt() {
	local Ext
	ForEach eval 'Ext=$(GetFileExt <<< {}); sed "s|.$Ext$||g" <<< {}; unset Ext'
}
GetBaseName() {
	ForEach basename "{}"
}
CheckFuncDefined() {
	typeset -f "${1}" >/dev/null || return 1
}
IsAvailable() {
	type "$1" 2>/dev/null 1>&2
}
Loop() {
	local _T="$1"
	shift 1 || return 1
	((_T == 0)) && return 0
	ForEach "$@" < <(yes "" | head -n "$_T")
}
GetLine() {
	head -n "$1" | tail -n 1
}
ForEach() {
	local _Item
	while read -r _Item; do
		"${@//"{}"/"${_Item}"}" || return "${?}"
	done
}
BreakChar() {
	grep -o "."
}
ToLowerStdin() {
	local _Str
	ForEach eval '_Str="{}"; echo "${_Str,,}"'
	unset _Str
}
IsUUID() {
	local _UUID="${1-""}"
	[[ ${_UUID//-/} =~ ^[[:xdigit:]]{32}$ ]] && return 0
	return 1
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
GetMaxWidth() {
	awk '{ if ( length > x && length > 0 ) { x = length } }END{ print x }'
}
CutLastString() {
	echo "${1%%"${2}"}"
	return 0
}
GetLastSplitString() {
	rev <<<"$2" | cut -d "$1" -f 1 | rev
}
CalcInt() {
	echo "$(("$@"))"
}
Sum() {
	local _Arg=()
	ForEach eval '_Arg+=("{}" "+")' < <(PrintArray "$@")
	readarray -t _Arg < <(PrintArray "${_Arg[@]}" | sed "${#_Arg[@]}d")
	CalcInt "${_Arg[@]}"
}
Ntest() {
	(("$@")) || return 1
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
ToArgs() {
	readarray -t args
	"$@" "${args[@]}"
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
Cache.getTimeDiffFromLastUpdate() {
	local _Now _Last
	_Now="$(date "+%s")"
	_Last="$(Cache.getFileLastUpdate "$1")"
	echo "$((_Now - _Last))"
	return 0
}
Cache.get() {
	cat "$(Cache.getDir)/$1" 2>/dev/null || return 1
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
Cache.exist() {
	local _File
	_File="$(Cache.createDir)/$1"
	[[ -e $_File ]] || return 1
	(("$(Cache.getTimeDiffFromLastUpdate "$_File")" > "${KEEPCACHESEC-"86400"}")) && return 2
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
Cache.create() {
	Cache.createDir >/dev/null
	cat >"$(Cache.getDir)/${1}"
	cat "$(Cache.getDir)/$1"
}
Cache.createDir() {
	FSBLIB_CACHEID="${FSBLIB_CACHEID-"$(RandomString "10")"}"
	export FSBLIB_CACHEID="$FSBLIB_CACHEID"
	local TMPDIR="${TMPDIR-"/tmp"}"
	local _Dir="$TMPDIR/${FSBLIB_CACHEID}"
	mkdir -p "$_Dir"
	echo "$_Dir"
	return 0
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
fsblibEnvCheck() {
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
Csv.toBashArray() {
	local _RawCsvLine=() _Line _ClmCnt=0
	local ArrayPrefix="${ArrayPrefix-"{}"}"
	readarray -t _RawCsvLine < <(
		while read -r _Line; do
			(($(tr "${CSVDELIM-","}" "\n" <<<"$_Line" | wc -l) >= ${#})) && echo "$_Line"
		done < <(grep -v "^#")
	)
	_ClmCnt=$(PrintArray "${_RawCsvLine[@]}" | Csv.getClmCnt)
	while read -r _Cnt; do
		readarray -t "$(sed "s|{}|$(eval "echo \"\${${_Cnt}}\"")|g" <<<"$ArrayPrefix")" < <(
			PrintArray "${_RawCsvLine[@]}" | cut -d "${CSVDELIM-","}" -f "$_Cnt"
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
	done < <(PrintArray "${_RawCsvLine[@]}")
	RemoveBlank <<<"$_ClmCnt"
	return 0
}
Csv.getClm() {
	grep -v "^#" | sed "/^$/d" | cut -d "${CSVDELIM-","}" -f "$1"
}
Em.getWorldPkgList() {
	sed -E 's|:.+$||g' /var/lib/portage/world | xargs -I{} bash -c 'ls -d /var/db/pkg/{}-* | sed "s|/var/db/pkg/||g" | grep -E "{}-[0-9]"'
}
Em.getInstalledPkgList() {
	find /var/db/pkg/ -mindepth 2 -maxdepth 2 -type d | sed 's|/var/db/pkg/||g'
}
Em.getDefaultRepoName() {
	Em.getRepoConf | Ini.GetParam DEFAULT main-repo
}
Em.getRepoLocation() {
	Em.getRepoConf | Ini.GetParam "$1" location
}
Em.getAllPkgList() {
	Em.getRepoConf | sed -e 's/^ *//' -e 's/ *$//' | grep "^ *location *=" | sed -e 's/^location *= *//' | xargs -L1 realpath | xargs -I{} bash -c "find '{}' -mindepth 3 -maxdepth 3 -type f -name '*.ebuild' | sed -e 's|{}/||g' -e 's|.ebuild$||g'" | awk -F "/" '{print $1"/"$3}'
}
Em.getRepoPkgList() {
	local _RepoPath
	_RepoPath="$(Em.getRepoLocation "$1")"
	find "$_RepoPath" -mindepth 3 -maxdepth 3 -type f -name '*.ebuild' | sed -e "s|${_RepoPath%/}/||g" -e 's|.ebuild$||g' | awk -F "/" '{print $1"/"$3}'
}
Em.getRepoConf() {
	cat /etc/portage/repos.conf /etc/portage/repos.conf/* 2>/dev/null
}
Em.noVersion() {
	sed -E 's|\-[0-9]+.+||g'
}
Esc.return() {
	printf "\r" >/dev/tty
}
Esc.clearLeft() {
	printf "\033[1K" >/dev/tty
}
Esc.clearLine() {
	printf "\033[2K" >/dev/tty
}
Esc.clearScreen() {
	printf "\033[2J" >/dev/tty
}
Esc.clearRight() {
	printf "\033[0K" >/dev/tty
}
Esc.getTermY() {
	[[ -n ${LINES-""} ]] && echo "$LINES" && return 0
	tput lines
}
Esc.getX() {
	local _POS
	printf "\033[6n" >>/dev/tty
	read -r -s -d "R" _POS
	echo $(("$(printf "%s\n" "${_POS:2}" | cut -d";" -f2)" - 1))
}
Esc.getTermX() {
	[[ -n ${COLUMNS-""} ]] && echo "$COLUMNS" && return 0
	tput cols
}
Esc.moveCursorLeft() {
	printf "\033[%dD" "$1" >/dev/tty
}
Esc.getY() {
	local _POS
	printf "\033[6n" >>/dev/tty
	read -r -s -d "R" _POS
	echo $(("$(printf "%s\n" "${_POS:2}" | cut -d";" -f1)" - 1))
}
Esc.moveCursorDown() {
	printf "\033[%dB" "$1" >/dev/tty
}
Esc.moveCursorRight() {
	printf "\033[%dC" "$1" >/dev/tty
}
Esc.moveCursor() {
	printf "\033[%d;%dH" "$1" "$2" >/dev/tty
}
Esc.moveCursorUp() {
	printf "\033[%dA" "$1" >/dev/tty
}
Esc.clearLineAndReturn() {
	Esc.clearLine
	Esc.return
}
Esc.clearUpperLines() {
	for i in $(seq 1 "$1"); do
		Esc.moveCursorUp 1
		Esc.clearLine
	done
}
Esc.blackBackground() {
	printf "\033[40m" >/dev/tty
}
Esc.cyanBackground() {
	printf "\033[46m" >/dev/tty
}
Esc.greenBackground() {
	printf "\033[42m" >/dev/tty
}
Esc.magentaText() {
	printf "\033[35m" >/dev/tty
}
Esc.lowIntensity() {
	printf "\033[2m" >/dev/tty
}
Esc.blueText() {
	printf "\033[34m" >/dev/tty
}
Esc.redBackground() {
	printf "\033[41m" >/dev/tty
}
Esc.magentaBackground() {
	printf "\033[45m" >/dev/tty
}
Esc.greenText() {
	printf "\033[32m" >/dev/tty
}
Esc.italic() {
	printf "\033[3m" >/dev/tty
}
Esc.blink() {
	printf "\033[5m" >/dev/tty
}
Esc.yellowText() {
	printf "\033[33m" >/dev/tty
}
Esc.whiteBackground() {
	printf "\033[47m" >/dev/tty
}
Esc.reverse() {
	printf "\033[7m" >/dev/tty
}
Esc.redText() {
	printf "\033[31m" >/dev/tty
}
Esc.conceal() {
	printf "\033[8m" >/dev/tty
}
Esc.yellowBackground() {
	printf "\033[43m" >/dev/tty
}
Esc.crossedOut() {
	printf "\033[9m" >/dev/tty
}
Esc.underline() {
	printf "\033[4m" >/dev/tty
}
Esc.resetStyle() {
	printf "\033[0m" >/dev/tty
}
Esc.rapidBlink() {
	printf "\033[6m" >/dev/tty
}
Esc.cyanText() {
	printf "\033[36m" >/dev/tty
}
Esc.blueBackground() {
	printf "\033[44m" >/dev/tty
}
Esc.bold() {
	printf "\033[1m" >/dev/tty
}
Esc.whiteText() {
	printf "\033[37m" >/dev/tty
}
Esc.blackText() {
	printf "\033[30m" >/dev/tty
}
Ini.getLastParam() {
	Ini.getParamList "$1" | tail -n 1
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
	done < <(PrintArray "${_RawIniLine[@]}")
	return "$_Exit"
}
Ini.parseLine() {
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
	done < <(PrintArray "${_RawIniLine[@]}")
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
	done < <(PrintArray "${_RawIniLine[@]}")
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
	if ! PrintArray "${IniContents[@]}" | Ini.getParamList "$Section" | grep -qx "$Param"; then
		SectionLastParam="$(PrintEvalArray IniContents | Ini.getLastParam "$Section")"
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
Ini.setValue() {
	local IniContents=()
	local Section="$1" Param="$2"
	readarray -t IniContents
	readarray -t IniContents < <(PrintArray "${IniContents[@]}" | Ini.newSection "$Section" | Ini.newParam "$Section" "$Param")
	PrintEvalArray IniContents
}
Ini.newSection() {
	local IniContents=()
	local Section="$1"
	readarray -t IniContents
	if PrintArray "${IniContents[@]}" | Ini.getSectionList | grep -x "$Section" >/dev/null; then
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
Arch.getKernelFileList() {
	find "/boot" -maxdepth 1 -mindepth 1 -name "vmlinuz-*"
}
Arch.getKernelSrcList() {
	find "/usr/src" -mindepth 1 -maxdepth 1 -type l -name "linux*"
}
Arch.getMkinitcpioPresetList() {
	find "/etc/mkinitcpio.d/" -name "*.preset" -type f | GetBaseName | RemoveFileExt
}
Array.shift() {
	readarray -t "$1" < <(PrintEvalArray "$1" | sed "1,${2-"1"}d")
}
Array.push() {
	eval "PrintArray \"\${$1[@]}\"" | grep -qx "$2" && return 0
	eval "$1+=(\"$2\")"
}
Array.append() {
	local _ArrName="$1"
	shift 1 || return 1
	readarray -t -O "$(ArrayIndex "$_ArrName")" "$_ArrName" < <(cat)
}
Array.remove() {
	readarray -t "$1" < <(PrintEvalArray "$1" | RemoveMatchLine "$2")
}
Array.pop() {
	readarray -t "$1" < <(PrintEvalArray "$1" | sed -e '$d')
}
Array.fromStr() {
	declare -a -x "$1"
	readarray -t "$1" < <(BreakChar)
}
Array.rev() {
	readarray -t "$1" < <(PrintEvalArray "$1" | tac)
}
Array.eval() {
	eval "PrintArray \"\${$1[@]}\""
}
Array.last() {
	PrintEval "$1[$(Array.lastIndex "$1")]"
}
Array.print() {
	(($# >= 1)) || return 0
	printf "%s\n" "${@}"
}
Array.length() {
	PrintEval "#${1}[@]"
}
Array.indexOf() {
	local n=()
	readarray -t n < <(grep -x -n "$1" | cut -d ":" -f 1 | ForEach eval echo '$(( {} - 1 ))')
	(("${#n[@]}" >= 1)) || return 1
	PrintArray "${n[@]}"
	return 0
}
Array.lastIndex() {
	CalcInt "$(Array.length "$1")" - 1
}
Array.forEach() {
	PrintEvalArray "$1" | ForEach "${@:2}"
}
Array.includes() {
	PrintEvalArray "$1" | grep -qx "$2"
}
Array.include() {
	Array.includes "$@"
}
Awk.print() {
	awk "BEGIN {print $*}"
}
Awk.pi() {
	Awk.float "atan2(0, -0)"
}
Awk.log() {
	Awk.float "log(${2}) / log($1)"
}
Awk.float() {
	awk "BEGIN {printf (\"%4.${AWKSCALE-"5"}f\n\", $*)}"
}
Awk.tan() {
	Awk.float "sin($1)/tan($1)"
}
Awk.sin() {
	Awk.float "sin($*)"
}
Awk.cos() {
	Awk.float "cos($*)"
}
Awk.rad() {
	Awk.float "$1 * $(Awk.pi) / 180 "
}
StrToCharList() {
	Array.FromStr "$1"
}
GetArrayIndex() {
	Array.IndexOf "$1"
}
ArrayIndex() {
	Array.Length "$1"
}
RevArray() {
	Array.Rev "$1"
}
ArrayAppend() {
	Array.Append "$1"
}
ArrayIncludes() {
	Array.Includes "$@"
}
PrintEvalArray() {
	Array.Eval "$1"
}
PrintArray() {
	Array.Print "$@"
}
AddNewToArray() {
	Array.Push "$@"
}
FileType() {
	file --mime-type -b "$1"
}
GetFileExt() {
	GetBaseName | rev | cut -d "." -f 1 | rev
}
RemoveFileExt() {
	local Ext
	ForEach eval 'Ext=$(GetFileExt <<< {}); sed "s|.$Ext$||g" <<< {}; unset Ext'
}
GetBaseName() {
	ForEach basename "{}"
}
CheckFuncDefined() {
	typeset -f "${1}" >/dev/null || return 1
}
IsAvailable() {
	type "$1" 2>/dev/null 1>&2
}
Loop() {
	local _T="$1"
	shift 1 || return 1
	((_T == 0)) && return 0
	ForEach "$@" < <(yes "" | head -n "$_T")
}
GetLine() {
	head -n "$1" | tail -n 1
}
ForEach() {
	local _Item
	while read -r _Item; do
		"${@//"{}"/"${_Item}"}" || return "${?}"
	done
}
BreakChar() {
	grep -o "."
}
ToLowerStdin() {
	local _Str
	ForEach eval '_Str="{}"; echo "${_Str,,}"'
	unset _Str
}
IsUUID() {
	local _UUID="${1-""}"
	[[ ${_UUID//-/} =~ ^[[:xdigit:]]{32}$ ]] && return 0
	return 1
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
GetMaxWidth() {
	awk '{ if ( length > x && length > 0 ) { x = length } }END{ print x }'
}
CutLastString() {
	echo "${1%%"${2}"}"
	return 0
}
GetLastSplitString() {
	rev <<<"$2" | cut -d "$1" -f 1 | rev
}
CalcInt() {
	echo "$(("$@"))"
}
Sum() {
	local _Arg=()
	ForEach eval '_Arg+=("{}" "+")' < <(PrintArray "$@")
	readarray -t _Arg < <(PrintArray "${_Arg[@]}" | sed "${#_Arg[@]}d")
	CalcInt "${_Arg[@]}"
}
Ntest() {
	(("$@")) || return 1
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
ToArgs() {
	readarray -t args
	"$@" "${args[@]}"
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
Cache.getTimeDiffFromLastUpdate() {
	local _Now _Last
	_Now="$(date "+%s")"
	_Last="$(Cache.getFileLastUpdate "$1")"
	echo "$((_Now - _Last))"
	return 0
}
Cache.get() {
	cat "$(Cache.getDir)/$1" 2>/dev/null || return 1
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
Cache.exist() {
	local _File
	_File="$(Cache.createDir)/$1"
	[[ -e $_File ]] || return 1
	(("$(Cache.getTimeDiffFromLastUpdate "$_File")" > "${KEEPCACHESEC-"86400"}")) && return 2
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
Cache.create() {
	Cache.createDir >/dev/null
	cat >"$(Cache.getDir)/${1}"
	cat "$(Cache.getDir)/$1"
}
Cache.createDir() {
	FSBLIB_CACHEID="${FSBLIB_CACHEID-"$(RandomString "10")"}"
	export FSBLIB_CACHEID="$FSBLIB_CACHEID"
	local TMPDIR="${TMPDIR-"/tmp"}"
	local _Dir="$TMPDIR/${FSBLIB_CACHEID}"
	mkdir -p "$_Dir"
	echo "$_Dir"
	return 0
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
fsblibEnvCheck() {
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
Csv.toBashArray() {
	local _RawCsvLine=() _Line _ClmCnt=0
	local ArrayPrefix="${ArrayPrefix-"{}"}"
	readarray -t _RawCsvLine < <(
		while read -r _Line; do
			(($(tr "${CSVDELIM-","}" "\n" <<<"$_Line" | wc -l) >= ${#})) && echo "$_Line"
		done < <(grep -v "^#")
	)
	_ClmCnt=$(PrintArray "${_RawCsvLine[@]}" | Csv.getClmCnt)
	while read -r _Cnt; do
		readarray -t "$(sed "s|{}|$(eval "echo \"\${${_Cnt}}\"")|g" <<<"$ArrayPrefix")" < <(
			PrintArray "${_RawCsvLine[@]}" | cut -d "${CSVDELIM-","}" -f "$_Cnt"
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
	done < <(PrintArray "${_RawCsvLine[@]}")
	RemoveBlank <<<"$_ClmCnt"
	return 0
}
Csv.getClm() {
	grep -v "^#" | sed "/^$/d" | cut -d "${CSVDELIM-","}" -f "$1"
}
Em.getWorldPkgList() {
	sed -E 's|:.+$||g' /var/lib/portage/world | xargs -I{} bash -c 'ls -d /var/db/pkg/{}-* | sed "s|/var/db/pkg/||g" | grep -E "{}-[0-9]"'
}
Em.getInstalledPkgList() {
	find /var/db/pkg/ -mindepth 2 -maxdepth 2 -type d | sed 's|/var/db/pkg/||g'
}
Em.getDefaultRepoName() {
	Em.getRepoConf | Ini.GetParam DEFAULT main-repo
}
Em.getRepoLocation() {
	Em.getRepoConf | Ini.GetParam "$1" location
}
Em.getAllPkgList() {
	Em.getRepoConf | sed -e 's/^ *//' -e 's/ *$//' | grep "^ *location *=" | sed -e 's/^location *= *//' | xargs -L1 realpath | xargs -I{} bash -c "find '{}' -mindepth 3 -maxdepth 3 -type f -name '*.ebuild' | sed -e 's|{}/||g' -e 's|.ebuild$||g'" | awk -F "/" '{print $1"/"$3}'
}
Em.getRepoPkgList() {
	local _RepoPath
	_RepoPath="$(Em.getRepoLocation "$1")"
	find "$_RepoPath" -mindepth 3 -maxdepth 3 -type f -name '*.ebuild' | sed -e "s|${_RepoPath%/}/||g" -e 's|.ebuild$||g' | awk -F "/" '{print $1"/"$3}'
}
Em.getRepoConf() {
	cat /etc/portage/repos.conf /etc/portage/repos.conf/* 2>/dev/null
}
Em.noVersion() {
	sed -E 's|\-[0-9]+.+||g'
}
Esc.return() {
	printf "\r" >/dev/tty
}
Esc.clearLeft() {
	printf "\033[1K" >/dev/tty
}
Esc.clearLine() {
	printf "\033[2K" >/dev/tty
}
Esc.clearScreen() {
	printf "\033[2J" >/dev/tty
}
Esc.clearRight() {
	printf "\033[0K" >/dev/tty
}
Esc.getTermY() {
	[[ -n ${LINES-""} ]] && echo "$LINES" && return 0
	tput lines
}
Esc.getX() {
	local _POS
	printf "\033[6n" >>/dev/tty
	read -r -s -d "R" _POS
	echo $(("$(printf "%s\n" "${_POS:2}" | cut -d";" -f2)" - 1))
}
Esc.getTermX() {
	[[ -n ${COLUMNS-""} ]] && echo "$COLUMNS" && return 0
	tput cols
}
Esc.moveCursorLeft() {
	printf "\033[%dD" "$1" >/dev/tty
}
Esc.getY() {
	local _POS
	printf "\033[6n" >>/dev/tty
	read -r -s -d "R" _POS
	echo $(("$(printf "%s\n" "${_POS:2}" | cut -d";" -f1)" - 1))
}
Esc.moveCursorDown() {
	printf "\033[%dB" "$1" >/dev/tty
}
Esc.moveCursorRight() {
	printf "\033[%dC" "$1" >/dev/tty
}
Esc.moveCursor() {
	printf "\033[%d;%dH" "$1" "$2" >/dev/tty
}
Esc.moveCursorUp() {
	printf "\033[%dA" "$1" >/dev/tty
}
Esc.clearLineAndReturn() {
	Esc.clearLine
	Esc.return
}
Esc.clearUpperLines() {
	for i in $(seq 1 "$1"); do
		Esc.moveCursorUp 1
		Esc.clearLine
	done
}
Esc.blackBackground() {
	printf "\033[40m" >/dev/tty
}
Esc.cyanBackground() {
	printf "\033[46m" >/dev/tty
}
Esc.greenBackground() {
	printf "\033[42m" >/dev/tty
}
Esc.magentaText() {
	printf "\033[35m" >/dev/tty
}
Esc.lowIntensity() {
	printf "\033[2m" >/dev/tty
}
Esc.blueText() {
	printf "\033[34m" >/dev/tty
}
Esc.redBackground() {
	printf "\033[41m" >/dev/tty
}
Esc.magentaBackground() {
	printf "\033[45m" >/dev/tty
}
Esc.greenText() {
	printf "\033[32m" >/dev/tty
}
Esc.italic() {
	printf "\033[3m" >/dev/tty
}
Esc.blink() {
	printf "\033[5m" >/dev/tty
}
Esc.yellowText() {
	printf "\033[33m" >/dev/tty
}
Esc.whiteBackground() {
	printf "\033[47m" >/dev/tty
}
Esc.reverse() {
	printf "\033[7m" >/dev/tty
}
Esc.redText() {
	printf "\033[31m" >/dev/tty
}
Esc.conceal() {
	printf "\033[8m" >/dev/tty
}
Esc.yellowBackground() {
	printf "\033[43m" >/dev/tty
}
Esc.crossedOut() {
	printf "\033[9m" >/dev/tty
}
Esc.underline() {
	printf "\033[4m" >/dev/tty
}
Esc.resetStyle() {
	printf "\033[0m" >/dev/tty
}
Esc.rapidBlink() {
	printf "\033[6m" >/dev/tty
}
Esc.cyanText() {
	printf "\033[36m" >/dev/tty
}
Esc.blueBackground() {
	printf "\033[44m" >/dev/tty
}
Esc.bold() {
	printf "\033[1m" >/dev/tty
}
Esc.whiteText() {
	printf "\033[37m" >/dev/tty
}
Esc.blackText() {
	printf "\033[30m" >/dev/tty
}
Ini.getLastParam() {
	Ini.getParamList "$1" | tail -n 1
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
	done < <(PrintArray "${_RawIniLine[@]}")
	return "$_Exit"
}
Ini.parseLine() {
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
	done < <(PrintArray "${_RawIniLine[@]}")
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
	done < <(PrintArray "${_RawIniLine[@]}")
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
	if ! PrintArray "${IniContents[@]}" | Ini.getParamList "$Section" | grep -qx "$Param"; then
		SectionLastParam="$(PrintEvalArray IniContents | Ini.getLastParam "$Section")"
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
Ini.setValue() {
	local IniContents=()
	local Section="$1" Param="$2"
	readarray -t IniContents
	readarray -t IniContents < <(PrintArray "${IniContents[@]}" | Ini.newSection "$Section" | Ini.newParam "$Section" "$Param")
	PrintEvalArray IniContents
}
Ini.newSection() {
	local IniContents=()
	local Section="$1"
	readarray -t IniContents
	if PrintArray "${IniContents[@]}" | Ini.getSectionList | grep -x "$Section" >/dev/null; then
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
LibreTranslate.languages() {
	LibreTranslate.check || return 2
	curl -s "${LIBRETRANSLATE_URL}/languages" | jq -r '.[].code'
}
LibreTranslate.translateAuto() {
	LibreTranslate.check || return 2
	LibreTranslate.translate "${1:-""}" "$(LibreTranslate.detect "${1:-""}")" "${2:-""}"
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
Arch.getKernelFileList() {
	find "/boot" -maxdepth 1 -mindepth 1 -name "vmlinuz-*"
}
Arch.getKernelSrcList() {
	find "/usr/src" -mindepth 1 -maxdepth 1 -type l -name "linux*"
}
Arch.getMkinitcpioPresetList() {
	find "/etc/mkinitcpio.d/" -name "*.preset" -type f | GetBaseName | RemoveFileExt
}
Array.shift() {
	readarray -t "$1" < <(PrintEvalArray "$1" | sed "1,${2-"1"}d")
}
Array.push() {
	eval "PrintArray \"\${$1[@]}\"" | grep -qx "$2" && return 0
	eval "$1+=(\"$2\")"
}
Array.append() {
	local _ArrName="$1"
	shift 1 || return 1
	readarray -t -O "$(ArrayIndex "$_ArrName")" "$_ArrName" < <(cat)
}
Array.remove() {
	readarray -t "$1" < <(PrintEvalArray "$1" | RemoveMatchLine "$2")
}
Array.pop() {
	readarray -t "$1" < <(PrintEvalArray "$1" | sed -e '$d')
}
Array.fromStr() {
	declare -a -x "$1"
	readarray -t "$1" < <(BreakChar)
}
Array.rev() {
	readarray -t "$1" < <(PrintEvalArray "$1" | tac)
}
Array.eval() {
	eval "PrintArray \"\${$1[@]}\""
}
Array.last() {
	PrintEval "$1[$(Array.lastIndex "$1")]"
}
Array.print() {
	(($# >= 1)) || return 0
	printf "%s\n" "${@}"
}
Array.length() {
	PrintEval "#${1}[@]"
}
Array.indexOf() {
	local n=()
	readarray -t n < <(grep -x -n "$1" | cut -d ":" -f 1 | ForEach eval echo '$(( {} - 1 ))')
	(("${#n[@]}" >= 1)) || return 1
	PrintArray "${n[@]}"
	return 0
}
Array.lastIndex() {
	CalcInt "$(Array.length "$1")" - 1
}
Array.forEach() {
	PrintEvalArray "$1" | ForEach "${@:2}"
}
Array.includes() {
	PrintEvalArray "$1" | grep -qx "$2"
}
Array.include() {
	Array.includes "$@"
}
Awk.print() {
	awk "BEGIN {print $*}"
}
Awk.pi() {
	Awk.float "atan2(0, -0)"
}
Awk.log() {
	Awk.float "log(${2}) / log($1)"
}
Awk.float() {
	awk "BEGIN {printf (\"%4.${AWKSCALE-"5"}f\n\", $*)}"
}
Awk.tan() {
	Awk.float "sin($1)/tan($1)"
}
Awk.sin() {
	Awk.float "sin($*)"
}
Awk.cos() {
	Awk.float "cos($*)"
}
Awk.rad() {
	Awk.float "$1 * $(Awk.pi) / 180 "
}
StrToCharList() {
	Array.FromStr "$1"
}
GetArrayIndex() {
	Array.IndexOf "$1"
}
ArrayIndex() {
	Array.Length "$1"
}
RevArray() {
	Array.Rev "$1"
}
ArrayAppend() {
	Array.Append "$1"
}
ArrayIncludes() {
	Array.Includes "$@"
}
PrintEvalArray() {
	Array.Eval "$1"
}
PrintArray() {
	Array.Print "$@"
}
AddNewToArray() {
	Array.Push "$@"
}
FileType() {
	file --mime-type -b "$1"
}
GetFileExt() {
	GetBaseName | rev | cut -d "." -f 1 | rev
}
RemoveFileExt() {
	local Ext
	ForEach eval 'Ext=$(GetFileExt <<< {}); sed "s|.$Ext$||g" <<< {}; unset Ext'
}
GetBaseName() {
	ForEach basename "{}"
}
CheckFuncDefined() {
	typeset -f "${1}" >/dev/null || return 1
}
IsAvailable() {
	type "$1" 2>/dev/null 1>&2
}
Loop() {
	local _T="$1"
	shift 1 || return 1
	((_T == 0)) && return 0
	ForEach "$@" < <(yes "" | head -n "$_T")
}
GetLine() {
	head -n "$1" | tail -n 1
}
ForEach() {
	local _Item
	while read -r _Item; do
		"${@//"{}"/"${_Item}"}" || return "${?}"
	done
}
BreakChar() {
	grep -o "."
}
ToLowerStdin() {
	local _Str
	ForEach eval '_Str="{}"; echo "${_Str,,}"'
	unset _Str
}
IsUUID() {
	local _UUID="${1-""}"
	[[ ${_UUID//-/} =~ ^[[:xdigit:]]{32}$ ]] && return 0
	return 1
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
GetMaxWidth() {
	awk '{ if ( length > x && length > 0 ) { x = length } }END{ print x }'
}
CutLastString() {
	echo "${1%%"${2}"}"
	return 0
}
GetLastSplitString() {
	rev <<<"$2" | cut -d "$1" -f 1 | rev
}
CalcInt() {
	echo "$(("$@"))"
}
Sum() {
	local _Arg=()
	ForEach eval '_Arg+=("{}" "+")' < <(PrintArray "$@")
	readarray -t _Arg < <(PrintArray "${_Arg[@]}" | sed "${#_Arg[@]}d")
	CalcInt "${_Arg[@]}"
}
Ntest() {
	(("$@")) || return 1
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
ToArgs() {
	readarray -t args
	"$@" "${args[@]}"
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
Cache.getTimeDiffFromLastUpdate() {
	local _Now _Last
	_Now="$(date "+%s")"
	_Last="$(Cache.getFileLastUpdate "$1")"
	echo "$((_Now - _Last))"
	return 0
}
Cache.get() {
	cat "$(Cache.getDir)/$1" 2>/dev/null || return 1
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
Cache.exist() {
	local _File
	_File="$(Cache.createDir)/$1"
	[[ -e $_File ]] || return 1
	(("$(Cache.getTimeDiffFromLastUpdate "$_File")" > "${KEEPCACHESEC-"86400"}")) && return 2
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
Cache.create() {
	Cache.createDir >/dev/null
	cat >"$(Cache.getDir)/${1}"
	cat "$(Cache.getDir)/$1"
}
Cache.createDir() {
	FSBLIB_CACHEID="${FSBLIB_CACHEID-"$(RandomString "10")"}"
	export FSBLIB_CACHEID="$FSBLIB_CACHEID"
	local TMPDIR="${TMPDIR-"/tmp"}"
	local _Dir="$TMPDIR/${FSBLIB_CACHEID}"
	mkdir -p "$_Dir"
	echo "$_Dir"
	return 0
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
fsblibEnvCheck() {
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
Csv.toBashArray() {
	local _RawCsvLine=() _Line _ClmCnt=0
	local ArrayPrefix="${ArrayPrefix-"{}"}"
	readarray -t _RawCsvLine < <(
		while read -r _Line; do
			(($(tr "${CSVDELIM-","}" "\n" <<<"$_Line" | wc -l) >= ${#})) && echo "$_Line"
		done < <(grep -v "^#")
	)
	_ClmCnt=$(PrintArray "${_RawCsvLine[@]}" | Csv.getClmCnt)
	while read -r _Cnt; do
		readarray -t "$(sed "s|{}|$(eval "echo \"\${${_Cnt}}\"")|g" <<<"$ArrayPrefix")" < <(
			PrintArray "${_RawCsvLine[@]}" | cut -d "${CSVDELIM-","}" -f "$_Cnt"
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
	done < <(PrintArray "${_RawCsvLine[@]}")
	RemoveBlank <<<"$_ClmCnt"
	return 0
}
Csv.getClm() {
	grep -v "^#" | sed "/^$/d" | cut -d "${CSVDELIM-","}" -f "$1"
}
Em.getWorldPkgList() {
	sed -E 's|:.+$||g' /var/lib/portage/world | xargs -I{} bash -c 'ls -d /var/db/pkg/{}-* | sed "s|/var/db/pkg/||g" | grep -E "{}-[0-9]"'
}
Em.getInstalledPkgList() {
	find /var/db/pkg/ -mindepth 2 -maxdepth 2 -type d | sed 's|/var/db/pkg/||g'
}
Em.getDefaultRepoName() {
	Em.getRepoConf | Ini.GetParam DEFAULT main-repo
}
Em.getRepoLocation() {
	Em.getRepoConf | Ini.GetParam "$1" location
}
Em.getAllPkgList() {
	Em.getRepoConf | sed -e 's/^ *//' -e 's/ *$//' | grep "^ *location *=" | sed -e 's/^location *= *//' | xargs -L1 realpath | xargs -I{} bash -c "find '{}' -mindepth 3 -maxdepth 3 -type f -name '*.ebuild' | sed -e 's|{}/||g' -e 's|.ebuild$||g'" | awk -F "/" '{print $1"/"$3}'
}
Em.getRepoPkgList() {
	local _RepoPath
	_RepoPath="$(Em.getRepoLocation "$1")"
	find "$_RepoPath" -mindepth 3 -maxdepth 3 -type f -name '*.ebuild' | sed -e "s|${_RepoPath%/}/||g" -e 's|.ebuild$||g' | awk -F "/" '{print $1"/"$3}'
}
Em.getRepoConf() {
	cat /etc/portage/repos.conf /etc/portage/repos.conf/* 2>/dev/null
}
Em.noVersion() {
	sed -E 's|\-[0-9]+.+||g'
}
Esc.return() {
	printf "\r" >/dev/tty
}
Esc.clearLeft() {
	printf "\033[1K" >/dev/tty
}
Esc.clearLine() {
	printf "\033[2K" >/dev/tty
}
Esc.clearScreen() {
	printf "\033[2J" >/dev/tty
}
Esc.clearRight() {
	printf "\033[0K" >/dev/tty
}
Esc.getTermY() {
	[[ -n ${LINES-""} ]] && echo "$LINES" && return 0
	tput lines
}
Esc.getX() {
	local _POS
	printf "\033[6n" >>/dev/tty
	read -r -s -d "R" _POS
	echo $(("$(printf "%s\n" "${_POS:2}" | cut -d";" -f2)" - 1))
}
Esc.getTermX() {
	[[ -n ${COLUMNS-""} ]] && echo "$COLUMNS" && return 0
	tput cols
}
Esc.moveCursorLeft() {
	printf "\033[%dD" "$1" >/dev/tty
}
Esc.getY() {
	local _POS
	printf "\033[6n" >>/dev/tty
	read -r -s -d "R" _POS
	echo $(("$(printf "%s\n" "${_POS:2}" | cut -d";" -f1)" - 1))
}
Esc.moveCursorDown() {
	printf "\033[%dB" "$1" >/dev/tty
}
Esc.moveCursorRight() {
	printf "\033[%dC" "$1" >/dev/tty
}
Esc.moveCursor() {
	printf "\033[%d;%dH" "$1" "$2" >/dev/tty
}
Esc.moveCursorUp() {
	printf "\033[%dA" "$1" >/dev/tty
}
Esc.clearLineAndReturn() {
	Esc.clearLine
	Esc.return
}
Esc.clearUpperLines() {
	for i in $(seq 1 "$1"); do
		Esc.moveCursorUp 1
		Esc.clearLine
	done
}
Esc.blackBackground() {
	printf "\033[40m" >/dev/tty
}
Esc.cyanBackground() {
	printf "\033[46m" >/dev/tty
}
Esc.greenBackground() {
	printf "\033[42m" >/dev/tty
}
Esc.magentaText() {
	printf "\033[35m" >/dev/tty
}
Esc.lowIntensity() {
	printf "\033[2m" >/dev/tty
}
Esc.blueText() {
	printf "\033[34m" >/dev/tty
}
Esc.redBackground() {
	printf "\033[41m" >/dev/tty
}
Esc.magentaBackground() {
	printf "\033[45m" >/dev/tty
}
Esc.greenText() {
	printf "\033[32m" >/dev/tty
}
Esc.italic() {
	printf "\033[3m" >/dev/tty
}
Esc.blink() {
	printf "\033[5m" >/dev/tty
}
Esc.yellowText() {
	printf "\033[33m" >/dev/tty
}
Esc.whiteBackground() {
	printf "\033[47m" >/dev/tty
}
Esc.reverse() {
	printf "\033[7m" >/dev/tty
}
Esc.redText() {
	printf "\033[31m" >/dev/tty
}
Esc.conceal() {
	printf "\033[8m" >/dev/tty
}
Esc.yellowBackground() {
	printf "\033[43m" >/dev/tty
}
Esc.crossedOut() {
	printf "\033[9m" >/dev/tty
}
Esc.underline() {
	printf "\033[4m" >/dev/tty
}
Esc.resetStyle() {
	printf "\033[0m" >/dev/tty
}
Esc.rapidBlink() {
	printf "\033[6m" >/dev/tty
}
Esc.cyanText() {
	printf "\033[36m" >/dev/tty
}
Esc.blueBackground() {
	printf "\033[44m" >/dev/tty
}
Esc.bold() {
	printf "\033[1m" >/dev/tty
}
Esc.whiteText() {
	printf "\033[37m" >/dev/tty
}
Esc.blackText() {
	printf "\033[30m" >/dev/tty
}
Ini.getLastParam() {
	Ini.getParamList "$1" | tail -n 1
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
	done < <(PrintArray "${_RawIniLine[@]}")
	return "$_Exit"
}
Ini.parseLine() {
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
	done < <(PrintArray "${_RawIniLine[@]}")
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
	done < <(PrintArray "${_RawIniLine[@]}")
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
	if ! PrintArray "${IniContents[@]}" | Ini.getParamList "$Section" | grep -qx "$Param"; then
		SectionLastParam="$(PrintEvalArray IniContents | Ini.getLastParam "$Section")"
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
Ini.setValue() {
	local IniContents=()
	local Section="$1" Param="$2"
	readarray -t IniContents
	readarray -t IniContents < <(PrintArray "${IniContents[@]}" | Ini.newSection "$Section" | Ini.newParam "$Section" "$Param")
	PrintEvalArray IniContents
}
Ini.newSection() {
	local IniContents=()
	local Section="$1"
	readarray -t IniContents
	if PrintArray "${IniContents[@]}" | Ini.getSectionList | grep -x "$Section" >/dev/null; then
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
LibreTranslate.languages() {
	LibreTranslate.check || return 2
	curl -s "${LIBRETRANSLATE_URL}/languages" | jq -r '.[].code'
}
LibreTranslate.translateAuto() {
	LibreTranslate.check || return 2
	LibreTranslate.translate "${1:-""}" "$(LibreTranslate.detect "${1:-""}")" "${2:-""}"
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
Arch.getKernelFileList() {
	find "/boot" -maxdepth 1 -mindepth 1 -name "vmlinuz-*"
}
Arch.getKernelSrcList() {
	find "/usr/src" -mindepth 1 -maxdepth 1 -type l -name "linux*"
}
Arch.getMkinitcpioPresetList() {
	find "/etc/mkinitcpio.d/" -name "*.preset" -type f | GetBaseName | RemoveFileExt
}
Array.shift() {
	readarray -t "$1" < <(PrintEvalArray "$1" | sed "1,${2-"1"}d")
}
Array.push() {
	eval "PrintArray \"\${$1[@]}\"" | grep -qx "$2" && return 0
	eval "$1+=(\"$2\")"
}
Array.append() {
	local _ArrName="$1"
	shift 1 || return 1
	readarray -t -O "$(ArrayIndex "$_ArrName")" "$_ArrName" < <(cat)
}
Array.remove() {
	readarray -t "$1" < <(PrintEvalArray "$1" | RemoveMatchLine "$2")
}
Array.pop() {
	readarray -t "$1" < <(PrintEvalArray "$1" | sed -e '$d')
}
Array.fromStr() {
	declare -a -x "$1"
	readarray -t "$1" < <(BreakChar)
}
Array.rev() {
	readarray -t "$1" < <(PrintEvalArray "$1" | tac)
}
Array.eval() {
	eval "PrintArray \"\${$1[@]}\""
}
Array.last() {
	PrintEval "$1[$(Array.lastIndex "$1")]"
}
Array.print() {
	(($# >= 1)) || return 0
	printf "%s\n" "${@}"
}
Array.length() {
	PrintEval "#${1}[@]"
}
Array.indexOf() {
	local n=()
	readarray -t n < <(grep -x -n "$1" | cut -d ":" -f 1 | ForEach eval echo '$(( {} - 1 ))')
	(("${#n[@]}" >= 1)) || return 1
	PrintArray "${n[@]}"
	return 0
}
Array.lastIndex() {
	CalcInt "$(Array.length "$1")" - 1
}
Array.forEach() {
	PrintEvalArray "$1" | ForEach "${@:2}"
}
Array.includes() {
	PrintEvalArray "$1" | grep -qx "$2"
}
Array.include() {
	Array.includes "$@"
}
Awk.print() {
	awk "BEGIN {print $*}"
}
Awk.pi() {
	Awk.float "atan2(0, -0)"
}
Awk.log() {
	Awk.float "log(${2}) / log($1)"
}
Awk.float() {
	awk "BEGIN {printf (\"%4.${AWKSCALE-"5"}f\n\", $*)}"
}
Awk.tan() {
	Awk.float "sin($1)/tan($1)"
}
Awk.sin() {
	Awk.float "sin($*)"
}
Awk.cos() {
	Awk.float "cos($*)"
}
Awk.rad() {
	Awk.float "$1 * $(Awk.pi) / 180 "
}
StrToCharList() {
	Array.FromStr "$1"
}
GetArrayIndex() {
	Array.IndexOf "$1"
}
ArrayIndex() {
	Array.Length "$1"
}
RevArray() {
	Array.Rev "$1"
}
ArrayAppend() {
	Array.Append "$1"
}
ArrayIncludes() {
	Array.Includes "$@"
}
PrintEvalArray() {
	Array.Eval "$1"
}
PrintArray() {
	Array.Print "$@"
}
AddNewToArray() {
	Array.Push "$@"
}
FileType() {
	file --mime-type -b "$1"
}
GetFileExt() {
	GetBaseName | rev | cut -d "." -f 1 | rev
}
RemoveFileExt() {
	local Ext
	ForEach eval 'Ext=$(GetFileExt <<< {}); sed "s|.$Ext$||g" <<< {}; unset Ext'
}
GetBaseName() {
	ForEach basename "{}"
}
CheckFuncDefined() {
	typeset -f "${1}" >/dev/null || return 1
}
IsAvailable() {
	type "$1" 2>/dev/null 1>&2
}
Loop() {
	local _T="$1"
	shift 1 || return 1
	((_T == 0)) && return 0
	ForEach "$@" < <(yes "" | head -n "$_T")
}
GetLine() {
	head -n "$1" | tail -n 1
}
ForEach() {
	local _Item
	while read -r _Item; do
		"${@//"{}"/"${_Item}"}" || return "${?}"
	done
}
BreakChar() {
	grep -o "."
}
ToLowerStdin() {
	local _Str
	ForEach eval '_Str="{}"; echo "${_Str,,}"'
	unset _Str
}
IsUUID() {
	local _UUID="${1-""}"
	[[ ${_UUID//-/} =~ ^[[:xdigit:]]{32}$ ]] && return 0
	return 1
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
GetMaxWidth() {
	awk '{ if ( length > x && length > 0 ) { x = length } }END{ print x }'
}
CutLastString() {
	echo "${1%%"${2}"}"
	return 0
}
GetLastSplitString() {
	rev <<<"$2" | cut -d "$1" -f 1 | rev
}
CalcInt() {
	echo "$(("$@"))"
}
Sum() {
	local _Arg=()
	ForEach eval '_Arg+=("{}" "+")' < <(PrintArray "$@")
	readarray -t _Arg < <(PrintArray "${_Arg[@]}" | sed "${#_Arg[@]}d")
	CalcInt "${_Arg[@]}"
}
Ntest() {
	(("$@")) || return 1
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
ToArgs() {
	readarray -t args
	"$@" "${args[@]}"
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
Cache.getTimeDiffFromLastUpdate() {
	local _Now _Last
	_Now="$(date "+%s")"
	_Last="$(Cache.getFileLastUpdate "$1")"
	echo "$((_Now - _Last))"
	return 0
}
Cache.get() {
	cat "$(Cache.getDir)/$1" 2>/dev/null || return 1
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
Cache.exist() {
	local _File
	_File="$(Cache.createDir)/$1"
	[[ -e $_File ]] || return 1
	(("$(Cache.getTimeDiffFromLastUpdate "$_File")" > "${KEEPCACHESEC-"86400"}")) && return 2
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
Cache.create() {
	Cache.createDir >/dev/null
	cat >"$(Cache.getDir)/${1}"
	cat "$(Cache.getDir)/$1"
}
Cache.createDir() {
	FSBLIB_CACHEID="${FSBLIB_CACHEID-"$(RandomString "10")"}"
	export FSBLIB_CACHEID="$FSBLIB_CACHEID"
	local TMPDIR="${TMPDIR-"/tmp"}"
	local _Dir="$TMPDIR/${FSBLIB_CACHEID}"
	mkdir -p "$_Dir"
	echo "$_Dir"
	return 0
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
fsblibEnvCheck() {
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
Csv.toBashArray() {
	local _RawCsvLine=() _Line _ClmCnt=0
	local ArrayPrefix="${ArrayPrefix-"{}"}"
	readarray -t _RawCsvLine < <(
		while read -r _Line; do
			(($(tr "${CSVDELIM-","}" "\n" <<<"$_Line" | wc -l) >= ${#})) && echo "$_Line"
		done < <(grep -v "^#")
	)
	_ClmCnt=$(PrintArray "${_RawCsvLine[@]}" | Csv.getClmCnt)
	while read -r _Cnt; do
		readarray -t "$(sed "s|{}|$(eval "echo \"\${${_Cnt}}\"")|g" <<<"$ArrayPrefix")" < <(
			PrintArray "${_RawCsvLine[@]}" | cut -d "${CSVDELIM-","}" -f "$_Cnt"
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
	done < <(PrintArray "${_RawCsvLine[@]}")
	RemoveBlank <<<"$_ClmCnt"
	return 0
}
Csv.getClm() {
	grep -v "^#" | sed "/^$/d" | cut -d "${CSVDELIM-","}" -f "$1"
}
Em.getWorldPkgList() {
	sed -E 's|:.+$||g' /var/lib/portage/world | xargs -I{} bash -c 'ls -d /var/db/pkg/{}-* | sed "s|/var/db/pkg/||g" | grep -E "{}-[0-9]"'
}
Em.getInstalledPkgList() {
	find /var/db/pkg/ -mindepth 2 -maxdepth 2 -type d | sed 's|/var/db/pkg/||g'
}
Em.getDefaultRepoName() {
	Em.getRepoConf | Ini.GetParam DEFAULT main-repo
}
Em.getRepoLocation() {
	Em.getRepoConf | Ini.GetParam "$1" location
}
Em.getAllPkgList() {
	Em.getRepoConf | sed -e 's/^ *//' -e 's/ *$//' | grep "^ *location *=" | sed -e 's/^location *= *//' | xargs -L1 realpath | xargs -I{} bash -c "find '{}' -mindepth 3 -maxdepth 3 -type f -name '*.ebuild' | sed -e 's|{}/||g' -e 's|.ebuild$||g'" | awk -F "/" '{print $1"/"$3}'
}
Em.getRepoPkgList() {
	local _RepoPath
	_RepoPath="$(Em.getRepoLocation "$1")"
	find "$_RepoPath" -mindepth 3 -maxdepth 3 -type f -name '*.ebuild' | sed -e "s|${_RepoPath%/}/||g" -e 's|.ebuild$||g' | awk -F "/" '{print $1"/"$3}'
}
Em.getRepoConf() {
	cat /etc/portage/repos.conf /etc/portage/repos.conf/* 2>/dev/null
}
Em.noVersion() {
	sed -E 's|\-[0-9]+.+||g'
}
Esc.return() {
	printf "\r" >/dev/tty
}
Esc.clearLeft() {
	printf "\033[1K" >/dev/tty
}
Esc.clearLine() {
	printf "\033[2K" >/dev/tty
}
Esc.clearScreen() {
	printf "\033[2J" >/dev/tty
}
Esc.clearRight() {
	printf "\033[0K" >/dev/tty
}
Esc.getTermY() {
	[[ -n ${LINES-""} ]] && echo "$LINES" && return 0
	tput lines
}
Esc.getX() {
	local _POS
	printf "\033[6n" >>/dev/tty
	read -r -s -d "R" _POS
	echo $(("$(printf "%s\n" "${_POS:2}" | cut -d";" -f2)" - 1))
}
Esc.getTermX() {
	[[ -n ${COLUMNS-""} ]] && echo "$COLUMNS" && return 0
	tput cols
}
Esc.moveCursorLeft() {
	printf "\033[%dD" "$1" >/dev/tty
}
Esc.getY() {
	local _POS
	printf "\033[6n" >>/dev/tty
	read -r -s -d "R" _POS
	echo $(("$(printf "%s\n" "${_POS:2}" | cut -d";" -f1)" - 1))
}
Esc.moveCursorDown() {
	printf "\033[%dB" "$1" >/dev/tty
}
Esc.moveCursorRight() {
	printf "\033[%dC" "$1" >/dev/tty
}
Esc.moveCursor() {
	printf "\033[%d;%dH" "$1" "$2" >/dev/tty
}
Esc.moveCursorUp() {
	printf "\033[%dA" "$1" >/dev/tty
}
Esc.clearLineAndReturn() {
	Esc.clearLine
	Esc.return
}
Esc.clearUpperLines() {
	for i in $(seq 1 "$1"); do
		Esc.moveCursorUp 1
		Esc.clearLine
	done
}
Esc.blackBackground() {
	printf "\033[40m" >/dev/tty
}
Esc.cyanBackground() {
	printf "\033[46m" >/dev/tty
}
Esc.greenBackground() {
	printf "\033[42m" >/dev/tty
}
Esc.magentaText() {
	printf "\033[35m" >/dev/tty
}
Esc.lowIntensity() {
	printf "\033[2m" >/dev/tty
}
Esc.blueText() {
	printf "\033[34m" >/dev/tty
}
Esc.redBackground() {
	printf "\033[41m" >/dev/tty
}
Esc.magentaBackground() {
	printf "\033[45m" >/dev/tty
}
Esc.greenText() {
	printf "\033[32m" >/dev/tty
}
Esc.italic() {
	printf "\033[3m" >/dev/tty
}
Esc.blink() {
	printf "\033[5m" >/dev/tty
}
Esc.yellowText() {
	printf "\033[33m" >/dev/tty
}
Esc.whiteBackground() {
	printf "\033[47m" >/dev/tty
}
Esc.reverse() {
	printf "\033[7m" >/dev/tty
}
Esc.redText() {
	printf "\033[31m" >/dev/tty
}
Esc.conceal() {
	printf "\033[8m" >/dev/tty
}
Esc.yellowBackground() {
	printf "\033[43m" >/dev/tty
}
Esc.crossedOut() {
	printf "\033[9m" >/dev/tty
}
Esc.underline() {
	printf "\033[4m" >/dev/tty
}
Esc.resetStyle() {
	printf "\033[0m" >/dev/tty
}
Esc.rapidBlink() {
	printf "\033[6m" >/dev/tty
}
Esc.cyanText() {
	printf "\033[36m" >/dev/tty
}
Esc.blueBackground() {
	printf "\033[44m" >/dev/tty
}
Esc.bold() {
	printf "\033[1m" >/dev/tty
}
Esc.whiteText() {
	printf "\033[37m" >/dev/tty
}
Esc.blackText() {
	printf "\033[30m" >/dev/tty
}
Ini.getLastParam() {
	Ini.getParamList "$1" | tail -n 1
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
	done < <(PrintArray "${_RawIniLine[@]}")
	return "$_Exit"
}
Ini.parseLine() {
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
	done < <(PrintArray "${_RawIniLine[@]}")
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
	done < <(PrintArray "${_RawIniLine[@]}")
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
	if ! PrintArray "${IniContents[@]}" | Ini.getParamList "$Section" | grep -qx "$Param"; then
		SectionLastParam="$(PrintEvalArray IniContents | Ini.getLastParam "$Section")"
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
Ini.setValue() {
	local IniContents=()
	local Section="$1" Param="$2"
	readarray -t IniContents
	readarray -t IniContents < <(PrintArray "${IniContents[@]}" | Ini.newSection "$Section" | Ini.newParam "$Section" "$Param")
	PrintEvalArray IniContents
}
Ini.newSection() {
	local IniContents=()
	local Section="$1"
	readarray -t IniContents
	if PrintArray "${IniContents[@]}" | Ini.getSectionList | grep -x "$Section" >/dev/null; then
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
LibreTranslate.languages() {
	LibreTranslate.check || return 2
	curl -s "${LIBRETRANSLATE_URL}/languages" | jq -r '.[].code'
}
LibreTranslate.translateAuto() {
	LibreTranslate.check || return 2
	LibreTranslate.translate "${1:-""}" "$(LibreTranslate.detect "${1:-""}")" "${2:-""}"
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
Misskey.notes.Renotes() {
	Misskey.bindingBase "notes/renotes" noteId limit sinceId untilId -- "$@"
}
Misskey.notes.Search() {
	Misskey.bindingBase "notes/search" query limit -- "$@"
}
Misskey.notes.Create() {
	Misskey.bindingBase "notes/create" text -- "$@"
}
Misskey.users.GetFrequentlyRepliedUsers() {
	Misskey.bindingBase "users/get-frequently-replied-users" userId -- "${1:-"$(Misskey.myId)"}" "${@:2}"
}
Misskey.users.Stats() {
	Misskey.bindingBase "users/stats" userId -- "${1:-"$(Misskey.myId)"}" "${@:2}"
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
Misskey.sendReq() {
	local _Url="$1" _CurlArgs=()
	shift 1
	_CurlArgs+=(-s -L)
	_CurlArgs+=(-X POST)
	_CurlArgs+=(-H "Content-Type: application/json")
	_CurlArgs+=(-d "$(Misskey.makeJson "$@")")
	_CurlArgs+=("$_Url")
	Msg.Debug "Run: ${_CurlArgs[*]//"${MISSKEY_TOKEN}"/"TOKEN"}"
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
	if ! Bool _Shifted; then
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
Misskey.isAdmin() {
	Bool "$(Misskey.i | jq -r ".isAdmin")"
}
Misskey.myId() {
	Misskey.i | jq -r ".id"
}
Misskey.myUserName() {
	Misskey.i | jq -r ".username"
}
Misskey.myName() {
	Misskey.i | jq -r ".name"
}
Arch.getKernelFileList() {
	find "/boot" -maxdepth 1 -mindepth 1 -name "vmlinuz-*"
}
Arch.getKernelSrcList() {
	find "/usr/src" -mindepth 1 -maxdepth 1 -type l -name "linux*"
}
Arch.getMkinitcpioPresetList() {
	find "/etc/mkinitcpio.d/" -name "*.preset" -type f | GetBaseName | RemoveFileExt
}
Array.shift() {
	readarray -t "$1" < <(PrintEvalArray "$1" | sed "1,${2-"1"}d")
}
Array.push() {
	eval "PrintArray \"\${$1[@]}\"" | grep -qx "$2" && return 0
	eval "$1+=(\"$2\")"
}
Array.append() {
	local _ArrName="$1"
	shift 1 || return 1
	readarray -t -O "$(ArrayIndex "$_ArrName")" "$_ArrName" < <(cat)
}
Array.remove() {
	readarray -t "$1" < <(PrintEvalArray "$1" | RemoveMatchLine "$2")
}
Array.pop() {
	readarray -t "$1" < <(PrintEvalArray "$1" | sed -e '$d')
}
Array.fromStr() {
	declare -a -x "$1"
	readarray -t "$1" < <(BreakChar)
}
Array.rev() {
	readarray -t "$1" < <(PrintEvalArray "$1" | tac)
}
Array.eval() {
	eval "PrintArray \"\${$1[@]}\""
}
Array.last() {
	PrintEval "$1[$(Array.lastIndex "$1")]"
}
Array.print() {
	(($# >= 1)) || return 0
	printf "%s\n" "${@}"
}
Array.length() {
	PrintEval "#${1}[@]"
}
Array.indexOf() {
	local n=()
	readarray -t n < <(grep -x -n "$1" | cut -d ":" -f 1 | ForEach eval echo '$(( {} - 1 ))')
	(("${#n[@]}" >= 1)) || return 1
	PrintArray "${n[@]}"
	return 0
}
Array.lastIndex() {
	CalcInt "$(Array.length "$1")" - 1
}
Array.forEach() {
	PrintEvalArray "$1" | ForEach "${@:2}"
}
Array.includes() {
	PrintEvalArray "$1" | grep -qx "$2"
}
Array.include() {
	Array.includes "$@"
}
Awk.print() {
	awk "BEGIN {print $*}"
}
Awk.pi() {
	Awk.float "atan2(0, -0)"
}
Awk.log() {
	Awk.float "log(${2}) / log($1)"
}
Awk.float() {
	awk "BEGIN {printf (\"%4.${AWKSCALE-"5"}f\n\", $*)}"
}
Awk.tan() {
	Awk.float "sin($1)/tan($1)"
}
Awk.sin() {
	Awk.float "sin($*)"
}
Awk.cos() {
	Awk.float "cos($*)"
}
Awk.rad() {
	Awk.float "$1 * $(Awk.pi) / 180 "
}
StrToCharList() {
	Array.FromStr "$1"
}
GetArrayIndex() {
	Array.IndexOf "$1"
}
ArrayIndex() {
	Array.Length "$1"
}
RevArray() {
	Array.Rev "$1"
}
ArrayAppend() {
	Array.Append "$1"
}
ArrayIncludes() {
	Array.Includes "$@"
}
PrintEvalArray() {
	Array.Eval "$1"
}
PrintArray() {
	Array.Print "$@"
}
AddNewToArray() {
	Array.Push "$@"
}
FileType() {
	file --mime-type -b "$1"
}
GetFileExt() {
	GetBaseName | rev | cut -d "." -f 1 | rev
}
RemoveFileExt() {
	local Ext
	ForEach eval 'Ext=$(GetFileExt <<< {}); sed "s|.$Ext$||g" <<< {}; unset Ext'
}
GetBaseName() {
	ForEach basename "{}"
}
CheckFuncDefined() {
	typeset -f "${1}" >/dev/null || return 1
}
IsAvailable() {
	type "$1" 2>/dev/null 1>&2
}
Loop() {
	local _T="$1"
	shift 1 || return 1
	((_T == 0)) && return 0
	ForEach "$@" < <(yes "" | head -n "$_T")
}
GetLine() {
	head -n "$1" | tail -n 1
}
ForEach() {
	local _Item
	while read -r _Item; do
		"${@//"{}"/"${_Item}"}" || return "${?}"
	done
}
BreakChar() {
	grep -o "."
}
ToLowerStdin() {
	local _Str
	ForEach eval '_Str="{}"; echo "${_Str,,}"'
	unset _Str
}
IsUUID() {
	local _UUID="${1-""}"
	[[ ${_UUID//-/} =~ ^[[:xdigit:]]{32}$ ]] && return 0
	return 1
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
GetMaxWidth() {
	awk '{ if ( length > x && length > 0 ) { x = length } }END{ print x }'
}
CutLastString() {
	echo "${1%%"${2}"}"
	return 0
}
GetLastSplitString() {
	rev <<<"$2" | cut -d "$1" -f 1 | rev
}
CalcInt() {
	echo "$(("$@"))"
}
Sum() {
	local _Arg=()
	ForEach eval '_Arg+=("{}" "+")' < <(PrintArray "$@")
	readarray -t _Arg < <(PrintArray "${_Arg[@]}" | sed "${#_Arg[@]}d")
	CalcInt "${_Arg[@]}"
}
Ntest() {
	(("$@")) || return 1
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
ToArgs() {
	readarray -t args
	"$@" "${args[@]}"
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
Cache.getTimeDiffFromLastUpdate() {
	local _Now _Last
	_Now="$(date "+%s")"
	_Last="$(Cache.getFileLastUpdate "$1")"
	echo "$((_Now - _Last))"
	return 0
}
Cache.get() {
	cat "$(Cache.getDir)/$1" 2>/dev/null || return 1
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
Cache.exist() {
	local _File
	_File="$(Cache.createDir)/$1"
	[[ -e $_File ]] || return 1
	(("$(Cache.getTimeDiffFromLastUpdate "$_File")" > "${KEEPCACHESEC-"86400"}")) && return 2
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
Cache.create() {
	Cache.createDir >/dev/null
	cat >"$(Cache.getDir)/${1}"
	cat "$(Cache.getDir)/$1"
}
Cache.createDir() {
	FSBLIB_CACHEID="${FSBLIB_CACHEID-"$(RandomString "10")"}"
	export FSBLIB_CACHEID="$FSBLIB_CACHEID"
	local TMPDIR="${TMPDIR-"/tmp"}"
	local _Dir="$TMPDIR/${FSBLIB_CACHEID}"
	mkdir -p "$_Dir"
	echo "$_Dir"
	return 0
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
fsblibEnvCheck() {
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
Csv.toBashArray() {
	local _RawCsvLine=() _Line _ClmCnt=0
	local ArrayPrefix="${ArrayPrefix-"{}"}"
	readarray -t _RawCsvLine < <(
		while read -r _Line; do
			(($(tr "${CSVDELIM-","}" "\n" <<<"$_Line" | wc -l) >= ${#})) && echo "$_Line"
		done < <(grep -v "^#")
	)
	_ClmCnt=$(PrintArray "${_RawCsvLine[@]}" | Csv.getClmCnt)
	while read -r _Cnt; do
		readarray -t "$(sed "s|{}|$(eval "echo \"\${${_Cnt}}\"")|g" <<<"$ArrayPrefix")" < <(
			PrintArray "${_RawCsvLine[@]}" | cut -d "${CSVDELIM-","}" -f "$_Cnt"
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
	done < <(PrintArray "${_RawCsvLine[@]}")
	RemoveBlank <<<"$_ClmCnt"
	return 0
}
Csv.getClm() {
	grep -v "^#" | sed "/^$/d" | cut -d "${CSVDELIM-","}" -f "$1"
}
Em.getWorldPkgList() {
	sed -E 's|:.+$||g' /var/lib/portage/world | xargs -I{} bash -c 'ls -d /var/db/pkg/{}-* | sed "s|/var/db/pkg/||g" | grep -E "{}-[0-9]"'
}
Em.getInstalledPkgList() {
	find /var/db/pkg/ -mindepth 2 -maxdepth 2 -type d | sed 's|/var/db/pkg/||g'
}
Em.getDefaultRepoName() {
	Em.getRepoConf | Ini.GetParam DEFAULT main-repo
}
Em.getRepoLocation() {
	Em.getRepoConf | Ini.GetParam "$1" location
}
Em.getAllPkgList() {
	Em.getRepoConf | sed -e 's/^ *//' -e 's/ *$//' | grep "^ *location *=" | sed -e 's/^location *= *//' | xargs -L1 realpath | xargs -I{} bash -c "find '{}' -mindepth 3 -maxdepth 3 -type f -name '*.ebuild' | sed -e 's|{}/||g' -e 's|.ebuild$||g'" | awk -F "/" '{print $1"/"$3}'
}
Em.getRepoPkgList() {
	local _RepoPath
	_RepoPath="$(Em.getRepoLocation "$1")"
	find "$_RepoPath" -mindepth 3 -maxdepth 3 -type f -name '*.ebuild' | sed -e "s|${_RepoPath%/}/||g" -e 's|.ebuild$||g' | awk -F "/" '{print $1"/"$3}'
}
Em.getRepoConf() {
	cat /etc/portage/repos.conf /etc/portage/repos.conf/* 2>/dev/null
}
Em.noVersion() {
	sed -E 's|\-[0-9]+.+||g'
}
Esc.return() {
	printf "\r" >/dev/tty
}
Esc.clearLeft() {
	printf "\033[1K" >/dev/tty
}
Esc.clearLine() {
	printf "\033[2K" >/dev/tty
}
Esc.clearScreen() {
	printf "\033[2J" >/dev/tty
}
Esc.clearRight() {
	printf "\033[0K" >/dev/tty
}
Esc.getTermY() {
	[[ -n ${LINES-""} ]] && echo "$LINES" && return 0
	tput lines
}
Esc.getX() {
	local _POS
	printf "\033[6n" >>/dev/tty
	read -r -s -d "R" _POS
	echo $(("$(printf "%s\n" "${_POS:2}" | cut -d";" -f2)" - 1))
}
Esc.getTermX() {
	[[ -n ${COLUMNS-""} ]] && echo "$COLUMNS" && return 0
	tput cols
}
Esc.moveCursorLeft() {
	printf "\033[%dD" "$1" >/dev/tty
}
Esc.getY() {
	local _POS
	printf "\033[6n" >>/dev/tty
	read -r -s -d "R" _POS
	echo $(("$(printf "%s\n" "${_POS:2}" | cut -d";" -f1)" - 1))
}
Esc.moveCursorDown() {
	printf "\033[%dB" "$1" >/dev/tty
}
Esc.moveCursorRight() {
	printf "\033[%dC" "$1" >/dev/tty
}
Esc.moveCursor() {
	printf "\033[%d;%dH" "$1" "$2" >/dev/tty
}
Esc.moveCursorUp() {
	printf "\033[%dA" "$1" >/dev/tty
}
Esc.clearLineAndReturn() {
	Esc.clearLine
	Esc.return
}
Esc.clearUpperLines() {
	for i in $(seq 1 "$1"); do
		Esc.moveCursorUp 1
		Esc.clearLine
	done
}
Esc.blackBackground() {
	printf "\033[40m" >/dev/tty
}
Esc.cyanBackground() {
	printf "\033[46m" >/dev/tty
}
Esc.greenBackground() {
	printf "\033[42m" >/dev/tty
}
Esc.magentaText() {
	printf "\033[35m" >/dev/tty
}
Esc.lowIntensity() {
	printf "\033[2m" >/dev/tty
}
Esc.blueText() {
	printf "\033[34m" >/dev/tty
}
Esc.redBackground() {
	printf "\033[41m" >/dev/tty
}
Esc.magentaBackground() {
	printf "\033[45m" >/dev/tty
}
Esc.greenText() {
	printf "\033[32m" >/dev/tty
}
Esc.italic() {
	printf "\033[3m" >/dev/tty
}
Esc.blink() {
	printf "\033[5m" >/dev/tty
}
Esc.yellowText() {
	printf "\033[33m" >/dev/tty
}
Esc.whiteBackground() {
	printf "\033[47m" >/dev/tty
}
Esc.reverse() {
	printf "\033[7m" >/dev/tty
}
Esc.redText() {
	printf "\033[31m" >/dev/tty
}
Esc.conceal() {
	printf "\033[8m" >/dev/tty
}
Esc.yellowBackground() {
	printf "\033[43m" >/dev/tty
}
Esc.crossedOut() {
	printf "\033[9m" >/dev/tty
}
Esc.underline() {
	printf "\033[4m" >/dev/tty
}
Esc.resetStyle() {
	printf "\033[0m" >/dev/tty
}
Esc.rapidBlink() {
	printf "\033[6m" >/dev/tty
}
Esc.cyanText() {
	printf "\033[36m" >/dev/tty
}
Esc.blueBackground() {
	printf "\033[44m" >/dev/tty
}
Esc.bold() {
	printf "\033[1m" >/dev/tty
}
Esc.whiteText() {
	printf "\033[37m" >/dev/tty
}
Esc.blackText() {
	printf "\033[30m" >/dev/tty
}
Ini.getLastParam() {
	Ini.getParamList "$1" | tail -n 1
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
	done < <(PrintArray "${_RawIniLine[@]}")
	return "$_Exit"
}
Ini.parseLine() {
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
	done < <(PrintArray "${_RawIniLine[@]}")
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
	done < <(PrintArray "${_RawIniLine[@]}")
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
	if ! PrintArray "${IniContents[@]}" | Ini.getParamList "$Section" | grep -qx "$Param"; then
		SectionLastParam="$(PrintEvalArray IniContents | Ini.getLastParam "$Section")"
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
Ini.setValue() {
	local IniContents=()
	local Section="$1" Param="$2"
	readarray -t IniContents
	readarray -t IniContents < <(PrintArray "${IniContents[@]}" | Ini.newSection "$Section" | Ini.newParam "$Section" "$Param")
	PrintEvalArray IniContents
}
Ini.newSection() {
	local IniContents=()
	local Section="$1"
	readarray -t IniContents
	if PrintArray "${IniContents[@]}" | Ini.getSectionList | grep -x "$Section" >/dev/null; then
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
LibreTranslate.languages() {
	LibreTranslate.check || return 2
	curl -s "${LIBRETRANSLATE_URL}/languages" | jq -r '.[].code'
}
LibreTranslate.translateAuto() {
	LibreTranslate.check || return 2
	LibreTranslate.translate "${1:-""}" "$(LibreTranslate.detect "${1:-""}")" "${2:-""}"
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
Misskey.notes.Renotes() {
	Misskey.bindingBase "notes/renotes" noteId limit sinceId untilId -- "$@"
}
Misskey.notes.Search() {
	Misskey.bindingBase "notes/search" query limit -- "$@"
}
Misskey.notes.Create() {
	Misskey.bindingBase "notes/create" text -- "$@"
}
Misskey.users.GetFrequentlyRepliedUsers() {
	Misskey.bindingBase "users/get-frequently-replied-users" userId -- "${1:-"$(Misskey.myId)"}" "${@:2}"
}
Misskey.users.Stats() {
	Misskey.bindingBase "users/stats" userId -- "${1:-"$(Misskey.myId)"}" "${@:2}"
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
Misskey.sendReq() {
	local _Url="$1" _CurlArgs=()
	shift 1
	_CurlArgs+=(-s -L)
	_CurlArgs+=(-X POST)
	_CurlArgs+=(-H "Content-Type: application/json")
	_CurlArgs+=(-d "$(Misskey.makeJson "$@")")
	_CurlArgs+=("$_Url")
	Msg.Debug "Run: ${_CurlArgs[*]//"${MISSKEY_TOKEN}"/"TOKEN"}"
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
	if ! Bool _Shifted; then
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
Misskey.isAdmin() {
	Bool "$(Misskey.i | jq -r ".isAdmin")"
}
Misskey.myId() {
	Misskey.i | jq -r ".id"
}
Misskey.myUserName() {
	Misskey.i | jq -r ".username"
}
Misskey.myName() {
	Misskey.i | jq -r ".name"
}
Pm.checkPkg() {
	local p
	for p in "$@"; do
		Pm.run -Qq "$p" >/dev/null 2>&1 || return 1
	done
	return 0
}
Pm.getKeyringList() {
	find "$(@GetKeyringDir)" -name "*.gpg" | GetBaseName | RemoveFileExt
}
Pm.getRepoListFromConf() {
	Pm.getConfig --repo-list
}
Pm.getRepoPkgList() {
	Pm.run -Slq "$@"
}
Pm.isRepoPkg() {
	Pm.run -Slq | grep -qx "$(Pm.getName <<<"$1")"
}
Pm.getRoot() {
	Pm.getConfig RootDir
}
Pm.getRepoConf() {
	ForEach eval 'echo [{}] && Pm.getConfig -r {}'
}
Pm.getPacmanKernelPkg() {
	echo "there is nothing"
}
Pm.getRepoServer() {
	ForEach eval 'Pm.getConfig -r {}' | grep "^Server" | ForEach eval "Ini.ParseLine <<< '{}' ; printf '%s\n' \${VALUE}"
}
Pm.getPacmanKeyringDir() {
	local _KeyringDir=""
	_KeyringDir="$(LANG=C pacman-key -h | RemoveBlank | grep -A 1 -- "^--populate" | tail -n 1 | cut -d "/" -f 2- | sed "s|'$||g")"
	: "${_KeyringDir="usr/share/pacman/keyrings"}"
	_KeyringDir="$(Pm.getRoot)/$_KeyringDir"
	_KeyringDir="$(sed -E "s|/+|/|g" <<<"$_KeyringDir")"
	if [[ -e $_KeyringDir ]]; then
		Readlinkf "$_KeyringDir"
	else
		echo "$_KeyringDir"
	fi
}
Pm.getRepoVer() {
	Pm.run -Sp --print-format '%v' "$1"
}
Pm.run() {
	pacman --noconfirm --config "${PACMAN_CONF-"/etc/pacman.conf"}" "$@"
}
Pm.runKey() {
	pacman-key --config "${PACMAN_CONF-"/etc/pacman.conf"}" "$@"
}
Pm.getName() {
	cut -d "<" -f 1 | cut -d ">" -f 1 | cut -d "=" -f 1
}
Pm.getLatestPkgVer() {
	local _LANG="${LANG-""}"
	export LANG=C
	if [[ -z ${*} ]]; then
		cat
	else
		PrintArray "$@"
	fi | ForEach Pm.run -Si "{}" | grep "^Version" | cut -d ":" -f 2 | RemoveBlank
	[[ -n $_LANG ]] && export LANG="$_LANG"
	return 0
}
Pm.getInstalledPkgVer() {
	if [[ -z ${*} ]]; then
		cat
	else
		PrintArray "$@"
	fi | ForEach pacman -Q "{}" | cut -d " " -f 2
	PrintArray "${PIPESTATUS[@]}" | grep -qx "1" && return 1
	return 0
}
Pm.getConfig() {
	LANG=C pacman-conf --config="${PACMAN_CONF-"/etc/pacman.conf"}" "$@"
}
Pm.pacmanGpg() {
	gpg --homedir "$(Pm.getConfig GPGDir)" "$@"
}
Pm.getDbSectionList() {
	grep -E "^%.*%$"
}
Pm.getDbNextSection() {
	Pm.getDbSectionList | grep -x -A 1 "^%$1%$" | GetLine 2 | sed "s|^%||g; s|%$||g"
}
Pm.getDbSection() {
	readarray -t _Stdin
	PrintArray "${_Stdin[@]}" | sed -ne "/^%$1%$/,/^%$(PrintEvalArray _Stdin | Pm.getDbNextSection "$1")%$/p" | sed '1d; $d'
}
Pm.isOpendSyncDb() {
	readarray -t _PkgDbList < <(find "$(Pm.getDbTmpDir)/sync/$1" -mindepth 1 -maxdepth 1 -type d)
	(("${#_PkgDbList[@]}" > 0)) && return 0
	return 1
}
Pm.createDbTmpDir() {
	mkdir -p "$(Pm.getDbTmpDir)"
}
Pm.getRepoListFromLocalDb() {
	find "$(Pm.getConfig DBPath)/sync" -mindepth 1 -maxdepth 1 -type f | GetBaseName | sed "s|.db$||g"
	return 0
}
Pm.getSyncDbDescPath() {
	local _repo
	_repo="$(pacman -Sp --print-format '%r' "$1")"
	{
		IsPacmanSyncDbOpend "$_repo" || OpenPacmanSyncDb "$_repo"
	} || return 1
	echo "$(Pm.getDbTmpDir)/sync/$(pacman -Sp --print-format '%r/%n-%v' "$1")"
}
Pm.openedSyncDbList() {
	find "$(Pm.getDbTmpDir)/sync/" -mindepth 1 -maxdepth 1 -type d
}
Pm.getSyncAllDesc() {
	find "$(Pm.getDbTmpDir)" -mindepth 3 -maxdepth 3 -name "desc" -type f
}
Pm.parsePkgFileName() {
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
Pm.getVirtualPkgList() {
	Pm.getRepoListFromLocalDb | ForEach Pm.openSyncDb {}
	Pm.getSyncAllDesc | ForEach eval "Pm.getDbSection PROVIDES < {}" | RemoveBlank
}
Pm.getPkgArch() {
	Pm.getSyncDbDesc "$1" | Pm.getDbSection ARCH | RemoveBlank
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
Pm.getSyncDbDesc() {
	local _path
	_path="$(Pm.getSyncDbDescPath "$1")"
	[[ -e $_path ]] || return 1
	cat "$_path/desc"
}
Pm.getDbTmpDir() {
	echo "${TMPDIR-"/tmp"}/fasbashlib-pacman-db"
}
Pm.deleteDbTmpDir() {
	rm -rf "$(Pm.getDbTmpDir)"
}
Arch.getKernelFileList() {
	find "/boot" -maxdepth 1 -mindepth 1 -name "vmlinuz-*"
}
Arch.getKernelSrcList() {
	find "/usr/src" -mindepth 1 -maxdepth 1 -type l -name "linux*"
}
Arch.getMkinitcpioPresetList() {
	find "/etc/mkinitcpio.d/" -name "*.preset" -type f | GetBaseName | RemoveFileExt
}
Array.shift() {
	readarray -t "$1" < <(PrintEvalArray "$1" | sed "1,${2-"1"}d")
}
Array.push() {
	eval "PrintArray \"\${$1[@]}\"" | grep -qx "$2" && return 0
	eval "$1+=(\"$2\")"
}
Array.append() {
	local _ArrName="$1"
	shift 1 || return 1
	readarray -t -O "$(ArrayIndex "$_ArrName")" "$_ArrName" < <(cat)
}
Array.remove() {
	readarray -t "$1" < <(PrintEvalArray "$1" | RemoveMatchLine "$2")
}
Array.pop() {
	readarray -t "$1" < <(PrintEvalArray "$1" | sed -e '$d')
}
Array.fromStr() {
	declare -a -x "$1"
	readarray -t "$1" < <(BreakChar)
}
Array.rev() {
	readarray -t "$1" < <(PrintEvalArray "$1" | tac)
}
Array.eval() {
	eval "PrintArray \"\${$1[@]}\""
}
Array.last() {
	PrintEval "$1[$(Array.lastIndex "$1")]"
}
Array.print() {
	(($# >= 1)) || return 0
	printf "%s\n" "${@}"
}
Array.length() {
	PrintEval "#${1}[@]"
}
Array.indexOf() {
	local n=()
	readarray -t n < <(grep -x -n "$1" | cut -d ":" -f 1 | ForEach eval echo '$(( {} - 1 ))')
	(("${#n[@]}" >= 1)) || return 1
	PrintArray "${n[@]}"
	return 0
}
Array.lastIndex() {
	CalcInt "$(Array.length "$1")" - 1
}
Array.forEach() {
	PrintEvalArray "$1" | ForEach "${@:2}"
}
Array.includes() {
	PrintEvalArray "$1" | grep -qx "$2"
}
Array.include() {
	Array.includes "$@"
}
Awk.print() {
	awk "BEGIN {print $*}"
}
Awk.pi() {
	Awk.float "atan2(0, -0)"
}
Awk.log() {
	Awk.float "log(${2}) / log($1)"
}
Awk.float() {
	awk "BEGIN {printf (\"%4.${AWKSCALE-"5"}f\n\", $*)}"
}
Awk.tan() {
	Awk.float "sin($1)/tan($1)"
}
Awk.sin() {
	Awk.float "sin($*)"
}
Awk.cos() {
	Awk.float "cos($*)"
}
Awk.rad() {
	Awk.float "$1 * $(Awk.pi) / 180 "
}
StrToCharList() {
	Array.FromStr "$1"
}
GetArrayIndex() {
	Array.IndexOf "$1"
}
ArrayIndex() {
	Array.Length "$1"
}
RevArray() {
	Array.Rev "$1"
}
ArrayAppend() {
	Array.Append "$1"
}
ArrayIncludes() {
	Array.Includes "$@"
}
PrintEvalArray() {
	Array.Eval "$1"
}
PrintArray() {
	Array.Print "$@"
}
AddNewToArray() {
	Array.Push "$@"
}
FileType() {
	file --mime-type -b "$1"
}
GetFileExt() {
	GetBaseName | rev | cut -d "." -f 1 | rev
}
RemoveFileExt() {
	local Ext
	ForEach eval 'Ext=$(GetFileExt <<< {}); sed "s|.$Ext$||g" <<< {}; unset Ext'
}
GetBaseName() {
	ForEach basename "{}"
}
CheckFuncDefined() {
	typeset -f "${1}" >/dev/null || return 1
}
IsAvailable() {
	type "$1" 2>/dev/null 1>&2
}
Loop() {
	local _T="$1"
	shift 1 || return 1
	((_T == 0)) && return 0
	ForEach "$@" < <(yes "" | head -n "$_T")
}
GetLine() {
	head -n "$1" | tail -n 1
}
ForEach() {
	local _Item
	while read -r _Item; do
		"${@//"{}"/"${_Item}"}" || return "${?}"
	done
}
BreakChar() {
	grep -o "."
}
ToLowerStdin() {
	local _Str
	ForEach eval '_Str="{}"; echo "${_Str,,}"'
	unset _Str
}
IsUUID() {
	local _UUID="${1-""}"
	[[ ${_UUID//-/} =~ ^[[:xdigit:]]{32}$ ]] && return 0
	return 1
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
GetMaxWidth() {
	awk '{ if ( length > x && length > 0 ) { x = length } }END{ print x }'
}
CutLastString() {
	echo "${1%%"${2}"}"
	return 0
}
GetLastSplitString() {
	rev <<<"$2" | cut -d "$1" -f 1 | rev
}
CalcInt() {
	echo "$(("$@"))"
}
Sum() {
	local _Arg=()
	ForEach eval '_Arg+=("{}" "+")' < <(PrintArray "$@")
	readarray -t _Arg < <(PrintArray "${_Arg[@]}" | sed "${#_Arg[@]}d")
	CalcInt "${_Arg[@]}"
}
Ntest() {
	(("$@")) || return 1
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
ToArgs() {
	readarray -t args
	"$@" "${args[@]}"
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
Cache.getTimeDiffFromLastUpdate() {
	local _Now _Last
	_Now="$(date "+%s")"
	_Last="$(Cache.getFileLastUpdate "$1")"
	echo "$((_Now - _Last))"
	return 0
}
Cache.get() {
	cat "$(Cache.getDir)/$1" 2>/dev/null || return 1
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
Cache.exist() {
	local _File
	_File="$(Cache.createDir)/$1"
	[[ -e $_File ]] || return 1
	(("$(Cache.getTimeDiffFromLastUpdate "$_File")" > "${KEEPCACHESEC-"86400"}")) && return 2
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
Cache.create() {
	Cache.createDir >/dev/null
	cat >"$(Cache.getDir)/${1}"
	cat "$(Cache.getDir)/$1"
}
Cache.createDir() {
	FSBLIB_CACHEID="${FSBLIB_CACHEID-"$(RandomString "10")"}"
	export FSBLIB_CACHEID="$FSBLIB_CACHEID"
	local TMPDIR="${TMPDIR-"/tmp"}"
	local _Dir="$TMPDIR/${FSBLIB_CACHEID}"
	mkdir -p "$_Dir"
	echo "$_Dir"
	return 0
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
fsblibEnvCheck() {
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
Csv.toBashArray() {
	local _RawCsvLine=() _Line _ClmCnt=0
	local ArrayPrefix="${ArrayPrefix-"{}"}"
	readarray -t _RawCsvLine < <(
		while read -r _Line; do
			(($(tr "${CSVDELIM-","}" "\n" <<<"$_Line" | wc -l) >= ${#})) && echo "$_Line"
		done < <(grep -v "^#")
	)
	_ClmCnt=$(PrintArray "${_RawCsvLine[@]}" | Csv.getClmCnt)
	while read -r _Cnt; do
		readarray -t "$(sed "s|{}|$(eval "echo \"\${${_Cnt}}\"")|g" <<<"$ArrayPrefix")" < <(
			PrintArray "${_RawCsvLine[@]}" | cut -d "${CSVDELIM-","}" -f "$_Cnt"
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
	done < <(PrintArray "${_RawCsvLine[@]}")
	RemoveBlank <<<"$_ClmCnt"
	return 0
}
Csv.getClm() {
	grep -v "^#" | sed "/^$/d" | cut -d "${CSVDELIM-","}" -f "$1"
}
Em.getWorldPkgList() {
	sed -E 's|:.+$||g' /var/lib/portage/world | xargs -I{} bash -c 'ls -d /var/db/pkg/{}-* | sed "s|/var/db/pkg/||g" | grep -E "{}-[0-9]"'
}
Em.getInstalledPkgList() {
	find /var/db/pkg/ -mindepth 2 -maxdepth 2 -type d | sed 's|/var/db/pkg/||g'
}
Em.getDefaultRepoName() {
	Em.getRepoConf | Ini.GetParam DEFAULT main-repo
}
Em.getRepoLocation() {
	Em.getRepoConf | Ini.GetParam "$1" location
}
Em.getAllPkgList() {
	Em.getRepoConf | sed -e 's/^ *//' -e 's/ *$//' | grep "^ *location *=" | sed -e 's/^location *= *//' | xargs -L1 realpath | xargs -I{} bash -c "find '{}' -mindepth 3 -maxdepth 3 -type f -name '*.ebuild' | sed -e 's|{}/||g' -e 's|.ebuild$||g'" | awk -F "/" '{print $1"/"$3}'
}
Em.getRepoPkgList() {
	local _RepoPath
	_RepoPath="$(Em.getRepoLocation "$1")"
	find "$_RepoPath" -mindepth 3 -maxdepth 3 -type f -name '*.ebuild' | sed -e "s|${_RepoPath%/}/||g" -e 's|.ebuild$||g' | awk -F "/" '{print $1"/"$3}'
}
Em.getRepoConf() {
	cat /etc/portage/repos.conf /etc/portage/repos.conf/* 2>/dev/null
}
Em.noVersion() {
	sed -E 's|\-[0-9]+.+||g'
}
Esc.return() {
	printf "\r" >/dev/tty
}
Esc.clearLeft() {
	printf "\033[1K" >/dev/tty
}
Esc.clearLine() {
	printf "\033[2K" >/dev/tty
}
Esc.clearScreen() {
	printf "\033[2J" >/dev/tty
}
Esc.clearRight() {
	printf "\033[0K" >/dev/tty
}
Esc.getTermY() {
	[[ -n ${LINES-""} ]] && echo "$LINES" && return 0
	tput lines
}
Esc.getX() {
	local _POS
	printf "\033[6n" >>/dev/tty
	read -r -s -d "R" _POS
	echo $(("$(printf "%s\n" "${_POS:2}" | cut -d";" -f2)" - 1))
}
Esc.getTermX() {
	[[ -n ${COLUMNS-""} ]] && echo "$COLUMNS" && return 0
	tput cols
}
Esc.moveCursorLeft() {
	printf "\033[%dD" "$1" >/dev/tty
}
Esc.getY() {
	local _POS
	printf "\033[6n" >>/dev/tty
	read -r -s -d "R" _POS
	echo $(("$(printf "%s\n" "${_POS:2}" | cut -d";" -f1)" - 1))
}
Esc.moveCursorDown() {
	printf "\033[%dB" "$1" >/dev/tty
}
Esc.moveCursorRight() {
	printf "\033[%dC" "$1" >/dev/tty
}
Esc.moveCursor() {
	printf "\033[%d;%dH" "$1" "$2" >/dev/tty
}
Esc.moveCursorUp() {
	printf "\033[%dA" "$1" >/dev/tty
}
Esc.clearLineAndReturn() {
	Esc.clearLine
	Esc.return
}
Esc.clearUpperLines() {
	for i in $(seq 1 "$1"); do
		Esc.moveCursorUp 1
		Esc.clearLine
	done
}
Esc.blackBackground() {
	printf "\033[40m" >/dev/tty
}
Esc.cyanBackground() {
	printf "\033[46m" >/dev/tty
}
Esc.greenBackground() {
	printf "\033[42m" >/dev/tty
}
Esc.magentaText() {
	printf "\033[35m" >/dev/tty
}
Esc.lowIntensity() {
	printf "\033[2m" >/dev/tty
}
Esc.blueText() {
	printf "\033[34m" >/dev/tty
}
Esc.redBackground() {
	printf "\033[41m" >/dev/tty
}
Esc.magentaBackground() {
	printf "\033[45m" >/dev/tty
}
Esc.greenText() {
	printf "\033[32m" >/dev/tty
}
Esc.italic() {
	printf "\033[3m" >/dev/tty
}
Esc.blink() {
	printf "\033[5m" >/dev/tty
}
Esc.yellowText() {
	printf "\033[33m" >/dev/tty
}
Esc.whiteBackground() {
	printf "\033[47m" >/dev/tty
}
Esc.reverse() {
	printf "\033[7m" >/dev/tty
}
Esc.redText() {
	printf "\033[31m" >/dev/tty
}
Esc.conceal() {
	printf "\033[8m" >/dev/tty
}
Esc.yellowBackground() {
	printf "\033[43m" >/dev/tty
}
Esc.crossedOut() {
	printf "\033[9m" >/dev/tty
}
Esc.underline() {
	printf "\033[4m" >/dev/tty
}
Esc.resetStyle() {
	printf "\033[0m" >/dev/tty
}
Esc.rapidBlink() {
	printf "\033[6m" >/dev/tty
}
Esc.cyanText() {
	printf "\033[36m" >/dev/tty
}
Esc.blueBackground() {
	printf "\033[44m" >/dev/tty
}
Esc.bold() {
	printf "\033[1m" >/dev/tty
}
Esc.whiteText() {
	printf "\033[37m" >/dev/tty
}
Esc.blackText() {
	printf "\033[30m" >/dev/tty
}
Ini.getLastParam() {
	Ini.getParamList "$1" | tail -n 1
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
	done < <(PrintArray "${_RawIniLine[@]}")
	return "$_Exit"
}
Ini.parseLine() {
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
	done < <(PrintArray "${_RawIniLine[@]}")
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
	done < <(PrintArray "${_RawIniLine[@]}")
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
	if ! PrintArray "${IniContents[@]}" | Ini.getParamList "$Section" | grep -qx "$Param"; then
		SectionLastParam="$(PrintEvalArray IniContents | Ini.getLastParam "$Section")"
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
Ini.setValue() {
	local IniContents=()
	local Section="$1" Param="$2"
	readarray -t IniContents
	readarray -t IniContents < <(PrintArray "${IniContents[@]}" | Ini.newSection "$Section" | Ini.newParam "$Section" "$Param")
	PrintEvalArray IniContents
}
Ini.newSection() {
	local IniContents=()
	local Section="$1"
	readarray -t IniContents
	if PrintArray "${IniContents[@]}" | Ini.getSectionList | grep -x "$Section" >/dev/null; then
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
LibreTranslate.languages() {
	LibreTranslate.check || return 2
	curl -s "${LIBRETRANSLATE_URL}/languages" | jq -r '.[].code'
}
LibreTranslate.translateAuto() {
	LibreTranslate.check || return 2
	LibreTranslate.translate "${1:-""}" "$(LibreTranslate.detect "${1:-""}")" "${2:-""}"
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
Misskey.notes.Renotes() {
	Misskey.bindingBase "notes/renotes" noteId limit sinceId untilId -- "$@"
}
Misskey.notes.Search() {
	Misskey.bindingBase "notes/search" query limit -- "$@"
}
Misskey.notes.Create() {
	Misskey.bindingBase "notes/create" text -- "$@"
}
Misskey.users.GetFrequentlyRepliedUsers() {
	Misskey.bindingBase "users/get-frequently-replied-users" userId -- "${1:-"$(Misskey.myId)"}" "${@:2}"
}
Misskey.users.Stats() {
	Misskey.bindingBase "users/stats" userId -- "${1:-"$(Misskey.myId)"}" "${@:2}"
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
Misskey.sendReq() {
	local _Url="$1" _CurlArgs=()
	shift 1
	_CurlArgs+=(-s -L)
	_CurlArgs+=(-X POST)
	_CurlArgs+=(-H "Content-Type: application/json")
	_CurlArgs+=(-d "$(Misskey.makeJson "$@")")
	_CurlArgs+=("$_Url")
	Msg.Debug "Run: ${_CurlArgs[*]//"${MISSKEY_TOKEN}"/"TOKEN"}"
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
	if ! Bool _Shifted; then
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
Misskey.isAdmin() {
	Bool "$(Misskey.i | jq -r ".isAdmin")"
}
Misskey.myId() {
	Misskey.i | jq -r ".id"
}
Misskey.myUserName() {
	Misskey.i | jq -r ".username"
}
Misskey.myName() {
	Misskey.i | jq -r ".name"
}
Pm.checkPkg() {
	local p
	for p in "$@"; do
		Pm.run -Qq "$p" >/dev/null 2>&1 || return 1
	done
	return 0
}
Pm.getKeyringList() {
	find "$(@GetKeyringDir)" -name "*.gpg" | GetBaseName | RemoveFileExt
}
Pm.getRepoListFromConf() {
	Pm.getConfig --repo-list
}
Pm.getRepoPkgList() {
	Pm.run -Slq "$@"
}
Pm.isRepoPkg() {
	Pm.run -Slq | grep -qx "$(Pm.getName <<<"$1")"
}
Pm.getRoot() {
	Pm.getConfig RootDir
}
Pm.getRepoConf() {
	ForEach eval 'echo [{}] && Pm.getConfig -r {}'
}
Pm.getPacmanKernelPkg() {
	echo "there is nothing"
}
Pm.getRepoServer() {
	ForEach eval 'Pm.getConfig -r {}' | grep "^Server" | ForEach eval "Ini.ParseLine <<< '{}' ; printf '%s\n' \${VALUE}"
}
Pm.getPacmanKeyringDir() {
	local _KeyringDir=""
	_KeyringDir="$(LANG=C pacman-key -h | RemoveBlank | grep -A 1 -- "^--populate" | tail -n 1 | cut -d "/" -f 2- | sed "s|'$||g")"
	: "${_KeyringDir="usr/share/pacman/keyrings"}"
	_KeyringDir="$(Pm.getRoot)/$_KeyringDir"
	_KeyringDir="$(sed -E "s|/+|/|g" <<<"$_KeyringDir")"
	if [[ -e $_KeyringDir ]]; then
		Readlinkf "$_KeyringDir"
	else
		echo "$_KeyringDir"
	fi
}
Pm.getRepoVer() {
	Pm.run -Sp --print-format '%v' "$1"
}
Pm.run() {
	pacman --noconfirm --config "${PACMAN_CONF-"/etc/pacman.conf"}" "$@"
}
Pm.runKey() {
	pacman-key --config "${PACMAN_CONF-"/etc/pacman.conf"}" "$@"
}
Pm.getName() {
	cut -d "<" -f 1 | cut -d ">" -f 1 | cut -d "=" -f 1
}
Pm.getLatestPkgVer() {
	local _LANG="${LANG-""}"
	export LANG=C
	if [[ -z ${*} ]]; then
		cat
	else
		PrintArray "$@"
	fi | ForEach Pm.run -Si "{}" | grep "^Version" | cut -d ":" -f 2 | RemoveBlank
	[[ -n $_LANG ]] && export LANG="$_LANG"
	return 0
}
Pm.getInstalledPkgVer() {
	if [[ -z ${*} ]]; then
		cat
	else
		PrintArray "$@"
	fi | ForEach pacman -Q "{}" | cut -d " " -f 2
	PrintArray "${PIPESTATUS[@]}" | grep -qx "1" && return 1
	return 0
}
Pm.getConfig() {
	LANG=C pacman-conf --config="${PACMAN_CONF-"/etc/pacman.conf"}" "$@"
}
Pm.pacmanGpg() {
	gpg --homedir "$(Pm.getConfig GPGDir)" "$@"
}
Pm.getDbSectionList() {
	grep -E "^%.*%$"
}
Pm.getDbNextSection() {
	Pm.getDbSectionList | grep -x -A 1 "^%$1%$" | GetLine 2 | sed "s|^%||g; s|%$||g"
}
Pm.getDbSection() {
	readarray -t _Stdin
	PrintArray "${_Stdin[@]}" | sed -ne "/^%$1%$/,/^%$(PrintEvalArray _Stdin | Pm.getDbNextSection "$1")%$/p" | sed '1d; $d'
}
Pm.isOpendSyncDb() {
	readarray -t _PkgDbList < <(find "$(Pm.getDbTmpDir)/sync/$1" -mindepth 1 -maxdepth 1 -type d)
	(("${#_PkgDbList[@]}" > 0)) && return 0
	return 1
}
Pm.createDbTmpDir() {
	mkdir -p "$(Pm.getDbTmpDir)"
}
Pm.getRepoListFromLocalDb() {
	find "$(Pm.getConfig DBPath)/sync" -mindepth 1 -maxdepth 1 -type f | GetBaseName | sed "s|.db$||g"
	return 0
}
Pm.getSyncDbDescPath() {
	local _repo
	_repo="$(pacman -Sp --print-format '%r' "$1")"
	{
		IsPacmanSyncDbOpend "$_repo" || OpenPacmanSyncDb "$_repo"
	} || return 1
	echo "$(Pm.getDbTmpDir)/sync/$(pacman -Sp --print-format '%r/%n-%v' "$1")"
}
Pm.openedSyncDbList() {
	find "$(Pm.getDbTmpDir)/sync/" -mindepth 1 -maxdepth 1 -type d
}
Pm.getSyncAllDesc() {
	find "$(Pm.getDbTmpDir)" -mindepth 3 -maxdepth 3 -name "desc" -type f
}
Pm.parsePkgFileName() {
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
Pm.getVirtualPkgList() {
	Pm.getRepoListFromLocalDb | ForEach Pm.openSyncDb {}
	Pm.getSyncAllDesc | ForEach eval "Pm.getDbSection PROVIDES < {}" | RemoveBlank
}
Pm.getPkgArch() {
	Pm.getSyncDbDesc "$1" | Pm.getDbSection ARCH | RemoveBlank
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
Pm.getSyncDbDesc() {
	local _path
	_path="$(Pm.getSyncDbDescPath "$1")"
	[[ -e $_path ]] || return 1
	cat "$_path/desc"
}
Pm.getDbTmpDir() {
	echo "${TMPDIR-"/tmp"}/fasbashlib-pacman-db"
}
Pm.deleteDbTmpDir() {
	rm -rf "$(Pm.getDbTmpDir)"
}
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
Arch.getKernelFileList() {
	find "/boot" -maxdepth 1 -mindepth 1 -name "vmlinuz-*"
}
Arch.getKernelSrcList() {
	find "/usr/src" -mindepth 1 -maxdepth 1 -type l -name "linux*"
}
Arch.getMkinitcpioPresetList() {
	find "/etc/mkinitcpio.d/" -name "*.preset" -type f | GetBaseName | RemoveFileExt
}
Array.shift() {
	readarray -t "$1" < <(PrintEvalArray "$1" | sed "1,${2-"1"}d")
}
Array.push() {
	eval "PrintArray \"\${$1[@]}\"" | grep -qx "$2" && return 0
	eval "$1+=(\"$2\")"
}
Array.append() {
	local _ArrName="$1"
	shift 1 || return 1
	readarray -t -O "$(ArrayIndex "$_ArrName")" "$_ArrName" < <(cat)
}
Array.remove() {
	readarray -t "$1" < <(PrintEvalArray "$1" | RemoveMatchLine "$2")
}
Array.pop() {
	readarray -t "$1" < <(PrintEvalArray "$1" | sed -e '$d')
}
Array.fromStr() {
	declare -a -x "$1"
	readarray -t "$1" < <(BreakChar)
}
Array.rev() {
	readarray -t "$1" < <(PrintEvalArray "$1" | tac)
}
Array.eval() {
	eval "PrintArray \"\${$1[@]}\""
}
Array.last() {
	PrintEval "$1[$(Array.lastIndex "$1")]"
}
Array.print() {
	(($# >= 1)) || return 0
	printf "%s\n" "${@}"
}
Array.length() {
	PrintEval "#${1}[@]"
}
Array.indexOf() {
	local n=()
	readarray -t n < <(grep -x -n "$1" | cut -d ":" -f 1 | ForEach eval echo '$(( {} - 1 ))')
	(("${#n[@]}" >= 1)) || return 1
	PrintArray "${n[@]}"
	return 0
}
Array.lastIndex() {
	CalcInt "$(Array.length "$1")" - 1
}
Array.forEach() {
	PrintEvalArray "$1" | ForEach "${@:2}"
}
Array.includes() {
	PrintEvalArray "$1" | grep -qx "$2"
}
Array.include() {
	Array.includes "$@"
}
Awk.print() {
	awk "BEGIN {print $*}"
}
Awk.pi() {
	Awk.float "atan2(0, -0)"
}
Awk.log() {
	Awk.float "log(${2}) / log($1)"
}
Awk.float() {
	awk "BEGIN {printf (\"%4.${AWKSCALE-"5"}f\n\", $*)}"
}
Awk.tan() {
	Awk.float "sin($1)/tan($1)"
}
Awk.sin() {
	Awk.float "sin($*)"
}
Awk.cos() {
	Awk.float "cos($*)"
}
Awk.rad() {
	Awk.float "$1 * $(Awk.pi) / 180 "
}
StrToCharList() {
	Array.FromStr "$1"
}
GetArrayIndex() {
	Array.IndexOf "$1"
}
ArrayIndex() {
	Array.Length "$1"
}
RevArray() {
	Array.Rev "$1"
}
ArrayAppend() {
	Array.Append "$1"
}
ArrayIncludes() {
	Array.Includes "$@"
}
PrintEvalArray() {
	Array.Eval "$1"
}
PrintArray() {
	Array.Print "$@"
}
AddNewToArray() {
	Array.Push "$@"
}
FileType() {
	file --mime-type -b "$1"
}
GetFileExt() {
	GetBaseName | rev | cut -d "." -f 1 | rev
}
RemoveFileExt() {
	local Ext
	ForEach eval 'Ext=$(GetFileExt <<< {}); sed "s|.$Ext$||g" <<< {}; unset Ext'
}
GetBaseName() {
	ForEach basename "{}"
}
CheckFuncDefined() {
	typeset -f "${1}" >/dev/null || return 1
}
IsAvailable() {
	type "$1" 2>/dev/null 1>&2
}
Loop() {
	local _T="$1"
	shift 1 || return 1
	((_T == 0)) && return 0
	ForEach "$@" < <(yes "" | head -n "$_T")
}
GetLine() {
	head -n "$1" | tail -n 1
}
ForEach() {
	local _Item
	while read -r _Item; do
		"${@//"{}"/"${_Item}"}" || return "${?}"
	done
}
BreakChar() {
	grep -o "."
}
ToLowerStdin() {
	local _Str
	ForEach eval '_Str="{}"; echo "${_Str,,}"'
	unset _Str
}
IsUUID() {
	local _UUID="${1-""}"
	[[ ${_UUID//-/} =~ ^[[:xdigit:]]{32}$ ]] && return 0
	return 1
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
GetMaxWidth() {
	awk '{ if ( length > x && length > 0 ) { x = length } }END{ print x }'
}
CutLastString() {
	echo "${1%%"${2}"}"
	return 0
}
GetLastSplitString() {
	rev <<<"$2" | cut -d "$1" -f 1 | rev
}
CalcInt() {
	echo "$(("$@"))"
}
Sum() {
	local _Arg=()
	ForEach eval '_Arg+=("{}" "+")' < <(PrintArray "$@")
	readarray -t _Arg < <(PrintArray "${_Arg[@]}" | sed "${#_Arg[@]}d")
	CalcInt "${_Arg[@]}"
}
Ntest() {
	(("$@")) || return 1
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
ToArgs() {
	readarray -t args
	"$@" "${args[@]}"
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
Cache.getTimeDiffFromLastUpdate() {
	local _Now _Last
	_Now="$(date "+%s")"
	_Last="$(Cache.getFileLastUpdate "$1")"
	echo "$((_Now - _Last))"
	return 0
}
Cache.get() {
	cat "$(Cache.getDir)/$1" 2>/dev/null || return 1
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
Cache.exist() {
	local _File
	_File="$(Cache.createDir)/$1"
	[[ -e $_File ]] || return 1
	(("$(Cache.getTimeDiffFromLastUpdate "$_File")" > "${KEEPCACHESEC-"86400"}")) && return 2
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
Cache.create() {
	Cache.createDir >/dev/null
	cat >"$(Cache.getDir)/${1}"
	cat "$(Cache.getDir)/$1"
}
Cache.createDir() {
	FSBLIB_CACHEID="${FSBLIB_CACHEID-"$(RandomString "10")"}"
	export FSBLIB_CACHEID="$FSBLIB_CACHEID"
	local TMPDIR="${TMPDIR-"/tmp"}"
	local _Dir="$TMPDIR/${FSBLIB_CACHEID}"
	mkdir -p "$_Dir"
	echo "$_Dir"
	return 0
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
fsblibEnvCheck() {
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
Csv.toBashArray() {
	local _RawCsvLine=() _Line _ClmCnt=0
	local ArrayPrefix="${ArrayPrefix-"{}"}"
	readarray -t _RawCsvLine < <(
		while read -r _Line; do
			(($(tr "${CSVDELIM-","}" "\n" <<<"$_Line" | wc -l) >= ${#})) && echo "$_Line"
		done < <(grep -v "^#")
	)
	_ClmCnt=$(PrintArray "${_RawCsvLine[@]}" | Csv.getClmCnt)
	while read -r _Cnt; do
		readarray -t "$(sed "s|{}|$(eval "echo \"\${${_Cnt}}\"")|g" <<<"$ArrayPrefix")" < <(
			PrintArray "${_RawCsvLine[@]}" | cut -d "${CSVDELIM-","}" -f "$_Cnt"
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
	done < <(PrintArray "${_RawCsvLine[@]}")
	RemoveBlank <<<"$_ClmCnt"
	return 0
}
Csv.getClm() {
	grep -v "^#" | sed "/^$/d" | cut -d "${CSVDELIM-","}" -f "$1"
}
Em.getWorldPkgList() {
	sed -E 's|:.+$||g' /var/lib/portage/world | xargs -I{} bash -c 'ls -d /var/db/pkg/{}-* | sed "s|/var/db/pkg/||g" | grep -E "{}-[0-9]"'
}
Em.getInstalledPkgList() {
	find /var/db/pkg/ -mindepth 2 -maxdepth 2 -type d | sed 's|/var/db/pkg/||g'
}
Em.getDefaultRepoName() {
	Em.getRepoConf | Ini.GetParam DEFAULT main-repo
}
Em.getRepoLocation() {
	Em.getRepoConf | Ini.GetParam "$1" location
}
Em.getAllPkgList() {
	Em.getRepoConf | sed -e 's/^ *//' -e 's/ *$//' | grep "^ *location *=" | sed -e 's/^location *= *//' | xargs -L1 realpath | xargs -I{} bash -c "find '{}' -mindepth 3 -maxdepth 3 -type f -name '*.ebuild' | sed -e 's|{}/||g' -e 's|.ebuild$||g'" | awk -F "/" '{print $1"/"$3}'
}
Em.getRepoPkgList() {
	local _RepoPath
	_RepoPath="$(Em.getRepoLocation "$1")"
	find "$_RepoPath" -mindepth 3 -maxdepth 3 -type f -name '*.ebuild' | sed -e "s|${_RepoPath%/}/||g" -e 's|.ebuild$||g' | awk -F "/" '{print $1"/"$3}'
}
Em.getRepoConf() {
	cat /etc/portage/repos.conf /etc/portage/repos.conf/* 2>/dev/null
}
Em.noVersion() {
	sed -E 's|\-[0-9]+.+||g'
}
Esc.return() {
	printf "\r" >/dev/tty
}
Esc.clearLeft() {
	printf "\033[1K" >/dev/tty
}
Esc.clearLine() {
	printf "\033[2K" >/dev/tty
}
Esc.clearScreen() {
	printf "\033[2J" >/dev/tty
}
Esc.clearRight() {
	printf "\033[0K" >/dev/tty
}
Esc.getTermY() {
	[[ -n ${LINES-""} ]] && echo "$LINES" && return 0
	tput lines
}
Esc.getX() {
	local _POS
	printf "\033[6n" >>/dev/tty
	read -r -s -d "R" _POS
	echo $(("$(printf "%s\n" "${_POS:2}" | cut -d";" -f2)" - 1))
}
Esc.getTermX() {
	[[ -n ${COLUMNS-""} ]] && echo "$COLUMNS" && return 0
	tput cols
}
Esc.moveCursorLeft() {
	printf "\033[%dD" "$1" >/dev/tty
}
Esc.getY() {
	local _POS
	printf "\033[6n" >>/dev/tty
	read -r -s -d "R" _POS
	echo $(("$(printf "%s\n" "${_POS:2}" | cut -d";" -f1)" - 1))
}
Esc.moveCursorDown() {
	printf "\033[%dB" "$1" >/dev/tty
}
Esc.moveCursorRight() {
	printf "\033[%dC" "$1" >/dev/tty
}
Esc.moveCursor() {
	printf "\033[%d;%dH" "$1" "$2" >/dev/tty
}
Esc.moveCursorUp() {
	printf "\033[%dA" "$1" >/dev/tty
}
Esc.clearLineAndReturn() {
	Esc.clearLine
	Esc.return
}
Esc.clearUpperLines() {
	for i in $(seq 1 "$1"); do
		Esc.moveCursorUp 1
		Esc.clearLine
	done
}
Esc.blackBackground() {
	printf "\033[40m" >/dev/tty
}
Esc.cyanBackground() {
	printf "\033[46m" >/dev/tty
}
Esc.greenBackground() {
	printf "\033[42m" >/dev/tty
}
Esc.magentaText() {
	printf "\033[35m" >/dev/tty
}
Esc.lowIntensity() {
	printf "\033[2m" >/dev/tty
}
Esc.blueText() {
	printf "\033[34m" >/dev/tty
}
Esc.redBackground() {
	printf "\033[41m" >/dev/tty
}
Esc.magentaBackground() {
	printf "\033[45m" >/dev/tty
}
Esc.greenText() {
	printf "\033[32m" >/dev/tty
}
Esc.italic() {
	printf "\033[3m" >/dev/tty
}
Esc.blink() {
	printf "\033[5m" >/dev/tty
}
Esc.yellowText() {
	printf "\033[33m" >/dev/tty
}
Esc.whiteBackground() {
	printf "\033[47m" >/dev/tty
}
Esc.reverse() {
	printf "\033[7m" >/dev/tty
}
Esc.redText() {
	printf "\033[31m" >/dev/tty
}
Esc.conceal() {
	printf "\033[8m" >/dev/tty
}
Esc.yellowBackground() {
	printf "\033[43m" >/dev/tty
}
Esc.crossedOut() {
	printf "\033[9m" >/dev/tty
}
Esc.underline() {
	printf "\033[4m" >/dev/tty
}
Esc.resetStyle() {
	printf "\033[0m" >/dev/tty
}
Esc.rapidBlink() {
	printf "\033[6m" >/dev/tty
}
Esc.cyanText() {
	printf "\033[36m" >/dev/tty
}
Esc.blueBackground() {
	printf "\033[44m" >/dev/tty
}
Esc.bold() {
	printf "\033[1m" >/dev/tty
}
Esc.whiteText() {
	printf "\033[37m" >/dev/tty
}
Esc.blackText() {
	printf "\033[30m" >/dev/tty
}
Ini.getLastParam() {
	Ini.getParamList "$1" | tail -n 1
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
	done < <(PrintArray "${_RawIniLine[@]}")
	return "$_Exit"
}
Ini.parseLine() {
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
	done < <(PrintArray "${_RawIniLine[@]}")
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
	done < <(PrintArray "${_RawIniLine[@]}")
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
	if ! PrintArray "${IniContents[@]}" | Ini.getParamList "$Section" | grep -qx "$Param"; then
		SectionLastParam="$(PrintEvalArray IniContents | Ini.getLastParam "$Section")"
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
Ini.setValue() {
	local IniContents=()
	local Section="$1" Param="$2"
	readarray -t IniContents
	readarray -t IniContents < <(PrintArray "${IniContents[@]}" | Ini.newSection "$Section" | Ini.newParam "$Section" "$Param")
	PrintEvalArray IniContents
}
Ini.newSection() {
	local IniContents=()
	local Section="$1"
	readarray -t IniContents
	if PrintArray "${IniContents[@]}" | Ini.getSectionList | grep -x "$Section" >/dev/null; then
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
LibreTranslate.languages() {
	LibreTranslate.check || return 2
	curl -s "${LIBRETRANSLATE_URL}/languages" | jq -r '.[].code'
}
LibreTranslate.translateAuto() {
	LibreTranslate.check || return 2
	LibreTranslate.translate "${1:-""}" "$(LibreTranslate.detect "${1:-""}")" "${2:-""}"
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
Misskey.notes.Renotes() {
	Misskey.bindingBase "notes/renotes" noteId limit sinceId untilId -- "$@"
}
Misskey.notes.Search() {
	Misskey.bindingBase "notes/search" query limit -- "$@"
}
Misskey.notes.Create() {
	Misskey.bindingBase "notes/create" text -- "$@"
}
Misskey.users.GetFrequentlyRepliedUsers() {
	Misskey.bindingBase "users/get-frequently-replied-users" userId -- "${1:-"$(Misskey.myId)"}" "${@:2}"
}
Misskey.users.Stats() {
	Misskey.bindingBase "users/stats" userId -- "${1:-"$(Misskey.myId)"}" "${@:2}"
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
Misskey.sendReq() {
	local _Url="$1" _CurlArgs=()
	shift 1
	_CurlArgs+=(-s -L)
	_CurlArgs+=(-X POST)
	_CurlArgs+=(-H "Content-Type: application/json")
	_CurlArgs+=(-d "$(Misskey.makeJson "$@")")
	_CurlArgs+=("$_Url")
	Msg.Debug "Run: ${_CurlArgs[*]//"${MISSKEY_TOKEN}"/"TOKEN"}"
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
	if ! Bool _Shifted; then
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
Misskey.isAdmin() {
	Bool "$(Misskey.i | jq -r ".isAdmin")"
}
Misskey.myId() {
	Misskey.i | jq -r ".id"
}
Misskey.myUserName() {
	Misskey.i | jq -r ".username"
}
Misskey.myName() {
	Misskey.i | jq -r ".name"
}
Pm.checkPkg() {
	local p
	for p in "$@"; do
		Pm.run -Qq "$p" >/dev/null 2>&1 || return 1
	done
	return 0
}
Pm.getKeyringList() {
	find "$(@GetKeyringDir)" -name "*.gpg" | GetBaseName | RemoveFileExt
}
Pm.getRepoListFromConf() {
	Pm.getConfig --repo-list
}
Pm.getRepoPkgList() {
	Pm.run -Slq "$@"
}
Pm.isRepoPkg() {
	Pm.run -Slq | grep -qx "$(Pm.getName <<<"$1")"
}
Pm.getRoot() {
	Pm.getConfig RootDir
}
Pm.getRepoConf() {
	ForEach eval 'echo [{}] && Pm.getConfig -r {}'
}
Pm.getPacmanKernelPkg() {
	echo "there is nothing"
}
Pm.getRepoServer() {
	ForEach eval 'Pm.getConfig -r {}' | grep "^Server" | ForEach eval "Ini.ParseLine <<< '{}' ; printf '%s\n' \${VALUE}"
}
Pm.getPacmanKeyringDir() {
	local _KeyringDir=""
	_KeyringDir="$(LANG=C pacman-key -h | RemoveBlank | grep -A 1 -- "^--populate" | tail -n 1 | cut -d "/" -f 2- | sed "s|'$||g")"
	: "${_KeyringDir="usr/share/pacman/keyrings"}"
	_KeyringDir="$(Pm.getRoot)/$_KeyringDir"
	_KeyringDir="$(sed -E "s|/+|/|g" <<<"$_KeyringDir")"
	if [[ -e $_KeyringDir ]]; then
		Readlinkf "$_KeyringDir"
	else
		echo "$_KeyringDir"
	fi
}
Pm.getRepoVer() {
	Pm.run -Sp --print-format '%v' "$1"
}
Pm.run() {
	pacman --noconfirm --config "${PACMAN_CONF-"/etc/pacman.conf"}" "$@"
}
Pm.runKey() {
	pacman-key --config "${PACMAN_CONF-"/etc/pacman.conf"}" "$@"
}
Pm.getName() {
	cut -d "<" -f 1 | cut -d ">" -f 1 | cut -d "=" -f 1
}
Pm.getLatestPkgVer() {
	local _LANG="${LANG-""}"
	export LANG=C
	if [[ -z ${*} ]]; then
		cat
	else
		PrintArray "$@"
	fi | ForEach Pm.run -Si "{}" | grep "^Version" | cut -d ":" -f 2 | RemoveBlank
	[[ -n $_LANG ]] && export LANG="$_LANG"
	return 0
}
Pm.getInstalledPkgVer() {
	if [[ -z ${*} ]]; then
		cat
	else
		PrintArray "$@"
	fi | ForEach pacman -Q "{}" | cut -d " " -f 2
	PrintArray "${PIPESTATUS[@]}" | grep -qx "1" && return 1
	return 0
}
Pm.getConfig() {
	LANG=C pacman-conf --config="${PACMAN_CONF-"/etc/pacman.conf"}" "$@"
}
Pm.pacmanGpg() {
	gpg --homedir "$(Pm.getConfig GPGDir)" "$@"
}
Pm.getDbSectionList() {
	grep -E "^%.*%$"
}
Pm.getDbNextSection() {
	Pm.getDbSectionList | grep -x -A 1 "^%$1%$" | GetLine 2 | sed "s|^%||g; s|%$||g"
}
Pm.getDbSection() {
	readarray -t _Stdin
	PrintArray "${_Stdin[@]}" | sed -ne "/^%$1%$/,/^%$(PrintEvalArray _Stdin | Pm.getDbNextSection "$1")%$/p" | sed '1d; $d'
}
Pm.isOpendSyncDb() {
	readarray -t _PkgDbList < <(find "$(Pm.getDbTmpDir)/sync/$1" -mindepth 1 -maxdepth 1 -type d)
	(("${#_PkgDbList[@]}" > 0)) && return 0
	return 1
}
Pm.createDbTmpDir() {
	mkdir -p "$(Pm.getDbTmpDir)"
}
Pm.getRepoListFromLocalDb() {
	find "$(Pm.getConfig DBPath)/sync" -mindepth 1 -maxdepth 1 -type f | GetBaseName | sed "s|.db$||g"
	return 0
}
Pm.getSyncDbDescPath() {
	local _repo
	_repo="$(pacman -Sp --print-format '%r' "$1")"
	{
		IsPacmanSyncDbOpend "$_repo" || OpenPacmanSyncDb "$_repo"
	} || return 1
	echo "$(Pm.getDbTmpDir)/sync/$(pacman -Sp --print-format '%r/%n-%v' "$1")"
}
Pm.openedSyncDbList() {
	find "$(Pm.getDbTmpDir)/sync/" -mindepth 1 -maxdepth 1 -type d
}
Pm.getSyncAllDesc() {
	find "$(Pm.getDbTmpDir)" -mindepth 3 -maxdepth 3 -name "desc" -type f
}
Pm.parsePkgFileName() {
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
Pm.getVirtualPkgList() {
	Pm.getRepoListFromLocalDb | ForEach Pm.openSyncDb {}
	Pm.getSyncAllDesc | ForEach eval "Pm.getDbSection PROVIDES < {}" | RemoveBlank
}
Pm.getPkgArch() {
	Pm.getSyncDbDesc "$1" | Pm.getDbSection ARCH | RemoveBlank
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
Pm.getSyncDbDesc() {
	local _path
	_path="$(Pm.getSyncDbDescPath "$1")"
	[[ -e $_path ]] || return 1
	cat "$_path/desc"
}
Pm.getDbTmpDir() {
	echo "${TMPDIR-"/tmp"}/fasbashlib-pacman-db"
}
Pm.deleteDbTmpDir() {
	rm -rf "$(Pm.getDbTmpDir)"
}
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
Prog.wideBar() {
	local Max="$1" Counter="$2"
	local StatusString="$Counter/$Max"
	local Size=$(($(Esc.GetTermX) - ${#StatusString} - 3))
	Prog.bar "$Max" "$Counter" "$Size"
}
Prog.rotation() {
	local Count="$1" CharList=('|' '/' '-' '\')
	Esc.ClearLineAndReturn
	[[ -n ${2-""} ]] && echo -n "${2}" 1>&2
	printf "%s" "${CharList["$((Count % "${#CharList[@]}"))"]}" 1>&2
}
Prog.bar() {
	local Max="$1" Counter="$2" Size="${3-"100"}"
	local SharpCount=$((Counter * Size / Max))
	local SpaceCount=$((Size - SharpCount))
	Esc.Return
	echo -n "$Counter/$Max [$(yes "#" | head -n "$SharpCount" 2>/dev/null | tr -d "\n")$(yes " " | head -n "$SpaceCount" 2>/dev/null | tr -d "\n")]"
}
Arch.getKernelFileList() {
	find "/boot" -maxdepth 1 -mindepth 1 -name "vmlinuz-*"
}
Arch.getKernelSrcList() {
	find "/usr/src" -mindepth 1 -maxdepth 1 -type l -name "linux*"
}
Arch.getMkinitcpioPresetList() {
	find "/etc/mkinitcpio.d/" -name "*.preset" -type f | GetBaseName | RemoveFileExt
}
Array.shift() {
	readarray -t "$1" < <(PrintEvalArray "$1" | sed "1,${2-"1"}d")
}
Array.push() {
	eval "PrintArray \"\${$1[@]}\"" | grep -qx "$2" && return 0
	eval "$1+=(\"$2\")"
}
Array.append() {
	local _ArrName="$1"
	shift 1 || return 1
	readarray -t -O "$(ArrayIndex "$_ArrName")" "$_ArrName" < <(cat)
}
Array.remove() {
	readarray -t "$1" < <(PrintEvalArray "$1" | RemoveMatchLine "$2")
}
Array.pop() {
	readarray -t "$1" < <(PrintEvalArray "$1" | sed -e '$d')
}
Array.fromStr() {
	declare -a -x "$1"
	readarray -t "$1" < <(BreakChar)
}
Array.rev() {
	readarray -t "$1" < <(PrintEvalArray "$1" | tac)
}
Array.eval() {
	eval "PrintArray \"\${$1[@]}\""
}
Array.last() {
	PrintEval "$1[$(Array.lastIndex "$1")]"
}
Array.print() {
	(($# >= 1)) || return 0
	printf "%s\n" "${@}"
}
Array.length() {
	PrintEval "#${1}[@]"
}
Array.indexOf() {
	local n=()
	readarray -t n < <(grep -x -n "$1" | cut -d ":" -f 1 | ForEach eval echo '$(( {} - 1 ))')
	(("${#n[@]}" >= 1)) || return 1
	PrintArray "${n[@]}"
	return 0
}
Array.lastIndex() {
	CalcInt "$(Array.length "$1")" - 1
}
Array.forEach() {
	PrintEvalArray "$1" | ForEach "${@:2}"
}
Array.includes() {
	PrintEvalArray "$1" | grep -qx "$2"
}
Array.include() {
	Array.includes "$@"
}
Awk.print() {
	awk "BEGIN {print $*}"
}
Awk.pi() {
	Awk.float "atan2(0, -0)"
}
Awk.log() {
	Awk.float "log(${2}) / log($1)"
}
Awk.float() {
	awk "BEGIN {printf (\"%4.${AWKSCALE-"5"}f\n\", $*)}"
}
Awk.tan() {
	Awk.float "sin($1)/tan($1)"
}
Awk.sin() {
	Awk.float "sin($*)"
}
Awk.cos() {
	Awk.float "cos($*)"
}
Awk.rad() {
	Awk.float "$1 * $(Awk.pi) / 180 "
}
StrToCharList() {
	Array.FromStr "$1"
}
GetArrayIndex() {
	Array.IndexOf "$1"
}
ArrayIndex() {
	Array.Length "$1"
}
RevArray() {
	Array.Rev "$1"
}
ArrayAppend() {
	Array.Append "$1"
}
ArrayIncludes() {
	Array.Includes "$@"
}
PrintEvalArray() {
	Array.Eval "$1"
}
PrintArray() {
	Array.Print "$@"
}
AddNewToArray() {
	Array.Push "$@"
}
FileType() {
	file --mime-type -b "$1"
}
GetFileExt() {
	GetBaseName | rev | cut -d "." -f 1 | rev
}
RemoveFileExt() {
	local Ext
	ForEach eval 'Ext=$(GetFileExt <<< {}); sed "s|.$Ext$||g" <<< {}; unset Ext'
}
GetBaseName() {
	ForEach basename "{}"
}
CheckFuncDefined() {
	typeset -f "${1}" >/dev/null || return 1
}
IsAvailable() {
	type "$1" 2>/dev/null 1>&2
}
Loop() {
	local _T="$1"
	shift 1 || return 1
	((_T == 0)) && return 0
	ForEach "$@" < <(yes "" | head -n "$_T")
}
GetLine() {
	head -n "$1" | tail -n 1
}
ForEach() {
	local _Item
	while read -r _Item; do
		"${@//"{}"/"${_Item}"}" || return "${?}"
	done
}
BreakChar() {
	grep -o "."
}
ToLowerStdin() {
	local _Str
	ForEach eval '_Str="{}"; echo "${_Str,,}"'
	unset _Str
}
IsUUID() {
	local _UUID="${1-""}"
	[[ ${_UUID//-/} =~ ^[[:xdigit:]]{32}$ ]] && return 0
	return 1
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
GetMaxWidth() {
	awk '{ if ( length > x && length > 0 ) { x = length } }END{ print x }'
}
CutLastString() {
	echo "${1%%"${2}"}"
	return 0
}
GetLastSplitString() {
	rev <<<"$2" | cut -d "$1" -f 1 | rev
}
CalcInt() {
	echo "$(("$@"))"
}
Sum() {
	local _Arg=()
	ForEach eval '_Arg+=("{}" "+")' < <(PrintArray "$@")
	readarray -t _Arg < <(PrintArray "${_Arg[@]}" | sed "${#_Arg[@]}d")
	CalcInt "${_Arg[@]}"
}
Ntest() {
	(("$@")) || return 1
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
ToArgs() {
	readarray -t args
	"$@" "${args[@]}"
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
Cache.getTimeDiffFromLastUpdate() {
	local _Now _Last
	_Now="$(date "+%s")"
	_Last="$(Cache.getFileLastUpdate "$1")"
	echo "$((_Now - _Last))"
	return 0
}
Cache.get() {
	cat "$(Cache.getDir)/$1" 2>/dev/null || return 1
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
Cache.exist() {
	local _File
	_File="$(Cache.createDir)/$1"
	[[ -e $_File ]] || return 1
	(("$(Cache.getTimeDiffFromLastUpdate "$_File")" > "${KEEPCACHESEC-"86400"}")) && return 2
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
Cache.create() {
	Cache.createDir >/dev/null
	cat >"$(Cache.getDir)/${1}"
	cat "$(Cache.getDir)/$1"
}
Cache.createDir() {
	FSBLIB_CACHEID="${FSBLIB_CACHEID-"$(RandomString "10")"}"
	export FSBLIB_CACHEID="$FSBLIB_CACHEID"
	local TMPDIR="${TMPDIR-"/tmp"}"
	local _Dir="$TMPDIR/${FSBLIB_CACHEID}"
	mkdir -p "$_Dir"
	echo "$_Dir"
	return 0
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
fsblibEnvCheck() {
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
Csv.toBashArray() {
	local _RawCsvLine=() _Line _ClmCnt=0
	local ArrayPrefix="${ArrayPrefix-"{}"}"
	readarray -t _RawCsvLine < <(
		while read -r _Line; do
			(($(tr "${CSVDELIM-","}" "\n" <<<"$_Line" | wc -l) >= ${#})) && echo "$_Line"
		done < <(grep -v "^#")
	)
	_ClmCnt=$(PrintArray "${_RawCsvLine[@]}" | Csv.getClmCnt)
	while read -r _Cnt; do
		readarray -t "$(sed "s|{}|$(eval "echo \"\${${_Cnt}}\"")|g" <<<"$ArrayPrefix")" < <(
			PrintArray "${_RawCsvLine[@]}" | cut -d "${CSVDELIM-","}" -f "$_Cnt"
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
	done < <(PrintArray "${_RawCsvLine[@]}")
	RemoveBlank <<<"$_ClmCnt"
	return 0
}
Csv.getClm() {
	grep -v "^#" | sed "/^$/d" | cut -d "${CSVDELIM-","}" -f "$1"
}
Em.getWorldPkgList() {
	sed -E 's|:.+$||g' /var/lib/portage/world | xargs -I{} bash -c 'ls -d /var/db/pkg/{}-* | sed "s|/var/db/pkg/||g" | grep -E "{}-[0-9]"'
}
Em.getInstalledPkgList() {
	find /var/db/pkg/ -mindepth 2 -maxdepth 2 -type d | sed 's|/var/db/pkg/||g'
}
Em.getDefaultRepoName() {
	Em.getRepoConf | Ini.GetParam DEFAULT main-repo
}
Em.getRepoLocation() {
	Em.getRepoConf | Ini.GetParam "$1" location
}
Em.getAllPkgList() {
	Em.getRepoConf | sed -e 's/^ *//' -e 's/ *$//' | grep "^ *location *=" | sed -e 's/^location *= *//' | xargs -L1 realpath | xargs -I{} bash -c "find '{}' -mindepth 3 -maxdepth 3 -type f -name '*.ebuild' | sed -e 's|{}/||g' -e 's|.ebuild$||g'" | awk -F "/" '{print $1"/"$3}'
}
Em.getRepoPkgList() {
	local _RepoPath
	_RepoPath="$(Em.getRepoLocation "$1")"
	find "$_RepoPath" -mindepth 3 -maxdepth 3 -type f -name '*.ebuild' | sed -e "s|${_RepoPath%/}/||g" -e 's|.ebuild$||g' | awk -F "/" '{print $1"/"$3}'
}
Em.getRepoConf() {
	cat /etc/portage/repos.conf /etc/portage/repos.conf/* 2>/dev/null
}
Em.noVersion() {
	sed -E 's|\-[0-9]+.+||g'
}
Esc.return() {
	printf "\r" >/dev/tty
}
Esc.clearLeft() {
	printf "\033[1K" >/dev/tty
}
Esc.clearLine() {
	printf "\033[2K" >/dev/tty
}
Esc.clearScreen() {
	printf "\033[2J" >/dev/tty
}
Esc.clearRight() {
	printf "\033[0K" >/dev/tty
}
Esc.getTermY() {
	[[ -n ${LINES-""} ]] && echo "$LINES" && return 0
	tput lines
}
Esc.getX() {
	local _POS
	printf "\033[6n" >>/dev/tty
	read -r -s -d "R" _POS
	echo $(("$(printf "%s\n" "${_POS:2}" | cut -d";" -f2)" - 1))
}
Esc.getTermX() {
	[[ -n ${COLUMNS-""} ]] && echo "$COLUMNS" && return 0
	tput cols
}
Esc.moveCursorLeft() {
	printf "\033[%dD" "$1" >/dev/tty
}
Esc.getY() {
	local _POS
	printf "\033[6n" >>/dev/tty
	read -r -s -d "R" _POS
	echo $(("$(printf "%s\n" "${_POS:2}" | cut -d";" -f1)" - 1))
}
Esc.moveCursorDown() {
	printf "\033[%dB" "$1" >/dev/tty
}
Esc.moveCursorRight() {
	printf "\033[%dC" "$1" >/dev/tty
}
Esc.moveCursor() {
	printf "\033[%d;%dH" "$1" "$2" >/dev/tty
}
Esc.moveCursorUp() {
	printf "\033[%dA" "$1" >/dev/tty
}
Esc.clearLineAndReturn() {
	Esc.clearLine
	Esc.return
}
Esc.clearUpperLines() {
	for i in $(seq 1 "$1"); do
		Esc.moveCursorUp 1
		Esc.clearLine
	done
}
Esc.blackBackground() {
	printf "\033[40m" >/dev/tty
}
Esc.cyanBackground() {
	printf "\033[46m" >/dev/tty
}
Esc.greenBackground() {
	printf "\033[42m" >/dev/tty
}
Esc.magentaText() {
	printf "\033[35m" >/dev/tty
}
Esc.lowIntensity() {
	printf "\033[2m" >/dev/tty
}
Esc.blueText() {
	printf "\033[34m" >/dev/tty
}
Esc.redBackground() {
	printf "\033[41m" >/dev/tty
}
Esc.magentaBackground() {
	printf "\033[45m" >/dev/tty
}
Esc.greenText() {
	printf "\033[32m" >/dev/tty
}
Esc.italic() {
	printf "\033[3m" >/dev/tty
}
Esc.blink() {
	printf "\033[5m" >/dev/tty
}
Esc.yellowText() {
	printf "\033[33m" >/dev/tty
}
Esc.whiteBackground() {
	printf "\033[47m" >/dev/tty
}
Esc.reverse() {
	printf "\033[7m" >/dev/tty
}
Esc.redText() {
	printf "\033[31m" >/dev/tty
}
Esc.conceal() {
	printf "\033[8m" >/dev/tty
}
Esc.yellowBackground() {
	printf "\033[43m" >/dev/tty
}
Esc.crossedOut() {
	printf "\033[9m" >/dev/tty
}
Esc.underline() {
	printf "\033[4m" >/dev/tty
}
Esc.resetStyle() {
	printf "\033[0m" >/dev/tty
}
Esc.rapidBlink() {
	printf "\033[6m" >/dev/tty
}
Esc.cyanText() {
	printf "\033[36m" >/dev/tty
}
Esc.blueBackground() {
	printf "\033[44m" >/dev/tty
}
Esc.bold() {
	printf "\033[1m" >/dev/tty
}
Esc.whiteText() {
	printf "\033[37m" >/dev/tty
}
Esc.blackText() {
	printf "\033[30m" >/dev/tty
}
Ini.getLastParam() {
	Ini.getParamList "$1" | tail -n 1
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
	done < <(PrintArray "${_RawIniLine[@]}")
	return "$_Exit"
}
Ini.parseLine() {
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
	done < <(PrintArray "${_RawIniLine[@]}")
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
	done < <(PrintArray "${_RawIniLine[@]}")
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
	if ! PrintArray "${IniContents[@]}" | Ini.getParamList "$Section" | grep -qx "$Param"; then
		SectionLastParam="$(PrintEvalArray IniContents | Ini.getLastParam "$Section")"
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
Ini.setValue() {
	local IniContents=()
	local Section="$1" Param="$2"
	readarray -t IniContents
	readarray -t IniContents < <(PrintArray "${IniContents[@]}" | Ini.newSection "$Section" | Ini.newParam "$Section" "$Param")
	PrintEvalArray IniContents
}
Ini.newSection() {
	local IniContents=()
	local Section="$1"
	readarray -t IniContents
	if PrintArray "${IniContents[@]}" | Ini.getSectionList | grep -x "$Section" >/dev/null; then
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
LibreTranslate.languages() {
	LibreTranslate.check || return 2
	curl -s "${LIBRETRANSLATE_URL}/languages" | jq -r '.[].code'
}
LibreTranslate.translateAuto() {
	LibreTranslate.check || return 2
	LibreTranslate.translate "${1:-""}" "$(LibreTranslate.detect "${1:-""}")" "${2:-""}"
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
Misskey.notes.Renotes() {
	Misskey.bindingBase "notes/renotes" noteId limit sinceId untilId -- "$@"
}
Misskey.notes.Search() {
	Misskey.bindingBase "notes/search" query limit -- "$@"
}
Misskey.notes.Create() {
	Misskey.bindingBase "notes/create" text -- "$@"
}
Misskey.users.GetFrequentlyRepliedUsers() {
	Misskey.bindingBase "users/get-frequently-replied-users" userId -- "${1:-"$(Misskey.myId)"}" "${@:2}"
}
Misskey.users.Stats() {
	Misskey.bindingBase "users/stats" userId -- "${1:-"$(Misskey.myId)"}" "${@:2}"
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
Misskey.sendReq() {
	local _Url="$1" _CurlArgs=()
	shift 1
	_CurlArgs+=(-s -L)
	_CurlArgs+=(-X POST)
	_CurlArgs+=(-H "Content-Type: application/json")
	_CurlArgs+=(-d "$(Misskey.makeJson "$@")")
	_CurlArgs+=("$_Url")
	Msg.Debug "Run: ${_CurlArgs[*]//"${MISSKEY_TOKEN}"/"TOKEN"}"
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
	if ! Bool _Shifted; then
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
Misskey.isAdmin() {
	Bool "$(Misskey.i | jq -r ".isAdmin")"
}
Misskey.myId() {
	Misskey.i | jq -r ".id"
}
Misskey.myUserName() {
	Misskey.i | jq -r ".username"
}
Misskey.myName() {
	Misskey.i | jq -r ".name"
}
Pm.checkPkg() {
	local p
	for p in "$@"; do
		Pm.run -Qq "$p" >/dev/null 2>&1 || return 1
	done
	return 0
}
Pm.getKeyringList() {
	find "$(@GetKeyringDir)" -name "*.gpg" | GetBaseName | RemoveFileExt
}
Pm.getRepoListFromConf() {
	Pm.getConfig --repo-list
}
Pm.getRepoPkgList() {
	Pm.run -Slq "$@"
}
Pm.isRepoPkg() {
	Pm.run -Slq | grep -qx "$(Pm.getName <<<"$1")"
}
Pm.getRoot() {
	Pm.getConfig RootDir
}
Pm.getRepoConf() {
	ForEach eval 'echo [{}] && Pm.getConfig -r {}'
}
Pm.getPacmanKernelPkg() {
	echo "there is nothing"
}
Pm.getRepoServer() {
	ForEach eval 'Pm.getConfig -r {}' | grep "^Server" | ForEach eval "Ini.ParseLine <<< '{}' ; printf '%s\n' \${VALUE}"
}
Pm.getPacmanKeyringDir() {
	local _KeyringDir=""
	_KeyringDir="$(LANG=C pacman-key -h | RemoveBlank | grep -A 1 -- "^--populate" | tail -n 1 | cut -d "/" -f 2- | sed "s|'$||g")"
	: "${_KeyringDir="usr/share/pacman/keyrings"}"
	_KeyringDir="$(Pm.getRoot)/$_KeyringDir"
	_KeyringDir="$(sed -E "s|/+|/|g" <<<"$_KeyringDir")"
	if [[ -e $_KeyringDir ]]; then
		Readlinkf "$_KeyringDir"
	else
		echo "$_KeyringDir"
	fi
}
Pm.getRepoVer() {
	Pm.run -Sp --print-format '%v' "$1"
}
Pm.run() {
	pacman --noconfirm --config "${PACMAN_CONF-"/etc/pacman.conf"}" "$@"
}
Pm.runKey() {
	pacman-key --config "${PACMAN_CONF-"/etc/pacman.conf"}" "$@"
}
Pm.getName() {
	cut -d "<" -f 1 | cut -d ">" -f 1 | cut -d "=" -f 1
}
Pm.getLatestPkgVer() {
	local _LANG="${LANG-""}"
	export LANG=C
	if [[ -z ${*} ]]; then
		cat
	else
		PrintArray "$@"
	fi | ForEach Pm.run -Si "{}" | grep "^Version" | cut -d ":" -f 2 | RemoveBlank
	[[ -n $_LANG ]] && export LANG="$_LANG"
	return 0
}
Pm.getInstalledPkgVer() {
	if [[ -z ${*} ]]; then
		cat
	else
		PrintArray "$@"
	fi | ForEach pacman -Q "{}" | cut -d " " -f 2
	PrintArray "${PIPESTATUS[@]}" | grep -qx "1" && return 1
	return 0
}
Pm.getConfig() {
	LANG=C pacman-conf --config="${PACMAN_CONF-"/etc/pacman.conf"}" "$@"
}
Pm.pacmanGpg() {
	gpg --homedir "$(Pm.getConfig GPGDir)" "$@"
}
Pm.getDbSectionList() {
	grep -E "^%.*%$"
}
Pm.getDbNextSection() {
	Pm.getDbSectionList | grep -x -A 1 "^%$1%$" | GetLine 2 | sed "s|^%||g; s|%$||g"
}
Pm.getDbSection() {
	readarray -t _Stdin
	PrintArray "${_Stdin[@]}" | sed -ne "/^%$1%$/,/^%$(PrintEvalArray _Stdin | Pm.getDbNextSection "$1")%$/p" | sed '1d; $d'
}
Pm.isOpendSyncDb() {
	readarray -t _PkgDbList < <(find "$(Pm.getDbTmpDir)/sync/$1" -mindepth 1 -maxdepth 1 -type d)
	(("${#_PkgDbList[@]}" > 0)) && return 0
	return 1
}
Pm.createDbTmpDir() {
	mkdir -p "$(Pm.getDbTmpDir)"
}
Pm.getRepoListFromLocalDb() {
	find "$(Pm.getConfig DBPath)/sync" -mindepth 1 -maxdepth 1 -type f | GetBaseName | sed "s|.db$||g"
	return 0
}
Pm.getSyncDbDescPath() {
	local _repo
	_repo="$(pacman -Sp --print-format '%r' "$1")"
	{
		IsPacmanSyncDbOpend "$_repo" || OpenPacmanSyncDb "$_repo"
	} || return 1
	echo "$(Pm.getDbTmpDir)/sync/$(pacman -Sp --print-format '%r/%n-%v' "$1")"
}
Pm.openedSyncDbList() {
	find "$(Pm.getDbTmpDir)/sync/" -mindepth 1 -maxdepth 1 -type d
}
Pm.getSyncAllDesc() {
	find "$(Pm.getDbTmpDir)" -mindepth 3 -maxdepth 3 -name "desc" -type f
}
Pm.parsePkgFileName() {
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
Pm.getVirtualPkgList() {
	Pm.getRepoListFromLocalDb | ForEach Pm.openSyncDb {}
	Pm.getSyncAllDesc | ForEach eval "Pm.getDbSection PROVIDES < {}" | RemoveBlank
}
Pm.getPkgArch() {
	Pm.getSyncDbDesc "$1" | Pm.getDbSection ARCH | RemoveBlank
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
Pm.getSyncDbDesc() {
	local _path
	_path="$(Pm.getSyncDbDescPath "$1")"
	[[ -e $_path ]] || return 1
	cat "$_path/desc"
}
Pm.getDbTmpDir() {
	echo "${TMPDIR-"/tmp"}/fasbashlib-pacman-db"
}
Pm.deleteDbTmpDir() {
	rm -rf "$(Pm.getDbTmpDir)"
}
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
Prog.wideBar() {
	local Max="$1" Counter="$2"
	local StatusString="$Counter/$Max"
	local Size=$(($(Esc.GetTermX) - ${#StatusString} - 3))
	Prog.bar "$Max" "$Counter" "$Size"
}
Prog.rotation() {
	local Count="$1" CharList=('|' '/' '-' '\')
	Esc.ClearLineAndReturn
	[[ -n ${2-""} ]] && echo -n "${2}" 1>&2
	printf "%s" "${CharList["$((Count % "${#CharList[@]}"))"]}" 1>&2
}
Prog.bar() {
	local Max="$1" Counter="$2" Size="${3-"100"}"
	local SharpCount=$((Counter * Size / Max))
	local SpaceCount=$((Size - SharpCount))
	Esc.Return
	echo -n "$Counter/$Max [$(yes "#" | head -n "$SharpCount" 2>/dev/null | tr -d "\n")$(yes " " | head -n "$SpaceCount" 2>/dev/null | tr -d "\n")]"
}
CaptureSpecialKeys() {
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
		' ')
			echo "Space"
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
CheckMenu() {
	local arg OPTARG OPTIND
	local Choices=() CurrentSelected=() Key="" CurrentChoice=0
	local _question="" _number=false _selected=()
	while getopts "s:p:n" arg; do
		case "${arg}" in
		s)
			_selected+=("${OPTARG}")
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
	Choices=("$@")
	[[ ${#Choices[@]} -eq 0 ]] && return 1
	for i in "${!_selected[@]}"; do
		if Array.Include Choices "${Choices[$i]}"; then
			CurrentSelected+=("$i")
		fi
	done
	if [[ -n $_question ]]; then
		echo "$_question" 1>&2
	fi
	while [[ $Key != "Enter" ]]; do
		for i in "${!Choices[@]}"; do
			[[ $i == "$CurrentChoice" ]] && {
				Esc.Bold && Esc.Underline
			}
			if [[ ${CurrentSelected[*]} =~ $i ]]; then
				echo " [X] $i: ${Choices[$i]}" 1>&2
			else
				echo " [ ] $i: ${Choices[$i]}" 1>&2
			fi
			Esc.ResetStyle
		done
		Key="$(CaptureSpecialKeys)"
		case "$Key" in
		Up)
			(("$CurrentChoice" != 0)) && CurrentChoice=$((CurrentChoice - 1))
			;;
		Down)
			(("$CurrentChoice" != "${#Choices[@]}" - 1)) && CurrentChoice=$((CurrentChoice + 1))
			;;
		Space)
			if Array.Include CurrentSelected "$CurrentChoice"; then
				Array.Remove CurrentSelected "$CurrentChoice"
			else
				CurrentSelected+=("$CurrentChoice")
			fi
			;;
		esac
		Esc.ClearUpperLines "${#Choices[@]}"
	done
	if [[ -n $_question ]]; then
		Esc.ClearUpperLines 1
	fi
	if [[ $_number == true ]]; then
		Array.Eval CurrentSelected
	else
		Array.ForEach CurrentSelected eval 'echo ${Choices[{}]}'
	fi
	return 0
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
ChoiceLoop() {
	while true; do
		if Choice "$@"; then
			break
		fi
	done
}
SelectMenu() {
	local arg OPTARG OPTIND
	local Choices=() CurrentChoice=0 Key=""
	local _question="" _default="" _number=false
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
	Choices=("$@")
	[[ ${#Choices[@]} -eq 0 ]] && return 1
	[[ ${#Choices[@]} -eq 1 ]] && {
		echo "${Choices[0]}" && return 0
	}
	if [[ -n $_default ]] && Array.Include Choices "$_default"; then
		CurrentChoice="$(Array.Eval Choices | Array.IndexOf "$_default")"
	fi
	if [[ -n $_question ]]; then
		echo "$_question" 1>&2
	fi
	while [[ $Key != "Enter" ]]; do
		for i in "${!Choices[@]}"; do
			if [[ $i == "$CurrentChoice" ]]; then
				Esc.Bold && Esc.Underline
				echo " > $i: ${Choices[$i]}" 1>&2
			else
				echo "   $i: ${Choices[$i]}" 1>&2
			fi
			Esc.ResetStyle
		done
		Key="$(CaptureSpecialKeys)"
		case "$Key" in
		Up)
			(("$CurrentChoice" != 0)) && CurrentChoice=$((CurrentChoice - 1))
			;;
		Down)
			(("$CurrentChoice" != "${#Choices[@]}" - 1)) && CurrentChoice=$((CurrentChoice + 1))
			;;
		esac
		Esc.ClearUpperLines "${#Choices[@]}"
	done
	if [[ -n $_question ]]; then
		Esc.ClearUpperLines 1
	fi
	if [[ $_number == true ]]; then
		echo "$CurrentChoice"
	else
		echo "${Choices[$CurrentChoice]}"
	fi
	return 0
}
Arch.getKernelFileList() {
	find "/boot" -maxdepth 1 -mindepth 1 -name "vmlinuz-*"
}
Arch.getKernelSrcList() {
	find "/usr/src" -mindepth 1 -maxdepth 1 -type l -name "linux*"
}
Arch.getMkinitcpioPresetList() {
	find "/etc/mkinitcpio.d/" -name "*.preset" -type f | GetBaseName | RemoveFileExt
}
Array.shift() {
	readarray -t "$1" < <(PrintEvalArray "$1" | sed "1,${2-"1"}d")
}
Array.push() {
	eval "PrintArray \"\${$1[@]}\"" | grep -qx "$2" && return 0
	eval "$1+=(\"$2\")"
}
Array.append() {
	local _ArrName="$1"
	shift 1 || return 1
	readarray -t -O "$(ArrayIndex "$_ArrName")" "$_ArrName" < <(cat)
}
Array.remove() {
	readarray -t "$1" < <(PrintEvalArray "$1" | RemoveMatchLine "$2")
}
Array.pop() {
	readarray -t "$1" < <(PrintEvalArray "$1" | sed -e '$d')
}
Array.fromStr() {
	declare -a -x "$1"
	readarray -t "$1" < <(BreakChar)
}
Array.rev() {
	readarray -t "$1" < <(PrintEvalArray "$1" | tac)
}
Array.eval() {
	eval "PrintArray \"\${$1[@]}\""
}
Array.last() {
	PrintEval "$1[$(Array.lastIndex "$1")]"
}
Array.print() {
	(($# >= 1)) || return 0
	printf "%s\n" "${@}"
}
Array.length() {
	PrintEval "#${1}[@]"
}
Array.indexOf() {
	local n=()
	readarray -t n < <(grep -x -n "$1" | cut -d ":" -f 1 | ForEach eval echo '$(( {} - 1 ))')
	(("${#n[@]}" >= 1)) || return 1
	PrintArray "${n[@]}"
	return 0
}
Array.lastIndex() {
	CalcInt "$(Array.length "$1")" - 1
}
Array.forEach() {
	PrintEvalArray "$1" | ForEach "${@:2}"
}
Array.includes() {
	PrintEvalArray "$1" | grep -qx "$2"
}
Array.include() {
	Array.includes "$@"
}
Awk.print() {
	awk "BEGIN {print $*}"
}
Awk.pi() {
	Awk.float "atan2(0, -0)"
}
Awk.log() {
	Awk.float "log(${2}) / log($1)"
}
Awk.float() {
	awk "BEGIN {printf (\"%4.${AWKSCALE-"5"}f\n\", $*)}"
}
Awk.tan() {
	Awk.float "sin($1)/tan($1)"
}
Awk.sin() {
	Awk.float "sin($*)"
}
Awk.cos() {
	Awk.float "cos($*)"
}
Awk.rad() {
	Awk.float "$1 * $(Awk.pi) / 180 "
}
StrToCharList() {
	Array.FromStr "$1"
}
GetArrayIndex() {
	Array.IndexOf "$1"
}
ArrayIndex() {
	Array.Length "$1"
}
RevArray() {
	Array.Rev "$1"
}
ArrayAppend() {
	Array.Append "$1"
}
ArrayIncludes() {
	Array.Includes "$@"
}
PrintEvalArray() {
	Array.Eval "$1"
}
PrintArray() {
	Array.Print "$@"
}
AddNewToArray() {
	Array.Push "$@"
}
FileType() {
	file --mime-type -b "$1"
}
GetFileExt() {
	GetBaseName | rev | cut -d "." -f 1 | rev
}
RemoveFileExt() {
	local Ext
	ForEach eval 'Ext=$(GetFileExt <<< {}); sed "s|.$Ext$||g" <<< {}; unset Ext'
}
GetBaseName() {
	ForEach basename "{}"
}
CheckFuncDefined() {
	typeset -f "${1}" >/dev/null || return 1
}
IsAvailable() {
	type "$1" 2>/dev/null 1>&2
}
Loop() {
	local _T="$1"
	shift 1 || return 1
	((_T == 0)) && return 0
	ForEach "$@" < <(yes "" | head -n "$_T")
}
GetLine() {
	head -n "$1" | tail -n 1
}
ForEach() {
	local _Item
	while read -r _Item; do
		"${@//"{}"/"${_Item}"}" || return "${?}"
	done
}
BreakChar() {
	grep -o "."
}
ToLowerStdin() {
	local _Str
	ForEach eval '_Str="{}"; echo "${_Str,,}"'
	unset _Str
}
IsUUID() {
	local _UUID="${1-""}"
	[[ ${_UUID//-/} =~ ^[[:xdigit:]]{32}$ ]] && return 0
	return 1
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
GetMaxWidth() {
	awk '{ if ( length > x && length > 0 ) { x = length } }END{ print x }'
}
CutLastString() {
	echo "${1%%"${2}"}"
	return 0
}
GetLastSplitString() {
	rev <<<"$2" | cut -d "$1" -f 1 | rev
}
CalcInt() {
	echo "$(("$@"))"
}
Sum() {
	local _Arg=()
	ForEach eval '_Arg+=("{}" "+")' < <(PrintArray "$@")
	readarray -t _Arg < <(PrintArray "${_Arg[@]}" | sed "${#_Arg[@]}d")
	CalcInt "${_Arg[@]}"
}
Ntest() {
	(("$@")) || return 1
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
ToArgs() {
	readarray -t args
	"$@" "${args[@]}"
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
Cache.getTimeDiffFromLastUpdate() {
	local _Now _Last
	_Now="$(date "+%s")"
	_Last="$(Cache.getFileLastUpdate "$1")"
	echo "$((_Now - _Last))"
	return 0
}
Cache.get() {
	cat "$(Cache.getDir)/$1" 2>/dev/null || return 1
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
Cache.exist() {
	local _File
	_File="$(Cache.createDir)/$1"
	[[ -e $_File ]] || return 1
	(("$(Cache.getTimeDiffFromLastUpdate "$_File")" > "${KEEPCACHESEC-"86400"}")) && return 2
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
Cache.create() {
	Cache.createDir >/dev/null
	cat >"$(Cache.getDir)/${1}"
	cat "$(Cache.getDir)/$1"
}
Cache.createDir() {
	FSBLIB_CACHEID="${FSBLIB_CACHEID-"$(RandomString "10")"}"
	export FSBLIB_CACHEID="$FSBLIB_CACHEID"
	local TMPDIR="${TMPDIR-"/tmp"}"
	local _Dir="$TMPDIR/${FSBLIB_CACHEID}"
	mkdir -p "$_Dir"
	echo "$_Dir"
	return 0
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
fsblibEnvCheck() {
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
Csv.toBashArray() {
	local _RawCsvLine=() _Line _ClmCnt=0
	local ArrayPrefix="${ArrayPrefix-"{}"}"
	readarray -t _RawCsvLine < <(
		while read -r _Line; do
			(($(tr "${CSVDELIM-","}" "\n" <<<"$_Line" | wc -l) >= ${#})) && echo "$_Line"
		done < <(grep -v "^#")
	)
	_ClmCnt=$(PrintArray "${_RawCsvLine[@]}" | Csv.getClmCnt)
	while read -r _Cnt; do
		readarray -t "$(sed "s|{}|$(eval "echo \"\${${_Cnt}}\"")|g" <<<"$ArrayPrefix")" < <(
			PrintArray "${_RawCsvLine[@]}" | cut -d "${CSVDELIM-","}" -f "$_Cnt"
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
	done < <(PrintArray "${_RawCsvLine[@]}")
	RemoveBlank <<<"$_ClmCnt"
	return 0
}
Csv.getClm() {
	grep -v "^#" | sed "/^$/d" | cut -d "${CSVDELIM-","}" -f "$1"
}
Em.getWorldPkgList() {
	sed -E 's|:.+$||g' /var/lib/portage/world | xargs -I{} bash -c 'ls -d /var/db/pkg/{}-* | sed "s|/var/db/pkg/||g" | grep -E "{}-[0-9]"'
}
Em.getInstalledPkgList() {
	find /var/db/pkg/ -mindepth 2 -maxdepth 2 -type d | sed 's|/var/db/pkg/||g'
}
Em.getDefaultRepoName() {
	Em.getRepoConf | Ini.GetParam DEFAULT main-repo
}
Em.getRepoLocation() {
	Em.getRepoConf | Ini.GetParam "$1" location
}
Em.getAllPkgList() {
	Em.getRepoConf | sed -e 's/^ *//' -e 's/ *$//' | grep "^ *location *=" | sed -e 's/^location *= *//' | xargs -L1 realpath | xargs -I{} bash -c "find '{}' -mindepth 3 -maxdepth 3 -type f -name '*.ebuild' | sed -e 's|{}/||g' -e 's|.ebuild$||g'" | awk -F "/" '{print $1"/"$3}'
}
Em.getRepoPkgList() {
	local _RepoPath
	_RepoPath="$(Em.getRepoLocation "$1")"
	find "$_RepoPath" -mindepth 3 -maxdepth 3 -type f -name '*.ebuild' | sed -e "s|${_RepoPath%/}/||g" -e 's|.ebuild$||g' | awk -F "/" '{print $1"/"$3}'
}
Em.getRepoConf() {
	cat /etc/portage/repos.conf /etc/portage/repos.conf/* 2>/dev/null
}
Em.noVersion() {
	sed -E 's|\-[0-9]+.+||g'
}
Esc.return() {
	printf "\r" >/dev/tty
}
Esc.clearLeft() {
	printf "\033[1K" >/dev/tty
}
Esc.clearLine() {
	printf "\033[2K" >/dev/tty
}
Esc.clearScreen() {
	printf "\033[2J" >/dev/tty
}
Esc.clearRight() {
	printf "\033[0K" >/dev/tty
}
Esc.getTermY() {
	[[ -n ${LINES-""} ]] && echo "$LINES" && return 0
	tput lines
}
Esc.getX() {
	local _POS
	printf "\033[6n" >>/dev/tty
	read -r -s -d "R" _POS
	echo $(("$(printf "%s\n" "${_POS:2}" | cut -d";" -f2)" - 1))
}
Esc.getTermX() {
	[[ -n ${COLUMNS-""} ]] && echo "$COLUMNS" && return 0
	tput cols
}
Esc.moveCursorLeft() {
	printf "\033[%dD" "$1" >/dev/tty
}
Esc.getY() {
	local _POS
	printf "\033[6n" >>/dev/tty
	read -r -s -d "R" _POS
	echo $(("$(printf "%s\n" "${_POS:2}" | cut -d";" -f1)" - 1))
}
Esc.moveCursorDown() {
	printf "\033[%dB" "$1" >/dev/tty
}
Esc.moveCursorRight() {
	printf "\033[%dC" "$1" >/dev/tty
}
Esc.moveCursor() {
	printf "\033[%d;%dH" "$1" "$2" >/dev/tty
}
Esc.moveCursorUp() {
	printf "\033[%dA" "$1" >/dev/tty
}
Esc.clearLineAndReturn() {
	Esc.clearLine
	Esc.return
}
Esc.clearUpperLines() {
	for i in $(seq 1 "$1"); do
		Esc.moveCursorUp 1
		Esc.clearLine
	done
}
Esc.blackBackground() {
	printf "\033[40m" >/dev/tty
}
Esc.cyanBackground() {
	printf "\033[46m" >/dev/tty
}
Esc.greenBackground() {
	printf "\033[42m" >/dev/tty
}
Esc.magentaText() {
	printf "\033[35m" >/dev/tty
}
Esc.lowIntensity() {
	printf "\033[2m" >/dev/tty
}
Esc.blueText() {
	printf "\033[34m" >/dev/tty
}
Esc.redBackground() {
	printf "\033[41m" >/dev/tty
}
Esc.magentaBackground() {
	printf "\033[45m" >/dev/tty
}
Esc.greenText() {
	printf "\033[32m" >/dev/tty
}
Esc.italic() {
	printf "\033[3m" >/dev/tty
}
Esc.blink() {
	printf "\033[5m" >/dev/tty
}
Esc.yellowText() {
	printf "\033[33m" >/dev/tty
}
Esc.whiteBackground() {
	printf "\033[47m" >/dev/tty
}
Esc.reverse() {
	printf "\033[7m" >/dev/tty
}
Esc.redText() {
	printf "\033[31m" >/dev/tty
}
Esc.conceal() {
	printf "\033[8m" >/dev/tty
}
Esc.yellowBackground() {
	printf "\033[43m" >/dev/tty
}
Esc.crossedOut() {
	printf "\033[9m" >/dev/tty
}
Esc.underline() {
	printf "\033[4m" >/dev/tty
}
Esc.resetStyle() {
	printf "\033[0m" >/dev/tty
}
Esc.rapidBlink() {
	printf "\033[6m" >/dev/tty
}
Esc.cyanText() {
	printf "\033[36m" >/dev/tty
}
Esc.blueBackground() {
	printf "\033[44m" >/dev/tty
}
Esc.bold() {
	printf "\033[1m" >/dev/tty
}
Esc.whiteText() {
	printf "\033[37m" >/dev/tty
}
Esc.blackText() {
	printf "\033[30m" >/dev/tty
}
Ini.getLastParam() {
	Ini.getParamList "$1" | tail -n 1
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
	done < <(PrintArray "${_RawIniLine[@]}")
	return "$_Exit"
}
Ini.parseLine() {
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
	done < <(PrintArray "${_RawIniLine[@]}")
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
	done < <(PrintArray "${_RawIniLine[@]}")
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
	if ! PrintArray "${IniContents[@]}" | Ini.getParamList "$Section" | grep -qx "$Param"; then
		SectionLastParam="$(PrintEvalArray IniContents | Ini.getLastParam "$Section")"
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
Ini.setValue() {
	local IniContents=()
	local Section="$1" Param="$2"
	readarray -t IniContents
	readarray -t IniContents < <(PrintArray "${IniContents[@]}" | Ini.newSection "$Section" | Ini.newParam "$Section" "$Param")
	PrintEvalArray IniContents
}
Ini.newSection() {
	local IniContents=()
	local Section="$1"
	readarray -t IniContents
	if PrintArray "${IniContents[@]}" | Ini.getSectionList | grep -x "$Section" >/dev/null; then
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
LibreTranslate.languages() {
	LibreTranslate.check || return 2
	curl -s "${LIBRETRANSLATE_URL}/languages" | jq -r '.[].code'
}
LibreTranslate.translateAuto() {
	LibreTranslate.check || return 2
	LibreTranslate.translate "${1:-""}" "$(LibreTranslate.detect "${1:-""}")" "${2:-""}"
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
Misskey.notes.Renotes() {
	Misskey.bindingBase "notes/renotes" noteId limit sinceId untilId -- "$@"
}
Misskey.notes.Search() {
	Misskey.bindingBase "notes/search" query limit -- "$@"
}
Misskey.notes.Create() {
	Misskey.bindingBase "notes/create" text -- "$@"
}
Misskey.users.GetFrequentlyRepliedUsers() {
	Misskey.bindingBase "users/get-frequently-replied-users" userId -- "${1:-"$(Misskey.myId)"}" "${@:2}"
}
Misskey.users.Stats() {
	Misskey.bindingBase "users/stats" userId -- "${1:-"$(Misskey.myId)"}" "${@:2}"
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
Misskey.sendReq() {
	local _Url="$1" _CurlArgs=()
	shift 1
	_CurlArgs+=(-s -L)
	_CurlArgs+=(-X POST)
	_CurlArgs+=(-H "Content-Type: application/json")
	_CurlArgs+=(-d "$(Misskey.makeJson "$@")")
	_CurlArgs+=("$_Url")
	Msg.Debug "Run: ${_CurlArgs[*]//"${MISSKEY_TOKEN}"/"TOKEN"}"
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
	if ! Bool _Shifted; then
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
Misskey.isAdmin() {
	Bool "$(Misskey.i | jq -r ".isAdmin")"
}
Misskey.myId() {
	Misskey.i | jq -r ".id"
}
Misskey.myUserName() {
	Misskey.i | jq -r ".username"
}
Misskey.myName() {
	Misskey.i | jq -r ".name"
}
Pm.checkPkg() {
	local p
	for p in "$@"; do
		Pm.run -Qq "$p" >/dev/null 2>&1 || return 1
	done
	return 0
}
Pm.getKeyringList() {
	find "$(@GetKeyringDir)" -name "*.gpg" | GetBaseName | RemoveFileExt
}
Pm.getRepoListFromConf() {
	Pm.getConfig --repo-list
}
Pm.getRepoPkgList() {
	Pm.run -Slq "$@"
}
Pm.isRepoPkg() {
	Pm.run -Slq | grep -qx "$(Pm.getName <<<"$1")"
}
Pm.getRoot() {
	Pm.getConfig RootDir
}
Pm.getRepoConf() {
	ForEach eval 'echo [{}] && Pm.getConfig -r {}'
}
Pm.getPacmanKernelPkg() {
	echo "there is nothing"
}
Pm.getRepoServer() {
	ForEach eval 'Pm.getConfig -r {}' | grep "^Server" | ForEach eval "Ini.ParseLine <<< '{}' ; printf '%s\n' \${VALUE}"
}
Pm.getPacmanKeyringDir() {
	local _KeyringDir=""
	_KeyringDir="$(LANG=C pacman-key -h | RemoveBlank | grep -A 1 -- "^--populate" | tail -n 1 | cut -d "/" -f 2- | sed "s|'$||g")"
	: "${_KeyringDir="usr/share/pacman/keyrings"}"
	_KeyringDir="$(Pm.getRoot)/$_KeyringDir"
	_KeyringDir="$(sed -E "s|/+|/|g" <<<"$_KeyringDir")"
	if [[ -e $_KeyringDir ]]; then
		Readlinkf "$_KeyringDir"
	else
		echo "$_KeyringDir"
	fi
}
Pm.getRepoVer() {
	Pm.run -Sp --print-format '%v' "$1"
}
Pm.run() {
	pacman --noconfirm --config "${PACMAN_CONF-"/etc/pacman.conf"}" "$@"
}
Pm.runKey() {
	pacman-key --config "${PACMAN_CONF-"/etc/pacman.conf"}" "$@"
}
Pm.getName() {
	cut -d "<" -f 1 | cut -d ">" -f 1 | cut -d "=" -f 1
}
Pm.getLatestPkgVer() {
	local _LANG="${LANG-""}"
	export LANG=C
	if [[ -z ${*} ]]; then
		cat
	else
		PrintArray "$@"
	fi | ForEach Pm.run -Si "{}" | grep "^Version" | cut -d ":" -f 2 | RemoveBlank
	[[ -n $_LANG ]] && export LANG="$_LANG"
	return 0
}
Pm.getInstalledPkgVer() {
	if [[ -z ${*} ]]; then
		cat
	else
		PrintArray "$@"
	fi | ForEach pacman -Q "{}" | cut -d " " -f 2
	PrintArray "${PIPESTATUS[@]}" | grep -qx "1" && return 1
	return 0
}
Pm.getConfig() {
	LANG=C pacman-conf --config="${PACMAN_CONF-"/etc/pacman.conf"}" "$@"
}
Pm.pacmanGpg() {
	gpg --homedir "$(Pm.getConfig GPGDir)" "$@"
}
Pm.getDbSectionList() {
	grep -E "^%.*%$"
}
Pm.getDbNextSection() {
	Pm.getDbSectionList | grep -x -A 1 "^%$1%$" | GetLine 2 | sed "s|^%||g; s|%$||g"
}
Pm.getDbSection() {
	readarray -t _Stdin
	PrintArray "${_Stdin[@]}" | sed -ne "/^%$1%$/,/^%$(PrintEvalArray _Stdin | Pm.getDbNextSection "$1")%$/p" | sed '1d; $d'
}
Pm.isOpendSyncDb() {
	readarray -t _PkgDbList < <(find "$(Pm.getDbTmpDir)/sync/$1" -mindepth 1 -maxdepth 1 -type d)
	(("${#_PkgDbList[@]}" > 0)) && return 0
	return 1
}
Pm.createDbTmpDir() {
	mkdir -p "$(Pm.getDbTmpDir)"
}
Pm.getRepoListFromLocalDb() {
	find "$(Pm.getConfig DBPath)/sync" -mindepth 1 -maxdepth 1 -type f | GetBaseName | sed "s|.db$||g"
	return 0
}
Pm.getSyncDbDescPath() {
	local _repo
	_repo="$(pacman -Sp --print-format '%r' "$1")"
	{
		IsPacmanSyncDbOpend "$_repo" || OpenPacmanSyncDb "$_repo"
	} || return 1
	echo "$(Pm.getDbTmpDir)/sync/$(pacman -Sp --print-format '%r/%n-%v' "$1")"
}
Pm.openedSyncDbList() {
	find "$(Pm.getDbTmpDir)/sync/" -mindepth 1 -maxdepth 1 -type d
}
Pm.getSyncAllDesc() {
	find "$(Pm.getDbTmpDir)" -mindepth 3 -maxdepth 3 -name "desc" -type f
}
Pm.parsePkgFileName() {
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
Pm.getVirtualPkgList() {
	Pm.getRepoListFromLocalDb | ForEach Pm.openSyncDb {}
	Pm.getSyncAllDesc | ForEach eval "Pm.getDbSection PROVIDES < {}" | RemoveBlank
}
Pm.getPkgArch() {
	Pm.getSyncDbDesc "$1" | Pm.getDbSection ARCH | RemoveBlank
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
Pm.getSyncDbDesc() {
	local _path
	_path="$(Pm.getSyncDbDescPath "$1")"
	[[ -e $_path ]] || return 1
	cat "$_path/desc"
}
Pm.getDbTmpDir() {
	echo "${TMPDIR-"/tmp"}/fasbashlib-pacman-db"
}
Pm.deleteDbTmpDir() {
	rm -rf "$(Pm.getDbTmpDir)"
}
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
Prog.wideBar() {
	local Max="$1" Counter="$2"
	local StatusString="$Counter/$Max"
	local Size=$(($(Esc.GetTermX) - ${#StatusString} - 3))
	Prog.bar "$Max" "$Counter" "$Size"
}
Prog.rotation() {
	local Count="$1" CharList=('|' '/' '-' '\')
	Esc.ClearLineAndReturn
	[[ -n ${2-""} ]] && echo -n "${2}" 1>&2
	printf "%s" "${CharList["$((Count % "${#CharList[@]}"))"]}" 1>&2
}
Prog.bar() {
	local Max="$1" Counter="$2" Size="${3-"100"}"
	local SharpCount=$((Counter * Size / Max))
	local SpaceCount=$((Size - SharpCount))
	Esc.Return
	echo -n "$Counter/$Max [$(yes "#" | head -n "$SharpCount" 2>/dev/null | tr -d "\n")$(yes " " | head -n "$SpaceCount" 2>/dev/null | tr -d "\n")]"
}
CaptureSpecialKeys() {
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
		' ')
			echo "Space"
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
CheckMenu() {
	local arg OPTARG OPTIND
	local Choices=() CurrentSelected=() Key="" CurrentChoice=0
	local _question="" _number=false _selected=()
	while getopts "s:p:n" arg; do
		case "${arg}" in
		s)
			_selected+=("${OPTARG}")
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
	Choices=("$@")
	[[ ${#Choices[@]} -eq 0 ]] && return 1
	for i in "${!_selected[@]}"; do
		if Array.Include Choices "${Choices[$i]}"; then
			CurrentSelected+=("$i")
		fi
	done
	if [[ -n $_question ]]; then
		echo "$_question" 1>&2
	fi
	while [[ $Key != "Enter" ]]; do
		for i in "${!Choices[@]}"; do
			[[ $i == "$CurrentChoice" ]] && {
				Esc.Bold && Esc.Underline
			}
			if [[ ${CurrentSelected[*]} =~ $i ]]; then
				echo " [X] $i: ${Choices[$i]}" 1>&2
			else
				echo " [ ] $i: ${Choices[$i]}" 1>&2
			fi
			Esc.ResetStyle
		done
		Key="$(CaptureSpecialKeys)"
		case "$Key" in
		Up)
			(("$CurrentChoice" != 0)) && CurrentChoice=$((CurrentChoice - 1))
			;;
		Down)
			(("$CurrentChoice" != "${#Choices[@]}" - 1)) && CurrentChoice=$((CurrentChoice + 1))
			;;
		Space)
			if Array.Include CurrentSelected "$CurrentChoice"; then
				Array.Remove CurrentSelected "$CurrentChoice"
			else
				CurrentSelected+=("$CurrentChoice")
			fi
			;;
		esac
		Esc.ClearUpperLines "${#Choices[@]}"
	done
	if [[ -n $_question ]]; then
		Esc.ClearUpperLines 1
	fi
	if [[ $_number == true ]]; then
		Array.Eval CurrentSelected
	else
		Array.ForEach CurrentSelected eval 'echo ${Choices[{}]}'
	fi
	return 0
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
ChoiceLoop() {
	while true; do
		if Choice "$@"; then
			break
		fi
	done
}
SelectMenu() {
	local arg OPTARG OPTIND
	local Choices=() CurrentChoice=0 Key=""
	local _question="" _default="" _number=false
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
	Choices=("$@")
	[[ ${#Choices[@]} -eq 0 ]] && return 1
	[[ ${#Choices[@]} -eq 1 ]] && {
		echo "${Choices[0]}" && return 0
	}
	if [[ -n $_default ]] && Array.Include Choices "$_default"; then
		CurrentChoice="$(Array.Eval Choices | Array.IndexOf "$_default")"
	fi
	if [[ -n $_question ]]; then
		echo "$_question" 1>&2
	fi
	while [[ $Key != "Enter" ]]; do
		for i in "${!Choices[@]}"; do
			if [[ $i == "$CurrentChoice" ]]; then
				Esc.Bold && Esc.Underline
				echo " > $i: ${Choices[$i]}" 1>&2
			else
				echo "   $i: ${Choices[$i]}" 1>&2
			fi
			Esc.ResetStyle
		done
		Key="$(CaptureSpecialKeys)"
		case "$Key" in
		Up)
			(("$CurrentChoice" != 0)) && CurrentChoice=$((CurrentChoice - 1))
			;;
		Down)
			(("$CurrentChoice" != "${#Choices[@]}" - 1)) && CurrentChoice=$((CurrentChoice + 1))
			;;
		esac
		Esc.ClearUpperLines "${#Choices[@]}"
	done
	if [[ -n $_question ]]; then
		Esc.ClearUpperLines 1
	fi
	if [[ $_number == true ]]; then
		echo "$CurrentChoice"
	else
		echo "${Choices[$CurrentChoice]}"
	fi
	return 0
}
Readlinkf_Posix() {
	Readlinkf.Posix "$@"
}
Readlinkf_Readlink() {
	Readlinkf.Readlink "$@"
}
Arch.getKernelFileList() {
	find "/boot" -maxdepth 1 -mindepth 1 -name "vmlinuz-*"
}
Arch.getKernelSrcList() {
	find "/usr/src" -mindepth 1 -maxdepth 1 -type l -name "linux*"
}
Arch.getMkinitcpioPresetList() {
	find "/etc/mkinitcpio.d/" -name "*.preset" -type f | GetBaseName | RemoveFileExt
}
Array.shift() {
	readarray -t "$1" < <(PrintEvalArray "$1" | sed "1,${2-"1"}d")
}
Array.push() {
	eval "PrintArray \"\${$1[@]}\"" | grep -qx "$2" && return 0
	eval "$1+=(\"$2\")"
}
Array.append() {
	local _ArrName="$1"
	shift 1 || return 1
	readarray -t -O "$(ArrayIndex "$_ArrName")" "$_ArrName" < <(cat)
}
Array.remove() {
	readarray -t "$1" < <(PrintEvalArray "$1" | RemoveMatchLine "$2")
}
Array.pop() {
	readarray -t "$1" < <(PrintEvalArray "$1" | sed -e '$d')
}
Array.fromStr() {
	declare -a -x "$1"
	readarray -t "$1" < <(BreakChar)
}
Array.rev() {
	readarray -t "$1" < <(PrintEvalArray "$1" | tac)
}
Array.eval() {
	eval "PrintArray \"\${$1[@]}\""
}
Array.last() {
	PrintEval "$1[$(Array.lastIndex "$1")]"
}
Array.print() {
	(($# >= 1)) || return 0
	printf "%s\n" "${@}"
}
Array.length() {
	PrintEval "#${1}[@]"
}
Array.indexOf() {
	local n=()
	readarray -t n < <(grep -x -n "$1" | cut -d ":" -f 1 | ForEach eval echo '$(( {} - 1 ))')
	(("${#n[@]}" >= 1)) || return 1
	PrintArray "${n[@]}"
	return 0
}
Array.lastIndex() {
	CalcInt "$(Array.length "$1")" - 1
}
Array.forEach() {
	PrintEvalArray "$1" | ForEach "${@:2}"
}
Array.includes() {
	PrintEvalArray "$1" | grep -qx "$2"
}
Array.include() {
	Array.includes "$@"
}
Awk.print() {
	awk "BEGIN {print $*}"
}
Awk.pi() {
	Awk.float "atan2(0, -0)"
}
Awk.log() {
	Awk.float "log(${2}) / log($1)"
}
Awk.float() {
	awk "BEGIN {printf (\"%4.${AWKSCALE-"5"}f\n\", $*)}"
}
Awk.tan() {
	Awk.float "sin($1)/tan($1)"
}
Awk.sin() {
	Awk.float "sin($*)"
}
Awk.cos() {
	Awk.float "cos($*)"
}
Awk.rad() {
	Awk.float "$1 * $(Awk.pi) / 180 "
}
StrToCharList() {
	Array.FromStr "$1"
}
GetArrayIndex() {
	Array.IndexOf "$1"
}
ArrayIndex() {
	Array.Length "$1"
}
RevArray() {
	Array.Rev "$1"
}
ArrayAppend() {
	Array.Append "$1"
}
ArrayIncludes() {
	Array.Includes "$@"
}
PrintEvalArray() {
	Array.Eval "$1"
}
PrintArray() {
	Array.Print "$@"
}
AddNewToArray() {
	Array.Push "$@"
}
FileType() {
	file --mime-type -b "$1"
}
GetFileExt() {
	GetBaseName | rev | cut -d "." -f 1 | rev
}
RemoveFileExt() {
	local Ext
	ForEach eval 'Ext=$(GetFileExt <<< {}); sed "s|.$Ext$||g" <<< {}; unset Ext'
}
GetBaseName() {
	ForEach basename "{}"
}
CheckFuncDefined() {
	typeset -f "${1}" >/dev/null || return 1
}
IsAvailable() {
	type "$1" 2>/dev/null 1>&2
}
Loop() {
	local _T="$1"
	shift 1 || return 1
	((_T == 0)) && return 0
	ForEach "$@" < <(yes "" | head -n "$_T")
}
GetLine() {
	head -n "$1" | tail -n 1
}
ForEach() {
	local _Item
	while read -r _Item; do
		"${@//"{}"/"${_Item}"}" || return "${?}"
	done
}
BreakChar() {
	grep -o "."
}
ToLowerStdin() {
	local _Str
	ForEach eval '_Str="{}"; echo "${_Str,,}"'
	unset _Str
}
IsUUID() {
	local _UUID="${1-""}"
	[[ ${_UUID//-/} =~ ^[[:xdigit:]]{32}$ ]] && return 0
	return 1
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
GetMaxWidth() {
	awk '{ if ( length > x && length > 0 ) { x = length } }END{ print x }'
}
CutLastString() {
	echo "${1%%"${2}"}"
	return 0
}
GetLastSplitString() {
	rev <<<"$2" | cut -d "$1" -f 1 | rev
}
CalcInt() {
	echo "$(("$@"))"
}
Sum() {
	local _Arg=()
	ForEach eval '_Arg+=("{}" "+")' < <(PrintArray "$@")
	readarray -t _Arg < <(PrintArray "${_Arg[@]}" | sed "${#_Arg[@]}d")
	CalcInt "${_Arg[@]}"
}
Ntest() {
	(("$@")) || return 1
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
ToArgs() {
	readarray -t args
	"$@" "${args[@]}"
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
Cache.getTimeDiffFromLastUpdate() {
	local _Now _Last
	_Now="$(date "+%s")"
	_Last="$(Cache.getFileLastUpdate "$1")"
	echo "$((_Now - _Last))"
	return 0
}
Cache.get() {
	cat "$(Cache.getDir)/$1" 2>/dev/null || return 1
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
Cache.exist() {
	local _File
	_File="$(Cache.createDir)/$1"
	[[ -e $_File ]] || return 1
	(("$(Cache.getTimeDiffFromLastUpdate "$_File")" > "${KEEPCACHESEC-"86400"}")) && return 2
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
Cache.create() {
	Cache.createDir >/dev/null
	cat >"$(Cache.getDir)/${1}"
	cat "$(Cache.getDir)/$1"
}
Cache.createDir() {
	FSBLIB_CACHEID="${FSBLIB_CACHEID-"$(RandomString "10")"}"
	export FSBLIB_CACHEID="$FSBLIB_CACHEID"
	local TMPDIR="${TMPDIR-"/tmp"}"
	local _Dir="$TMPDIR/${FSBLIB_CACHEID}"
	mkdir -p "$_Dir"
	echo "$_Dir"
	return 0
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
fsblibEnvCheck() {
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
Csv.toBashArray() {
	local _RawCsvLine=() _Line _ClmCnt=0
	local ArrayPrefix="${ArrayPrefix-"{}"}"
	readarray -t _RawCsvLine < <(
		while read -r _Line; do
			(($(tr "${CSVDELIM-","}" "\n" <<<"$_Line" | wc -l) >= ${#})) && echo "$_Line"
		done < <(grep -v "^#")
	)
	_ClmCnt=$(PrintArray "${_RawCsvLine[@]}" | Csv.getClmCnt)
	while read -r _Cnt; do
		readarray -t "$(sed "s|{}|$(eval "echo \"\${${_Cnt}}\"")|g" <<<"$ArrayPrefix")" < <(
			PrintArray "${_RawCsvLine[@]}" | cut -d "${CSVDELIM-","}" -f "$_Cnt"
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
	done < <(PrintArray "${_RawCsvLine[@]}")
	RemoveBlank <<<"$_ClmCnt"
	return 0
}
Csv.getClm() {
	grep -v "^#" | sed "/^$/d" | cut -d "${CSVDELIM-","}" -f "$1"
}
Em.getWorldPkgList() {
	sed -E 's|:.+$||g' /var/lib/portage/world | xargs -I{} bash -c 'ls -d /var/db/pkg/{}-* | sed "s|/var/db/pkg/||g" | grep -E "{}-[0-9]"'
}
Em.getInstalledPkgList() {
	find /var/db/pkg/ -mindepth 2 -maxdepth 2 -type d | sed 's|/var/db/pkg/||g'
}
Em.getDefaultRepoName() {
	Em.getRepoConf | Ini.GetParam DEFAULT main-repo
}
Em.getRepoLocation() {
	Em.getRepoConf | Ini.GetParam "$1" location
}
Em.getAllPkgList() {
	Em.getRepoConf | sed -e 's/^ *//' -e 's/ *$//' | grep "^ *location *=" | sed -e 's/^location *= *//' | xargs -L1 realpath | xargs -I{} bash -c "find '{}' -mindepth 3 -maxdepth 3 -type f -name '*.ebuild' | sed -e 's|{}/||g' -e 's|.ebuild$||g'" | awk -F "/" '{print $1"/"$3}'
}
Em.getRepoPkgList() {
	local _RepoPath
	_RepoPath="$(Em.getRepoLocation "$1")"
	find "$_RepoPath" -mindepth 3 -maxdepth 3 -type f -name '*.ebuild' | sed -e "s|${_RepoPath%/}/||g" -e 's|.ebuild$||g' | awk -F "/" '{print $1"/"$3}'
}
Em.getRepoConf() {
	cat /etc/portage/repos.conf /etc/portage/repos.conf/* 2>/dev/null
}
Em.noVersion() {
	sed -E 's|\-[0-9]+.+||g'
}
Esc.return() {
	printf "\r" >/dev/tty
}
Esc.clearLeft() {
	printf "\033[1K" >/dev/tty
}
Esc.clearLine() {
	printf "\033[2K" >/dev/tty
}
Esc.clearScreen() {
	printf "\033[2J" >/dev/tty
}
Esc.clearRight() {
	printf "\033[0K" >/dev/tty
}
Esc.getTermY() {
	[[ -n ${LINES-""} ]] && echo "$LINES" && return 0
	tput lines
}
Esc.getX() {
	local _POS
	printf "\033[6n" >>/dev/tty
	read -r -s -d "R" _POS
	echo $(("$(printf "%s\n" "${_POS:2}" | cut -d";" -f2)" - 1))
}
Esc.getTermX() {
	[[ -n ${COLUMNS-""} ]] && echo "$COLUMNS" && return 0
	tput cols
}
Esc.moveCursorLeft() {
	printf "\033[%dD" "$1" >/dev/tty
}
Esc.getY() {
	local _POS
	printf "\033[6n" >>/dev/tty
	read -r -s -d "R" _POS
	echo $(("$(printf "%s\n" "${_POS:2}" | cut -d";" -f1)" - 1))
}
Esc.moveCursorDown() {
	printf "\033[%dB" "$1" >/dev/tty
}
Esc.moveCursorRight() {
	printf "\033[%dC" "$1" >/dev/tty
}
Esc.moveCursor() {
	printf "\033[%d;%dH" "$1" "$2" >/dev/tty
}
Esc.moveCursorUp() {
	printf "\033[%dA" "$1" >/dev/tty
}
Esc.clearLineAndReturn() {
	Esc.clearLine
	Esc.return
}
Esc.clearUpperLines() {
	for i in $(seq 1 "$1"); do
		Esc.moveCursorUp 1
		Esc.clearLine
	done
}
Esc.blackBackground() {
	printf "\033[40m" >/dev/tty
}
Esc.cyanBackground() {
	printf "\033[46m" >/dev/tty
}
Esc.greenBackground() {
	printf "\033[42m" >/dev/tty
}
Esc.magentaText() {
	printf "\033[35m" >/dev/tty
}
Esc.lowIntensity() {
	printf "\033[2m" >/dev/tty
}
Esc.blueText() {
	printf "\033[34m" >/dev/tty
}
Esc.redBackground() {
	printf "\033[41m" >/dev/tty
}
Esc.magentaBackground() {
	printf "\033[45m" >/dev/tty
}
Esc.greenText() {
	printf "\033[32m" >/dev/tty
}
Esc.italic() {
	printf "\033[3m" >/dev/tty
}
Esc.blink() {
	printf "\033[5m" >/dev/tty
}
Esc.yellowText() {
	printf "\033[33m" >/dev/tty
}
Esc.whiteBackground() {
	printf "\033[47m" >/dev/tty
}
Esc.reverse() {
	printf "\033[7m" >/dev/tty
}
Esc.redText() {
	printf "\033[31m" >/dev/tty
}
Esc.conceal() {
	printf "\033[8m" >/dev/tty
}
Esc.yellowBackground() {
	printf "\033[43m" >/dev/tty
}
Esc.crossedOut() {
	printf "\033[9m" >/dev/tty
}
Esc.underline() {
	printf "\033[4m" >/dev/tty
}
Esc.resetStyle() {
	printf "\033[0m" >/dev/tty
}
Esc.rapidBlink() {
	printf "\033[6m" >/dev/tty
}
Esc.cyanText() {
	printf "\033[36m" >/dev/tty
}
Esc.blueBackground() {
	printf "\033[44m" >/dev/tty
}
Esc.bold() {
	printf "\033[1m" >/dev/tty
}
Esc.whiteText() {
	printf "\033[37m" >/dev/tty
}
Esc.blackText() {
	printf "\033[30m" >/dev/tty
}
Ini.getLastParam() {
	Ini.getParamList "$1" | tail -n 1
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
	done < <(PrintArray "${_RawIniLine[@]}")
	return "$_Exit"
}
Ini.parseLine() {
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
	done < <(PrintArray "${_RawIniLine[@]}")
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
	done < <(PrintArray "${_RawIniLine[@]}")
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
	if ! PrintArray "${IniContents[@]}" | Ini.getParamList "$Section" | grep -qx "$Param"; then
		SectionLastParam="$(PrintEvalArray IniContents | Ini.getLastParam "$Section")"
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
Ini.setValue() {
	local IniContents=()
	local Section="$1" Param="$2"
	readarray -t IniContents
	readarray -t IniContents < <(PrintArray "${IniContents[@]}" | Ini.newSection "$Section" | Ini.newParam "$Section" "$Param")
	PrintEvalArray IniContents
}
Ini.newSection() {
	local IniContents=()
	local Section="$1"
	readarray -t IniContents
	if PrintArray "${IniContents[@]}" | Ini.getSectionList | grep -x "$Section" >/dev/null; then
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
LibreTranslate.languages() {
	LibreTranslate.check || return 2
	curl -s "${LIBRETRANSLATE_URL}/languages" | jq -r '.[].code'
}
LibreTranslate.translateAuto() {
	LibreTranslate.check || return 2
	LibreTranslate.translate "${1:-""}" "$(LibreTranslate.detect "${1:-""}")" "${2:-""}"
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
Misskey.notes.Renotes() {
	Misskey.bindingBase "notes/renotes" noteId limit sinceId untilId -- "$@"
}
Misskey.notes.Search() {
	Misskey.bindingBase "notes/search" query limit -- "$@"
}
Misskey.notes.Create() {
	Misskey.bindingBase "notes/create" text -- "$@"
}
Misskey.users.GetFrequentlyRepliedUsers() {
	Misskey.bindingBase "users/get-frequently-replied-users" userId -- "${1:-"$(Misskey.myId)"}" "${@:2}"
}
Misskey.users.Stats() {
	Misskey.bindingBase "users/stats" userId -- "${1:-"$(Misskey.myId)"}" "${@:2}"
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
Misskey.sendReq() {
	local _Url="$1" _CurlArgs=()
	shift 1
	_CurlArgs+=(-s -L)
	_CurlArgs+=(-X POST)
	_CurlArgs+=(-H "Content-Type: application/json")
	_CurlArgs+=(-d "$(Misskey.makeJson "$@")")
	_CurlArgs+=("$_Url")
	Msg.Debug "Run: ${_CurlArgs[*]//"${MISSKEY_TOKEN}"/"TOKEN"}"
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
	if ! Bool _Shifted; then
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
Misskey.isAdmin() {
	Bool "$(Misskey.i | jq -r ".isAdmin")"
}
Misskey.myId() {
	Misskey.i | jq -r ".id"
}
Misskey.myUserName() {
	Misskey.i | jq -r ".username"
}
Misskey.myName() {
	Misskey.i | jq -r ".name"
}
Pm.checkPkg() {
	local p
	for p in "$@"; do
		Pm.run -Qq "$p" >/dev/null 2>&1 || return 1
	done
	return 0
}
Pm.getKeyringList() {
	find "$(@GetKeyringDir)" -name "*.gpg" | GetBaseName | RemoveFileExt
}
Pm.getRepoListFromConf() {
	Pm.getConfig --repo-list
}
Pm.getRepoPkgList() {
	Pm.run -Slq "$@"
}
Pm.isRepoPkg() {
	Pm.run -Slq | grep -qx "$(Pm.getName <<<"$1")"
}
Pm.getRoot() {
	Pm.getConfig RootDir
}
Pm.getRepoConf() {
	ForEach eval 'echo [{}] && Pm.getConfig -r {}'
}
Pm.getPacmanKernelPkg() {
	echo "there is nothing"
}
Pm.getRepoServer() {
	ForEach eval 'Pm.getConfig -r {}' | grep "^Server" | ForEach eval "Ini.ParseLine <<< '{}' ; printf '%s\n' \${VALUE}"
}
Pm.getPacmanKeyringDir() {
	local _KeyringDir=""
	_KeyringDir="$(LANG=C pacman-key -h | RemoveBlank | grep -A 1 -- "^--populate" | tail -n 1 | cut -d "/" -f 2- | sed "s|'$||g")"
	: "${_KeyringDir="usr/share/pacman/keyrings"}"
	_KeyringDir="$(Pm.getRoot)/$_KeyringDir"
	_KeyringDir="$(sed -E "s|/+|/|g" <<<"$_KeyringDir")"
	if [[ -e $_KeyringDir ]]; then
		Readlinkf "$_KeyringDir"
	else
		echo "$_KeyringDir"
	fi
}
Pm.getRepoVer() {
	Pm.run -Sp --print-format '%v' "$1"
}
Pm.run() {
	pacman --noconfirm --config "${PACMAN_CONF-"/etc/pacman.conf"}" "$@"
}
Pm.runKey() {
	pacman-key --config "${PACMAN_CONF-"/etc/pacman.conf"}" "$@"
}
Pm.getName() {
	cut -d "<" -f 1 | cut -d ">" -f 1 | cut -d "=" -f 1
}
Pm.getLatestPkgVer() {
	local _LANG="${LANG-""}"
	export LANG=C
	if [[ -z ${*} ]]; then
		cat
	else
		PrintArray "$@"
	fi | ForEach Pm.run -Si "{}" | grep "^Version" | cut -d ":" -f 2 | RemoveBlank
	[[ -n $_LANG ]] && export LANG="$_LANG"
	return 0
}
Pm.getInstalledPkgVer() {
	if [[ -z ${*} ]]; then
		cat
	else
		PrintArray "$@"
	fi | ForEach pacman -Q "{}" | cut -d " " -f 2
	PrintArray "${PIPESTATUS[@]}" | grep -qx "1" && return 1
	return 0
}
Pm.getConfig() {
	LANG=C pacman-conf --config="${PACMAN_CONF-"/etc/pacman.conf"}" "$@"
}
Pm.pacmanGpg() {
	gpg --homedir "$(Pm.getConfig GPGDir)" "$@"
}
Pm.getDbSectionList() {
	grep -E "^%.*%$"
}
Pm.getDbNextSection() {
	Pm.getDbSectionList | grep -x -A 1 "^%$1%$" | GetLine 2 | sed "s|^%||g; s|%$||g"
}
Pm.getDbSection() {
	readarray -t _Stdin
	PrintArray "${_Stdin[@]}" | sed -ne "/^%$1%$/,/^%$(PrintEvalArray _Stdin | Pm.getDbNextSection "$1")%$/p" | sed '1d; $d'
}
Pm.isOpendSyncDb() {
	readarray -t _PkgDbList < <(find "$(Pm.getDbTmpDir)/sync/$1" -mindepth 1 -maxdepth 1 -type d)
	(("${#_PkgDbList[@]}" > 0)) && return 0
	return 1
}
Pm.createDbTmpDir() {
	mkdir -p "$(Pm.getDbTmpDir)"
}
Pm.getRepoListFromLocalDb() {
	find "$(Pm.getConfig DBPath)/sync" -mindepth 1 -maxdepth 1 -type f | GetBaseName | sed "s|.db$||g"
	return 0
}
Pm.getSyncDbDescPath() {
	local _repo
	_repo="$(pacman -Sp --print-format '%r' "$1")"
	{
		IsPacmanSyncDbOpend "$_repo" || OpenPacmanSyncDb "$_repo"
	} || return 1
	echo "$(Pm.getDbTmpDir)/sync/$(pacman -Sp --print-format '%r/%n-%v' "$1")"
}
Pm.openedSyncDbList() {
	find "$(Pm.getDbTmpDir)/sync/" -mindepth 1 -maxdepth 1 -type d
}
Pm.getSyncAllDesc() {
	find "$(Pm.getDbTmpDir)" -mindepth 3 -maxdepth 3 -name "desc" -type f
}
Pm.parsePkgFileName() {
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
Pm.getVirtualPkgList() {
	Pm.getRepoListFromLocalDb | ForEach Pm.openSyncDb {}
	Pm.getSyncAllDesc | ForEach eval "Pm.getDbSection PROVIDES < {}" | RemoveBlank
}
Pm.getPkgArch() {
	Pm.getSyncDbDesc "$1" | Pm.getDbSection ARCH | RemoveBlank
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
Pm.getSyncDbDesc() {
	local _path
	_path="$(Pm.getSyncDbDescPath "$1")"
	[[ -e $_path ]] || return 1
	cat "$_path/desc"
}
Pm.getDbTmpDir() {
	echo "${TMPDIR-"/tmp"}/fasbashlib-pacman-db"
}
Pm.deleteDbTmpDir() {
	rm -rf "$(Pm.getDbTmpDir)"
}
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
Prog.wideBar() {
	local Max="$1" Counter="$2"
	local StatusString="$Counter/$Max"
	local Size=$(($(Esc.GetTermX) - ${#StatusString} - 3))
	Prog.bar "$Max" "$Counter" "$Size"
}
Prog.rotation() {
	local Count="$1" CharList=('|' '/' '-' '\')
	Esc.ClearLineAndReturn
	[[ -n ${2-""} ]] && echo -n "${2}" 1>&2
	printf "%s" "${CharList["$((Count % "${#CharList[@]}"))"]}" 1>&2
}
Prog.bar() {
	local Max="$1" Counter="$2" Size="${3-"100"}"
	local SharpCount=$((Counter * Size / Max))
	local SpaceCount=$((Size - SharpCount))
	Esc.Return
	echo -n "$Counter/$Max [$(yes "#" | head -n "$SharpCount" 2>/dev/null | tr -d "\n")$(yes " " | head -n "$SpaceCount" 2>/dev/null | tr -d "\n")]"
}
CaptureSpecialKeys() {
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
		' ')
			echo "Space"
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
CheckMenu() {
	local arg OPTARG OPTIND
	local Choices=() CurrentSelected=() Key="" CurrentChoice=0
	local _question="" _number=false _selected=()
	while getopts "s:p:n" arg; do
		case "${arg}" in
		s)
			_selected+=("${OPTARG}")
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
	Choices=("$@")
	[[ ${#Choices[@]} -eq 0 ]] && return 1
	for i in "${!_selected[@]}"; do
		if Array.Include Choices "${Choices[$i]}"; then
			CurrentSelected+=("$i")
		fi
	done
	if [[ -n $_question ]]; then
		echo "$_question" 1>&2
	fi
	while [[ $Key != "Enter" ]]; do
		for i in "${!Choices[@]}"; do
			[[ $i == "$CurrentChoice" ]] && {
				Esc.Bold && Esc.Underline
			}
			if [[ ${CurrentSelected[*]} =~ $i ]]; then
				echo " [X] $i: ${Choices[$i]}" 1>&2
			else
				echo " [ ] $i: ${Choices[$i]}" 1>&2
			fi
			Esc.ResetStyle
		done
		Key="$(CaptureSpecialKeys)"
		case "$Key" in
		Up)
			(("$CurrentChoice" != 0)) && CurrentChoice=$((CurrentChoice - 1))
			;;
		Down)
			(("$CurrentChoice" != "${#Choices[@]}" - 1)) && CurrentChoice=$((CurrentChoice + 1))
			;;
		Space)
			if Array.Include CurrentSelected "$CurrentChoice"; then
				Array.Remove CurrentSelected "$CurrentChoice"
			else
				CurrentSelected+=("$CurrentChoice")
			fi
			;;
		esac
		Esc.ClearUpperLines "${#Choices[@]}"
	done
	if [[ -n $_question ]]; then
		Esc.ClearUpperLines 1
	fi
	if [[ $_number == true ]]; then
		Array.Eval CurrentSelected
	else
		Array.ForEach CurrentSelected eval 'echo ${Choices[{}]}'
	fi
	return 0
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
ChoiceLoop() {
	while true; do
		if Choice "$@"; then
			break
		fi
	done
}
SelectMenu() {
	local arg OPTARG OPTIND
	local Choices=() CurrentChoice=0 Key=""
	local _question="" _default="" _number=false
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
	Choices=("$@")
	[[ ${#Choices[@]} -eq 0 ]] && return 1
	[[ ${#Choices[@]} -eq 1 ]] && {
		echo "${Choices[0]}" && return 0
	}
	if [[ -n $_default ]] && Array.Include Choices "$_default"; then
		CurrentChoice="$(Array.Eval Choices | Array.IndexOf "$_default")"
	fi
	if [[ -n $_question ]]; then
		echo "$_question" 1>&2
	fi
	while [[ $Key != "Enter" ]]; do
		for i in "${!Choices[@]}"; do
			if [[ $i == "$CurrentChoice" ]]; then
				Esc.Bold && Esc.Underline
				echo " > $i: ${Choices[$i]}" 1>&2
			else
				echo "   $i: ${Choices[$i]}" 1>&2
			fi
			Esc.ResetStyle
		done
		Key="$(CaptureSpecialKeys)"
		case "$Key" in
		Up)
			(("$CurrentChoice" != 0)) && CurrentChoice=$((CurrentChoice - 1))
			;;
		Down)
			(("$CurrentChoice" != "${#Choices[@]}" - 1)) && CurrentChoice=$((CurrentChoice + 1))
			;;
		esac
		Esc.ClearUpperLines "${#Choices[@]}"
	done
	if [[ -n $_question ]]; then
		Esc.ClearUpperLines 1
	fi
	if [[ $_number == true ]]; then
		echo "$CurrentChoice"
	else
		echo "${Choices[$CurrentChoice]}"
	fi
	return 0
}
readlinkf() {
	Readlinkf.posix "$@"
}
Readlinkf.posix() {
	[ "${1-}" ] || return 1
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
Readlinkf.readlink() {
	[ "${1-}" ] || return 1
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
	Readlinkf.Posix "$@"
}
Readlinkf_Readlink() {
	Readlinkf.Readlink "$@"
}
Arch.getKernelFileList() {
	find "/boot" -maxdepth 1 -mindepth 1 -name "vmlinuz-*"
}
Arch.getKernelSrcList() {
	find "/usr/src" -mindepth 1 -maxdepth 1 -type l -name "linux*"
}
Arch.getMkinitcpioPresetList() {
	find "/etc/mkinitcpio.d/" -name "*.preset" -type f | GetBaseName | RemoveFileExt
}
Array.shift() {
	readarray -t "$1" < <(PrintEvalArray "$1" | sed "1,${2-"1"}d")
}
Array.push() {
	eval "PrintArray \"\${$1[@]}\"" | grep -qx "$2" && return 0
	eval "$1+=(\"$2\")"
}
Array.append() {
	local _ArrName="$1"
	shift 1 || return 1
	readarray -t -O "$(ArrayIndex "$_ArrName")" "$_ArrName" < <(cat)
}
Array.remove() {
	readarray -t "$1" < <(PrintEvalArray "$1" | RemoveMatchLine "$2")
}
Array.pop() {
	readarray -t "$1" < <(PrintEvalArray "$1" | sed -e '$d')
}
Array.fromStr() {
	declare -a -x "$1"
	readarray -t "$1" < <(BreakChar)
}
Array.rev() {
	readarray -t "$1" < <(PrintEvalArray "$1" | tac)
}
Array.eval() {
	eval "PrintArray \"\${$1[@]}\""
}
Array.last() {
	PrintEval "$1[$(Array.lastIndex "$1")]"
}
Array.print() {
	(($# >= 1)) || return 0
	printf "%s\n" "${@}"
}
Array.length() {
	PrintEval "#${1}[@]"
}
Array.indexOf() {
	local n=()
	readarray -t n < <(grep -x -n "$1" | cut -d ":" -f 1 | ForEach eval echo '$(( {} - 1 ))')
	(("${#n[@]}" >= 1)) || return 1
	PrintArray "${n[@]}"
	return 0
}
Array.lastIndex() {
	CalcInt "$(Array.length "$1")" - 1
}
Array.forEach() {
	PrintEvalArray "$1" | ForEach "${@:2}"
}
Array.includes() {
	PrintEvalArray "$1" | grep -qx "$2"
}
Array.include() {
	Array.includes "$@"
}
Awk.print() {
	awk "BEGIN {print $*}"
}
Awk.pi() {
	Awk.float "atan2(0, -0)"
}
Awk.log() {
	Awk.float "log(${2}) / log($1)"
}
Awk.float() {
	awk "BEGIN {printf (\"%4.${AWKSCALE-"5"}f\n\", $*)}"
}
Awk.tan() {
	Awk.float "sin($1)/tan($1)"
}
Awk.sin() {
	Awk.float "sin($*)"
}
Awk.cos() {
	Awk.float "cos($*)"
}
Awk.rad() {
	Awk.float "$1 * $(Awk.pi) / 180 "
}
StrToCharList() {
	Array.FromStr "$1"
}
GetArrayIndex() {
	Array.IndexOf "$1"
}
ArrayIndex() {
	Array.Length "$1"
}
RevArray() {
	Array.Rev "$1"
}
ArrayAppend() {
	Array.Append "$1"
}
ArrayIncludes() {
	Array.Includes "$@"
}
PrintEvalArray() {
	Array.Eval "$1"
}
PrintArray() {
	Array.Print "$@"
}
AddNewToArray() {
	Array.Push "$@"
}
FileType() {
	file --mime-type -b "$1"
}
GetFileExt() {
	GetBaseName | rev | cut -d "." -f 1 | rev
}
RemoveFileExt() {
	local Ext
	ForEach eval 'Ext=$(GetFileExt <<< {}); sed "s|.$Ext$||g" <<< {}; unset Ext'
}
GetBaseName() {
	ForEach basename "{}"
}
CheckFuncDefined() {
	typeset -f "${1}" >/dev/null || return 1
}
IsAvailable() {
	type "$1" 2>/dev/null 1>&2
}
Loop() {
	local _T="$1"
	shift 1 || return 1
	((_T == 0)) && return 0
	ForEach "$@" < <(yes "" | head -n "$_T")
}
GetLine() {
	head -n "$1" | tail -n 1
}
ForEach() {
	local _Item
	while read -r _Item; do
		"${@//"{}"/"${_Item}"}" || return "${?}"
	done
}
BreakChar() {
	grep -o "."
}
ToLowerStdin() {
	local _Str
	ForEach eval '_Str="{}"; echo "${_Str,,}"'
	unset _Str
}
IsUUID() {
	local _UUID="${1-""}"
	[[ ${_UUID//-/} =~ ^[[:xdigit:]]{32}$ ]] && return 0
	return 1
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
GetMaxWidth() {
	awk '{ if ( length > x && length > 0 ) { x = length } }END{ print x }'
}
CutLastString() {
	echo "${1%%"${2}"}"
	return 0
}
GetLastSplitString() {
	rev <<<"$2" | cut -d "$1" -f 1 | rev
}
CalcInt() {
	echo "$(("$@"))"
}
Sum() {
	local _Arg=()
	ForEach eval '_Arg+=("{}" "+")' < <(PrintArray "$@")
	readarray -t _Arg < <(PrintArray "${_Arg[@]}" | sed "${#_Arg[@]}d")
	CalcInt "${_Arg[@]}"
}
Ntest() {
	(("$@")) || return 1
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
ToArgs() {
	readarray -t args
	"$@" "${args[@]}"
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
Cache.getTimeDiffFromLastUpdate() {
	local _Now _Last
	_Now="$(date "+%s")"
	_Last="$(Cache.getFileLastUpdate "$1")"
	echo "$((_Now - _Last))"
	return 0
}
Cache.get() {
	cat "$(Cache.getDir)/$1" 2>/dev/null || return 1
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
Cache.exist() {
	local _File
	_File="$(Cache.createDir)/$1"
	[[ -e $_File ]] || return 1
	(("$(Cache.getTimeDiffFromLastUpdate "$_File")" > "${KEEPCACHESEC-"86400"}")) && return 2
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
Cache.create() {
	Cache.createDir >/dev/null
	cat >"$(Cache.getDir)/${1}"
	cat "$(Cache.getDir)/$1"
}
Cache.createDir() {
	FSBLIB_CACHEID="${FSBLIB_CACHEID-"$(RandomString "10")"}"
	export FSBLIB_CACHEID="$FSBLIB_CACHEID"
	local TMPDIR="${TMPDIR-"/tmp"}"
	local _Dir="$TMPDIR/${FSBLIB_CACHEID}"
	mkdir -p "$_Dir"
	echo "$_Dir"
	return 0
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
fsblibEnvCheck() {
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
Csv.toBashArray() {
	local _RawCsvLine=() _Line _ClmCnt=0
	local ArrayPrefix="${ArrayPrefix-"{}"}"
	readarray -t _RawCsvLine < <(
		while read -r _Line; do
			(($(tr "${CSVDELIM-","}" "\n" <<<"$_Line" | wc -l) >= ${#})) && echo "$_Line"
		done < <(grep -v "^#")
	)
	_ClmCnt=$(PrintArray "${_RawCsvLine[@]}" | Csv.getClmCnt)
	while read -r _Cnt; do
		readarray -t "$(sed "s|{}|$(eval "echo \"\${${_Cnt}}\"")|g" <<<"$ArrayPrefix")" < <(
			PrintArray "${_RawCsvLine[@]}" | cut -d "${CSVDELIM-","}" -f "$_Cnt"
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
	done < <(PrintArray "${_RawCsvLine[@]}")
	RemoveBlank <<<"$_ClmCnt"
	return 0
}
Csv.getClm() {
	grep -v "^#" | sed "/^$/d" | cut -d "${CSVDELIM-","}" -f "$1"
}
Em.getWorldPkgList() {
	sed -E 's|:.+$||g' /var/lib/portage/world | xargs -I{} bash -c 'ls -d /var/db/pkg/{}-* | sed "s|/var/db/pkg/||g" | grep -E "{}-[0-9]"'
}
Em.getInstalledPkgList() {
	find /var/db/pkg/ -mindepth 2 -maxdepth 2 -type d | sed 's|/var/db/pkg/||g'
}
Em.getDefaultRepoName() {
	Em.getRepoConf | Ini.GetParam DEFAULT main-repo
}
Em.getRepoLocation() {
	Em.getRepoConf | Ini.GetParam "$1" location
}
Em.getAllPkgList() {
	Em.getRepoConf | sed -e 's/^ *//' -e 's/ *$//' | grep "^ *location *=" | sed -e 's/^location *= *//' | xargs -L1 realpath | xargs -I{} bash -c "find '{}' -mindepth 3 -maxdepth 3 -type f -name '*.ebuild' | sed -e 's|{}/||g' -e 's|.ebuild$||g'" | awk -F "/" '{print $1"/"$3}'
}
Em.getRepoPkgList() {
	local _RepoPath
	_RepoPath="$(Em.getRepoLocation "$1")"
	find "$_RepoPath" -mindepth 3 -maxdepth 3 -type f -name '*.ebuild' | sed -e "s|${_RepoPath%/}/||g" -e 's|.ebuild$||g' | awk -F "/" '{print $1"/"$3}'
}
Em.getRepoConf() {
	cat /etc/portage/repos.conf /etc/portage/repos.conf/* 2>/dev/null
}
Em.noVersion() {
	sed -E 's|\-[0-9]+.+||g'
}
Esc.return() {
	printf "\r" >/dev/tty
}
Esc.clearLeft() {
	printf "\033[1K" >/dev/tty
}
Esc.clearLine() {
	printf "\033[2K" >/dev/tty
}
Esc.clearScreen() {
	printf "\033[2J" >/dev/tty
}
Esc.clearRight() {
	printf "\033[0K" >/dev/tty
}
Esc.getTermY() {
	[[ -n ${LINES-""} ]] && echo "$LINES" && return 0
	tput lines
}
Esc.getX() {
	local _POS
	printf "\033[6n" >>/dev/tty
	read -r -s -d "R" _POS
	echo $(("$(printf "%s\n" "${_POS:2}" | cut -d";" -f2)" - 1))
}
Esc.getTermX() {
	[[ -n ${COLUMNS-""} ]] && echo "$COLUMNS" && return 0
	tput cols
}
Esc.moveCursorLeft() {
	printf "\033[%dD" "$1" >/dev/tty
}
Esc.getY() {
	local _POS
	printf "\033[6n" >>/dev/tty
	read -r -s -d "R" _POS
	echo $(("$(printf "%s\n" "${_POS:2}" | cut -d";" -f1)" - 1))
}
Esc.moveCursorDown() {
	printf "\033[%dB" "$1" >/dev/tty
}
Esc.moveCursorRight() {
	printf "\033[%dC" "$1" >/dev/tty
}
Esc.moveCursor() {
	printf "\033[%d;%dH" "$1" "$2" >/dev/tty
}
Esc.moveCursorUp() {
	printf "\033[%dA" "$1" >/dev/tty
}
Esc.clearLineAndReturn() {
	Esc.clearLine
	Esc.return
}
Esc.clearUpperLines() {
	for i in $(seq 1 "$1"); do
		Esc.moveCursorUp 1
		Esc.clearLine
	done
}
Esc.blackBackground() {
	printf "\033[40m" >/dev/tty
}
Esc.cyanBackground() {
	printf "\033[46m" >/dev/tty
}
Esc.greenBackground() {
	printf "\033[42m" >/dev/tty
}
Esc.magentaText() {
	printf "\033[35m" >/dev/tty
}
Esc.lowIntensity() {
	printf "\033[2m" >/dev/tty
}
Esc.blueText() {
	printf "\033[34m" >/dev/tty
}
Esc.redBackground() {
	printf "\033[41m" >/dev/tty
}
Esc.magentaBackground() {
	printf "\033[45m" >/dev/tty
}
Esc.greenText() {
	printf "\033[32m" >/dev/tty
}
Esc.italic() {
	printf "\033[3m" >/dev/tty
}
Esc.blink() {
	printf "\033[5m" >/dev/tty
}
Esc.yellowText() {
	printf "\033[33m" >/dev/tty
}
Esc.whiteBackground() {
	printf "\033[47m" >/dev/tty
}
Esc.reverse() {
	printf "\033[7m" >/dev/tty
}
Esc.redText() {
	printf "\033[31m" >/dev/tty
}
Esc.conceal() {
	printf "\033[8m" >/dev/tty
}
Esc.yellowBackground() {
	printf "\033[43m" >/dev/tty
}
Esc.crossedOut() {
	printf "\033[9m" >/dev/tty
}
Esc.underline() {
	printf "\033[4m" >/dev/tty
}
Esc.resetStyle() {
	printf "\033[0m" >/dev/tty
}
Esc.rapidBlink() {
	printf "\033[6m" >/dev/tty
}
Esc.cyanText() {
	printf "\033[36m" >/dev/tty
}
Esc.blueBackground() {
	printf "\033[44m" >/dev/tty
}
Esc.bold() {
	printf "\033[1m" >/dev/tty
}
Esc.whiteText() {
	printf "\033[37m" >/dev/tty
}
Esc.blackText() {
	printf "\033[30m" >/dev/tty
}
Ini.getLastParam() {
	Ini.getParamList "$1" | tail -n 1
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
	done < <(PrintArray "${_RawIniLine[@]}")
	return "$_Exit"
}
Ini.parseLine() {
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
	done < <(PrintArray "${_RawIniLine[@]}")
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
	done < <(PrintArray "${_RawIniLine[@]}")
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
	if ! PrintArray "${IniContents[@]}" | Ini.getParamList "$Section" | grep -qx "$Param"; then
		SectionLastParam="$(PrintEvalArray IniContents | Ini.getLastParam "$Section")"
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
Ini.setValue() {
	local IniContents=()
	local Section="$1" Param="$2"
	readarray -t IniContents
	readarray -t IniContents < <(PrintArray "${IniContents[@]}" | Ini.newSection "$Section" | Ini.newParam "$Section" "$Param")
	PrintEvalArray IniContents
}
Ini.newSection() {
	local IniContents=()
	local Section="$1"
	readarray -t IniContents
	if PrintArray "${IniContents[@]}" | Ini.getSectionList | grep -x "$Section" >/dev/null; then
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
LibreTranslate.languages() {
	LibreTranslate.check || return 2
	curl -s "${LIBRETRANSLATE_URL}/languages" | jq -r '.[].code'
}
LibreTranslate.translateAuto() {
	LibreTranslate.check || return 2
	LibreTranslate.translate "${1:-""}" "$(LibreTranslate.detect "${1:-""}")" "${2:-""}"
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
Misskey.notes.Renotes() {
	Misskey.bindingBase "notes/renotes" noteId limit sinceId untilId -- "$@"
}
Misskey.notes.Search() {
	Misskey.bindingBase "notes/search" query limit -- "$@"
}
Misskey.notes.Create() {
	Misskey.bindingBase "notes/create" text -- "$@"
}
Misskey.users.GetFrequentlyRepliedUsers() {
	Misskey.bindingBase "users/get-frequently-replied-users" userId -- "${1:-"$(Misskey.myId)"}" "${@:2}"
}
Misskey.users.Stats() {
	Misskey.bindingBase "users/stats" userId -- "${1:-"$(Misskey.myId)"}" "${@:2}"
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
Misskey.sendReq() {
	local _Url="$1" _CurlArgs=()
	shift 1
	_CurlArgs+=(-s -L)
	_CurlArgs+=(-X POST)
	_CurlArgs+=(-H "Content-Type: application/json")
	_CurlArgs+=(-d "$(Misskey.makeJson "$@")")
	_CurlArgs+=("$_Url")
	Msg.Debug "Run: ${_CurlArgs[*]//"${MISSKEY_TOKEN}"/"TOKEN"}"
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
	if ! Bool _Shifted; then
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
Misskey.isAdmin() {
	Bool "$(Misskey.i | jq -r ".isAdmin")"
}
Misskey.myId() {
	Misskey.i | jq -r ".id"
}
Misskey.myUserName() {
	Misskey.i | jq -r ".username"
}
Misskey.myName() {
	Misskey.i | jq -r ".name"
}
Pm.checkPkg() {
	local p
	for p in "$@"; do
		Pm.run -Qq "$p" >/dev/null 2>&1 || return 1
	done
	return 0
}
Pm.getKeyringList() {
	find "$(@GetKeyringDir)" -name "*.gpg" | GetBaseName | RemoveFileExt
}
Pm.getRepoListFromConf() {
	Pm.getConfig --repo-list
}
Pm.getRepoPkgList() {
	Pm.run -Slq "$@"
}
Pm.isRepoPkg() {
	Pm.run -Slq | grep -qx "$(Pm.getName <<<"$1")"
}
Pm.getRoot() {
	Pm.getConfig RootDir
}
Pm.getRepoConf() {
	ForEach eval 'echo [{}] && Pm.getConfig -r {}'
}
Pm.getPacmanKernelPkg() {
	echo "there is nothing"
}
Pm.getRepoServer() {
	ForEach eval 'Pm.getConfig -r {}' | grep "^Server" | ForEach eval "Ini.ParseLine <<< '{}' ; printf '%s\n' \${VALUE}"
}
Pm.getPacmanKeyringDir() {
	local _KeyringDir=""
	_KeyringDir="$(LANG=C pacman-key -h | RemoveBlank | grep -A 1 -- "^--populate" | tail -n 1 | cut -d "/" -f 2- | sed "s|'$||g")"
	: "${_KeyringDir="usr/share/pacman/keyrings"}"
	_KeyringDir="$(Pm.getRoot)/$_KeyringDir"
	_KeyringDir="$(sed -E "s|/+|/|g" <<<"$_KeyringDir")"
	if [[ -e $_KeyringDir ]]; then
		Readlinkf "$_KeyringDir"
	else
		echo "$_KeyringDir"
	fi
}
Pm.getRepoVer() {
	Pm.run -Sp --print-format '%v' "$1"
}
Pm.run() {
	pacman --noconfirm --config "${PACMAN_CONF-"/etc/pacman.conf"}" "$@"
}
Pm.runKey() {
	pacman-key --config "${PACMAN_CONF-"/etc/pacman.conf"}" "$@"
}
Pm.getName() {
	cut -d "<" -f 1 | cut -d ">" -f 1 | cut -d "=" -f 1
}
Pm.getLatestPkgVer() {
	local _LANG="${LANG-""}"
	export LANG=C
	if [[ -z ${*} ]]; then
		cat
	else
		PrintArray "$@"
	fi | ForEach Pm.run -Si "{}" | grep "^Version" | cut -d ":" -f 2 | RemoveBlank
	[[ -n $_LANG ]] && export LANG="$_LANG"
	return 0
}
Pm.getInstalledPkgVer() {
	if [[ -z ${*} ]]; then
		cat
	else
		PrintArray "$@"
	fi | ForEach pacman -Q "{}" | cut -d " " -f 2
	PrintArray "${PIPESTATUS[@]}" | grep -qx "1" && return 1
	return 0
}
Pm.getConfig() {
	LANG=C pacman-conf --config="${PACMAN_CONF-"/etc/pacman.conf"}" "$@"
}
Pm.pacmanGpg() {
	gpg --homedir "$(Pm.getConfig GPGDir)" "$@"
}
Pm.getDbSectionList() {
	grep -E "^%.*%$"
}
Pm.getDbNextSection() {
	Pm.getDbSectionList | grep -x -A 1 "^%$1%$" | GetLine 2 | sed "s|^%||g; s|%$||g"
}
Pm.getDbSection() {
	readarray -t _Stdin
	PrintArray "${_Stdin[@]}" | sed -ne "/^%$1%$/,/^%$(PrintEvalArray _Stdin | Pm.getDbNextSection "$1")%$/p" | sed '1d; $d'
}
Pm.isOpendSyncDb() {
	readarray -t _PkgDbList < <(find "$(Pm.getDbTmpDir)/sync/$1" -mindepth 1 -maxdepth 1 -type d)
	(("${#_PkgDbList[@]}" > 0)) && return 0
	return 1
}
Pm.createDbTmpDir() {
	mkdir -p "$(Pm.getDbTmpDir)"
}
Pm.getRepoListFromLocalDb() {
	find "$(Pm.getConfig DBPath)/sync" -mindepth 1 -maxdepth 1 -type f | GetBaseName | sed "s|.db$||g"
	return 0
}
Pm.getSyncDbDescPath() {
	local _repo
	_repo="$(pacman -Sp --print-format '%r' "$1")"
	{
		IsPacmanSyncDbOpend "$_repo" || OpenPacmanSyncDb "$_repo"
	} || return 1
	echo "$(Pm.getDbTmpDir)/sync/$(pacman -Sp --print-format '%r/%n-%v' "$1")"
}
Pm.openedSyncDbList() {
	find "$(Pm.getDbTmpDir)/sync/" -mindepth 1 -maxdepth 1 -type d
}
Pm.getSyncAllDesc() {
	find "$(Pm.getDbTmpDir)" -mindepth 3 -maxdepth 3 -name "desc" -type f
}
Pm.parsePkgFileName() {
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
Pm.getVirtualPkgList() {
	Pm.getRepoListFromLocalDb | ForEach Pm.openSyncDb {}
	Pm.getSyncAllDesc | ForEach eval "Pm.getDbSection PROVIDES < {}" | RemoveBlank
}
Pm.getPkgArch() {
	Pm.getSyncDbDesc "$1" | Pm.getDbSection ARCH | RemoveBlank
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
Pm.getSyncDbDesc() {
	local _path
	_path="$(Pm.getSyncDbDescPath "$1")"
	[[ -e $_path ]] || return 1
	cat "$_path/desc"
}
Pm.getDbTmpDir() {
	echo "${TMPDIR-"/tmp"}/fasbashlib-pacman-db"
}
Pm.deleteDbTmpDir() {
	rm -rf "$(Pm.getDbTmpDir)"
}
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
Prog.wideBar() {
	local Max="$1" Counter="$2"
	local StatusString="$Counter/$Max"
	local Size=$(($(Esc.GetTermX) - ${#StatusString} - 3))
	Prog.bar "$Max" "$Counter" "$Size"
}
Prog.rotation() {
	local Count="$1" CharList=('|' '/' '-' '\')
	Esc.ClearLineAndReturn
	[[ -n ${2-""} ]] && echo -n "${2}" 1>&2
	printf "%s" "${CharList["$((Count % "${#CharList[@]}"))"]}" 1>&2
}
Prog.bar() {
	local Max="$1" Counter="$2" Size="${3-"100"}"
	local SharpCount=$((Counter * Size / Max))
	local SpaceCount=$((Size - SharpCount))
	Esc.Return
	echo -n "$Counter/$Max [$(yes "#" | head -n "$SharpCount" 2>/dev/null | tr -d "\n")$(yes " " | head -n "$SpaceCount" 2>/dev/null | tr -d "\n")]"
}
CaptureSpecialKeys() {
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
		' ')
			echo "Space"
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
CheckMenu() {
	local arg OPTARG OPTIND
	local Choices=() CurrentSelected=() Key="" CurrentChoice=0
	local _question="" _number=false _selected=()
	while getopts "s:p:n" arg; do
		case "${arg}" in
		s)
			_selected+=("${OPTARG}")
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
	Choices=("$@")
	[[ ${#Choices[@]} -eq 0 ]] && return 1
	for i in "${!_selected[@]}"; do
		if Array.Include Choices "${Choices[$i]}"; then
			CurrentSelected+=("$i")
		fi
	done
	if [[ -n $_question ]]; then
		echo "$_question" 1>&2
	fi
	while [[ $Key != "Enter" ]]; do
		for i in "${!Choices[@]}"; do
			[[ $i == "$CurrentChoice" ]] && {
				Esc.Bold && Esc.Underline
			}
			if [[ ${CurrentSelected[*]} =~ $i ]]; then
				echo " [X] $i: ${Choices[$i]}" 1>&2
			else
				echo " [ ] $i: ${Choices[$i]}" 1>&2
			fi
			Esc.ResetStyle
		done
		Key="$(CaptureSpecialKeys)"
		case "$Key" in
		Up)
			(("$CurrentChoice" != 0)) && CurrentChoice=$((CurrentChoice - 1))
			;;
		Down)
			(("$CurrentChoice" != "${#Choices[@]}" - 1)) && CurrentChoice=$((CurrentChoice + 1))
			;;
		Space)
			if Array.Include CurrentSelected "$CurrentChoice"; then
				Array.Remove CurrentSelected "$CurrentChoice"
			else
				CurrentSelected+=("$CurrentChoice")
			fi
			;;
		esac
		Esc.ClearUpperLines "${#Choices[@]}"
	done
	if [[ -n $_question ]]; then
		Esc.ClearUpperLines 1
	fi
	if [[ $_number == true ]]; then
		Array.Eval CurrentSelected
	else
		Array.ForEach CurrentSelected eval 'echo ${Choices[{}]}'
	fi
	return 0
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
ChoiceLoop() {
	while true; do
		if Choice "$@"; then
			break
		fi
	done
}
SelectMenu() {
	local arg OPTARG OPTIND
	local Choices=() CurrentChoice=0 Key=""
	local _question="" _default="" _number=false
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
	Choices=("$@")
	[[ ${#Choices[@]} -eq 0 ]] && return 1
	[[ ${#Choices[@]} -eq 1 ]] && {
		echo "${Choices[0]}" && return 0
	}
	if [[ -n $_default ]] && Array.Include Choices "$_default"; then
		CurrentChoice="$(Array.Eval Choices | Array.IndexOf "$_default")"
	fi
	if [[ -n $_question ]]; then
		echo "$_question" 1>&2
	fi
	while [[ $Key != "Enter" ]]; do
		for i in "${!Choices[@]}"; do
			if [[ $i == "$CurrentChoice" ]]; then
				Esc.Bold && Esc.Underline
				echo " > $i: ${Choices[$i]}" 1>&2
			else
				echo "   $i: ${Choices[$i]}" 1>&2
			fi
			Esc.ResetStyle
		done
		Key="$(CaptureSpecialKeys)"
		case "$Key" in
		Up)
			(("$CurrentChoice" != 0)) && CurrentChoice=$((CurrentChoice - 1))
			;;
		Down)
			(("$CurrentChoice" != "${#Choices[@]}" - 1)) && CurrentChoice=$((CurrentChoice + 1))
			;;
		esac
		Esc.ClearUpperLines "${#Choices[@]}"
	done
	if [[ -n $_question ]]; then
		Esc.ClearUpperLines 1
	fi
	if [[ $_number == true ]]; then
		echo "$CurrentChoice"
	else
		echo "${Choices[$CurrentChoice]}"
	fi
	return 0
}
readlinkf() {
	Readlinkf.posix "$@"
}
Readlinkf.posix() {
	[ "${1-}" ] || return 1
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
Readlinkf.readlink() {
	[ "${1-}" ] || return 1
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
	Readlinkf.Posix "$@"
}
Readlinkf_Readlink() {
	Readlinkf.Readlink "$@"
}
Sqlite3.select() {
	local _table="$1" _args=()
	shift 1 || return 1
	local _values=("$@")
	_args+=(select)
	ForEach eval '_args+=("\"{}\"" ,)' < <(PrintEvalArray _values)
	Array.Pop _args
	_args+=("from" "$_table" ";")
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
Sqlite3.call() {
	Msg.Debug sqlite3 "${SQLITE3_OPTIONS[@]}" "$SQLITE3_DBPATH" "$@" 1>&2
	sqlite3 "${SQLITE3_OPTIONS[@]}" "$SQLITE3_DBPATH" "$@"
}
Sqlite3.delete() {
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
	Sqlite3.call "${_args[*]}"
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
Sqlite3.insert() {
	local _table="$1" _args=()
	shift 1 || return 1
	local _values=("$@")
	_args+=(insert into "$_table" values '(')
	ForEach eval '_args+=("\"{}\"" ,)' < <(PrintEvalArray _values)
	Array.Pop _args
	_args+=(");")
	Sqlite3.call "${_args[*]}"
}
Sqlite3.create() {
	local _table="$1" _args=() _columns=()
	shift 1 || return 1
	_columns=("$@")
	_args+=(create table "$_table" "(")
	ForEach eval '_args+=("\"{}\"" ,)' < <(PrintEvalArray _columns)
	Array.Pop _args
	_args+=(")")
	Sqlite3.call "${_args[*]}"
}
Sqlite3.currentDb() {
	if [[ -z ${SQLITE3_DBPATH-""} ]]; then
		Msg.Err "No datebase is connected."
		return 1
	fi
	echo "${SQLITE3_DBPATH}"
	return 0
}
Sqlite3.connect() {
	export SQLITE3_DBPATH="$1"
	echo ".open \"$SQLITE3_DBPATH\"" | sqlite3
	return 0
}
Arch.getKernelFileList() {
	find "/boot" -maxdepth 1 -mindepth 1 -name "vmlinuz-*"
}
Arch.getKernelSrcList() {
	find "/usr/src" -mindepth 1 -maxdepth 1 -type l -name "linux*"
}
Arch.getMkinitcpioPresetList() {
	find "/etc/mkinitcpio.d/" -name "*.preset" -type f | GetBaseName | RemoveFileExt
}
Array.shift() {
	readarray -t "$1" < <(PrintEvalArray "$1" | sed "1,${2-"1"}d")
}
Array.push() {
	eval "PrintArray \"\${$1[@]}\"" | grep -qx "$2" && return 0
	eval "$1+=(\"$2\")"
}
Array.append() {
	local _ArrName="$1"
	shift 1 || return 1
	readarray -t -O "$(ArrayIndex "$_ArrName")" "$_ArrName" < <(cat)
}
Array.remove() {
	readarray -t "$1" < <(PrintEvalArray "$1" | RemoveMatchLine "$2")
}
Array.pop() {
	readarray -t "$1" < <(PrintEvalArray "$1" | sed -e '$d')
}
Array.fromStr() {
	declare -a -x "$1"
	readarray -t "$1" < <(BreakChar)
}
Array.rev() {
	readarray -t "$1" < <(PrintEvalArray "$1" | tac)
}
Array.eval() {
	eval "PrintArray \"\${$1[@]}\""
}
Array.last() {
	PrintEval "$1[$(Array.lastIndex "$1")]"
}
Array.print() {
	(($# >= 1)) || return 0
	printf "%s\n" "${@}"
}
Array.length() {
	PrintEval "#${1}[@]"
}
Array.indexOf() {
	local n=()
	readarray -t n < <(grep -x -n "$1" | cut -d ":" -f 1 | ForEach eval echo '$(( {} - 1 ))')
	(("${#n[@]}" >= 1)) || return 1
	PrintArray "${n[@]}"
	return 0
}
Array.lastIndex() {
	CalcInt "$(Array.length "$1")" - 1
}
Array.forEach() {
	PrintEvalArray "$1" | ForEach "${@:2}"
}
Array.includes() {
	PrintEvalArray "$1" | grep -qx "$2"
}
Array.include() {
	Array.includes "$@"
}
Awk.print() {
	awk "BEGIN {print $*}"
}
Awk.pi() {
	Awk.float "atan2(0, -0)"
}
Awk.log() {
	Awk.float "log(${2}) / log($1)"
}
Awk.float() {
	awk "BEGIN {printf (\"%4.${AWKSCALE-"5"}f\n\", $*)}"
}
Awk.tan() {
	Awk.float "sin($1)/tan($1)"
}
Awk.sin() {
	Awk.float "sin($*)"
}
Awk.cos() {
	Awk.float "cos($*)"
}
Awk.rad() {
	Awk.float "$1 * $(Awk.pi) / 180 "
}
StrToCharList() {
	Array.FromStr "$1"
}
GetArrayIndex() {
	Array.IndexOf "$1"
}
ArrayIndex() {
	Array.Length "$1"
}
RevArray() {
	Array.Rev "$1"
}
ArrayAppend() {
	Array.Append "$1"
}
ArrayIncludes() {
	Array.Includes "$@"
}
PrintEvalArray() {
	Array.Eval "$1"
}
PrintArray() {
	Array.Print "$@"
}
AddNewToArray() {
	Array.Push "$@"
}
FileType() {
	file --mime-type -b "$1"
}
GetFileExt() {
	GetBaseName | rev | cut -d "." -f 1 | rev
}
RemoveFileExt() {
	local Ext
	ForEach eval 'Ext=$(GetFileExt <<< {}); sed "s|.$Ext$||g" <<< {}; unset Ext'
}
GetBaseName() {
	ForEach basename "{}"
}
CheckFuncDefined() {
	typeset -f "${1}" >/dev/null || return 1
}
IsAvailable() {
	type "$1" 2>/dev/null 1>&2
}
Loop() {
	local _T="$1"
	shift 1 || return 1
	((_T == 0)) && return 0
	ForEach "$@" < <(yes "" | head -n "$_T")
}
GetLine() {
	head -n "$1" | tail -n 1
}
ForEach() {
	local _Item
	while read -r _Item; do
		"${@//"{}"/"${_Item}"}" || return "${?}"
	done
}
BreakChar() {
	grep -o "."
}
ToLowerStdin() {
	local _Str
	ForEach eval '_Str="{}"; echo "${_Str,,}"'
	unset _Str
}
IsUUID() {
	local _UUID="${1-""}"
	[[ ${_UUID//-/} =~ ^[[:xdigit:]]{32}$ ]] && return 0
	return 1
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
GetMaxWidth() {
	awk '{ if ( length > x && length > 0 ) { x = length } }END{ print x }'
}
CutLastString() {
	echo "${1%%"${2}"}"
	return 0
}
GetLastSplitString() {
	rev <<<"$2" | cut -d "$1" -f 1 | rev
}
CalcInt() {
	echo "$(("$@"))"
}
Sum() {
	local _Arg=()
	ForEach eval '_Arg+=("{}" "+")' < <(PrintArray "$@")
	readarray -t _Arg < <(PrintArray "${_Arg[@]}" | sed "${#_Arg[@]}d")
	CalcInt "${_Arg[@]}"
}
Ntest() {
	(("$@")) || return 1
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
ToArgs() {
	readarray -t args
	"$@" "${args[@]}"
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
Cache.getTimeDiffFromLastUpdate() {
	local _Now _Last
	_Now="$(date "+%s")"
	_Last="$(Cache.getFileLastUpdate "$1")"
	echo "$((_Now - _Last))"
	return 0
}
Cache.get() {
	cat "$(Cache.getDir)/$1" 2>/dev/null || return 1
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
Cache.exist() {
	local _File
	_File="$(Cache.createDir)/$1"
	[[ -e $_File ]] || return 1
	(("$(Cache.getTimeDiffFromLastUpdate "$_File")" > "${KEEPCACHESEC-"86400"}")) && return 2
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
Cache.create() {
	Cache.createDir >/dev/null
	cat >"$(Cache.getDir)/${1}"
	cat "$(Cache.getDir)/$1"
}
Cache.createDir() {
	FSBLIB_CACHEID="${FSBLIB_CACHEID-"$(RandomString "10")"}"
	export FSBLIB_CACHEID="$FSBLIB_CACHEID"
	local TMPDIR="${TMPDIR-"/tmp"}"
	local _Dir="$TMPDIR/${FSBLIB_CACHEID}"
	mkdir -p "$_Dir"
	echo "$_Dir"
	return 0
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
fsblibEnvCheck() {
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
Csv.toBashArray() {
	local _RawCsvLine=() _Line _ClmCnt=0
	local ArrayPrefix="${ArrayPrefix-"{}"}"
	readarray -t _RawCsvLine < <(
		while read -r _Line; do
			(($(tr "${CSVDELIM-","}" "\n" <<<"$_Line" | wc -l) >= ${#})) && echo "$_Line"
		done < <(grep -v "^#")
	)
	_ClmCnt=$(PrintArray "${_RawCsvLine[@]}" | Csv.getClmCnt)
	while read -r _Cnt; do
		readarray -t "$(sed "s|{}|$(eval "echo \"\${${_Cnt}}\"")|g" <<<"$ArrayPrefix")" < <(
			PrintArray "${_RawCsvLine[@]}" | cut -d "${CSVDELIM-","}" -f "$_Cnt"
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
	done < <(PrintArray "${_RawCsvLine[@]}")
	RemoveBlank <<<"$_ClmCnt"
	return 0
}
Csv.getClm() {
	grep -v "^#" | sed "/^$/d" | cut -d "${CSVDELIM-","}" -f "$1"
}
Em.getWorldPkgList() {
	sed -E 's|:.+$||g' /var/lib/portage/world | xargs -I{} bash -c 'ls -d /var/db/pkg/{}-* | sed "s|/var/db/pkg/||g" | grep -E "{}-[0-9]"'
}
Em.getInstalledPkgList() {
	find /var/db/pkg/ -mindepth 2 -maxdepth 2 -type d | sed 's|/var/db/pkg/||g'
}
Em.getDefaultRepoName() {
	Em.getRepoConf | Ini.GetParam DEFAULT main-repo
}
Em.getRepoLocation() {
	Em.getRepoConf | Ini.GetParam "$1" location
}
Em.getAllPkgList() {
	Em.getRepoConf | sed -e 's/^ *//' -e 's/ *$//' | grep "^ *location *=" | sed -e 's/^location *= *//' | xargs -L1 realpath | xargs -I{} bash -c "find '{}' -mindepth 3 -maxdepth 3 -type f -name '*.ebuild' | sed -e 's|{}/||g' -e 's|.ebuild$||g'" | awk -F "/" '{print $1"/"$3}'
}
Em.getRepoPkgList() {
	local _RepoPath
	_RepoPath="$(Em.getRepoLocation "$1")"
	find "$_RepoPath" -mindepth 3 -maxdepth 3 -type f -name '*.ebuild' | sed -e "s|${_RepoPath%/}/||g" -e 's|.ebuild$||g' | awk -F "/" '{print $1"/"$3}'
}
Em.getRepoConf() {
	cat /etc/portage/repos.conf /etc/portage/repos.conf/* 2>/dev/null
}
Em.noVersion() {
	sed -E 's|\-[0-9]+.+||g'
}
Esc.return() {
	printf "\r" >/dev/tty
}
Esc.clearLeft() {
	printf "\033[1K" >/dev/tty
}
Esc.clearLine() {
	printf "\033[2K" >/dev/tty
}
Esc.clearScreen() {
	printf "\033[2J" >/dev/tty
}
Esc.clearRight() {
	printf "\033[0K" >/dev/tty
}
Esc.getTermY() {
	[[ -n ${LINES-""} ]] && echo "$LINES" && return 0
	tput lines
}
Esc.getX() {
	local _POS
	printf "\033[6n" >>/dev/tty
	read -r -s -d "R" _POS
	echo $(("$(printf "%s\n" "${_POS:2}" | cut -d";" -f2)" - 1))
}
Esc.getTermX() {
	[[ -n ${COLUMNS-""} ]] && echo "$COLUMNS" && return 0
	tput cols
}
Esc.moveCursorLeft() {
	printf "\033[%dD" "$1" >/dev/tty
}
Esc.getY() {
	local _POS
	printf "\033[6n" >>/dev/tty
	read -r -s -d "R" _POS
	echo $(("$(printf "%s\n" "${_POS:2}" | cut -d";" -f1)" - 1))
}
Esc.moveCursorDown() {
	printf "\033[%dB" "$1" >/dev/tty
}
Esc.moveCursorRight() {
	printf "\033[%dC" "$1" >/dev/tty
}
Esc.moveCursor() {
	printf "\033[%d;%dH" "$1" "$2" >/dev/tty
}
Esc.moveCursorUp() {
	printf "\033[%dA" "$1" >/dev/tty
}
Esc.clearLineAndReturn() {
	Esc.clearLine
	Esc.return
}
Esc.clearUpperLines() {
	for i in $(seq 1 "$1"); do
		Esc.moveCursorUp 1
		Esc.clearLine
	done
}
Esc.blackBackground() {
	printf "\033[40m" >/dev/tty
}
Esc.cyanBackground() {
	printf "\033[46m" >/dev/tty
}
Esc.greenBackground() {
	printf "\033[42m" >/dev/tty
}
Esc.magentaText() {
	printf "\033[35m" >/dev/tty
}
Esc.lowIntensity() {
	printf "\033[2m" >/dev/tty
}
Esc.blueText() {
	printf "\033[34m" >/dev/tty
}
Esc.redBackground() {
	printf "\033[41m" >/dev/tty
}
Esc.magentaBackground() {
	printf "\033[45m" >/dev/tty
}
Esc.greenText() {
	printf "\033[32m" >/dev/tty
}
Esc.italic() {
	printf "\033[3m" >/dev/tty
}
Esc.blink() {
	printf "\033[5m" >/dev/tty
}
Esc.yellowText() {
	printf "\033[33m" >/dev/tty
}
Esc.whiteBackground() {
	printf "\033[47m" >/dev/tty
}
Esc.reverse() {
	printf "\033[7m" >/dev/tty
}
Esc.redText() {
	printf "\033[31m" >/dev/tty
}
Esc.conceal() {
	printf "\033[8m" >/dev/tty
}
Esc.yellowBackground() {
	printf "\033[43m" >/dev/tty
}
Esc.crossedOut() {
	printf "\033[9m" >/dev/tty
}
Esc.underline() {
	printf "\033[4m" >/dev/tty
}
Esc.resetStyle() {
	printf "\033[0m" >/dev/tty
}
Esc.rapidBlink() {
	printf "\033[6m" >/dev/tty
}
Esc.cyanText() {
	printf "\033[36m" >/dev/tty
}
Esc.blueBackground() {
	printf "\033[44m" >/dev/tty
}
Esc.bold() {
	printf "\033[1m" >/dev/tty
}
Esc.whiteText() {
	printf "\033[37m" >/dev/tty
}
Esc.blackText() {
	printf "\033[30m" >/dev/tty
}
Ini.getLastParam() {
	Ini.getParamList "$1" | tail -n 1
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
	done < <(PrintArray "${_RawIniLine[@]}")
	return "$_Exit"
}
Ini.parseLine() {
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
	done < <(PrintArray "${_RawIniLine[@]}")
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
	done < <(PrintArray "${_RawIniLine[@]}")
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
	if ! PrintArray "${IniContents[@]}" | Ini.getParamList "$Section" | grep -qx "$Param"; then
		SectionLastParam="$(PrintEvalArray IniContents | Ini.getLastParam "$Section")"
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
Ini.setValue() {
	local IniContents=()
	local Section="$1" Param="$2"
	readarray -t IniContents
	readarray -t IniContents < <(PrintArray "${IniContents[@]}" | Ini.newSection "$Section" | Ini.newParam "$Section" "$Param")
	PrintEvalArray IniContents
}
Ini.newSection() {
	local IniContents=()
	local Section="$1"
	readarray -t IniContents
	if PrintArray "${IniContents[@]}" | Ini.getSectionList | grep -x "$Section" >/dev/null; then
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
LibreTranslate.languages() {
	LibreTranslate.check || return 2
	curl -s "${LIBRETRANSLATE_URL}/languages" | jq -r '.[].code'
}
LibreTranslate.translateAuto() {
	LibreTranslate.check || return 2
	LibreTranslate.translate "${1:-""}" "$(LibreTranslate.detect "${1:-""}")" "${2:-""}"
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
Misskey.notes.Renotes() {
	Misskey.bindingBase "notes/renotes" noteId limit sinceId untilId -- "$@"
}
Misskey.notes.Search() {
	Misskey.bindingBase "notes/search" query limit -- "$@"
}
Misskey.notes.Create() {
	Misskey.bindingBase "notes/create" text -- "$@"
}
Misskey.users.GetFrequentlyRepliedUsers() {
	Misskey.bindingBase "users/get-frequently-replied-users" userId -- "${1:-"$(Misskey.myId)"}" "${@:2}"
}
Misskey.users.Stats() {
	Misskey.bindingBase "users/stats" userId -- "${1:-"$(Misskey.myId)"}" "${@:2}"
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
Misskey.sendReq() {
	local _Url="$1" _CurlArgs=()
	shift 1
	_CurlArgs+=(-s -L)
	_CurlArgs+=(-X POST)
	_CurlArgs+=(-H "Content-Type: application/json")
	_CurlArgs+=(-d "$(Misskey.makeJson "$@")")
	_CurlArgs+=("$_Url")
	Msg.Debug "Run: ${_CurlArgs[*]//"${MISSKEY_TOKEN}"/"TOKEN"}"
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
	if ! Bool _Shifted; then
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
Misskey.isAdmin() {
	Bool "$(Misskey.i | jq -r ".isAdmin")"
}
Misskey.myId() {
	Misskey.i | jq -r ".id"
}
Misskey.myUserName() {
	Misskey.i | jq -r ".username"
}
Misskey.myName() {
	Misskey.i | jq -r ".name"
}
Pm.checkPkg() {
	local p
	for p in "$@"; do
		Pm.run -Qq "$p" >/dev/null 2>&1 || return 1
	done
	return 0
}
Pm.getKeyringList() {
	find "$(@GetKeyringDir)" -name "*.gpg" | GetBaseName | RemoveFileExt
}
Pm.getRepoListFromConf() {
	Pm.getConfig --repo-list
}
Pm.getRepoPkgList() {
	Pm.run -Slq "$@"
}
Pm.isRepoPkg() {
	Pm.run -Slq | grep -qx "$(Pm.getName <<<"$1")"
}
Pm.getRoot() {
	Pm.getConfig RootDir
}
Pm.getRepoConf() {
	ForEach eval 'echo [{}] && Pm.getConfig -r {}'
}
Pm.getPacmanKernelPkg() {
	echo "there is nothing"
}
Pm.getRepoServer() {
	ForEach eval 'Pm.getConfig -r {}' | grep "^Server" | ForEach eval "Ini.ParseLine <<< '{}' ; printf '%s\n' \${VALUE}"
}
Pm.getPacmanKeyringDir() {
	local _KeyringDir=""
	_KeyringDir="$(LANG=C pacman-key -h | RemoveBlank | grep -A 1 -- "^--populate" | tail -n 1 | cut -d "/" -f 2- | sed "s|'$||g")"
	: "${_KeyringDir="usr/share/pacman/keyrings"}"
	_KeyringDir="$(Pm.getRoot)/$_KeyringDir"
	_KeyringDir="$(sed -E "s|/+|/|g" <<<"$_KeyringDir")"
	if [[ -e $_KeyringDir ]]; then
		Readlinkf "$_KeyringDir"
	else
		echo "$_KeyringDir"
	fi
}
Pm.getRepoVer() {
	Pm.run -Sp --print-format '%v' "$1"
}
Pm.run() {
	pacman --noconfirm --config "${PACMAN_CONF-"/etc/pacman.conf"}" "$@"
}
Pm.runKey() {
	pacman-key --config "${PACMAN_CONF-"/etc/pacman.conf"}" "$@"
}
Pm.getName() {
	cut -d "<" -f 1 | cut -d ">" -f 1 | cut -d "=" -f 1
}
Pm.getLatestPkgVer() {
	local _LANG="${LANG-""}"
	export LANG=C
	if [[ -z ${*} ]]; then
		cat
	else
		PrintArray "$@"
	fi | ForEach Pm.run -Si "{}" | grep "^Version" | cut -d ":" -f 2 | RemoveBlank
	[[ -n $_LANG ]] && export LANG="$_LANG"
	return 0
}
Pm.getInstalledPkgVer() {
	if [[ -z ${*} ]]; then
		cat
	else
		PrintArray "$@"
	fi | ForEach pacman -Q "{}" | cut -d " " -f 2
	PrintArray "${PIPESTATUS[@]}" | grep -qx "1" && return 1
	return 0
}
Pm.getConfig() {
	LANG=C pacman-conf --config="${PACMAN_CONF-"/etc/pacman.conf"}" "$@"
}
Pm.pacmanGpg() {
	gpg --homedir "$(Pm.getConfig GPGDir)" "$@"
}
Pm.getDbSectionList() {
	grep -E "^%.*%$"
}
Pm.getDbNextSection() {
	Pm.getDbSectionList | grep -x -A 1 "^%$1%$" | GetLine 2 | sed "s|^%||g; s|%$||g"
}
Pm.getDbSection() {
	readarray -t _Stdin
	PrintArray "${_Stdin[@]}" | sed -ne "/^%$1%$/,/^%$(PrintEvalArray _Stdin | Pm.getDbNextSection "$1")%$/p" | sed '1d; $d'
}
Pm.isOpendSyncDb() {
	readarray -t _PkgDbList < <(find "$(Pm.getDbTmpDir)/sync/$1" -mindepth 1 -maxdepth 1 -type d)
	(("${#_PkgDbList[@]}" > 0)) && return 0
	return 1
}
Pm.createDbTmpDir() {
	mkdir -p "$(Pm.getDbTmpDir)"
}
Pm.getRepoListFromLocalDb() {
	find "$(Pm.getConfig DBPath)/sync" -mindepth 1 -maxdepth 1 -type f | GetBaseName | sed "s|.db$||g"
	return 0
}
Pm.getSyncDbDescPath() {
	local _repo
	_repo="$(pacman -Sp --print-format '%r' "$1")"
	{
		IsPacmanSyncDbOpend "$_repo" || OpenPacmanSyncDb "$_repo"
	} || return 1
	echo "$(Pm.getDbTmpDir)/sync/$(pacman -Sp --print-format '%r/%n-%v' "$1")"
}
Pm.openedSyncDbList() {
	find "$(Pm.getDbTmpDir)/sync/" -mindepth 1 -maxdepth 1 -type d
}
Pm.getSyncAllDesc() {
	find "$(Pm.getDbTmpDir)" -mindepth 3 -maxdepth 3 -name "desc" -type f
}
Pm.parsePkgFileName() {
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
Pm.getVirtualPkgList() {
	Pm.getRepoListFromLocalDb | ForEach Pm.openSyncDb {}
	Pm.getSyncAllDesc | ForEach eval "Pm.getDbSection PROVIDES < {}" | RemoveBlank
}
Pm.getPkgArch() {
	Pm.getSyncDbDesc "$1" | Pm.getDbSection ARCH | RemoveBlank
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
Pm.getSyncDbDesc() {
	local _path
	_path="$(Pm.getSyncDbDescPath "$1")"
	[[ -e $_path ]] || return 1
	cat "$_path/desc"
}
Pm.getDbTmpDir() {
	echo "${TMPDIR-"/tmp"}/fasbashlib-pacman-db"
}
Pm.deleteDbTmpDir() {
	rm -rf "$(Pm.getDbTmpDir)"
}
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
Prog.wideBar() {
	local Max="$1" Counter="$2"
	local StatusString="$Counter/$Max"
	local Size=$(($(Esc.GetTermX) - ${#StatusString} - 3))
	Prog.bar "$Max" "$Counter" "$Size"
}
Prog.rotation() {
	local Count="$1" CharList=('|' '/' '-' '\')
	Esc.ClearLineAndReturn
	[[ -n ${2-""} ]] && echo -n "${2}" 1>&2
	printf "%s" "${CharList["$((Count % "${#CharList[@]}"))"]}" 1>&2
}
Prog.bar() {
	local Max="$1" Counter="$2" Size="${3-"100"}"
	local SharpCount=$((Counter * Size / Max))
	local SpaceCount=$((Size - SharpCount))
	Esc.Return
	echo -n "$Counter/$Max [$(yes "#" | head -n "$SharpCount" 2>/dev/null | tr -d "\n")$(yes " " | head -n "$SpaceCount" 2>/dev/null | tr -d "\n")]"
}
CaptureSpecialKeys() {
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
		' ')
			echo "Space"
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
CheckMenu() {
	local arg OPTARG OPTIND
	local Choices=() CurrentSelected=() Key="" CurrentChoice=0
	local _question="" _number=false _selected=()
	while getopts "s:p:n" arg; do
		case "${arg}" in
		s)
			_selected+=("${OPTARG}")
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
	Choices=("$@")
	[[ ${#Choices[@]} -eq 0 ]] && return 1
	for i in "${!_selected[@]}"; do
		if Array.Include Choices "${Choices[$i]}"; then
			CurrentSelected+=("$i")
		fi
	done
	if [[ -n $_question ]]; then
		echo "$_question" 1>&2
	fi
	while [[ $Key != "Enter" ]]; do
		for i in "${!Choices[@]}"; do
			[[ $i == "$CurrentChoice" ]] && {
				Esc.Bold && Esc.Underline
			}
			if [[ ${CurrentSelected[*]} =~ $i ]]; then
				echo " [X] $i: ${Choices[$i]}" 1>&2
			else
				echo " [ ] $i: ${Choices[$i]}" 1>&2
			fi
			Esc.ResetStyle
		done
		Key="$(CaptureSpecialKeys)"
		case "$Key" in
		Up)
			(("$CurrentChoice" != 0)) && CurrentChoice=$((CurrentChoice - 1))
			;;
		Down)
			(("$CurrentChoice" != "${#Choices[@]}" - 1)) && CurrentChoice=$((CurrentChoice + 1))
			;;
		Space)
			if Array.Include CurrentSelected "$CurrentChoice"; then
				Array.Remove CurrentSelected "$CurrentChoice"
			else
				CurrentSelected+=("$CurrentChoice")
			fi
			;;
		esac
		Esc.ClearUpperLines "${#Choices[@]}"
	done
	if [[ -n $_question ]]; then
		Esc.ClearUpperLines 1
	fi
	if [[ $_number == true ]]; then
		Array.Eval CurrentSelected
	else
		Array.ForEach CurrentSelected eval 'echo ${Choices[{}]}'
	fi
	return 0
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
ChoiceLoop() {
	while true; do
		if Choice "$@"; then
			break
		fi
	done
}
SelectMenu() {
	local arg OPTARG OPTIND
	local Choices=() CurrentChoice=0 Key=""
	local _question="" _default="" _number=false
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
	Choices=("$@")
	[[ ${#Choices[@]} -eq 0 ]] && return 1
	[[ ${#Choices[@]} -eq 1 ]] && {
		echo "${Choices[0]}" && return 0
	}
	if [[ -n $_default ]] && Array.Include Choices "$_default"; then
		CurrentChoice="$(Array.Eval Choices | Array.IndexOf "$_default")"
	fi
	if [[ -n $_question ]]; then
		echo "$_question" 1>&2
	fi
	while [[ $Key != "Enter" ]]; do
		for i in "${!Choices[@]}"; do
			if [[ $i == "$CurrentChoice" ]]; then
				Esc.Bold && Esc.Underline
				echo " > $i: ${Choices[$i]}" 1>&2
			else
				echo "   $i: ${Choices[$i]}" 1>&2
			fi
			Esc.ResetStyle
		done
		Key="$(CaptureSpecialKeys)"
		case "$Key" in
		Up)
			(("$CurrentChoice" != 0)) && CurrentChoice=$((CurrentChoice - 1))
			;;
		Down)
			(("$CurrentChoice" != "${#Choices[@]}" - 1)) && CurrentChoice=$((CurrentChoice + 1))
			;;
		esac
		Esc.ClearUpperLines "${#Choices[@]}"
	done
	if [[ -n $_question ]]; then
		Esc.ClearUpperLines 1
	fi
	if [[ $_number == true ]]; then
		echo "$CurrentChoice"
	else
		echo "${Choices[$CurrentChoice]}"
	fi
	return 0
}
readlinkf() {
	Readlinkf.posix "$@"
}
Readlinkf.posix() {
	[ "${1-}" ] || return 1
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
Readlinkf.readlink() {
	[ "${1-}" ] || return 1
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
	Readlinkf.Posix "$@"
}
Readlinkf_Readlink() {
	Readlinkf.Readlink "$@"
}
Sqlite3.select() {
	local _table="$1" _args=()
	shift 1 || return 1
	local _values=("$@")
	_args+=(select)
	ForEach eval '_args+=("\"{}\"" ,)' < <(PrintEvalArray _values)
	Array.Pop _args
	_args+=("from" "$_table" ";")
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
Sqlite3.call() {
	Msg.Debug sqlite3 "${SQLITE3_OPTIONS[@]}" "$SQLITE3_DBPATH" "$@" 1>&2
	sqlite3 "${SQLITE3_OPTIONS[@]}" "$SQLITE3_DBPATH" "$@"
}
Sqlite3.delete() {
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
	Sqlite3.call "${_args[*]}"
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
Sqlite3.insert() {
	local _table="$1" _args=()
	shift 1 || return 1
	local _values=("$@")
	_args+=(insert into "$_table" values '(')
	ForEach eval '_args+=("\"{}\"" ,)' < <(PrintEvalArray _values)
	Array.Pop _args
	_args+=(");")
	Sqlite3.call "${_args[*]}"
}
Sqlite3.create() {
	local _table="$1" _args=() _columns=()
	shift 1 || return 1
	_columns=("$@")
	_args+=(create table "$_table" "(")
	ForEach eval '_args+=("\"{}\"" ,)' < <(PrintEvalArray _columns)
	Array.Pop _args
	_args+=(")")
	Sqlite3.call "${_args[*]}"
}
Sqlite3.currentDb() {
	if [[ -z ${SQLITE3_DBPATH-""} ]]; then
		Msg.Err "No datebase is connected."
		return 1
	fi
	echo "${SQLITE3_DBPATH}"
	return 0
}
Sqlite3.connect() {
	export SQLITE3_DBPATH="$1"
	echo ".open \"$SQLITE3_DBPATH\"" | sqlite3
	return 0
}
SrcInfo.format() {
	RemoveBlank | sed "/^$/d" | grep -v "^#" | ForEach eval 'SrcInfo.parse Line <<< "{}"'
}
SrcInfo.parse() {
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
SrcInfo.getValue() {
	local _SrcInfo=()
	local _Output=()
	local _PkgBaseValues=("pkgver" "pkgrel" "epoch")
	local _AllValues=("pkgdesc" "url" "install" "changelog")
	local _AllArrays=("arch" "groups" "license" "noextract" "options" "backup" "validpgpkeys")
	local _AllArraysWithArch=("source" "depends" "checkdepends" "makedepends" "optdepends" "provides" "conflicts" "replaces" "md5sums" "sha1sums" "sha224sums" "sha256sums" "sha384sums" "sha512sums")
	ArrayAppend _SrcInfo
	ArrayIncludes _PkgBaseValues "$1" && {
		PrintEvalArray _SrcInfo | SrcInfo.getValueInPkgBase "$1"
		return 0
	}
	[[ -n ${2-""} ]] || {
		echo "No pkgname or pkgbase is specified" 1>&2
		return 1
	}
	if ArrayIncludes _AllValues "$1" || ArrayIncludes _AllArrays "$1"; then
		ArrayAppend _Output < <(PrintEvalArray _SrcInfo | SrcInfo.getValueInPkgBase "$1")
		ArrayAppend _Output < <(PrintEvalArray _SrcInfo | SrcInfo.getValueInPkgName "$2" "$1")
		PrintArray "${_Output[@]}" | tail -n 1
		return 0
	fi
	ArrayIncludes _AllArraysWithArch "$1" || return 1
	local _Arch _ArchList=()
	if [[ -z ${3-""} ]]; then
		ArrayAppend _ArchList < <(PrintEvalArray _SrcInfo | SrcInfo.getValue arch "$2")
	else
		ArrayAppend _ArchList < <(tr "," "\n" <<<"$3" | RemoveBlank)
	fi
	ArrayAppend _Output < <(PrintEvalArray _SrcInfo | SrcInfo.getValueInPkgBase "$1")
	ArrayAppend _Output < <(PrintEvalArray _SrcInfo | SrcInfo.getValueInPkgName "$2" "$1")
	for _Arch in "${_ArchList[@]}"; do
		ArrayAppend _Output < <(PrintEvalArray _SrcInfo | SrcInfo.getValueInPkgBase "$1_${_Arch}")
		ArrayAppend _Output < <(PrintEvalArray _SrcInfo | SrcInfo.getValueInPkgName "$2" "$1_${_Arch}")
	done
	PrintEvalArray _Output
	return 0
}
SrcInfo.getKeyList() {
	SrcInfo.format | cut -d "=" -f 1
}
Arch.getKernelFileList() {
	find "/boot" -maxdepth 1 -mindepth 1 -name "vmlinuz-*"
}
Arch.getKernelSrcList() {
	find "/usr/src" -mindepth 1 -maxdepth 1 -type l -name "linux*"
}
Arch.getMkinitcpioPresetList() {
	find "/etc/mkinitcpio.d/" -name "*.preset" -type f | GetBaseName | RemoveFileExt
}
Array.shift() {
	readarray -t "$1" < <(PrintEvalArray "$1" | sed "1,${2-"1"}d")
}
Array.push() {
	eval "PrintArray \"\${$1[@]}\"" | grep -qx "$2" && return 0
	eval "$1+=(\"$2\")"
}
Array.append() {
	local _ArrName="$1"
	shift 1 || return 1
	readarray -t -O "$(ArrayIndex "$_ArrName")" "$_ArrName" < <(cat)
}
Array.remove() {
	readarray -t "$1" < <(PrintEvalArray "$1" | RemoveMatchLine "$2")
}
Array.pop() {
	readarray -t "$1" < <(PrintEvalArray "$1" | sed -e '$d')
}
Array.fromStr() {
	declare -a -x "$1"
	readarray -t "$1" < <(BreakChar)
}
Array.rev() {
	readarray -t "$1" < <(PrintEvalArray "$1" | tac)
}
Array.eval() {
	eval "PrintArray \"\${$1[@]}\""
}
Array.last() {
	PrintEval "$1[$(Array.lastIndex "$1")]"
}
Array.print() {
	(($# >= 1)) || return 0
	printf "%s\n" "${@}"
}
Array.length() {
	PrintEval "#${1}[@]"
}
Array.indexOf() {
	local n=()
	readarray -t n < <(grep -x -n "$1" | cut -d ":" -f 1 | ForEach eval echo '$(( {} - 1 ))')
	(("${#n[@]}" >= 1)) || return 1
	PrintArray "${n[@]}"
	return 0
}
Array.lastIndex() {
	CalcInt "$(Array.length "$1")" - 1
}
Array.forEach() {
	PrintEvalArray "$1" | ForEach "${@:2}"
}
Array.includes() {
	PrintEvalArray "$1" | grep -qx "$2"
}
Array.include() {
	Array.includes "$@"
}
Awk.print() {
	awk "BEGIN {print $*}"
}
Awk.pi() {
	Awk.float "atan2(0, -0)"
}
Awk.log() {
	Awk.float "log(${2}) / log($1)"
}
Awk.float() {
	awk "BEGIN {printf (\"%4.${AWKSCALE-"5"}f\n\", $*)}"
}
Awk.tan() {
	Awk.float "sin($1)/tan($1)"
}
Awk.sin() {
	Awk.float "sin($*)"
}
Awk.cos() {
	Awk.float "cos($*)"
}
Awk.rad() {
	Awk.float "$1 * $(Awk.pi) / 180 "
}
StrToCharList() {
	Array.FromStr "$1"
}
GetArrayIndex() {
	Array.IndexOf "$1"
}
ArrayIndex() {
	Array.Length "$1"
}
RevArray() {
	Array.Rev "$1"
}
ArrayAppend() {
	Array.Append "$1"
}
ArrayIncludes() {
	Array.Includes "$@"
}
PrintEvalArray() {
	Array.Eval "$1"
}
PrintArray() {
	Array.Print "$@"
}
AddNewToArray() {
	Array.Push "$@"
}
FileType() {
	file --mime-type -b "$1"
}
GetFileExt() {
	GetBaseName | rev | cut -d "." -f 1 | rev
}
RemoveFileExt() {
	local Ext
	ForEach eval 'Ext=$(GetFileExt <<< {}); sed "s|.$Ext$||g" <<< {}; unset Ext'
}
GetBaseName() {
	ForEach basename "{}"
}
CheckFuncDefined() {
	typeset -f "${1}" >/dev/null || return 1
}
IsAvailable() {
	type "$1" 2>/dev/null 1>&2
}
Loop() {
	local _T="$1"
	shift 1 || return 1
	((_T == 0)) && return 0
	ForEach "$@" < <(yes "" | head -n "$_T")
}
GetLine() {
	head -n "$1" | tail -n 1
}
ForEach() {
	local _Item
	while read -r _Item; do
		"${@//"{}"/"${_Item}"}" || return "${?}"
	done
}
BreakChar() {
	grep -o "."
}
ToLowerStdin() {
	local _Str
	ForEach eval '_Str="{}"; echo "${_Str,,}"'
	unset _Str
}
IsUUID() {
	local _UUID="${1-""}"
	[[ ${_UUID//-/} =~ ^[[:xdigit:]]{32}$ ]] && return 0
	return 1
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
GetMaxWidth() {
	awk '{ if ( length > x && length > 0 ) { x = length } }END{ print x }'
}
CutLastString() {
	echo "${1%%"${2}"}"
	return 0
}
GetLastSplitString() {
	rev <<<"$2" | cut -d "$1" -f 1 | rev
}
CalcInt() {
	echo "$(("$@"))"
}
Sum() {
	local _Arg=()
	ForEach eval '_Arg+=("{}" "+")' < <(PrintArray "$@")
	readarray -t _Arg < <(PrintArray "${_Arg[@]}" | sed "${#_Arg[@]}d")
	CalcInt "${_Arg[@]}"
}
Ntest() {
	(("$@")) || return 1
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
ToArgs() {
	readarray -t args
	"$@" "${args[@]}"
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
Cache.getTimeDiffFromLastUpdate() {
	local _Now _Last
	_Now="$(date "+%s")"
	_Last="$(Cache.getFileLastUpdate "$1")"
	echo "$((_Now - _Last))"
	return 0
}
Cache.get() {
	cat "$(Cache.getDir)/$1" 2>/dev/null || return 1
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
Cache.exist() {
	local _File
	_File="$(Cache.createDir)/$1"
	[[ -e $_File ]] || return 1
	(("$(Cache.getTimeDiffFromLastUpdate "$_File")" > "${KEEPCACHESEC-"86400"}")) && return 2
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
Cache.create() {
	Cache.createDir >/dev/null
	cat >"$(Cache.getDir)/${1}"
	cat "$(Cache.getDir)/$1"
}
Cache.createDir() {
	FSBLIB_CACHEID="${FSBLIB_CACHEID-"$(RandomString "10")"}"
	export FSBLIB_CACHEID="$FSBLIB_CACHEID"
	local TMPDIR="${TMPDIR-"/tmp"}"
	local _Dir="$TMPDIR/${FSBLIB_CACHEID}"
	mkdir -p "$_Dir"
	echo "$_Dir"
	return 0
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
fsblibEnvCheck() {
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
Csv.toBashArray() {
	local _RawCsvLine=() _Line _ClmCnt=0
	local ArrayPrefix="${ArrayPrefix-"{}"}"
	readarray -t _RawCsvLine < <(
		while read -r _Line; do
			(($(tr "${CSVDELIM-","}" "\n" <<<"$_Line" | wc -l) >= ${#})) && echo "$_Line"
		done < <(grep -v "^#")
	)
	_ClmCnt=$(PrintArray "${_RawCsvLine[@]}" | Csv.getClmCnt)
	while read -r _Cnt; do
		readarray -t "$(sed "s|{}|$(eval "echo \"\${${_Cnt}}\"")|g" <<<"$ArrayPrefix")" < <(
			PrintArray "${_RawCsvLine[@]}" | cut -d "${CSVDELIM-","}" -f "$_Cnt"
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
	done < <(PrintArray "${_RawCsvLine[@]}")
	RemoveBlank <<<"$_ClmCnt"
	return 0
}
Csv.getClm() {
	grep -v "^#" | sed "/^$/d" | cut -d "${CSVDELIM-","}" -f "$1"
}
Em.getWorldPkgList() {
	sed -E 's|:.+$||g' /var/lib/portage/world | xargs -I{} bash -c 'ls -d /var/db/pkg/{}-* | sed "s|/var/db/pkg/||g" | grep -E "{}-[0-9]"'
}
Em.getInstalledPkgList() {
	find /var/db/pkg/ -mindepth 2 -maxdepth 2 -type d | sed 's|/var/db/pkg/||g'
}
Em.getDefaultRepoName() {
	Em.getRepoConf | Ini.GetParam DEFAULT main-repo
}
Em.getRepoLocation() {
	Em.getRepoConf | Ini.GetParam "$1" location
}
Em.getAllPkgList() {
	Em.getRepoConf | sed -e 's/^ *//' -e 's/ *$//' | grep "^ *location *=" | sed -e 's/^location *= *//' | xargs -L1 realpath | xargs -I{} bash -c "find '{}' -mindepth 3 -maxdepth 3 -type f -name '*.ebuild' | sed -e 's|{}/||g' -e 's|.ebuild$||g'" | awk -F "/" '{print $1"/"$3}'
}
Em.getRepoPkgList() {
	local _RepoPath
	_RepoPath="$(Em.getRepoLocation "$1")"
	find "$_RepoPath" -mindepth 3 -maxdepth 3 -type f -name '*.ebuild' | sed -e "s|${_RepoPath%/}/||g" -e 's|.ebuild$||g' | awk -F "/" '{print $1"/"$3}'
}
Em.getRepoConf() {
	cat /etc/portage/repos.conf /etc/portage/repos.conf/* 2>/dev/null
}
Em.noVersion() {
	sed -E 's|\-[0-9]+.+||g'
}
Esc.return() {
	printf "\r" >/dev/tty
}
Esc.clearLeft() {
	printf "\033[1K" >/dev/tty
}
Esc.clearLine() {
	printf "\033[2K" >/dev/tty
}
Esc.clearScreen() {
	printf "\033[2J" >/dev/tty
}
Esc.clearRight() {
	printf "\033[0K" >/dev/tty
}
Esc.getTermY() {
	[[ -n ${LINES-""} ]] && echo "$LINES" && return 0
	tput lines
}
Esc.getX() {
	local _POS
	printf "\033[6n" >>/dev/tty
	read -r -s -d "R" _POS
	echo $(("$(printf "%s\n" "${_POS:2}" | cut -d";" -f2)" - 1))
}
Esc.getTermX() {
	[[ -n ${COLUMNS-""} ]] && echo "$COLUMNS" && return 0
	tput cols
}
Esc.moveCursorLeft() {
	printf "\033[%dD" "$1" >/dev/tty
}
Esc.getY() {
	local _POS
	printf "\033[6n" >>/dev/tty
	read -r -s -d "R" _POS
	echo $(("$(printf "%s\n" "${_POS:2}" | cut -d";" -f1)" - 1))
}
Esc.moveCursorDown() {
	printf "\033[%dB" "$1" >/dev/tty
}
Esc.moveCursorRight() {
	printf "\033[%dC" "$1" >/dev/tty
}
Esc.moveCursor() {
	printf "\033[%d;%dH" "$1" "$2" >/dev/tty
}
Esc.moveCursorUp() {
	printf "\033[%dA" "$1" >/dev/tty
}
Esc.clearLineAndReturn() {
	Esc.clearLine
	Esc.return
}
Esc.clearUpperLines() {
	for i in $(seq 1 "$1"); do
		Esc.moveCursorUp 1
		Esc.clearLine
	done
}
Esc.blackBackground() {
	printf "\033[40m" >/dev/tty
}
Esc.cyanBackground() {
	printf "\033[46m" >/dev/tty
}
Esc.greenBackground() {
	printf "\033[42m" >/dev/tty
}
Esc.magentaText() {
	printf "\033[35m" >/dev/tty
}
Esc.lowIntensity() {
	printf "\033[2m" >/dev/tty
}
Esc.blueText() {
	printf "\033[34m" >/dev/tty
}
Esc.redBackground() {
	printf "\033[41m" >/dev/tty
}
Esc.magentaBackground() {
	printf "\033[45m" >/dev/tty
}
Esc.greenText() {
	printf "\033[32m" >/dev/tty
}
Esc.italic() {
	printf "\033[3m" >/dev/tty
}
Esc.blink() {
	printf "\033[5m" >/dev/tty
}
Esc.yellowText() {
	printf "\033[33m" >/dev/tty
}
Esc.whiteBackground() {
	printf "\033[47m" >/dev/tty
}
Esc.reverse() {
	printf "\033[7m" >/dev/tty
}
Esc.redText() {
	printf "\033[31m" >/dev/tty
}
Esc.conceal() {
	printf "\033[8m" >/dev/tty
}
Esc.yellowBackground() {
	printf "\033[43m" >/dev/tty
}
Esc.crossedOut() {
	printf "\033[9m" >/dev/tty
}
Esc.underline() {
	printf "\033[4m" >/dev/tty
}
Esc.resetStyle() {
	printf "\033[0m" >/dev/tty
}
Esc.rapidBlink() {
	printf "\033[6m" >/dev/tty
}
Esc.cyanText() {
	printf "\033[36m" >/dev/tty
}
Esc.blueBackground() {
	printf "\033[44m" >/dev/tty
}
Esc.bold() {
	printf "\033[1m" >/dev/tty
}
Esc.whiteText() {
	printf "\033[37m" >/dev/tty
}
Esc.blackText() {
	printf "\033[30m" >/dev/tty
}
Ini.getLastParam() {
	Ini.getParamList "$1" | tail -n 1
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
	done < <(PrintArray "${_RawIniLine[@]}")
	return "$_Exit"
}
Ini.parseLine() {
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
	done < <(PrintArray "${_RawIniLine[@]}")
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
	done < <(PrintArray "${_RawIniLine[@]}")
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
	if ! PrintArray "${IniContents[@]}" | Ini.getParamList "$Section" | grep -qx "$Param"; then
		SectionLastParam="$(PrintEvalArray IniContents | Ini.getLastParam "$Section")"
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
Ini.setValue() {
	local IniContents=()
	local Section="$1" Param="$2"
	readarray -t IniContents
	readarray -t IniContents < <(PrintArray "${IniContents[@]}" | Ini.newSection "$Section" | Ini.newParam "$Section" "$Param")
	PrintEvalArray IniContents
}
Ini.newSection() {
	local IniContents=()
	local Section="$1"
	readarray -t IniContents
	if PrintArray "${IniContents[@]}" | Ini.getSectionList | grep -x "$Section" >/dev/null; then
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
LibreTranslate.languages() {
	LibreTranslate.check || return 2
	curl -s "${LIBRETRANSLATE_URL}/languages" | jq -r '.[].code'
}
LibreTranslate.translateAuto() {
	LibreTranslate.check || return 2
	LibreTranslate.translate "${1:-""}" "$(LibreTranslate.detect "${1:-""}")" "${2:-""}"
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
Misskey.notes.Renotes() {
	Misskey.bindingBase "notes/renotes" noteId limit sinceId untilId -- "$@"
}
Misskey.notes.Search() {
	Misskey.bindingBase "notes/search" query limit -- "$@"
}
Misskey.notes.Create() {
	Misskey.bindingBase "notes/create" text -- "$@"
}
Misskey.users.GetFrequentlyRepliedUsers() {
	Misskey.bindingBase "users/get-frequently-replied-users" userId -- "${1:-"$(Misskey.myId)"}" "${@:2}"
}
Misskey.users.Stats() {
	Misskey.bindingBase "users/stats" userId -- "${1:-"$(Misskey.myId)"}" "${@:2}"
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
Misskey.sendReq() {
	local _Url="$1" _CurlArgs=()
	shift 1
	_CurlArgs+=(-s -L)
	_CurlArgs+=(-X POST)
	_CurlArgs+=(-H "Content-Type: application/json")
	_CurlArgs+=(-d "$(Misskey.makeJson "$@")")
	_CurlArgs+=("$_Url")
	Msg.Debug "Run: ${_CurlArgs[*]//"${MISSKEY_TOKEN}"/"TOKEN"}"
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
	if ! Bool _Shifted; then
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
Misskey.isAdmin() {
	Bool "$(Misskey.i | jq -r ".isAdmin")"
}
Misskey.myId() {
	Misskey.i | jq -r ".id"
}
Misskey.myUserName() {
	Misskey.i | jq -r ".username"
}
Misskey.myName() {
	Misskey.i | jq -r ".name"
}
Pm.checkPkg() {
	local p
	for p in "$@"; do
		Pm.run -Qq "$p" >/dev/null 2>&1 || return 1
	done
	return 0
}
Pm.getKeyringList() {
	find "$(@GetKeyringDir)" -name "*.gpg" | GetBaseName | RemoveFileExt
}
Pm.getRepoListFromConf() {
	Pm.getConfig --repo-list
}
Pm.getRepoPkgList() {
	Pm.run -Slq "$@"
}
Pm.isRepoPkg() {
	Pm.run -Slq | grep -qx "$(Pm.getName <<<"$1")"
}
Pm.getRoot() {
	Pm.getConfig RootDir
}
Pm.getRepoConf() {
	ForEach eval 'echo [{}] && Pm.getConfig -r {}'
}
Pm.getPacmanKernelPkg() {
	echo "there is nothing"
}
Pm.getRepoServer() {
	ForEach eval 'Pm.getConfig -r {}' | grep "^Server" | ForEach eval "Ini.ParseLine <<< '{}' ; printf '%s\n' \${VALUE}"
}
Pm.getPacmanKeyringDir() {
	local _KeyringDir=""
	_KeyringDir="$(LANG=C pacman-key -h | RemoveBlank | grep -A 1 -- "^--populate" | tail -n 1 | cut -d "/" -f 2- | sed "s|'$||g")"
	: "${_KeyringDir="usr/share/pacman/keyrings"}"
	_KeyringDir="$(Pm.getRoot)/$_KeyringDir"
	_KeyringDir="$(sed -E "s|/+|/|g" <<<"$_KeyringDir")"
	if [[ -e $_KeyringDir ]]; then
		Readlinkf "$_KeyringDir"
	else
		echo "$_KeyringDir"
	fi
}
Pm.getRepoVer() {
	Pm.run -Sp --print-format '%v' "$1"
}
Pm.run() {
	pacman --noconfirm --config "${PACMAN_CONF-"/etc/pacman.conf"}" "$@"
}
Pm.runKey() {
	pacman-key --config "${PACMAN_CONF-"/etc/pacman.conf"}" "$@"
}
Pm.getName() {
	cut -d "<" -f 1 | cut -d ">" -f 1 | cut -d "=" -f 1
}
Pm.getLatestPkgVer() {
	local _LANG="${LANG-""}"
	export LANG=C
	if [[ -z ${*} ]]; then
		cat
	else
		PrintArray "$@"
	fi | ForEach Pm.run -Si "{}" | grep "^Version" | cut -d ":" -f 2 | RemoveBlank
	[[ -n $_LANG ]] && export LANG="$_LANG"
	return 0
}
Pm.getInstalledPkgVer() {
	if [[ -z ${*} ]]; then
		cat
	else
		PrintArray "$@"
	fi | ForEach pacman -Q "{}" | cut -d " " -f 2
	PrintArray "${PIPESTATUS[@]}" | grep -qx "1" && return 1
	return 0
}
Pm.getConfig() {
	LANG=C pacman-conf --config="${PACMAN_CONF-"/etc/pacman.conf"}" "$@"
}
Pm.pacmanGpg() {
	gpg --homedir "$(Pm.getConfig GPGDir)" "$@"
}
Pm.getDbSectionList() {
	grep -E "^%.*%$"
}
Pm.getDbNextSection() {
	Pm.getDbSectionList | grep -x -A 1 "^%$1%$" | GetLine 2 | sed "s|^%||g; s|%$||g"
}
Pm.getDbSection() {
	readarray -t _Stdin
	PrintArray "${_Stdin[@]}" | sed -ne "/^%$1%$/,/^%$(PrintEvalArray _Stdin | Pm.getDbNextSection "$1")%$/p" | sed '1d; $d'
}
Pm.isOpendSyncDb() {
	readarray -t _PkgDbList < <(find "$(Pm.getDbTmpDir)/sync/$1" -mindepth 1 -maxdepth 1 -type d)
	(("${#_PkgDbList[@]}" > 0)) && return 0
	return 1
}
Pm.createDbTmpDir() {
	mkdir -p "$(Pm.getDbTmpDir)"
}
Pm.getRepoListFromLocalDb() {
	find "$(Pm.getConfig DBPath)/sync" -mindepth 1 -maxdepth 1 -type f | GetBaseName | sed "s|.db$||g"
	return 0
}
Pm.getSyncDbDescPath() {
	local _repo
	_repo="$(pacman -Sp --print-format '%r' "$1")"
	{
		IsPacmanSyncDbOpend "$_repo" || OpenPacmanSyncDb "$_repo"
	} || return 1
	echo "$(Pm.getDbTmpDir)/sync/$(pacman -Sp --print-format '%r/%n-%v' "$1")"
}
Pm.openedSyncDbList() {
	find "$(Pm.getDbTmpDir)/sync/" -mindepth 1 -maxdepth 1 -type d
}
Pm.getSyncAllDesc() {
	find "$(Pm.getDbTmpDir)" -mindepth 3 -maxdepth 3 -name "desc" -type f
}
Pm.parsePkgFileName() {
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
Pm.getVirtualPkgList() {
	Pm.getRepoListFromLocalDb | ForEach Pm.openSyncDb {}
	Pm.getSyncAllDesc | ForEach eval "Pm.getDbSection PROVIDES < {}" | RemoveBlank
}
Pm.getPkgArch() {
	Pm.getSyncDbDesc "$1" | Pm.getDbSection ARCH | RemoveBlank
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
Pm.getSyncDbDesc() {
	local _path
	_path="$(Pm.getSyncDbDescPath "$1")"
	[[ -e $_path ]] || return 1
	cat "$_path/desc"
}
Pm.getDbTmpDir() {
	echo "${TMPDIR-"/tmp"}/fasbashlib-pacman-db"
}
Pm.deleteDbTmpDir() {
	rm -rf "$(Pm.getDbTmpDir)"
}
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
Prog.wideBar() {
	local Max="$1" Counter="$2"
	local StatusString="$Counter/$Max"
	local Size=$(($(Esc.GetTermX) - ${#StatusString} - 3))
	Prog.bar "$Max" "$Counter" "$Size"
}
Prog.rotation() {
	local Count="$1" CharList=('|' '/' '-' '\')
	Esc.ClearLineAndReturn
	[[ -n ${2-""} ]] && echo -n "${2}" 1>&2
	printf "%s" "${CharList["$((Count % "${#CharList[@]}"))"]}" 1>&2
}
Prog.bar() {
	local Max="$1" Counter="$2" Size="${3-"100"}"
	local SharpCount=$((Counter * Size / Max))
	local SpaceCount=$((Size - SharpCount))
	Esc.Return
	echo -n "$Counter/$Max [$(yes "#" | head -n "$SharpCount" 2>/dev/null | tr -d "\n")$(yes " " | head -n "$SpaceCount" 2>/dev/null | tr -d "\n")]"
}
CaptureSpecialKeys() {
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
		' ')
			echo "Space"
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
CheckMenu() {
	local arg OPTARG OPTIND
	local Choices=() CurrentSelected=() Key="" CurrentChoice=0
	local _question="" _number=false _selected=()
	while getopts "s:p:n" arg; do
		case "${arg}" in
		s)
			_selected+=("${OPTARG}")
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
	Choices=("$@")
	[[ ${#Choices[@]} -eq 0 ]] && return 1
	for i in "${!_selected[@]}"; do
		if Array.Include Choices "${Choices[$i]}"; then
			CurrentSelected+=("$i")
		fi
	done
	if [[ -n $_question ]]; then
		echo "$_question" 1>&2
	fi
	while [[ $Key != "Enter" ]]; do
		for i in "${!Choices[@]}"; do
			[[ $i == "$CurrentChoice" ]] && {
				Esc.Bold && Esc.Underline
			}
			if [[ ${CurrentSelected[*]} =~ $i ]]; then
				echo " [X] $i: ${Choices[$i]}" 1>&2
			else
				echo " [ ] $i: ${Choices[$i]}" 1>&2
			fi
			Esc.ResetStyle
		done
		Key="$(CaptureSpecialKeys)"
		case "$Key" in
		Up)
			(("$CurrentChoice" != 0)) && CurrentChoice=$((CurrentChoice - 1))
			;;
		Down)
			(("$CurrentChoice" != "${#Choices[@]}" - 1)) && CurrentChoice=$((CurrentChoice + 1))
			;;
		Space)
			if Array.Include CurrentSelected "$CurrentChoice"; then
				Array.Remove CurrentSelected "$CurrentChoice"
			else
				CurrentSelected+=("$CurrentChoice")
			fi
			;;
		esac
		Esc.ClearUpperLines "${#Choices[@]}"
	done
	if [[ -n $_question ]]; then
		Esc.ClearUpperLines 1
	fi
	if [[ $_number == true ]]; then
		Array.Eval CurrentSelected
	else
		Array.ForEach CurrentSelected eval 'echo ${Choices[{}]}'
	fi
	return 0
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
ChoiceLoop() {
	while true; do
		if Choice "$@"; then
			break
		fi
	done
}
SelectMenu() {
	local arg OPTARG OPTIND
	local Choices=() CurrentChoice=0 Key=""
	local _question="" _default="" _number=false
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
	Choices=("$@")
	[[ ${#Choices[@]} -eq 0 ]] && return 1
	[[ ${#Choices[@]} -eq 1 ]] && {
		echo "${Choices[0]}" && return 0
	}
	if [[ -n $_default ]] && Array.Include Choices "$_default"; then
		CurrentChoice="$(Array.Eval Choices | Array.IndexOf "$_default")"
	fi
	if [[ -n $_question ]]; then
		echo "$_question" 1>&2
	fi
	while [[ $Key != "Enter" ]]; do
		for i in "${!Choices[@]}"; do
			if [[ $i == "$CurrentChoice" ]]; then
				Esc.Bold && Esc.Underline
				echo " > $i: ${Choices[$i]}" 1>&2
			else
				echo "   $i: ${Choices[$i]}" 1>&2
			fi
			Esc.ResetStyle
		done
		Key="$(CaptureSpecialKeys)"
		case "$Key" in
		Up)
			(("$CurrentChoice" != 0)) && CurrentChoice=$((CurrentChoice - 1))
			;;
		Down)
			(("$CurrentChoice" != "${#Choices[@]}" - 1)) && CurrentChoice=$((CurrentChoice + 1))
			;;
		esac
		Esc.ClearUpperLines "${#Choices[@]}"
	done
	if [[ -n $_question ]]; then
		Esc.ClearUpperLines 1
	fi
	if [[ $_number == true ]]; then
		echo "$CurrentChoice"
	else
		echo "${Choices[$CurrentChoice]}"
	fi
	return 0
}
readlinkf() {
	Readlinkf.posix "$@"
}
Readlinkf.posix() {
	[ "${1-}" ] || return 1
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
Readlinkf.readlink() {
	[ "${1-}" ] || return 1
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
	Readlinkf.Posix "$@"
}
Readlinkf_Readlink() {
	Readlinkf.Readlink "$@"
}
Sqlite3.select() {
	local _table="$1" _args=()
	shift 1 || return 1
	local _values=("$@")
	_args+=(select)
	ForEach eval '_args+=("\"{}\"" ,)' < <(PrintEvalArray _values)
	Array.Pop _args
	_args+=("from" "$_table" ";")
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
Sqlite3.call() {
	Msg.Debug sqlite3 "${SQLITE3_OPTIONS[@]}" "$SQLITE3_DBPATH" "$@" 1>&2
	sqlite3 "${SQLITE3_OPTIONS[@]}" "$SQLITE3_DBPATH" "$@"
}
Sqlite3.delete() {
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
	Sqlite3.call "${_args[*]}"
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
Sqlite3.insert() {
	local _table="$1" _args=()
	shift 1 || return 1
	local _values=("$@")
	_args+=(insert into "$_table" values '(')
	ForEach eval '_args+=("\"{}\"" ,)' < <(PrintEvalArray _values)
	Array.Pop _args
	_args+=(");")
	Sqlite3.call "${_args[*]}"
}
Sqlite3.create() {
	local _table="$1" _args=() _columns=()
	shift 1 || return 1
	_columns=("$@")
	_args+=(create table "$_table" "(")
	ForEach eval '_args+=("\"{}\"" ,)' < <(PrintEvalArray _columns)
	Array.Pop _args
	_args+=(")")
	Sqlite3.call "${_args[*]}"
}
Sqlite3.currentDb() {
	if [[ -z ${SQLITE3_DBPATH-""} ]]; then
		Msg.Err "No datebase is connected."
		return 1
	fi
	echo "${SQLITE3_DBPATH}"
	return 0
}
Sqlite3.connect() {
	export SQLITE3_DBPATH="$1"
	echo ".open \"$SQLITE3_DBPATH\"" | sqlite3
	return 0
}
SrcInfo.format() {
	RemoveBlank | sed "/^$/d" | grep -v "^#" | ForEach eval 'SrcInfo.parse Line <<< "{}"'
}
SrcInfo.parse() {
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
SrcInfo.getValue() {
	local _SrcInfo=()
	local _Output=()
	local _PkgBaseValues=("pkgver" "pkgrel" "epoch")
	local _AllValues=("pkgdesc" "url" "install" "changelog")
	local _AllArrays=("arch" "groups" "license" "noextract" "options" "backup" "validpgpkeys")
	local _AllArraysWithArch=("source" "depends" "checkdepends" "makedepends" "optdepends" "provides" "conflicts" "replaces" "md5sums" "sha1sums" "sha224sums" "sha256sums" "sha384sums" "sha512sums")
	ArrayAppend _SrcInfo
	ArrayIncludes _PkgBaseValues "$1" && {
		PrintEvalArray _SrcInfo | SrcInfo.getValueInPkgBase "$1"
		return 0
	}
	[[ -n ${2-""} ]] || {
		echo "No pkgname or pkgbase is specified" 1>&2
		return 1
	}
	if ArrayIncludes _AllValues "$1" || ArrayIncludes _AllArrays "$1"; then
		ArrayAppend _Output < <(PrintEvalArray _SrcInfo | SrcInfo.getValueInPkgBase "$1")
		ArrayAppend _Output < <(PrintEvalArray _SrcInfo | SrcInfo.getValueInPkgName "$2" "$1")
		PrintArray "${_Output[@]}" | tail -n 1
		return 0
	fi
	ArrayIncludes _AllArraysWithArch "$1" || return 1
	local _Arch _ArchList=()
	if [[ -z ${3-""} ]]; then
		ArrayAppend _ArchList < <(PrintEvalArray _SrcInfo | SrcInfo.getValue arch "$2")
	else
		ArrayAppend _ArchList < <(tr "," "\n" <<<"$3" | RemoveBlank)
	fi
	ArrayAppend _Output < <(PrintEvalArray _SrcInfo | SrcInfo.getValueInPkgBase "$1")
	ArrayAppend _Output < <(PrintEvalArray _SrcInfo | SrcInfo.getValueInPkgName "$2" "$1")
	for _Arch in "${_ArchList[@]}"; do
		ArrayAppend _Output < <(PrintEvalArray _SrcInfo | SrcInfo.getValueInPkgBase "$1_${_Arch}")
		ArrayAppend _Output < <(PrintEvalArray _SrcInfo | SrcInfo.getValueInPkgName "$2" "$1_${_Arch}")
	done
	PrintEvalArray _Output
	return 0
}
SrcInfo.getKeyList() {
	SrcInfo.format | cut -d "=" -f 1
}
URL.scheme() {
	cut -d ":" -f 1
}
URL.query() {
	local i
	while read -r i; do
		URL.pathAndQueryAndFragment <<<"$i" | sed "s|#$(URL.fragment <<<"$i")||g" | cut -d "?" -f 2-
	done
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
URL.authority() {
	local i _NoScheme
	while read -r i; do
		_NoScheme=$(URL.noScheme <<<"$i")
		[[ $_NoScheme == "//"* ]] || return 1
		cut -d "/" -f 1 < <(sed "s|^//||g" <<<"$_NoScheme")
	done
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
URL.noScheme() {
	cut -d ":" -f 2-
}
URL.host() {
	URL.authority | cut -d "@" -f 2- | cut -d ":" -f 1
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
URL.fragment() {
	local i
	i="$(URL.pathAndQueryAndFragment)"
	[[ $i == *"#"* ]] || return 0
	cut -d "#" -f 2- <<<"$i"
}
URL.hasPort() {
	local i="${1-""}"
	[[ -n $i ]] || read -r i
	[[ "$(URL.authority <<<"$i")" == *":"* ]]
}
URL.hasAuthority() {
	local i="${1-""}"
	[[ -n $i ]] || read -r i
	[[ "$(URL.noScheme <<<"$i")" == "//"* ]]
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
URL.hasFragment() {
	local i="${1-""}"
	[[ -n $i ]] || read -r i
	[[ "$(URL.pathAndQueryAndFragment <<<"$i")" == *"#"* ]]
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
