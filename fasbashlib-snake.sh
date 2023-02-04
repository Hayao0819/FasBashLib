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
FSBLIB_VERSION='v0.2.7.2.r440.ge730bc8-snake'
FSBLIB_REQUIRE='ModernBash'
FSBLIB_PROG_PIDFILEPATH='FSBLIB_PROGRESS_PIDLIST'

arch.get_mkinitcpio_preset_list() {
	find "/etc/mkinitcpio.d/" -name "*.preset" -type f | GetBaseName | RemoveFileExt
}
arch.get_kernel_src_list() {
	find "/usr/src" -mindepth 1 -maxdepth 1 -type l -name "linux*"
}
arch.get_kernel_file_list() {
	find "/boot" -maxdepth 1 -mindepth 1 -name "vmlinuz-*"
}
arch.get_mkinitcpio_preset_list() {
	find "/etc/mkinitcpio.d/" -name "*.preset" -type f | GetBaseName | RemoveFileExt
}
arch.get_kernel_src_list() {
	find "/usr/src" -mindepth 1 -maxdepth 1 -type l -name "linux*"
}
arch.get_kernel_file_list() {
	find "/boot" -maxdepth 1 -mindepth 1 -name "vmlinuz-*"
}
array.append() {
	local _ArrName="$1"
	shift 1 || return 1
	readarray -t -O "$(ArrayIndex "$_ArrName")" "$_ArrName" < <(cat)
}
array.shift() {
	readarray -t "$1" < <(PrintEvalArray "$1" | sed "1,${2-"1"}d")
}
array.push() {
	eval "PrintArray \"\${$1[@]}\"" | grep -qx "$2" && return 0
	eval "$1+=(\"$2\")"
}
array.from_str() {
	declare -a -x "$1"
	readarray -t "$1" < <(BreakChar)
}
array.pop() {
	readarray -t "$1" < <(PrintEvalArray "$1" | sed -e '$d')
}
array.rev() {
	readarray -t "$1" < <(PrintEvalArray "$1" | tac)
}
array.remove() {
	readarray -t "$1" < <(PrintEvalArray "$1" | RemoveMatchLine "$2")
}
array.print() {
	(($# >= 1)) || return 0
	printf "%s\n" "${@}"
}
array.last() {
	PrintEval "$1[$(array.last_index "$1")]"
}
array.eval() {
	eval "PrintArray \"\${$1[@]}\""
}
array.length() {
	PrintEval "#${1}[@]"
}
array.index_of() {
	local n=()
	readarray -t n < <(grep -x -n "$1" | cut -d ":" -f 1 | ForEach eval echo '$(( {} - 1 ))')
	(("${#n[@]}" >= 1)) || return 1
	PrintArray "${n[@]}"
	return 0
}
array.last_index() {
	CalcInt "$(array.length "$1")" - 1
}
array.includes() {
	PrintEvalArray "$1" | grep -qx "$2"
}
array.for_each() {
	PrintEvalArray "$1" | ForEach "${@:2}"
}
array.include() {
	array.includes "$@"
}
arch.get_mkinitcpio_preset_list() {
	find "/etc/mkinitcpio.d/" -name "*.preset" -type f | GetBaseName | RemoveFileExt
}
arch.get_kernel_src_list() {
	find "/usr/src" -mindepth 1 -maxdepth 1 -type l -name "linux*"
}
arch.get_kernel_file_list() {
	find "/boot" -maxdepth 1 -mindepth 1 -name "vmlinuz-*"
}
array.append() {
	local _ArrName="$1"
	shift 1 || return 1
	readarray -t -O "$(ArrayIndex "$_ArrName")" "$_ArrName" < <(cat)
}
array.shift() {
	readarray -t "$1" < <(PrintEvalArray "$1" | sed "1,${2-"1"}d")
}
array.push() {
	eval "PrintArray \"\${$1[@]}\"" | grep -qx "$2" && return 0
	eval "$1+=(\"$2\")"
}
array.from_str() {
	declare -a -x "$1"
	readarray -t "$1" < <(BreakChar)
}
array.pop() {
	readarray -t "$1" < <(PrintEvalArray "$1" | sed -e '$d')
}
array.rev() {
	readarray -t "$1" < <(PrintEvalArray "$1" | tac)
}
array.remove() {
	readarray -t "$1" < <(PrintEvalArray "$1" | RemoveMatchLine "$2")
}
array.print() {
	(($# >= 1)) || return 0
	printf "%s\n" "${@}"
}
array.last() {
	PrintEval "$1[$(array.last_index "$1")]"
}
array.eval() {
	eval "PrintArray \"\${$1[@]}\""
}
array.length() {
	PrintEval "#${1}[@]"
}
array.index_of() {
	local n=()
	readarray -t n < <(grep -x -n "$1" | cut -d ":" -f 1 | ForEach eval echo '$(( {} - 1 ))')
	(("${#n[@]}" >= 1)) || return 1
	PrintArray "${n[@]}"
	return 0
}
array.last_index() {
	CalcInt "$(array.length "$1")" - 1
}
array.includes() {
	PrintEvalArray "$1" | grep -qx "$2"
}
array.for_each() {
	PrintEvalArray "$1" | ForEach "${@:2}"
}
array.include() {
	array.includes "$@"
}
awk.cos() {
	awk.float "cos($*)"
}
awk.tan() {
	awk.float "sin($1)/tan($1)"
}
awk.sin() {
	awk.float "sin($*)"
}
awk.pi() {
	awk.float "atan2(0, -0)"
}
awk.print() {
	awk "BEGIN {print $*}"
}
awk.log() {
	awk.float "log(${2}) / log($1)"
}
awk.rad() {
	awk.float "$1 * $(awk.pi) / 180 "
}
awk.float() {
	awk "BEGIN {printf (\"%4.${AWKSCALE-"5"}f\n\", $*)}"
}
arch.get_mkinitcpio_preset_list() {
	find "/etc/mkinitcpio.d/" -name "*.preset" -type f | GetBaseName | RemoveFileExt
}
arch.get_kernel_src_list() {
	find "/usr/src" -mindepth 1 -maxdepth 1 -type l -name "linux*"
}
arch.get_kernel_file_list() {
	find "/boot" -maxdepth 1 -mindepth 1 -name "vmlinuz-*"
}
array.append() {
	local _ArrName="$1"
	shift 1 || return 1
	readarray -t -O "$(ArrayIndex "$_ArrName")" "$_ArrName" < <(cat)
}
array.shift() {
	readarray -t "$1" < <(PrintEvalArray "$1" | sed "1,${2-"1"}d")
}
array.push() {
	eval "PrintArray \"\${$1[@]}\"" | grep -qx "$2" && return 0
	eval "$1+=(\"$2\")"
}
array.from_str() {
	declare -a -x "$1"
	readarray -t "$1" < <(BreakChar)
}
array.pop() {
	readarray -t "$1" < <(PrintEvalArray "$1" | sed -e '$d')
}
array.rev() {
	readarray -t "$1" < <(PrintEvalArray "$1" | tac)
}
array.remove() {
	readarray -t "$1" < <(PrintEvalArray "$1" | RemoveMatchLine "$2")
}
array.print() {
	(($# >= 1)) || return 0
	printf "%s\n" "${@}"
}
array.last() {
	PrintEval "$1[$(array.last_index "$1")]"
}
array.eval() {
	eval "PrintArray \"\${$1[@]}\""
}
array.length() {
	PrintEval "#${1}[@]"
}
array.index_of() {
	local n=()
	readarray -t n < <(grep -x -n "$1" | cut -d ":" -f 1 | ForEach eval echo '$(( {} - 1 ))')
	(("${#n[@]}" >= 1)) || return 1
	PrintArray "${n[@]}"
	return 0
}
array.last_index() {
	CalcInt "$(array.length "$1")" - 1
}
array.includes() {
	PrintEvalArray "$1" | grep -qx "$2"
}
array.for_each() {
	PrintEvalArray "$1" | ForEach "${@:2}"
}
array.include() {
	array.includes "$@"
}
awk.cos() {
	awk.float "cos($*)"
}
awk.tan() {
	awk.float "sin($1)/tan($1)"
}
awk.sin() {
	awk.float "sin($*)"
}
awk.pi() {
	awk.float "atan2(0, -0)"
}
awk.print() {
	awk "BEGIN {print $*}"
}
awk.log() {
	awk.float "log(${2}) / log($1)"
}
awk.rad() {
	awk.float "$1 * $(awk.pi) / 180 "
}
awk.float() {
	awk "BEGIN {printf (\"%4.${AWKSCALE-"5"}f\n\", $*)}"
}
PrintEvalArray() {
	Array.Eval "$1"
}
ArrayAppend() {
	Array.Append "$1"
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
StrToCharList() {
	Array.FromStr "$1"
}
GetArrayIndex() {
	Array.IndexOf "$1"
}
ArrayIndex() {
	Array.Length "$1"
}
AddNewToArray() {
	Array.Push "$@"
}
FileType() {
	file --mime-type -b "$1"
}
RemoveFileExt() {
	local Ext
	ForEach eval 'Ext=$(GetFileExt <<< {}); sed "s|.$Ext$||g" <<< {}; unset Ext'
}
GetFileExt() {
	GetBaseName | rev | cut -d "." -f 1 | rev
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
ToLower() {
	local _Str="${1,,}"
	[[ -z ${_Str-""} ]] || echo "${_Str}"
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
PrintEval() {
	eval echo "\${$1}"
}
RemoveBlank() {
	sed "s|^ *||g; s| *$||g; s|^	*||g; s|	*$||g; /^$/d"
}
GetMaxWidth() {
	awk '{ if ( length > x && length > 0 ) { x = length } }END{ print x }'
}
RandomString() {
	base64 <"/dev/random" | fold -w "$1" | head -n 1
	return 0
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
GetLastSplitString() {
	rev <<<"$2" | cut -d "$1" -f 1 | rev
}
CutLastString() {
	echo "${1%%"${2}"}"
	return 0
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
ToArgs() {
	readarray -t args
	"$@" "${args[@]}"
}
arch.get_mkinitcpio_preset_list() {
	find "/etc/mkinitcpio.d/" -name "*.preset" -type f | GetBaseName | RemoveFileExt
}
arch.get_kernel_src_list() {
	find "/usr/src" -mindepth 1 -maxdepth 1 -type l -name "linux*"
}
arch.get_kernel_file_list() {
	find "/boot" -maxdepth 1 -mindepth 1 -name "vmlinuz-*"
}
array.append() {
	local _ArrName="$1"
	shift 1 || return 1
	readarray -t -O "$(ArrayIndex "$_ArrName")" "$_ArrName" < <(cat)
}
array.shift() {
	readarray -t "$1" < <(PrintEvalArray "$1" | sed "1,${2-"1"}d")
}
array.push() {
	eval "PrintArray \"\${$1[@]}\"" | grep -qx "$2" && return 0
	eval "$1+=(\"$2\")"
}
array.from_str() {
	declare -a -x "$1"
	readarray -t "$1" < <(BreakChar)
}
array.pop() {
	readarray -t "$1" < <(PrintEvalArray "$1" | sed -e '$d')
}
array.rev() {
	readarray -t "$1" < <(PrintEvalArray "$1" | tac)
}
array.remove() {
	readarray -t "$1" < <(PrintEvalArray "$1" | RemoveMatchLine "$2")
}
array.print() {
	(($# >= 1)) || return 0
	printf "%s\n" "${@}"
}
array.last() {
	PrintEval "$1[$(array.last_index "$1")]"
}
array.eval() {
	eval "PrintArray \"\${$1[@]}\""
}
array.length() {
	PrintEval "#${1}[@]"
}
array.index_of() {
	local n=()
	readarray -t n < <(grep -x -n "$1" | cut -d ":" -f 1 | ForEach eval echo '$(( {} - 1 ))')
	(("${#n[@]}" >= 1)) || return 1
	PrintArray "${n[@]}"
	return 0
}
array.last_index() {
	CalcInt "$(array.length "$1")" - 1
}
array.includes() {
	PrintEvalArray "$1" | grep -qx "$2"
}
array.for_each() {
	PrintEvalArray "$1" | ForEach "${@:2}"
}
array.include() {
	array.includes "$@"
}
awk.cos() {
	awk.float "cos($*)"
}
awk.tan() {
	awk.float "sin($1)/tan($1)"
}
awk.sin() {
	awk.float "sin($*)"
}
awk.pi() {
	awk.float "atan2(0, -0)"
}
awk.print() {
	awk "BEGIN {print $*}"
}
awk.log() {
	awk.float "log(${2}) / log($1)"
}
awk.rad() {
	awk.float "$1 * $(awk.pi) / 180 "
}
awk.float() {
	awk "BEGIN {printf (\"%4.${AWKSCALE-"5"}f\n\", $*)}"
}
PrintEvalArray() {
	Array.Eval "$1"
}
ArrayAppend() {
	Array.Append "$1"
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
StrToCharList() {
	Array.FromStr "$1"
}
GetArrayIndex() {
	Array.IndexOf "$1"
}
ArrayIndex() {
	Array.Length "$1"
}
AddNewToArray() {
	Array.Push "$@"
}
FileType() {
	file --mime-type -b "$1"
}
RemoveFileExt() {
	local Ext
	ForEach eval 'Ext=$(GetFileExt <<< {}); sed "s|.$Ext$||g" <<< {}; unset Ext'
}
GetFileExt() {
	GetBaseName | rev | cut -d "." -f 1 | rev
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
ToLower() {
	local _Str="${1,,}"
	[[ -z ${_Str-""} ]] || echo "${_Str}"
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
PrintEval() {
	eval echo "\${$1}"
}
RemoveBlank() {
	sed "s|^ *||g; s| *$||g; s|^	*||g; s|	*$||g; /^$/d"
}
GetMaxWidth() {
	awk '{ if ( length > x && length > 0 ) { x = length } }END{ print x }'
}
RandomString() {
	base64 <"/dev/random" | fold -w "$1" | head -n 1
	return 0
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
GetLastSplitString() {
	rev <<<"$2" | cut -d "$1" -f 1 | rev
}
CutLastString() {
	echo "${1%%"${2}"}"
	return 0
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
ToArgs() {
	readarray -t args
	"$@" "${args[@]}"
}
cache.get_file_last_update() {
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
cache.exist() {
	local _File
	_File="$(cache.create_dir)/$1"
	[[ -e $_File ]] || return 1
	(("$(cache.get_time_diff_from_last_update "$_File")" > "${KEEPCACHESEC-"86400"}")) && return 2
	return 0
}
cache.get_time_diff_from_last_update() {
	local _Now _Last
	_Now="$(date "+%s")"
	_Last="$(cache.get_file_last_update "$1")"
	echo "$((_Now - _Last))"
	return 0
}
cache.get_id() {
	if [[ -z ${FSBLIB_CACHEID-""} ]]; then
		cache.create_dir >/dev/null
	fi
	echo "$FSBLIB_CACHEID"
}
cache.get_dir() {
	echo "${TMPDIR-"/tmp"}/$(cache.get_id)"
}
cache.get() {
	cat "$(cache.get_dir)/$1" 2>/dev/null || return 1
}
cache.create() {
	cache.create_dir >/dev/null
	cat >"$(cache.get_dir)/${1}"
	cat "$(cache.get_dir)/$1"
}
cache.create_dir() {
	FSBLIB_CACHEID="${FSBLIB_CACHEID-"$(RandomString "10")"}"
	export FSBLIB_CACHEID="$FSBLIB_CACHEID"
	local TMPDIR="${TMPDIR-"/tmp"}"
	local _Dir="$TMPDIR/${FSBLIB_CACHEID}"
	mkdir -p "$_Dir"
	echo "$_Dir"
	return 0
}
arch.get_mkinitcpio_preset_list() {
	find "/etc/mkinitcpio.d/" -name "*.preset" -type f | GetBaseName | RemoveFileExt
}
arch.get_kernel_src_list() {
	find "/usr/src" -mindepth 1 -maxdepth 1 -type l -name "linux*"
}
arch.get_kernel_file_list() {
	find "/boot" -maxdepth 1 -mindepth 1 -name "vmlinuz-*"
}
array.append() {
	local _ArrName="$1"
	shift 1 || return 1
	readarray -t -O "$(ArrayIndex "$_ArrName")" "$_ArrName" < <(cat)
}
array.shift() {
	readarray -t "$1" < <(PrintEvalArray "$1" | sed "1,${2-"1"}d")
}
array.push() {
	eval "PrintArray \"\${$1[@]}\"" | grep -qx "$2" && return 0
	eval "$1+=(\"$2\")"
}
array.from_str() {
	declare -a -x "$1"
	readarray -t "$1" < <(BreakChar)
}
array.pop() {
	readarray -t "$1" < <(PrintEvalArray "$1" | sed -e '$d')
}
array.rev() {
	readarray -t "$1" < <(PrintEvalArray "$1" | tac)
}
array.remove() {
	readarray -t "$1" < <(PrintEvalArray "$1" | RemoveMatchLine "$2")
}
array.print() {
	(($# >= 1)) || return 0
	printf "%s\n" "${@}"
}
array.last() {
	PrintEval "$1[$(array.last_index "$1")]"
}
array.eval() {
	eval "PrintArray \"\${$1[@]}\""
}
array.length() {
	PrintEval "#${1}[@]"
}
array.index_of() {
	local n=()
	readarray -t n < <(grep -x -n "$1" | cut -d ":" -f 1 | ForEach eval echo '$(( {} - 1 ))')
	(("${#n[@]}" >= 1)) || return 1
	PrintArray "${n[@]}"
	return 0
}
array.last_index() {
	CalcInt "$(array.length "$1")" - 1
}
array.includes() {
	PrintEvalArray "$1" | grep -qx "$2"
}
array.for_each() {
	PrintEvalArray "$1" | ForEach "${@:2}"
}
array.include() {
	array.includes "$@"
}
awk.cos() {
	awk.float "cos($*)"
}
awk.tan() {
	awk.float "sin($1)/tan($1)"
}
awk.sin() {
	awk.float "sin($*)"
}
awk.pi() {
	awk.float "atan2(0, -0)"
}
awk.print() {
	awk "BEGIN {print $*}"
}
awk.log() {
	awk.float "log(${2}) / log($1)"
}
awk.rad() {
	awk.float "$1 * $(awk.pi) / 180 "
}
awk.float() {
	awk "BEGIN {printf (\"%4.${AWKSCALE-"5"}f\n\", $*)}"
}
PrintEvalArray() {
	Array.Eval "$1"
}
ArrayAppend() {
	Array.Append "$1"
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
StrToCharList() {
	Array.FromStr "$1"
}
GetArrayIndex() {
	Array.IndexOf "$1"
}
ArrayIndex() {
	Array.Length "$1"
}
AddNewToArray() {
	Array.Push "$@"
}
FileType() {
	file --mime-type -b "$1"
}
RemoveFileExt() {
	local Ext
	ForEach eval 'Ext=$(GetFileExt <<< {}); sed "s|.$Ext$||g" <<< {}; unset Ext'
}
GetFileExt() {
	GetBaseName | rev | cut -d "." -f 1 | rev
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
ToLower() {
	local _Str="${1,,}"
	[[ -z ${_Str-""} ]] || echo "${_Str}"
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
PrintEval() {
	eval echo "\${$1}"
}
RemoveBlank() {
	sed "s|^ *||g; s| *$||g; s|^	*||g; s|	*$||g; /^$/d"
}
GetMaxWidth() {
	awk '{ if ( length > x && length > 0 ) { x = length } }END{ print x }'
}
RandomString() {
	base64 <"/dev/random" | fold -w "$1" | head -n 1
	return 0
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
GetLastSplitString() {
	rev <<<"$2" | cut -d "$1" -f 1 | rev
}
CutLastString() {
	echo "${1%%"${2}"}"
	return 0
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
ToArgs() {
	readarray -t args
	"$@" "${args[@]}"
}
cache.get_file_last_update() {
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
cache.exist() {
	local _File
	_File="$(cache.create_dir)/$1"
	[[ -e $_File ]] || return 1
	(("$(cache.get_time_diff_from_last_update "$_File")" > "${KEEPCACHESEC-"86400"}")) && return 2
	return 0
}
cache.get_time_diff_from_last_update() {
	local _Now _Last
	_Now="$(date "+%s")"
	_Last="$(cache.get_file_last_update "$1")"
	echo "$((_Now - _Last))"
	return 0
}
cache.get_id() {
	if [[ -z ${FSBLIB_CACHEID-""} ]]; then
		cache.create_dir >/dev/null
	fi
	echo "$FSBLIB_CACHEID"
}
cache.get_dir() {
	echo "${TMPDIR-"/tmp"}/$(cache.get_id)"
}
cache.get() {
	cat "$(cache.get_dir)/$1" 2>/dev/null || return 1
}
cache.create() {
	cache.create_dir >/dev/null
	cat >"$(cache.get_dir)/${1}"
	cat "$(cache.get_dir)/$1"
}
cache.create_dir() {
	FSBLIB_CACHEID="${FSBLIB_CACHEID-"$(RandomString "10")"}"
	export FSBLIB_CACHEID="$FSBLIB_CACHEID"
	local TMPDIR="${TMPDIR-"/tmp"}"
	local _Dir="$TMPDIR/${FSBLIB_CACHEID}"
	mkdir -p "$_Dir"
	echo "$_Dir"
	return 0
}
fsblib.require_lib() {
	local lib missing=() return=0
	for lib in "$@"; do
		if ! [[ ${FSBLIB_LIBLIST[*]} == *" $lib "* ]]; then
			missing+=("$lib")
			return=1
		fi
	done
	return "$return"
}
fsblib_env_check() {
	fsblib.env_check
}
fsblib.env_check() {
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
arch.get_mkinitcpio_preset_list() {
	find "/etc/mkinitcpio.d/" -name "*.preset" -type f | GetBaseName | RemoveFileExt
}
arch.get_kernel_src_list() {
	find "/usr/src" -mindepth 1 -maxdepth 1 -type l -name "linux*"
}
arch.get_kernel_file_list() {
	find "/boot" -maxdepth 1 -mindepth 1 -name "vmlinuz-*"
}
array.append() {
	local _ArrName="$1"
	shift 1 || return 1
	readarray -t -O "$(ArrayIndex "$_ArrName")" "$_ArrName" < <(cat)
}
array.shift() {
	readarray -t "$1" < <(PrintEvalArray "$1" | sed "1,${2-"1"}d")
}
array.push() {
	eval "PrintArray \"\${$1[@]}\"" | grep -qx "$2" && return 0
	eval "$1+=(\"$2\")"
}
array.from_str() {
	declare -a -x "$1"
	readarray -t "$1" < <(BreakChar)
}
array.pop() {
	readarray -t "$1" < <(PrintEvalArray "$1" | sed -e '$d')
}
array.rev() {
	readarray -t "$1" < <(PrintEvalArray "$1" | tac)
}
array.remove() {
	readarray -t "$1" < <(PrintEvalArray "$1" | RemoveMatchLine "$2")
}
array.print() {
	(($# >= 1)) || return 0
	printf "%s\n" "${@}"
}
array.last() {
	PrintEval "$1[$(array.last_index "$1")]"
}
array.eval() {
	eval "PrintArray \"\${$1[@]}\""
}
array.length() {
	PrintEval "#${1}[@]"
}
array.index_of() {
	local n=()
	readarray -t n < <(grep -x -n "$1" | cut -d ":" -f 1 | ForEach eval echo '$(( {} - 1 ))')
	(("${#n[@]}" >= 1)) || return 1
	PrintArray "${n[@]}"
	return 0
}
array.last_index() {
	CalcInt "$(array.length "$1")" - 1
}
array.includes() {
	PrintEvalArray "$1" | grep -qx "$2"
}
array.for_each() {
	PrintEvalArray "$1" | ForEach "${@:2}"
}
array.include() {
	array.includes "$@"
}
awk.cos() {
	awk.float "cos($*)"
}
awk.tan() {
	awk.float "sin($1)/tan($1)"
}
awk.sin() {
	awk.float "sin($*)"
}
awk.pi() {
	awk.float "atan2(0, -0)"
}
awk.print() {
	awk "BEGIN {print $*}"
}
awk.log() {
	awk.float "log(${2}) / log($1)"
}
awk.rad() {
	awk.float "$1 * $(awk.pi) / 180 "
}
awk.float() {
	awk "BEGIN {printf (\"%4.${AWKSCALE-"5"}f\n\", $*)}"
}
PrintEvalArray() {
	Array.Eval "$1"
}
ArrayAppend() {
	Array.Append "$1"
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
StrToCharList() {
	Array.FromStr "$1"
}
GetArrayIndex() {
	Array.IndexOf "$1"
}
ArrayIndex() {
	Array.Length "$1"
}
AddNewToArray() {
	Array.Push "$@"
}
FileType() {
	file --mime-type -b "$1"
}
RemoveFileExt() {
	local Ext
	ForEach eval 'Ext=$(GetFileExt <<< {}); sed "s|.$Ext$||g" <<< {}; unset Ext'
}
GetFileExt() {
	GetBaseName | rev | cut -d "." -f 1 | rev
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
ToLower() {
	local _Str="${1,,}"
	[[ -z ${_Str-""} ]] || echo "${_Str}"
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
PrintEval() {
	eval echo "\${$1}"
}
RemoveBlank() {
	sed "s|^ *||g; s| *$||g; s|^	*||g; s|	*$||g; /^$/d"
}
GetMaxWidth() {
	awk '{ if ( length > x && length > 0 ) { x = length } }END{ print x }'
}
RandomString() {
	base64 <"/dev/random" | fold -w "$1" | head -n 1
	return 0
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
GetLastSplitString() {
	rev <<<"$2" | cut -d "$1" -f 1 | rev
}
CutLastString() {
	echo "${1%%"${2}"}"
	return 0
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
ToArgs() {
	readarray -t args
	"$@" "${args[@]}"
}
cache.get_file_last_update() {
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
cache.exist() {
	local _File
	_File="$(cache.create_dir)/$1"
	[[ -e $_File ]] || return 1
	(("$(cache.get_time_diff_from_last_update "$_File")" > "${KEEPCACHESEC-"86400"}")) && return 2
	return 0
}
cache.get_time_diff_from_last_update() {
	local _Now _Last
	_Now="$(date "+%s")"
	_Last="$(cache.get_file_last_update "$1")"
	echo "$((_Now - _Last))"
	return 0
}
cache.get_id() {
	if [[ -z ${FSBLIB_CACHEID-""} ]]; then
		cache.create_dir >/dev/null
	fi
	echo "$FSBLIB_CACHEID"
}
cache.get_dir() {
	echo "${TMPDIR-"/tmp"}/$(cache.get_id)"
}
cache.get() {
	cat "$(cache.get_dir)/$1" 2>/dev/null || return 1
}
cache.create() {
	cache.create_dir >/dev/null
	cat >"$(cache.get_dir)/${1}"
	cat "$(cache.get_dir)/$1"
}
cache.create_dir() {
	FSBLIB_CACHEID="${FSBLIB_CACHEID-"$(RandomString "10")"}"
	export FSBLIB_CACHEID="$FSBLIB_CACHEID"
	local TMPDIR="${TMPDIR-"/tmp"}"
	local _Dir="$TMPDIR/${FSBLIB_CACHEID}"
	mkdir -p "$_Dir"
	echo "$_Dir"
	return 0
}
fsblib.require_lib() {
	local lib missing=() return=0
	for lib in "$@"; do
		if ! [[ ${FSBLIB_LIBLIST[*]} == *" $lib "* ]]; then
			missing+=("$lib")
			return=1
		fi
	done
	return "$return"
}
fsblib_env_check() {
	fsblib.env_check
}
fsblib.env_check() {
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
csv.to_bash_array() {
	local _RawCsvLine=() _Line _ClmCnt=0
	local ArrayPrefix="${ArrayPrefix-"{}"}"
	readarray -t _RawCsvLine < <(
		while read -r _Line; do
			(($(tr "${CSVDELIM-","}" "\n" <<<"$_Line" | wc -l) >= ${#})) && echo "$_Line"
		done < <(grep -v "^#")
	)
	_ClmCnt=$(PrintArray "${_RawCsvLine[@]}" | csv.get_clm_cnt)
	while read -r _Cnt; do
		readarray -t "$(sed "s|{}|$(eval "echo \"\${${_Cnt}}\"")|g" <<<"$ArrayPrefix")" < <(
			PrintArray "${_RawCsvLine[@]}" | cut -d "${CSVDELIM-","}" -f "$_Cnt"
		)
	done < <(seq 1 "$#")
}
csv.get_clm() {
	grep -v "^#" | sed "/^$/d" | cut -d "${CSVDELIM-","}" -f "$1"
}
csv.get_clm_cnt() {
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
arch.get_mkinitcpio_preset_list() {
	find "/etc/mkinitcpio.d/" -name "*.preset" -type f | GetBaseName | RemoveFileExt
}
arch.get_kernel_src_list() {
	find "/usr/src" -mindepth 1 -maxdepth 1 -type l -name "linux*"
}
arch.get_kernel_file_list() {
	find "/boot" -maxdepth 1 -mindepth 1 -name "vmlinuz-*"
}
array.append() {
	local _ArrName="$1"
	shift 1 || return 1
	readarray -t -O "$(ArrayIndex "$_ArrName")" "$_ArrName" < <(cat)
}
array.shift() {
	readarray -t "$1" < <(PrintEvalArray "$1" | sed "1,${2-"1"}d")
}
array.push() {
	eval "PrintArray \"\${$1[@]}\"" | grep -qx "$2" && return 0
	eval "$1+=(\"$2\")"
}
array.from_str() {
	declare -a -x "$1"
	readarray -t "$1" < <(BreakChar)
}
array.pop() {
	readarray -t "$1" < <(PrintEvalArray "$1" | sed -e '$d')
}
array.rev() {
	readarray -t "$1" < <(PrintEvalArray "$1" | tac)
}
array.remove() {
	readarray -t "$1" < <(PrintEvalArray "$1" | RemoveMatchLine "$2")
}
array.print() {
	(($# >= 1)) || return 0
	printf "%s\n" "${@}"
}
array.last() {
	PrintEval "$1[$(array.last_index "$1")]"
}
array.eval() {
	eval "PrintArray \"\${$1[@]}\""
}
array.length() {
	PrintEval "#${1}[@]"
}
array.index_of() {
	local n=()
	readarray -t n < <(grep -x -n "$1" | cut -d ":" -f 1 | ForEach eval echo '$(( {} - 1 ))')
	(("${#n[@]}" >= 1)) || return 1
	PrintArray "${n[@]}"
	return 0
}
array.last_index() {
	CalcInt "$(array.length "$1")" - 1
}
array.includes() {
	PrintEvalArray "$1" | grep -qx "$2"
}
array.for_each() {
	PrintEvalArray "$1" | ForEach "${@:2}"
}
array.include() {
	array.includes "$@"
}
awk.cos() {
	awk.float "cos($*)"
}
awk.tan() {
	awk.float "sin($1)/tan($1)"
}
awk.sin() {
	awk.float "sin($*)"
}
awk.pi() {
	awk.float "atan2(0, -0)"
}
awk.print() {
	awk "BEGIN {print $*}"
}
awk.log() {
	awk.float "log(${2}) / log($1)"
}
awk.rad() {
	awk.float "$1 * $(awk.pi) / 180 "
}
awk.float() {
	awk "BEGIN {printf (\"%4.${AWKSCALE-"5"}f\n\", $*)}"
}
PrintEvalArray() {
	Array.Eval "$1"
}
ArrayAppend() {
	Array.Append "$1"
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
StrToCharList() {
	Array.FromStr "$1"
}
GetArrayIndex() {
	Array.IndexOf "$1"
}
ArrayIndex() {
	Array.Length "$1"
}
AddNewToArray() {
	Array.Push "$@"
}
FileType() {
	file --mime-type -b "$1"
}
RemoveFileExt() {
	local Ext
	ForEach eval 'Ext=$(GetFileExt <<< {}); sed "s|.$Ext$||g" <<< {}; unset Ext'
}
GetFileExt() {
	GetBaseName | rev | cut -d "." -f 1 | rev
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
ToLower() {
	local _Str="${1,,}"
	[[ -z ${_Str-""} ]] || echo "${_Str}"
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
PrintEval() {
	eval echo "\${$1}"
}
RemoveBlank() {
	sed "s|^ *||g; s| *$||g; s|^	*||g; s|	*$||g; /^$/d"
}
GetMaxWidth() {
	awk '{ if ( length > x && length > 0 ) { x = length } }END{ print x }'
}
RandomString() {
	base64 <"/dev/random" | fold -w "$1" | head -n 1
	return 0
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
GetLastSplitString() {
	rev <<<"$2" | cut -d "$1" -f 1 | rev
}
CutLastString() {
	echo "${1%%"${2}"}"
	return 0
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
ToArgs() {
	readarray -t args
	"$@" "${args[@]}"
}
cache.get_file_last_update() {
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
cache.exist() {
	local _File
	_File="$(cache.create_dir)/$1"
	[[ -e $_File ]] || return 1
	(("$(cache.get_time_diff_from_last_update "$_File")" > "${KEEPCACHESEC-"86400"}")) && return 2
	return 0
}
cache.get_time_diff_from_last_update() {
	local _Now _Last
	_Now="$(date "+%s")"
	_Last="$(cache.get_file_last_update "$1")"
	echo "$((_Now - _Last))"
	return 0
}
cache.get_id() {
	if [[ -z ${FSBLIB_CACHEID-""} ]]; then
		cache.create_dir >/dev/null
	fi
	echo "$FSBLIB_CACHEID"
}
cache.get_dir() {
	echo "${TMPDIR-"/tmp"}/$(cache.get_id)"
}
cache.get() {
	cat "$(cache.get_dir)/$1" 2>/dev/null || return 1
}
cache.create() {
	cache.create_dir >/dev/null
	cat >"$(cache.get_dir)/${1}"
	cat "$(cache.get_dir)/$1"
}
cache.create_dir() {
	FSBLIB_CACHEID="${FSBLIB_CACHEID-"$(RandomString "10")"}"
	export FSBLIB_CACHEID="$FSBLIB_CACHEID"
	local TMPDIR="${TMPDIR-"/tmp"}"
	local _Dir="$TMPDIR/${FSBLIB_CACHEID}"
	mkdir -p "$_Dir"
	echo "$_Dir"
	return 0
}
fsblib.require_lib() {
	local lib missing=() return=0
	for lib in "$@"; do
		if ! [[ ${FSBLIB_LIBLIST[*]} == *" $lib "* ]]; then
			missing+=("$lib")
			return=1
		fi
	done
	return "$return"
}
fsblib_env_check() {
	fsblib.env_check
}
fsblib.env_check() {
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
csv.to_bash_array() {
	local _RawCsvLine=() _Line _ClmCnt=0
	local ArrayPrefix="${ArrayPrefix-"{}"}"
	readarray -t _RawCsvLine < <(
		while read -r _Line; do
			(($(tr "${CSVDELIM-","}" "\n" <<<"$_Line" | wc -l) >= ${#})) && echo "$_Line"
		done < <(grep -v "^#")
	)
	_ClmCnt=$(PrintArray "${_RawCsvLine[@]}" | csv.get_clm_cnt)
	while read -r _Cnt; do
		readarray -t "$(sed "s|{}|$(eval "echo \"\${${_Cnt}}\"")|g" <<<"$ArrayPrefix")" < <(
			PrintArray "${_RawCsvLine[@]}" | cut -d "${CSVDELIM-","}" -f "$_Cnt"
		)
	done < <(seq 1 "$#")
}
csv.get_clm() {
	grep -v "^#" | sed "/^$/d" | cut -d "${CSVDELIM-","}" -f "$1"
}
csv.get_clm_cnt() {
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
em.get_world_pkg_list() {
	sed -E 's|:.+$||g' /var/lib/portage/world | xargs -I{} bash -c 'ls -d /var/db/pkg/{}-* | sed "s|/var/db/pkg/||g" | grep -E "{}-[0-9]"'
}
em.get_repo_pkg_list() {
	local _RepoPath
	_RepoPath="$(em.get_repo_location "$1")"
	find "$_RepoPath" -mindepth 3 -maxdepth 3 -type f -name '*.ebuild' | sed -e "s|${_RepoPath%/}/||g" -e 's|.ebuild$||g' | awk -F "/" '{print $1"/"$3}'
}
em.get_all_pkg_list() {
	em.get_repo_conf | sed -e 's/^ *//' -e 's/ *$//' | grep "^ *location *=" | sed -e 's/^location *= *//' | xargs -L1 realpath | xargs -I{} bash -c "find '{}' -mindepth 3 -maxdepth 3 -type f -name '*.ebuild' | sed -e 's|{}/||g' -e 's|.ebuild$||g'" | awk -F "/" '{print $1"/"$3}'
}
em.get_installed_pkg_list() {
	find /var/db/pkg/ -mindepth 2 -maxdepth 2 -type d | sed 's|/var/db/pkg/||g'
}
em.get_repo_location() {
	em.get_repo_conf | Ini.GetParam "$1" location
}
em.get_repo_conf() {
	cat /etc/portage/repos.conf /etc/portage/repos.conf/* 2>/dev/null
}
em.get_default_repo_name() {
	em.get_repo_conf | Ini.GetParam DEFAULT main-repo
}
em.no_version() {
	sed -E 's|\-[0-9]+.+||g'
}
arch.get_mkinitcpio_preset_list() {
	find "/etc/mkinitcpio.d/" -name "*.preset" -type f | GetBaseName | RemoveFileExt
}
arch.get_kernel_src_list() {
	find "/usr/src" -mindepth 1 -maxdepth 1 -type l -name "linux*"
}
arch.get_kernel_file_list() {
	find "/boot" -maxdepth 1 -mindepth 1 -name "vmlinuz-*"
}
array.append() {
	local _ArrName="$1"
	shift 1 || return 1
	readarray -t -O "$(ArrayIndex "$_ArrName")" "$_ArrName" < <(cat)
}
array.shift() {
	readarray -t "$1" < <(PrintEvalArray "$1" | sed "1,${2-"1"}d")
}
array.push() {
	eval "PrintArray \"\${$1[@]}\"" | grep -qx "$2" && return 0
	eval "$1+=(\"$2\")"
}
array.from_str() {
	declare -a -x "$1"
	readarray -t "$1" < <(BreakChar)
}
array.pop() {
	readarray -t "$1" < <(PrintEvalArray "$1" | sed -e '$d')
}
array.rev() {
	readarray -t "$1" < <(PrintEvalArray "$1" | tac)
}
array.remove() {
	readarray -t "$1" < <(PrintEvalArray "$1" | RemoveMatchLine "$2")
}
array.print() {
	(($# >= 1)) || return 0
	printf "%s\n" "${@}"
}
array.last() {
	PrintEval "$1[$(array.last_index "$1")]"
}
array.eval() {
	eval "PrintArray \"\${$1[@]}\""
}
array.length() {
	PrintEval "#${1}[@]"
}
array.index_of() {
	local n=()
	readarray -t n < <(grep -x -n "$1" | cut -d ":" -f 1 | ForEach eval echo '$(( {} - 1 ))')
	(("${#n[@]}" >= 1)) || return 1
	PrintArray "${n[@]}"
	return 0
}
array.last_index() {
	CalcInt "$(array.length "$1")" - 1
}
array.includes() {
	PrintEvalArray "$1" | grep -qx "$2"
}
array.for_each() {
	PrintEvalArray "$1" | ForEach "${@:2}"
}
array.include() {
	array.includes "$@"
}
awk.cos() {
	awk.float "cos($*)"
}
awk.tan() {
	awk.float "sin($1)/tan($1)"
}
awk.sin() {
	awk.float "sin($*)"
}
awk.pi() {
	awk.float "atan2(0, -0)"
}
awk.print() {
	awk "BEGIN {print $*}"
}
awk.log() {
	awk.float "log(${2}) / log($1)"
}
awk.rad() {
	awk.float "$1 * $(awk.pi) / 180 "
}
awk.float() {
	awk "BEGIN {printf (\"%4.${AWKSCALE-"5"}f\n\", $*)}"
}
PrintEvalArray() {
	Array.Eval "$1"
}
ArrayAppend() {
	Array.Append "$1"
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
StrToCharList() {
	Array.FromStr "$1"
}
GetArrayIndex() {
	Array.IndexOf "$1"
}
ArrayIndex() {
	Array.Length "$1"
}
AddNewToArray() {
	Array.Push "$@"
}
FileType() {
	file --mime-type -b "$1"
}
RemoveFileExt() {
	local Ext
	ForEach eval 'Ext=$(GetFileExt <<< {}); sed "s|.$Ext$||g" <<< {}; unset Ext'
}
GetFileExt() {
	GetBaseName | rev | cut -d "." -f 1 | rev
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
ToLower() {
	local _Str="${1,,}"
	[[ -z ${_Str-""} ]] || echo "${_Str}"
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
PrintEval() {
	eval echo "\${$1}"
}
RemoveBlank() {
	sed "s|^ *||g; s| *$||g; s|^	*||g; s|	*$||g; /^$/d"
}
GetMaxWidth() {
	awk '{ if ( length > x && length > 0 ) { x = length } }END{ print x }'
}
RandomString() {
	base64 <"/dev/random" | fold -w "$1" | head -n 1
	return 0
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
GetLastSplitString() {
	rev <<<"$2" | cut -d "$1" -f 1 | rev
}
CutLastString() {
	echo "${1%%"${2}"}"
	return 0
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
ToArgs() {
	readarray -t args
	"$@" "${args[@]}"
}
cache.get_file_last_update() {
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
cache.exist() {
	local _File
	_File="$(cache.create_dir)/$1"
	[[ -e $_File ]] || return 1
	(("$(cache.get_time_diff_from_last_update "$_File")" > "${KEEPCACHESEC-"86400"}")) && return 2
	return 0
}
cache.get_time_diff_from_last_update() {
	local _Now _Last
	_Now="$(date "+%s")"
	_Last="$(cache.get_file_last_update "$1")"
	echo "$((_Now - _Last))"
	return 0
}
cache.get_id() {
	if [[ -z ${FSBLIB_CACHEID-""} ]]; then
		cache.create_dir >/dev/null
	fi
	echo "$FSBLIB_CACHEID"
}
cache.get_dir() {
	echo "${TMPDIR-"/tmp"}/$(cache.get_id)"
}
cache.get() {
	cat "$(cache.get_dir)/$1" 2>/dev/null || return 1
}
cache.create() {
	cache.create_dir >/dev/null
	cat >"$(cache.get_dir)/${1}"
	cat "$(cache.get_dir)/$1"
}
cache.create_dir() {
	FSBLIB_CACHEID="${FSBLIB_CACHEID-"$(RandomString "10")"}"
	export FSBLIB_CACHEID="$FSBLIB_CACHEID"
	local TMPDIR="${TMPDIR-"/tmp"}"
	local _Dir="$TMPDIR/${FSBLIB_CACHEID}"
	mkdir -p "$_Dir"
	echo "$_Dir"
	return 0
}
fsblib.require_lib() {
	local lib missing=() return=0
	for lib in "$@"; do
		if ! [[ ${FSBLIB_LIBLIST[*]} == *" $lib "* ]]; then
			missing+=("$lib")
			return=1
		fi
	done
	return "$return"
}
fsblib_env_check() {
	fsblib.env_check
}
fsblib.env_check() {
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
csv.to_bash_array() {
	local _RawCsvLine=() _Line _ClmCnt=0
	local ArrayPrefix="${ArrayPrefix-"{}"}"
	readarray -t _RawCsvLine < <(
		while read -r _Line; do
			(($(tr "${CSVDELIM-","}" "\n" <<<"$_Line" | wc -l) >= ${#})) && echo "$_Line"
		done < <(grep -v "^#")
	)
	_ClmCnt=$(PrintArray "${_RawCsvLine[@]}" | csv.get_clm_cnt)
	while read -r _Cnt; do
		readarray -t "$(sed "s|{}|$(eval "echo \"\${${_Cnt}}\"")|g" <<<"$ArrayPrefix")" < <(
			PrintArray "${_RawCsvLine[@]}" | cut -d "${CSVDELIM-","}" -f "$_Cnt"
		)
	done < <(seq 1 "$#")
}
csv.get_clm() {
	grep -v "^#" | sed "/^$/d" | cut -d "${CSVDELIM-","}" -f "$1"
}
csv.get_clm_cnt() {
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
em.get_world_pkg_list() {
	sed -E 's|:.+$||g' /var/lib/portage/world | xargs -I{} bash -c 'ls -d /var/db/pkg/{}-* | sed "s|/var/db/pkg/||g" | grep -E "{}-[0-9]"'
}
em.get_repo_pkg_list() {
	local _RepoPath
	_RepoPath="$(em.get_repo_location "$1")"
	find "$_RepoPath" -mindepth 3 -maxdepth 3 -type f -name '*.ebuild' | sed -e "s|${_RepoPath%/}/||g" -e 's|.ebuild$||g' | awk -F "/" '{print $1"/"$3}'
}
em.get_all_pkg_list() {
	em.get_repo_conf | sed -e 's/^ *//' -e 's/ *$//' | grep "^ *location *=" | sed -e 's/^location *= *//' | xargs -L1 realpath | xargs -I{} bash -c "find '{}' -mindepth 3 -maxdepth 3 -type f -name '*.ebuild' | sed -e 's|{}/||g' -e 's|.ebuild$||g'" | awk -F "/" '{print $1"/"$3}'
}
em.get_installed_pkg_list() {
	find /var/db/pkg/ -mindepth 2 -maxdepth 2 -type d | sed 's|/var/db/pkg/||g'
}
em.get_repo_location() {
	em.get_repo_conf | Ini.GetParam "$1" location
}
em.get_repo_conf() {
	cat /etc/portage/repos.conf /etc/portage/repos.conf/* 2>/dev/null
}
em.get_default_repo_name() {
	em.get_repo_conf | Ini.GetParam DEFAULT main-repo
}
em.no_version() {
	sed -E 's|\-[0-9]+.+||g'
}
esc.clear_screen() {
	printf "\033[2J" >/dev/tty
}
esc.return() {
	printf "\r" >/dev/tty
}
esc.clear_left() {
	printf "\033[1K" >/dev/tty
}
esc.clear_line() {
	printf "\033[2K" >/dev/tty
}
esc.clear_right() {
	printf "\033[0K" >/dev/tty
}
esc.get_y() {
	local _POS
	printf "\033[6n" >>/dev/tty
	read -r -s -d "R" _POS
	echo $(("$(printf "%s\n" "${_POS:2}" | cut -d";" -f1)" - 1))
}
esc.get_x() {
	local _POS
	printf "\033[6n" >>/dev/tty
	read -r -s -d "R" _POS
	echo $(("$(printf "%s\n" "${_POS:2}" | cut -d";" -f2)" - 1))
}
esc.get_term_x() {
	[[ -n ${COLUMNS-""} ]] && echo "$COLUMNS" && return 0
	tput cols
}
esc.move_cursor() {
	printf "\033[%d;%dH" "$1" "$2" >/dev/tty
}
esc.move_cursor_up() {
	printf "\033[%dA" "$1" >/dev/tty
}
esc.move_cursor_left() {
	printf "\033[%dD" "$1" >/dev/tty
}
esc.move_cursor_down() {
	printf "\033[%dB" "$1" >/dev/tty
}
esc.move_cursor_right() {
	printf "\033[%dC" "$1" >/dev/tty
}
esc.get_term_y() {
	[[ -n ${LINES-""} ]] && echo "$LINES" && return 0
	tput lines
}
esc.clear_line_and_return() {
	esc.clear_line
	esc.return
}
esc.clear_upper_lines() {
	for i in $(seq 1 "$1"); do
		esc.move_cursor_up 1
		esc.clear_line
	done
}
esc.italic() {
	printf "\033[3m" >/dev/tty
}
esc.green_background() {
	printf "\033[42m" >/dev/tty
}
esc.black_background() {
	printf "\033[40m" >/dev/tty
}
esc.blue_text() {
	printf "\033[34m" >/dev/tty
}
esc.underline() {
	printf "\033[4m" >/dev/tty
}
esc.white_text() {
	printf "\033[37m" >/dev/tty
}
esc.magenta_background() {
	printf "\033[45m" >/dev/tty
}
esc.cyan_background() {
	printf "\033[46m" >/dev/tty
}
esc.magenta_text() {
	printf "\033[35m" >/dev/tty
}
esc.yellow_text() {
	printf "\033[33m" >/dev/tty
}
esc.green_text() {
	printf "\033[32m" >/dev/tty
}
esc.white_background() {
	printf "\033[47m" >/dev/tty
}
esc.low_intensity() {
	printf "\033[2m" >/dev/tty
}
esc.yellow_background() {
	printf "\033[43m" >/dev/tty
}
esc.red_background() {
	printf "\033[41m" >/dev/tty
}
esc.reset_style() {
	printf "\033[0m" >/dev/tty
}
esc.rapid_blink() {
	printf "\033[6m" >/dev/tty
}
esc.reverse() {
	printf "\033[7m" >/dev/tty
}
esc.conceal() {
	printf "\033[8m" >/dev/tty
}
esc.blue_background() {
	printf "\033[44m" >/dev/tty
}
esc.cyan_text() {
	printf "\033[36m" >/dev/tty
}
esc.bold() {
	printf "\033[1m" >/dev/tty
}
esc.red_text() {
	printf "\033[31m" >/dev/tty
}
esc.crossed_out() {
	printf "\033[9m" >/dev/tty
}
esc.blink() {
	printf "\033[5m" >/dev/tty
}
esc.black_text() {
	printf "\033[30m" >/dev/tty
}
arch.get_mkinitcpio_preset_list() {
	find "/etc/mkinitcpio.d/" -name "*.preset" -type f | GetBaseName | RemoveFileExt
}
arch.get_kernel_src_list() {
	find "/usr/src" -mindepth 1 -maxdepth 1 -type l -name "linux*"
}
arch.get_kernel_file_list() {
	find "/boot" -maxdepth 1 -mindepth 1 -name "vmlinuz-*"
}
array.append() {
	local _ArrName="$1"
	shift 1 || return 1
	readarray -t -O "$(ArrayIndex "$_ArrName")" "$_ArrName" < <(cat)
}
array.shift() {
	readarray -t "$1" < <(PrintEvalArray "$1" | sed "1,${2-"1"}d")
}
array.push() {
	eval "PrintArray \"\${$1[@]}\"" | grep -qx "$2" && return 0
	eval "$1+=(\"$2\")"
}
array.from_str() {
	declare -a -x "$1"
	readarray -t "$1" < <(BreakChar)
}
array.pop() {
	readarray -t "$1" < <(PrintEvalArray "$1" | sed -e '$d')
}
array.rev() {
	readarray -t "$1" < <(PrintEvalArray "$1" | tac)
}
array.remove() {
	readarray -t "$1" < <(PrintEvalArray "$1" | RemoveMatchLine "$2")
}
array.print() {
	(($# >= 1)) || return 0
	printf "%s\n" "${@}"
}
array.last() {
	PrintEval "$1[$(array.last_index "$1")]"
}
array.eval() {
	eval "PrintArray \"\${$1[@]}\""
}
array.length() {
	PrintEval "#${1}[@]"
}
array.index_of() {
	local n=()
	readarray -t n < <(grep -x -n "$1" | cut -d ":" -f 1 | ForEach eval echo '$(( {} - 1 ))')
	(("${#n[@]}" >= 1)) || return 1
	PrintArray "${n[@]}"
	return 0
}
array.last_index() {
	CalcInt "$(array.length "$1")" - 1
}
array.includes() {
	PrintEvalArray "$1" | grep -qx "$2"
}
array.for_each() {
	PrintEvalArray "$1" | ForEach "${@:2}"
}
array.include() {
	array.includes "$@"
}
awk.cos() {
	awk.float "cos($*)"
}
awk.tan() {
	awk.float "sin($1)/tan($1)"
}
awk.sin() {
	awk.float "sin($*)"
}
awk.pi() {
	awk.float "atan2(0, -0)"
}
awk.print() {
	awk "BEGIN {print $*}"
}
awk.log() {
	awk.float "log(${2}) / log($1)"
}
awk.rad() {
	awk.float "$1 * $(awk.pi) / 180 "
}
awk.float() {
	awk "BEGIN {printf (\"%4.${AWKSCALE-"5"}f\n\", $*)}"
}
PrintEvalArray() {
	Array.Eval "$1"
}
ArrayAppend() {
	Array.Append "$1"
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
StrToCharList() {
	Array.FromStr "$1"
}
GetArrayIndex() {
	Array.IndexOf "$1"
}
ArrayIndex() {
	Array.Length "$1"
}
AddNewToArray() {
	Array.Push "$@"
}
FileType() {
	file --mime-type -b "$1"
}
RemoveFileExt() {
	local Ext
	ForEach eval 'Ext=$(GetFileExt <<< {}); sed "s|.$Ext$||g" <<< {}; unset Ext'
}
GetFileExt() {
	GetBaseName | rev | cut -d "." -f 1 | rev
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
ToLower() {
	local _Str="${1,,}"
	[[ -z ${_Str-""} ]] || echo "${_Str}"
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
PrintEval() {
	eval echo "\${$1}"
}
RemoveBlank() {
	sed "s|^ *||g; s| *$||g; s|^	*||g; s|	*$||g; /^$/d"
}
GetMaxWidth() {
	awk '{ if ( length > x && length > 0 ) { x = length } }END{ print x }'
}
RandomString() {
	base64 <"/dev/random" | fold -w "$1" | head -n 1
	return 0
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
GetLastSplitString() {
	rev <<<"$2" | cut -d "$1" -f 1 | rev
}
CutLastString() {
	echo "${1%%"${2}"}"
	return 0
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
ToArgs() {
	readarray -t args
	"$@" "${args[@]}"
}
cache.get_file_last_update() {
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
cache.exist() {
	local _File
	_File="$(cache.create_dir)/$1"
	[[ -e $_File ]] || return 1
	(("$(cache.get_time_diff_from_last_update "$_File")" > "${KEEPCACHESEC-"86400"}")) && return 2
	return 0
}
cache.get_time_diff_from_last_update() {
	local _Now _Last
	_Now="$(date "+%s")"
	_Last="$(cache.get_file_last_update "$1")"
	echo "$((_Now - _Last))"
	return 0
}
cache.get_id() {
	if [[ -z ${FSBLIB_CACHEID-""} ]]; then
		cache.create_dir >/dev/null
	fi
	echo "$FSBLIB_CACHEID"
}
cache.get_dir() {
	echo "${TMPDIR-"/tmp"}/$(cache.get_id)"
}
cache.get() {
	cat "$(cache.get_dir)/$1" 2>/dev/null || return 1
}
cache.create() {
	cache.create_dir >/dev/null
	cat >"$(cache.get_dir)/${1}"
	cat "$(cache.get_dir)/$1"
}
cache.create_dir() {
	FSBLIB_CACHEID="${FSBLIB_CACHEID-"$(RandomString "10")"}"
	export FSBLIB_CACHEID="$FSBLIB_CACHEID"
	local TMPDIR="${TMPDIR-"/tmp"}"
	local _Dir="$TMPDIR/${FSBLIB_CACHEID}"
	mkdir -p "$_Dir"
	echo "$_Dir"
	return 0
}
fsblib.require_lib() {
	local lib missing=() return=0
	for lib in "$@"; do
		if ! [[ ${FSBLIB_LIBLIST[*]} == *" $lib "* ]]; then
			missing+=("$lib")
			return=1
		fi
	done
	return "$return"
}
fsblib_env_check() {
	fsblib.env_check
}
fsblib.env_check() {
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
csv.to_bash_array() {
	local _RawCsvLine=() _Line _ClmCnt=0
	local ArrayPrefix="${ArrayPrefix-"{}"}"
	readarray -t _RawCsvLine < <(
		while read -r _Line; do
			(($(tr "${CSVDELIM-","}" "\n" <<<"$_Line" | wc -l) >= ${#})) && echo "$_Line"
		done < <(grep -v "^#")
	)
	_ClmCnt=$(PrintArray "${_RawCsvLine[@]}" | csv.get_clm_cnt)
	while read -r _Cnt; do
		readarray -t "$(sed "s|{}|$(eval "echo \"\${${_Cnt}}\"")|g" <<<"$ArrayPrefix")" < <(
			PrintArray "${_RawCsvLine[@]}" | cut -d "${CSVDELIM-","}" -f "$_Cnt"
		)
	done < <(seq 1 "$#")
}
csv.get_clm() {
	grep -v "^#" | sed "/^$/d" | cut -d "${CSVDELIM-","}" -f "$1"
}
csv.get_clm_cnt() {
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
em.get_world_pkg_list() {
	sed -E 's|:.+$||g' /var/lib/portage/world | xargs -I{} bash -c 'ls -d /var/db/pkg/{}-* | sed "s|/var/db/pkg/||g" | grep -E "{}-[0-9]"'
}
em.get_repo_pkg_list() {
	local _RepoPath
	_RepoPath="$(em.get_repo_location "$1")"
	find "$_RepoPath" -mindepth 3 -maxdepth 3 -type f -name '*.ebuild' | sed -e "s|${_RepoPath%/}/||g" -e 's|.ebuild$||g' | awk -F "/" '{print $1"/"$3}'
}
em.get_all_pkg_list() {
	em.get_repo_conf | sed -e 's/^ *//' -e 's/ *$//' | grep "^ *location *=" | sed -e 's/^location *= *//' | xargs -L1 realpath | xargs -I{} bash -c "find '{}' -mindepth 3 -maxdepth 3 -type f -name '*.ebuild' | sed -e 's|{}/||g' -e 's|.ebuild$||g'" | awk -F "/" '{print $1"/"$3}'
}
em.get_installed_pkg_list() {
	find /var/db/pkg/ -mindepth 2 -maxdepth 2 -type d | sed 's|/var/db/pkg/||g'
}
em.get_repo_location() {
	em.get_repo_conf | Ini.GetParam "$1" location
}
em.get_repo_conf() {
	cat /etc/portage/repos.conf /etc/portage/repos.conf/* 2>/dev/null
}
em.get_default_repo_name() {
	em.get_repo_conf | Ini.GetParam DEFAULT main-repo
}
em.no_version() {
	sed -E 's|\-[0-9]+.+||g'
}
esc.clear_screen() {
	printf "\033[2J" >/dev/tty
}
esc.return() {
	printf "\r" >/dev/tty
}
esc.clear_left() {
	printf "\033[1K" >/dev/tty
}
esc.clear_line() {
	printf "\033[2K" >/dev/tty
}
esc.clear_right() {
	printf "\033[0K" >/dev/tty
}
esc.get_y() {
	local _POS
	printf "\033[6n" >>/dev/tty
	read -r -s -d "R" _POS
	echo $(("$(printf "%s\n" "${_POS:2}" | cut -d";" -f1)" - 1))
}
esc.get_x() {
	local _POS
	printf "\033[6n" >>/dev/tty
	read -r -s -d "R" _POS
	echo $(("$(printf "%s\n" "${_POS:2}" | cut -d";" -f2)" - 1))
}
esc.get_term_x() {
	[[ -n ${COLUMNS-""} ]] && echo "$COLUMNS" && return 0
	tput cols
}
esc.move_cursor() {
	printf "\033[%d;%dH" "$1" "$2" >/dev/tty
}
esc.move_cursor_up() {
	printf "\033[%dA" "$1" >/dev/tty
}
esc.move_cursor_left() {
	printf "\033[%dD" "$1" >/dev/tty
}
esc.move_cursor_down() {
	printf "\033[%dB" "$1" >/dev/tty
}
esc.move_cursor_right() {
	printf "\033[%dC" "$1" >/dev/tty
}
esc.get_term_y() {
	[[ -n ${LINES-""} ]] && echo "$LINES" && return 0
	tput lines
}
esc.clear_line_and_return() {
	esc.clear_line
	esc.return
}
esc.clear_upper_lines() {
	for i in $(seq 1 "$1"); do
		esc.move_cursor_up 1
		esc.clear_line
	done
}
esc.italic() {
	printf "\033[3m" >/dev/tty
}
esc.green_background() {
	printf "\033[42m" >/dev/tty
}
esc.black_background() {
	printf "\033[40m" >/dev/tty
}
esc.blue_text() {
	printf "\033[34m" >/dev/tty
}
esc.underline() {
	printf "\033[4m" >/dev/tty
}
esc.white_text() {
	printf "\033[37m" >/dev/tty
}
esc.magenta_background() {
	printf "\033[45m" >/dev/tty
}
esc.cyan_background() {
	printf "\033[46m" >/dev/tty
}
esc.magenta_text() {
	printf "\033[35m" >/dev/tty
}
esc.yellow_text() {
	printf "\033[33m" >/dev/tty
}
esc.green_text() {
	printf "\033[32m" >/dev/tty
}
esc.white_background() {
	printf "\033[47m" >/dev/tty
}
esc.low_intensity() {
	printf "\033[2m" >/dev/tty
}
esc.yellow_background() {
	printf "\033[43m" >/dev/tty
}
esc.red_background() {
	printf "\033[41m" >/dev/tty
}
esc.reset_style() {
	printf "\033[0m" >/dev/tty
}
esc.rapid_blink() {
	printf "\033[6m" >/dev/tty
}
esc.reverse() {
	printf "\033[7m" >/dev/tty
}
esc.conceal() {
	printf "\033[8m" >/dev/tty
}
esc.blue_background() {
	printf "\033[44m" >/dev/tty
}
esc.cyan_text() {
	printf "\033[36m" >/dev/tty
}
esc.bold() {
	printf "\033[1m" >/dev/tty
}
esc.red_text() {
	printf "\033[31m" >/dev/tty
}
esc.crossed_out() {
	printf "\033[9m" >/dev/tty
}
esc.blink() {
	printf "\033[5m" >/dev/tty
}
esc.black_text() {
	printf "\033[30m" >/dev/tty
}
ini.get_last_param() {
	ini.get_param_list "$1" | tail -n 1
}
ini.get_section_list() {
	local _RawIniLine=()
	local _Line _LineNo=1 _Exit=0
	readarray -t _RawIniLine
	while read -r _Line; do
		ini.parse_line <<<"$_Line"
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
ini.get_param_list() {
	local _RawIniLine=()
	local _Line _LineNo=1 _Exit=0 _InSection=false
	readarray -t _RawIniLine
	while read -r _Line; do
		ini.parse_line <<<"$_Line"
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
ini.get_param() {
	local _RawIniLine=()
	local _Line _LineNo=1 _Exit=0 _InSection=false
	readarray -t _RawIniLine
	while read -r _Line; do
		ini.parse_line <<<"$_Line"
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
ini.parse_line() {
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
ini.new_param() {
	local IniContents=() Line
	local Section="$1" Param="$2"
	local InSection=false LineNo=0
	local NewIniContents=()
	readarray -t IniContents
	local BeforeParam
	local SectionLastParam
	local ParamAdded=false
	if ! PrintArray "${IniContents[@]}" | ini.get_param_list "$Section" | grep -qx "$Param"; then
		SectionLastParam="$(PrintEvalArray IniContents | ini.get_last_param "$Section")"
		for Line in "${IniContents[@]}"; do
			LineNo=$((LineNo + 1))
			ini.parse_line <<<"$Line"
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
ini.new_section() {
	local IniContents=()
	local Section="$1"
	readarray -t IniContents
	if PrintArray "${IniContents[@]}" | ini.get_section_list | grep -x "$Section" >/dev/null; then
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
ini.set_value() {
	local IniContents=()
	local Section="$1" Param="$2"
	readarray -t IniContents
	readarray -t IniContents < <(PrintArray "${IniContents[@]}" | ini.new_section "$Section" | ini.new_param "$Section" "$Param")
	PrintEvalArray IniContents
}
arch.get_mkinitcpio_preset_list() {
	find "/etc/mkinitcpio.d/" -name "*.preset" -type f | GetBaseName | RemoveFileExt
}
arch.get_kernel_src_list() {
	find "/usr/src" -mindepth 1 -maxdepth 1 -type l -name "linux*"
}
arch.get_kernel_file_list() {
	find "/boot" -maxdepth 1 -mindepth 1 -name "vmlinuz-*"
}
array.append() {
	local _ArrName="$1"
	shift 1 || return 1
	readarray -t -O "$(ArrayIndex "$_ArrName")" "$_ArrName" < <(cat)
}
array.shift() {
	readarray -t "$1" < <(PrintEvalArray "$1" | sed "1,${2-"1"}d")
}
array.push() {
	eval "PrintArray \"\${$1[@]}\"" | grep -qx "$2" && return 0
	eval "$1+=(\"$2\")"
}
array.from_str() {
	declare -a -x "$1"
	readarray -t "$1" < <(BreakChar)
}
array.pop() {
	readarray -t "$1" < <(PrintEvalArray "$1" | sed -e '$d')
}
array.rev() {
	readarray -t "$1" < <(PrintEvalArray "$1" | tac)
}
array.remove() {
	readarray -t "$1" < <(PrintEvalArray "$1" | RemoveMatchLine "$2")
}
array.print() {
	(($# >= 1)) || return 0
	printf "%s\n" "${@}"
}
array.last() {
	PrintEval "$1[$(array.last_index "$1")]"
}
array.eval() {
	eval "PrintArray \"\${$1[@]}\""
}
array.length() {
	PrintEval "#${1}[@]"
}
array.index_of() {
	local n=()
	readarray -t n < <(grep -x -n "$1" | cut -d ":" -f 1 | ForEach eval echo '$(( {} - 1 ))')
	(("${#n[@]}" >= 1)) || return 1
	PrintArray "${n[@]}"
	return 0
}
array.last_index() {
	CalcInt "$(array.length "$1")" - 1
}
array.includes() {
	PrintEvalArray "$1" | grep -qx "$2"
}
array.for_each() {
	PrintEvalArray "$1" | ForEach "${@:2}"
}
array.include() {
	array.includes "$@"
}
awk.cos() {
	awk.float "cos($*)"
}
awk.tan() {
	awk.float "sin($1)/tan($1)"
}
awk.sin() {
	awk.float "sin($*)"
}
awk.pi() {
	awk.float "atan2(0, -0)"
}
awk.print() {
	awk "BEGIN {print $*}"
}
awk.log() {
	awk.float "log(${2}) / log($1)"
}
awk.rad() {
	awk.float "$1 * $(awk.pi) / 180 "
}
awk.float() {
	awk "BEGIN {printf (\"%4.${AWKSCALE-"5"}f\n\", $*)}"
}
PrintEvalArray() {
	Array.Eval "$1"
}
ArrayAppend() {
	Array.Append "$1"
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
StrToCharList() {
	Array.FromStr "$1"
}
GetArrayIndex() {
	Array.IndexOf "$1"
}
ArrayIndex() {
	Array.Length "$1"
}
AddNewToArray() {
	Array.Push "$@"
}
FileType() {
	file --mime-type -b "$1"
}
RemoveFileExt() {
	local Ext
	ForEach eval 'Ext=$(GetFileExt <<< {}); sed "s|.$Ext$||g" <<< {}; unset Ext'
}
GetFileExt() {
	GetBaseName | rev | cut -d "." -f 1 | rev
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
ToLower() {
	local _Str="${1,,}"
	[[ -z ${_Str-""} ]] || echo "${_Str}"
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
PrintEval() {
	eval echo "\${$1}"
}
RemoveBlank() {
	sed "s|^ *||g; s| *$||g; s|^	*||g; s|	*$||g; /^$/d"
}
GetMaxWidth() {
	awk '{ if ( length > x && length > 0 ) { x = length } }END{ print x }'
}
RandomString() {
	base64 <"/dev/random" | fold -w "$1" | head -n 1
	return 0
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
GetLastSplitString() {
	rev <<<"$2" | cut -d "$1" -f 1 | rev
}
CutLastString() {
	echo "${1%%"${2}"}"
	return 0
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
ToArgs() {
	readarray -t args
	"$@" "${args[@]}"
}
cache.get_file_last_update() {
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
cache.exist() {
	local _File
	_File="$(cache.create_dir)/$1"
	[[ -e $_File ]] || return 1
	(("$(cache.get_time_diff_from_last_update "$_File")" > "${KEEPCACHESEC-"86400"}")) && return 2
	return 0
}
cache.get_time_diff_from_last_update() {
	local _Now _Last
	_Now="$(date "+%s")"
	_Last="$(cache.get_file_last_update "$1")"
	echo "$((_Now - _Last))"
	return 0
}
cache.get_id() {
	if [[ -z ${FSBLIB_CACHEID-""} ]]; then
		cache.create_dir >/dev/null
	fi
	echo "$FSBLIB_CACHEID"
}
cache.get_dir() {
	echo "${TMPDIR-"/tmp"}/$(cache.get_id)"
}
cache.get() {
	cat "$(cache.get_dir)/$1" 2>/dev/null || return 1
}
cache.create() {
	cache.create_dir >/dev/null
	cat >"$(cache.get_dir)/${1}"
	cat "$(cache.get_dir)/$1"
}
cache.create_dir() {
	FSBLIB_CACHEID="${FSBLIB_CACHEID-"$(RandomString "10")"}"
	export FSBLIB_CACHEID="$FSBLIB_CACHEID"
	local TMPDIR="${TMPDIR-"/tmp"}"
	local _Dir="$TMPDIR/${FSBLIB_CACHEID}"
	mkdir -p "$_Dir"
	echo "$_Dir"
	return 0
}
fsblib.require_lib() {
	local lib missing=() return=0
	for lib in "$@"; do
		if ! [[ ${FSBLIB_LIBLIST[*]} == *" $lib "* ]]; then
			missing+=("$lib")
			return=1
		fi
	done
	return "$return"
}
fsblib_env_check() {
	fsblib.env_check
}
fsblib.env_check() {
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
csv.to_bash_array() {
	local _RawCsvLine=() _Line _ClmCnt=0
	local ArrayPrefix="${ArrayPrefix-"{}"}"
	readarray -t _RawCsvLine < <(
		while read -r _Line; do
			(($(tr "${CSVDELIM-","}" "\n" <<<"$_Line" | wc -l) >= ${#})) && echo "$_Line"
		done < <(grep -v "^#")
	)
	_ClmCnt=$(PrintArray "${_RawCsvLine[@]}" | csv.get_clm_cnt)
	while read -r _Cnt; do
		readarray -t "$(sed "s|{}|$(eval "echo \"\${${_Cnt}}\"")|g" <<<"$ArrayPrefix")" < <(
			PrintArray "${_RawCsvLine[@]}" | cut -d "${CSVDELIM-","}" -f "$_Cnt"
		)
	done < <(seq 1 "$#")
}
csv.get_clm() {
	grep -v "^#" | sed "/^$/d" | cut -d "${CSVDELIM-","}" -f "$1"
}
csv.get_clm_cnt() {
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
em.get_world_pkg_list() {
	sed -E 's|:.+$||g' /var/lib/portage/world | xargs -I{} bash -c 'ls -d /var/db/pkg/{}-* | sed "s|/var/db/pkg/||g" | grep -E "{}-[0-9]"'
}
em.get_repo_pkg_list() {
	local _RepoPath
	_RepoPath="$(em.get_repo_location "$1")"
	find "$_RepoPath" -mindepth 3 -maxdepth 3 -type f -name '*.ebuild' | sed -e "s|${_RepoPath%/}/||g" -e 's|.ebuild$||g' | awk -F "/" '{print $1"/"$3}'
}
em.get_all_pkg_list() {
	em.get_repo_conf | sed -e 's/^ *//' -e 's/ *$//' | grep "^ *location *=" | sed -e 's/^location *= *//' | xargs -L1 realpath | xargs -I{} bash -c "find '{}' -mindepth 3 -maxdepth 3 -type f -name '*.ebuild' | sed -e 's|{}/||g' -e 's|.ebuild$||g'" | awk -F "/" '{print $1"/"$3}'
}
em.get_installed_pkg_list() {
	find /var/db/pkg/ -mindepth 2 -maxdepth 2 -type d | sed 's|/var/db/pkg/||g'
}
em.get_repo_location() {
	em.get_repo_conf | Ini.GetParam "$1" location
}
em.get_repo_conf() {
	cat /etc/portage/repos.conf /etc/portage/repos.conf/* 2>/dev/null
}
em.get_default_repo_name() {
	em.get_repo_conf | Ini.GetParam DEFAULT main-repo
}
em.no_version() {
	sed -E 's|\-[0-9]+.+||g'
}
esc.clear_screen() {
	printf "\033[2J" >/dev/tty
}
esc.return() {
	printf "\r" >/dev/tty
}
esc.clear_left() {
	printf "\033[1K" >/dev/tty
}
esc.clear_line() {
	printf "\033[2K" >/dev/tty
}
esc.clear_right() {
	printf "\033[0K" >/dev/tty
}
esc.get_y() {
	local _POS
	printf "\033[6n" >>/dev/tty
	read -r -s -d "R" _POS
	echo $(("$(printf "%s\n" "${_POS:2}" | cut -d";" -f1)" - 1))
}
esc.get_x() {
	local _POS
	printf "\033[6n" >>/dev/tty
	read -r -s -d "R" _POS
	echo $(("$(printf "%s\n" "${_POS:2}" | cut -d";" -f2)" - 1))
}
esc.get_term_x() {
	[[ -n ${COLUMNS-""} ]] && echo "$COLUMNS" && return 0
	tput cols
}
esc.move_cursor() {
	printf "\033[%d;%dH" "$1" "$2" >/dev/tty
}
esc.move_cursor_up() {
	printf "\033[%dA" "$1" >/dev/tty
}
esc.move_cursor_left() {
	printf "\033[%dD" "$1" >/dev/tty
}
esc.move_cursor_down() {
	printf "\033[%dB" "$1" >/dev/tty
}
esc.move_cursor_right() {
	printf "\033[%dC" "$1" >/dev/tty
}
esc.get_term_y() {
	[[ -n ${LINES-""} ]] && echo "$LINES" && return 0
	tput lines
}
esc.clear_line_and_return() {
	esc.clear_line
	esc.return
}
esc.clear_upper_lines() {
	for i in $(seq 1 "$1"); do
		esc.move_cursor_up 1
		esc.clear_line
	done
}
esc.italic() {
	printf "\033[3m" >/dev/tty
}
esc.green_background() {
	printf "\033[42m" >/dev/tty
}
esc.black_background() {
	printf "\033[40m" >/dev/tty
}
esc.blue_text() {
	printf "\033[34m" >/dev/tty
}
esc.underline() {
	printf "\033[4m" >/dev/tty
}
esc.white_text() {
	printf "\033[37m" >/dev/tty
}
esc.magenta_background() {
	printf "\033[45m" >/dev/tty
}
esc.cyan_background() {
	printf "\033[46m" >/dev/tty
}
esc.magenta_text() {
	printf "\033[35m" >/dev/tty
}
esc.yellow_text() {
	printf "\033[33m" >/dev/tty
}
esc.green_text() {
	printf "\033[32m" >/dev/tty
}
esc.white_background() {
	printf "\033[47m" >/dev/tty
}
esc.low_intensity() {
	printf "\033[2m" >/dev/tty
}
esc.yellow_background() {
	printf "\033[43m" >/dev/tty
}
esc.red_background() {
	printf "\033[41m" >/dev/tty
}
esc.reset_style() {
	printf "\033[0m" >/dev/tty
}
esc.rapid_blink() {
	printf "\033[6m" >/dev/tty
}
esc.reverse() {
	printf "\033[7m" >/dev/tty
}
esc.conceal() {
	printf "\033[8m" >/dev/tty
}
esc.blue_background() {
	printf "\033[44m" >/dev/tty
}
esc.cyan_text() {
	printf "\033[36m" >/dev/tty
}
esc.bold() {
	printf "\033[1m" >/dev/tty
}
esc.red_text() {
	printf "\033[31m" >/dev/tty
}
esc.crossed_out() {
	printf "\033[9m" >/dev/tty
}
esc.blink() {
	printf "\033[5m" >/dev/tty
}
esc.black_text() {
	printf "\033[30m" >/dev/tty
}
ini.get_last_param() {
	ini.get_param_list "$1" | tail -n 1
}
ini.get_section_list() {
	local _RawIniLine=()
	local _Line _LineNo=1 _Exit=0
	readarray -t _RawIniLine
	while read -r _Line; do
		ini.parse_line <<<"$_Line"
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
ini.get_param_list() {
	local _RawIniLine=()
	local _Line _LineNo=1 _Exit=0 _InSection=false
	readarray -t _RawIniLine
	while read -r _Line; do
		ini.parse_line <<<"$_Line"
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
ini.get_param() {
	local _RawIniLine=()
	local _Line _LineNo=1 _Exit=0 _InSection=false
	readarray -t _RawIniLine
	while read -r _Line; do
		ini.parse_line <<<"$_Line"
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
ini.parse_line() {
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
ini.new_param() {
	local IniContents=() Line
	local Section="$1" Param="$2"
	local InSection=false LineNo=0
	local NewIniContents=()
	readarray -t IniContents
	local BeforeParam
	local SectionLastParam
	local ParamAdded=false
	if ! PrintArray "${IniContents[@]}" | ini.get_param_list "$Section" | grep -qx "$Param"; then
		SectionLastParam="$(PrintEvalArray IniContents | ini.get_last_param "$Section")"
		for Line in "${IniContents[@]}"; do
			LineNo=$((LineNo + 1))
			ini.parse_line <<<"$Line"
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
ini.new_section() {
	local IniContents=()
	local Section="$1"
	readarray -t IniContents
	if PrintArray "${IniContents[@]}" | ini.get_section_list | grep -x "$Section" >/dev/null; then
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
ini.set_value() {
	local IniContents=()
	local Section="$1" Param="$2"
	readarray -t IniContents
	readarray -t IniContents < <(PrintArray "${IniContents[@]}" | ini.new_section "$Section" | ini.new_param "$Section" "$Param")
	PrintEvalArray IniContents
}
libretranslate.check() {
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
libretranslate.translate() {
	libretranslate.check || return 2
	__libre_translate_return="$(curl -s "$LIBRETRANSLATE_URL/translate" -X POST -d "q=${1:-""}&source=${2:-""}&target=${3:-""}&api_key=${LIBRETRANSLATE_APIKEY:-""}")"
	if [ "$(echo "${__libre_translate_return}" | jq -r '.error')" = "null" ]; then
		echo "${__libre_translate_return}" | jq -r '.translatedText'
		return 0
	else
		echo "${__libre_translate_return}" | jq -r '.error'
		return 1
	fi
}
libretranslate.detect() {
	libretranslate.check || return 2
	__libre_translate_return="$(curl -s "${LIBRETRANSLATE_URL}/detect" -X POST -d "q=${1:-""}&api_key=${LIBRETRANSLATE_APIKEY:-""}")"
	if [ "$(echo "${__libre_translate_return}" | jq -r '.[].error')" = "null" ]; then
		echo "${__libre_translate_return}" | jq -r '.[].language'
		return 0
	else
		echo "${__libre_translate_return}" | jq -r '.error'
		return 1
	fi
}
libretranslate.translate_auto() {
	libretranslate.check || return 2
	libretranslate.translate "${1:-""}" "$(libretranslate.detect "${1:-""}")" "${2:-""}"
}
libretranslate.languages() {
	libretranslate.check || return 2
	curl -s "${LIBRETRANSLATE_URL}/languages" | jq -r '.[].code'
}
arch.get_mkinitcpio_preset_list() {
	find "/etc/mkinitcpio.d/" -name "*.preset" -type f | GetBaseName | RemoveFileExt
}
arch.get_kernel_src_list() {
	find "/usr/src" -mindepth 1 -maxdepth 1 -type l -name "linux*"
}
arch.get_kernel_file_list() {
	find "/boot" -maxdepth 1 -mindepth 1 -name "vmlinuz-*"
}
array.append() {
	local _ArrName="$1"
	shift 1 || return 1
	readarray -t -O "$(ArrayIndex "$_ArrName")" "$_ArrName" < <(cat)
}
array.shift() {
	readarray -t "$1" < <(PrintEvalArray "$1" | sed "1,${2-"1"}d")
}
array.push() {
	eval "PrintArray \"\${$1[@]}\"" | grep -qx "$2" && return 0
	eval "$1+=(\"$2\")"
}
array.from_str() {
	declare -a -x "$1"
	readarray -t "$1" < <(BreakChar)
}
array.pop() {
	readarray -t "$1" < <(PrintEvalArray "$1" | sed -e '$d')
}
array.rev() {
	readarray -t "$1" < <(PrintEvalArray "$1" | tac)
}
array.remove() {
	readarray -t "$1" < <(PrintEvalArray "$1" | RemoveMatchLine "$2")
}
array.print() {
	(($# >= 1)) || return 0
	printf "%s\n" "${@}"
}
array.last() {
	PrintEval "$1[$(array.last_index "$1")]"
}
array.eval() {
	eval "PrintArray \"\${$1[@]}\""
}
array.length() {
	PrintEval "#${1}[@]"
}
array.index_of() {
	local n=()
	readarray -t n < <(grep -x -n "$1" | cut -d ":" -f 1 | ForEach eval echo '$(( {} - 1 ))')
	(("${#n[@]}" >= 1)) || return 1
	PrintArray "${n[@]}"
	return 0
}
array.last_index() {
	CalcInt "$(array.length "$1")" - 1
}
array.includes() {
	PrintEvalArray "$1" | grep -qx "$2"
}
array.for_each() {
	PrintEvalArray "$1" | ForEach "${@:2}"
}
array.include() {
	array.includes "$@"
}
awk.cos() {
	awk.float "cos($*)"
}
awk.tan() {
	awk.float "sin($1)/tan($1)"
}
awk.sin() {
	awk.float "sin($*)"
}
awk.pi() {
	awk.float "atan2(0, -0)"
}
awk.print() {
	awk "BEGIN {print $*}"
}
awk.log() {
	awk.float "log(${2}) / log($1)"
}
awk.rad() {
	awk.float "$1 * $(awk.pi) / 180 "
}
awk.float() {
	awk "BEGIN {printf (\"%4.${AWKSCALE-"5"}f\n\", $*)}"
}
PrintEvalArray() {
	Array.Eval "$1"
}
ArrayAppend() {
	Array.Append "$1"
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
StrToCharList() {
	Array.FromStr "$1"
}
GetArrayIndex() {
	Array.IndexOf "$1"
}
ArrayIndex() {
	Array.Length "$1"
}
AddNewToArray() {
	Array.Push "$@"
}
FileType() {
	file --mime-type -b "$1"
}
RemoveFileExt() {
	local Ext
	ForEach eval 'Ext=$(GetFileExt <<< {}); sed "s|.$Ext$||g" <<< {}; unset Ext'
}
GetFileExt() {
	GetBaseName | rev | cut -d "." -f 1 | rev
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
ToLower() {
	local _Str="${1,,}"
	[[ -z ${_Str-""} ]] || echo "${_Str}"
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
PrintEval() {
	eval echo "\${$1}"
}
RemoveBlank() {
	sed "s|^ *||g; s| *$||g; s|^	*||g; s|	*$||g; /^$/d"
}
GetMaxWidth() {
	awk '{ if ( length > x && length > 0 ) { x = length } }END{ print x }'
}
RandomString() {
	base64 <"/dev/random" | fold -w "$1" | head -n 1
	return 0
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
GetLastSplitString() {
	rev <<<"$2" | cut -d "$1" -f 1 | rev
}
CutLastString() {
	echo "${1%%"${2}"}"
	return 0
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
ToArgs() {
	readarray -t args
	"$@" "${args[@]}"
}
cache.get_file_last_update() {
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
cache.exist() {
	local _File
	_File="$(cache.create_dir)/$1"
	[[ -e $_File ]] || return 1
	(("$(cache.get_time_diff_from_last_update "$_File")" > "${KEEPCACHESEC-"86400"}")) && return 2
	return 0
}
cache.get_time_diff_from_last_update() {
	local _Now _Last
	_Now="$(date "+%s")"
	_Last="$(cache.get_file_last_update "$1")"
	echo "$((_Now - _Last))"
	return 0
}
cache.get_id() {
	if [[ -z ${FSBLIB_CACHEID-""} ]]; then
		cache.create_dir >/dev/null
	fi
	echo "$FSBLIB_CACHEID"
}
cache.get_dir() {
	echo "${TMPDIR-"/tmp"}/$(cache.get_id)"
}
cache.get() {
	cat "$(cache.get_dir)/$1" 2>/dev/null || return 1
}
cache.create() {
	cache.create_dir >/dev/null
	cat >"$(cache.get_dir)/${1}"
	cat "$(cache.get_dir)/$1"
}
cache.create_dir() {
	FSBLIB_CACHEID="${FSBLIB_CACHEID-"$(RandomString "10")"}"
	export FSBLIB_CACHEID="$FSBLIB_CACHEID"
	local TMPDIR="${TMPDIR-"/tmp"}"
	local _Dir="$TMPDIR/${FSBLIB_CACHEID}"
	mkdir -p "$_Dir"
	echo "$_Dir"
	return 0
}
fsblib.require_lib() {
	local lib missing=() return=0
	for lib in "$@"; do
		if ! [[ ${FSBLIB_LIBLIST[*]} == *" $lib "* ]]; then
			missing+=("$lib")
			return=1
		fi
	done
	return "$return"
}
fsblib_env_check() {
	fsblib.env_check
}
fsblib.env_check() {
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
csv.to_bash_array() {
	local _RawCsvLine=() _Line _ClmCnt=0
	local ArrayPrefix="${ArrayPrefix-"{}"}"
	readarray -t _RawCsvLine < <(
		while read -r _Line; do
			(($(tr "${CSVDELIM-","}" "\n" <<<"$_Line" | wc -l) >= ${#})) && echo "$_Line"
		done < <(grep -v "^#")
	)
	_ClmCnt=$(PrintArray "${_RawCsvLine[@]}" | csv.get_clm_cnt)
	while read -r _Cnt; do
		readarray -t "$(sed "s|{}|$(eval "echo \"\${${_Cnt}}\"")|g" <<<"$ArrayPrefix")" < <(
			PrintArray "${_RawCsvLine[@]}" | cut -d "${CSVDELIM-","}" -f "$_Cnt"
		)
	done < <(seq 1 "$#")
}
csv.get_clm() {
	grep -v "^#" | sed "/^$/d" | cut -d "${CSVDELIM-","}" -f "$1"
}
csv.get_clm_cnt() {
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
em.get_world_pkg_list() {
	sed -E 's|:.+$||g' /var/lib/portage/world | xargs -I{} bash -c 'ls -d /var/db/pkg/{}-* | sed "s|/var/db/pkg/||g" | grep -E "{}-[0-9]"'
}
em.get_repo_pkg_list() {
	local _RepoPath
	_RepoPath="$(em.get_repo_location "$1")"
	find "$_RepoPath" -mindepth 3 -maxdepth 3 -type f -name '*.ebuild' | sed -e "s|${_RepoPath%/}/||g" -e 's|.ebuild$||g' | awk -F "/" '{print $1"/"$3}'
}
em.get_all_pkg_list() {
	em.get_repo_conf | sed -e 's/^ *//' -e 's/ *$//' | grep "^ *location *=" | sed -e 's/^location *= *//' | xargs -L1 realpath | xargs -I{} bash -c "find '{}' -mindepth 3 -maxdepth 3 -type f -name '*.ebuild' | sed -e 's|{}/||g' -e 's|.ebuild$||g'" | awk -F "/" '{print $1"/"$3}'
}
em.get_installed_pkg_list() {
	find /var/db/pkg/ -mindepth 2 -maxdepth 2 -type d | sed 's|/var/db/pkg/||g'
}
em.get_repo_location() {
	em.get_repo_conf | Ini.GetParam "$1" location
}
em.get_repo_conf() {
	cat /etc/portage/repos.conf /etc/portage/repos.conf/* 2>/dev/null
}
em.get_default_repo_name() {
	em.get_repo_conf | Ini.GetParam DEFAULT main-repo
}
em.no_version() {
	sed -E 's|\-[0-9]+.+||g'
}
esc.clear_screen() {
	printf "\033[2J" >/dev/tty
}
esc.return() {
	printf "\r" >/dev/tty
}
esc.clear_left() {
	printf "\033[1K" >/dev/tty
}
esc.clear_line() {
	printf "\033[2K" >/dev/tty
}
esc.clear_right() {
	printf "\033[0K" >/dev/tty
}
esc.get_y() {
	local _POS
	printf "\033[6n" >>/dev/tty
	read -r -s -d "R" _POS
	echo $(("$(printf "%s\n" "${_POS:2}" | cut -d";" -f1)" - 1))
}
esc.get_x() {
	local _POS
	printf "\033[6n" >>/dev/tty
	read -r -s -d "R" _POS
	echo $(("$(printf "%s\n" "${_POS:2}" | cut -d";" -f2)" - 1))
}
esc.get_term_x() {
	[[ -n ${COLUMNS-""} ]] && echo "$COLUMNS" && return 0
	tput cols
}
esc.move_cursor() {
	printf "\033[%d;%dH" "$1" "$2" >/dev/tty
}
esc.move_cursor_up() {
	printf "\033[%dA" "$1" >/dev/tty
}
esc.move_cursor_left() {
	printf "\033[%dD" "$1" >/dev/tty
}
esc.move_cursor_down() {
	printf "\033[%dB" "$1" >/dev/tty
}
esc.move_cursor_right() {
	printf "\033[%dC" "$1" >/dev/tty
}
esc.get_term_y() {
	[[ -n ${LINES-""} ]] && echo "$LINES" && return 0
	tput lines
}
esc.clear_line_and_return() {
	esc.clear_line
	esc.return
}
esc.clear_upper_lines() {
	for i in $(seq 1 "$1"); do
		esc.move_cursor_up 1
		esc.clear_line
	done
}
esc.italic() {
	printf "\033[3m" >/dev/tty
}
esc.green_background() {
	printf "\033[42m" >/dev/tty
}
esc.black_background() {
	printf "\033[40m" >/dev/tty
}
esc.blue_text() {
	printf "\033[34m" >/dev/tty
}
esc.underline() {
	printf "\033[4m" >/dev/tty
}
esc.white_text() {
	printf "\033[37m" >/dev/tty
}
esc.magenta_background() {
	printf "\033[45m" >/dev/tty
}
esc.cyan_background() {
	printf "\033[46m" >/dev/tty
}
esc.magenta_text() {
	printf "\033[35m" >/dev/tty
}
esc.yellow_text() {
	printf "\033[33m" >/dev/tty
}
esc.green_text() {
	printf "\033[32m" >/dev/tty
}
esc.white_background() {
	printf "\033[47m" >/dev/tty
}
esc.low_intensity() {
	printf "\033[2m" >/dev/tty
}
esc.yellow_background() {
	printf "\033[43m" >/dev/tty
}
esc.red_background() {
	printf "\033[41m" >/dev/tty
}
esc.reset_style() {
	printf "\033[0m" >/dev/tty
}
esc.rapid_blink() {
	printf "\033[6m" >/dev/tty
}
esc.reverse() {
	printf "\033[7m" >/dev/tty
}
esc.conceal() {
	printf "\033[8m" >/dev/tty
}
esc.blue_background() {
	printf "\033[44m" >/dev/tty
}
esc.cyan_text() {
	printf "\033[36m" >/dev/tty
}
esc.bold() {
	printf "\033[1m" >/dev/tty
}
esc.red_text() {
	printf "\033[31m" >/dev/tty
}
esc.crossed_out() {
	printf "\033[9m" >/dev/tty
}
esc.blink() {
	printf "\033[5m" >/dev/tty
}
esc.black_text() {
	printf "\033[30m" >/dev/tty
}
ini.get_last_param() {
	ini.get_param_list "$1" | tail -n 1
}
ini.get_section_list() {
	local _RawIniLine=()
	local _Line _LineNo=1 _Exit=0
	readarray -t _RawIniLine
	while read -r _Line; do
		ini.parse_line <<<"$_Line"
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
ini.get_param_list() {
	local _RawIniLine=()
	local _Line _LineNo=1 _Exit=0 _InSection=false
	readarray -t _RawIniLine
	while read -r _Line; do
		ini.parse_line <<<"$_Line"
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
ini.get_param() {
	local _RawIniLine=()
	local _Line _LineNo=1 _Exit=0 _InSection=false
	readarray -t _RawIniLine
	while read -r _Line; do
		ini.parse_line <<<"$_Line"
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
ini.parse_line() {
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
ini.new_param() {
	local IniContents=() Line
	local Section="$1" Param="$2"
	local InSection=false LineNo=0
	local NewIniContents=()
	readarray -t IniContents
	local BeforeParam
	local SectionLastParam
	local ParamAdded=false
	if ! PrintArray "${IniContents[@]}" | ini.get_param_list "$Section" | grep -qx "$Param"; then
		SectionLastParam="$(PrintEvalArray IniContents | ini.get_last_param "$Section")"
		for Line in "${IniContents[@]}"; do
			LineNo=$((LineNo + 1))
			ini.parse_line <<<"$Line"
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
ini.new_section() {
	local IniContents=()
	local Section="$1"
	readarray -t IniContents
	if PrintArray "${IniContents[@]}" | ini.get_section_list | grep -x "$Section" >/dev/null; then
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
ini.set_value() {
	local IniContents=()
	local Section="$1" Param="$2"
	readarray -t IniContents
	readarray -t IniContents < <(PrintArray "${IniContents[@]}" | ini.new_section "$Section" | ini.new_param "$Section" "$Param")
	PrintEvalArray IniContents
}
libretranslate.check() {
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
libretranslate.translate() {
	libretranslate.check || return 2
	__libre_translate_return="$(curl -s "$LIBRETRANSLATE_URL/translate" -X POST -d "q=${1:-""}&source=${2:-""}&target=${3:-""}&api_key=${LIBRETRANSLATE_APIKEY:-""}")"
	if [ "$(echo "${__libre_translate_return}" | jq -r '.error')" = "null" ]; then
		echo "${__libre_translate_return}" | jq -r '.translatedText'
		return 0
	else
		echo "${__libre_translate_return}" | jq -r '.error'
		return 1
	fi
}
libretranslate.detect() {
	libretranslate.check || return 2
	__libre_translate_return="$(curl -s "${LIBRETRANSLATE_URL}/detect" -X POST -d "q=${1:-""}&api_key=${LIBRETRANSLATE_APIKEY:-""}")"
	if [ "$(echo "${__libre_translate_return}" | jq -r '.[].error')" = "null" ]; then
		echo "${__libre_translate_return}" | jq -r '.[].language'
		return 0
	else
		echo "${__libre_translate_return}" | jq -r '.error'
		return 1
	fi
}
libretranslate.translate_auto() {
	libretranslate.check || return 2
	libretranslate.translate "${1:-""}" "$(libretranslate.detect "${1:-""}")" "${2:-""}"
}
libretranslate.languages() {
	libretranslate.check || return 2
	curl -s "${LIBRETRANSLATE_URL}/languages" | jq -r '.[].code'
}
msg.warn() {
	msg.common " Warn:" "${*}" stderr
}
msg.err() {
	msg.common "Error:" "${*}" stderr
}
msg.common() {
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
msg.debug() {
	msg.common "Debug:" "${*}" stderr
}
msg.info() {
	msg.common " Info:" "${*}" stdout
}
arch.get_mkinitcpio_preset_list() {
	find "/etc/mkinitcpio.d/" -name "*.preset" -type f | GetBaseName | RemoveFileExt
}
arch.get_kernel_src_list() {
	find "/usr/src" -mindepth 1 -maxdepth 1 -type l -name "linux*"
}
arch.get_kernel_file_list() {
	find "/boot" -maxdepth 1 -mindepth 1 -name "vmlinuz-*"
}
array.append() {
	local _ArrName="$1"
	shift 1 || return 1
	readarray -t -O "$(ArrayIndex "$_ArrName")" "$_ArrName" < <(cat)
}
array.shift() {
	readarray -t "$1" < <(PrintEvalArray "$1" | sed "1,${2-"1"}d")
}
array.push() {
	eval "PrintArray \"\${$1[@]}\"" | grep -qx "$2" && return 0
	eval "$1+=(\"$2\")"
}
array.from_str() {
	declare -a -x "$1"
	readarray -t "$1" < <(BreakChar)
}
array.pop() {
	readarray -t "$1" < <(PrintEvalArray "$1" | sed -e '$d')
}
array.rev() {
	readarray -t "$1" < <(PrintEvalArray "$1" | tac)
}
array.remove() {
	readarray -t "$1" < <(PrintEvalArray "$1" | RemoveMatchLine "$2")
}
array.print() {
	(($# >= 1)) || return 0
	printf "%s\n" "${@}"
}
array.last() {
	PrintEval "$1[$(array.last_index "$1")]"
}
array.eval() {
	eval "PrintArray \"\${$1[@]}\""
}
array.length() {
	PrintEval "#${1}[@]"
}
array.index_of() {
	local n=()
	readarray -t n < <(grep -x -n "$1" | cut -d ":" -f 1 | ForEach eval echo '$(( {} - 1 ))')
	(("${#n[@]}" >= 1)) || return 1
	PrintArray "${n[@]}"
	return 0
}
array.last_index() {
	CalcInt "$(array.length "$1")" - 1
}
array.includes() {
	PrintEvalArray "$1" | grep -qx "$2"
}
array.for_each() {
	PrintEvalArray "$1" | ForEach "${@:2}"
}
array.include() {
	array.includes "$@"
}
awk.cos() {
	awk.float "cos($*)"
}
awk.tan() {
	awk.float "sin($1)/tan($1)"
}
awk.sin() {
	awk.float "sin($*)"
}
awk.pi() {
	awk.float "atan2(0, -0)"
}
awk.print() {
	awk "BEGIN {print $*}"
}
awk.log() {
	awk.float "log(${2}) / log($1)"
}
awk.rad() {
	awk.float "$1 * $(awk.pi) / 180 "
}
awk.float() {
	awk "BEGIN {printf (\"%4.${AWKSCALE-"5"}f\n\", $*)}"
}
PrintEvalArray() {
	Array.Eval "$1"
}
ArrayAppend() {
	Array.Append "$1"
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
StrToCharList() {
	Array.FromStr "$1"
}
GetArrayIndex() {
	Array.IndexOf "$1"
}
ArrayIndex() {
	Array.Length "$1"
}
AddNewToArray() {
	Array.Push "$@"
}
FileType() {
	file --mime-type -b "$1"
}
RemoveFileExt() {
	local Ext
	ForEach eval 'Ext=$(GetFileExt <<< {}); sed "s|.$Ext$||g" <<< {}; unset Ext'
}
GetFileExt() {
	GetBaseName | rev | cut -d "." -f 1 | rev
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
ToLower() {
	local _Str="${1,,}"
	[[ -z ${_Str-""} ]] || echo "${_Str}"
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
PrintEval() {
	eval echo "\${$1}"
}
RemoveBlank() {
	sed "s|^ *||g; s| *$||g; s|^	*||g; s|	*$||g; /^$/d"
}
GetMaxWidth() {
	awk '{ if ( length > x && length > 0 ) { x = length } }END{ print x }'
}
RandomString() {
	base64 <"/dev/random" | fold -w "$1" | head -n 1
	return 0
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
GetLastSplitString() {
	rev <<<"$2" | cut -d "$1" -f 1 | rev
}
CutLastString() {
	echo "${1%%"${2}"}"
	return 0
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
ToArgs() {
	readarray -t args
	"$@" "${args[@]}"
}
cache.get_file_last_update() {
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
cache.exist() {
	local _File
	_File="$(cache.create_dir)/$1"
	[[ -e $_File ]] || return 1
	(("$(cache.get_time_diff_from_last_update "$_File")" > "${KEEPCACHESEC-"86400"}")) && return 2
	return 0
}
cache.get_time_diff_from_last_update() {
	local _Now _Last
	_Now="$(date "+%s")"
	_Last="$(cache.get_file_last_update "$1")"
	echo "$((_Now - _Last))"
	return 0
}
cache.get_id() {
	if [[ -z ${FSBLIB_CACHEID-""} ]]; then
		cache.create_dir >/dev/null
	fi
	echo "$FSBLIB_CACHEID"
}
cache.get_dir() {
	echo "${TMPDIR-"/tmp"}/$(cache.get_id)"
}
cache.get() {
	cat "$(cache.get_dir)/$1" 2>/dev/null || return 1
}
cache.create() {
	cache.create_dir >/dev/null
	cat >"$(cache.get_dir)/${1}"
	cat "$(cache.get_dir)/$1"
}
cache.create_dir() {
	FSBLIB_CACHEID="${FSBLIB_CACHEID-"$(RandomString "10")"}"
	export FSBLIB_CACHEID="$FSBLIB_CACHEID"
	local TMPDIR="${TMPDIR-"/tmp"}"
	local _Dir="$TMPDIR/${FSBLIB_CACHEID}"
	mkdir -p "$_Dir"
	echo "$_Dir"
	return 0
}
fsblib.require_lib() {
	local lib missing=() return=0
	for lib in "$@"; do
		if ! [[ ${FSBLIB_LIBLIST[*]} == *" $lib "* ]]; then
			missing+=("$lib")
			return=1
		fi
	done
	return "$return"
}
fsblib_env_check() {
	fsblib.env_check
}
fsblib.env_check() {
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
csv.to_bash_array() {
	local _RawCsvLine=() _Line _ClmCnt=0
	local ArrayPrefix="${ArrayPrefix-"{}"}"
	readarray -t _RawCsvLine < <(
		while read -r _Line; do
			(($(tr "${CSVDELIM-","}" "\n" <<<"$_Line" | wc -l) >= ${#})) && echo "$_Line"
		done < <(grep -v "^#")
	)
	_ClmCnt=$(PrintArray "${_RawCsvLine[@]}" | csv.get_clm_cnt)
	while read -r _Cnt; do
		readarray -t "$(sed "s|{}|$(eval "echo \"\${${_Cnt}}\"")|g" <<<"$ArrayPrefix")" < <(
			PrintArray "${_RawCsvLine[@]}" | cut -d "${CSVDELIM-","}" -f "$_Cnt"
		)
	done < <(seq 1 "$#")
}
csv.get_clm() {
	grep -v "^#" | sed "/^$/d" | cut -d "${CSVDELIM-","}" -f "$1"
}
csv.get_clm_cnt() {
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
em.get_world_pkg_list() {
	sed -E 's|:.+$||g' /var/lib/portage/world | xargs -I{} bash -c 'ls -d /var/db/pkg/{}-* | sed "s|/var/db/pkg/||g" | grep -E "{}-[0-9]"'
}
em.get_repo_pkg_list() {
	local _RepoPath
	_RepoPath="$(em.get_repo_location "$1")"
	find "$_RepoPath" -mindepth 3 -maxdepth 3 -type f -name '*.ebuild' | sed -e "s|${_RepoPath%/}/||g" -e 's|.ebuild$||g' | awk -F "/" '{print $1"/"$3}'
}
em.get_all_pkg_list() {
	em.get_repo_conf | sed -e 's/^ *//' -e 's/ *$//' | grep "^ *location *=" | sed -e 's/^location *= *//' | xargs -L1 realpath | xargs -I{} bash -c "find '{}' -mindepth 3 -maxdepth 3 -type f -name '*.ebuild' | sed -e 's|{}/||g' -e 's|.ebuild$||g'" | awk -F "/" '{print $1"/"$3}'
}
em.get_installed_pkg_list() {
	find /var/db/pkg/ -mindepth 2 -maxdepth 2 -type d | sed 's|/var/db/pkg/||g'
}
em.get_repo_location() {
	em.get_repo_conf | Ini.GetParam "$1" location
}
em.get_repo_conf() {
	cat /etc/portage/repos.conf /etc/portage/repos.conf/* 2>/dev/null
}
em.get_default_repo_name() {
	em.get_repo_conf | Ini.GetParam DEFAULT main-repo
}
em.no_version() {
	sed -E 's|\-[0-9]+.+||g'
}
esc.clear_screen() {
	printf "\033[2J" >/dev/tty
}
esc.return() {
	printf "\r" >/dev/tty
}
esc.clear_left() {
	printf "\033[1K" >/dev/tty
}
esc.clear_line() {
	printf "\033[2K" >/dev/tty
}
esc.clear_right() {
	printf "\033[0K" >/dev/tty
}
esc.get_y() {
	local _POS
	printf "\033[6n" >>/dev/tty
	read -r -s -d "R" _POS
	echo $(("$(printf "%s\n" "${_POS:2}" | cut -d";" -f1)" - 1))
}
esc.get_x() {
	local _POS
	printf "\033[6n" >>/dev/tty
	read -r -s -d "R" _POS
	echo $(("$(printf "%s\n" "${_POS:2}" | cut -d";" -f2)" - 1))
}
esc.get_term_x() {
	[[ -n ${COLUMNS-""} ]] && echo "$COLUMNS" && return 0
	tput cols
}
esc.move_cursor() {
	printf "\033[%d;%dH" "$1" "$2" >/dev/tty
}
esc.move_cursor_up() {
	printf "\033[%dA" "$1" >/dev/tty
}
esc.move_cursor_left() {
	printf "\033[%dD" "$1" >/dev/tty
}
esc.move_cursor_down() {
	printf "\033[%dB" "$1" >/dev/tty
}
esc.move_cursor_right() {
	printf "\033[%dC" "$1" >/dev/tty
}
esc.get_term_y() {
	[[ -n ${LINES-""} ]] && echo "$LINES" && return 0
	tput lines
}
esc.clear_line_and_return() {
	esc.clear_line
	esc.return
}
esc.clear_upper_lines() {
	for i in $(seq 1 "$1"); do
		esc.move_cursor_up 1
		esc.clear_line
	done
}
esc.italic() {
	printf "\033[3m" >/dev/tty
}
esc.green_background() {
	printf "\033[42m" >/dev/tty
}
esc.black_background() {
	printf "\033[40m" >/dev/tty
}
esc.blue_text() {
	printf "\033[34m" >/dev/tty
}
esc.underline() {
	printf "\033[4m" >/dev/tty
}
esc.white_text() {
	printf "\033[37m" >/dev/tty
}
esc.magenta_background() {
	printf "\033[45m" >/dev/tty
}
esc.cyan_background() {
	printf "\033[46m" >/dev/tty
}
esc.magenta_text() {
	printf "\033[35m" >/dev/tty
}
esc.yellow_text() {
	printf "\033[33m" >/dev/tty
}
esc.green_text() {
	printf "\033[32m" >/dev/tty
}
esc.white_background() {
	printf "\033[47m" >/dev/tty
}
esc.low_intensity() {
	printf "\033[2m" >/dev/tty
}
esc.yellow_background() {
	printf "\033[43m" >/dev/tty
}
esc.red_background() {
	printf "\033[41m" >/dev/tty
}
esc.reset_style() {
	printf "\033[0m" >/dev/tty
}
esc.rapid_blink() {
	printf "\033[6m" >/dev/tty
}
esc.reverse() {
	printf "\033[7m" >/dev/tty
}
esc.conceal() {
	printf "\033[8m" >/dev/tty
}
esc.blue_background() {
	printf "\033[44m" >/dev/tty
}
esc.cyan_text() {
	printf "\033[36m" >/dev/tty
}
esc.bold() {
	printf "\033[1m" >/dev/tty
}
esc.red_text() {
	printf "\033[31m" >/dev/tty
}
esc.crossed_out() {
	printf "\033[9m" >/dev/tty
}
esc.blink() {
	printf "\033[5m" >/dev/tty
}
esc.black_text() {
	printf "\033[30m" >/dev/tty
}
ini.get_last_param() {
	ini.get_param_list "$1" | tail -n 1
}
ini.get_section_list() {
	local _RawIniLine=()
	local _Line _LineNo=1 _Exit=0
	readarray -t _RawIniLine
	while read -r _Line; do
		ini.parse_line <<<"$_Line"
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
ini.get_param_list() {
	local _RawIniLine=()
	local _Line _LineNo=1 _Exit=0 _InSection=false
	readarray -t _RawIniLine
	while read -r _Line; do
		ini.parse_line <<<"$_Line"
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
ini.get_param() {
	local _RawIniLine=()
	local _Line _LineNo=1 _Exit=0 _InSection=false
	readarray -t _RawIniLine
	while read -r _Line; do
		ini.parse_line <<<"$_Line"
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
ini.parse_line() {
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
ini.new_param() {
	local IniContents=() Line
	local Section="$1" Param="$2"
	local InSection=false LineNo=0
	local NewIniContents=()
	readarray -t IniContents
	local BeforeParam
	local SectionLastParam
	local ParamAdded=false
	if ! PrintArray "${IniContents[@]}" | ini.get_param_list "$Section" | grep -qx "$Param"; then
		SectionLastParam="$(PrintEvalArray IniContents | ini.get_last_param "$Section")"
		for Line in "${IniContents[@]}"; do
			LineNo=$((LineNo + 1))
			ini.parse_line <<<"$Line"
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
ini.new_section() {
	local IniContents=()
	local Section="$1"
	readarray -t IniContents
	if PrintArray "${IniContents[@]}" | ini.get_section_list | grep -x "$Section" >/dev/null; then
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
ini.set_value() {
	local IniContents=()
	local Section="$1" Param="$2"
	readarray -t IniContents
	readarray -t IniContents < <(PrintArray "${IniContents[@]}" | ini.new_section "$Section" | ini.new_param "$Section" "$Param")
	PrintEvalArray IniContents
}
libretranslate.check() {
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
libretranslate.translate() {
	libretranslate.check || return 2
	__libre_translate_return="$(curl -s "$LIBRETRANSLATE_URL/translate" -X POST -d "q=${1:-""}&source=${2:-""}&target=${3:-""}&api_key=${LIBRETRANSLATE_APIKEY:-""}")"
	if [ "$(echo "${__libre_translate_return}" | jq -r '.error')" = "null" ]; then
		echo "${__libre_translate_return}" | jq -r '.translatedText'
		return 0
	else
		echo "${__libre_translate_return}" | jq -r '.error'
		return 1
	fi
}
libretranslate.detect() {
	libretranslate.check || return 2
	__libre_translate_return="$(curl -s "${LIBRETRANSLATE_URL}/detect" -X POST -d "q=${1:-""}&api_key=${LIBRETRANSLATE_APIKEY:-""}")"
	if [ "$(echo "${__libre_translate_return}" | jq -r '.[].error')" = "null" ]; then
		echo "${__libre_translate_return}" | jq -r '.[].language'
		return 0
	else
		echo "${__libre_translate_return}" | jq -r '.error'
		return 1
	fi
}
libretranslate.translate_auto() {
	libretranslate.check || return 2
	libretranslate.translate "${1:-""}" "$(libretranslate.detect "${1:-""}")" "${2:-""}"
}
libretranslate.languages() {
	libretranslate.check || return 2
	curl -s "${LIBRETRANSLATE_URL}/languages" | jq -r '.[].code'
}
msg.warn() {
	msg.common " Warn:" "${*}" stderr
}
msg.err() {
	msg.common "Error:" "${*}" stderr
}
msg.common() {
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
msg.debug() {
	msg.common "Debug:" "${*}" stderr
}
msg.info() {
	msg.common " Info:" "${*}" stdout
}
misskey.notes.renotes() {
	misskey.binding_base "notes/renotes" noteId limit sinceId untilId -- "$@"
}
misskey.notes.search() {
	misskey.binding_base "notes/search" query limit -- "$@"
}
misskey.notes.create() {
	misskey.binding_base "notes/create" text -- "$@"
}
misskey.users.show() {
	misskey.binding_base "users/show" userId -- "${1:-"$(misskey.my_id)"}" "${@:2}"
}
misskey.users.stats() {
	misskey.binding_base "users/stats" userId -- "${1:-"$(misskey.my_id)"}" "${@:2}"
}
misskey.users.get_frequently_replied_users() {
	misskey.binding_base "users/get-frequently-replied-users" userId -- "${1:-"$(misskey.my_id)"}" "${@:2}"
}
misskey.users.search_by_username_and_host() {
	misskey.binding_base "users/search-by-username-and-host" username -- "${1:-"$(misskey.my_user_name)"}" "${@:2}"
}
misskey.users.notes() {
	misskey.binding_base "users/notes" userId -- "${1:-"$(misskey.my_id)"}" "${@:2}"
}
misskey.users.pages() {
	misskey.binding_base "users/pages" userId -- "${1:-"$(misskey.my_id)"}" "${@:2}"
}
misskey.admin.server_info() {
	misskey.binding_base "/admin/server-info" -- "$@"
}
misskey.setup() {
	export MISSKEY_DOMAIN="${1-"${MISSKEY_DOMAIN-""}"}"
	export MISSKEY_TOKEN="${2-"${MISSKEY_TOKEN-""}"}"
	export MISSKEY_ENTRY="https://${MISSKEY_DOMAIN}/api"
}
misskey.i() {
	misskey.binding_base "/i" -- "$@"
}
misskey.server_info() {
	misskey.binding_base "/server-info" -- "$@"
}
misskey.meta() {
	misskey.binding_base "/meta" -- "$@"
}
misskey.binding_base() {
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
		misskey.setup "${MISSKEY_DOMAIN}" "$MISSKEY_TOKEN"
	fi
	misskey.send_req "${MISSKEY_ENTRY%/}/${_API#/}" "${_Args[@]}" "$@"
}
misskey.send_req() {
	local _Url="$1" _CurlArgs=()
	shift 1
	_CurlArgs+=(-s -L)
	_CurlArgs+=(-X POST)
	_CurlArgs+=(-H "Content-Type: application/json")
	_CurlArgs+=(-d "$(misskey.make_json "$@")")
	_CurlArgs+=("$_Url")
	Msg.Debug "Run: ${_CurlArgs[*]//"${MISSKEY_TOKEN}"/"TOKEN"}"
	curl "${_CurlArgs[@]}"
}
misskey.make_json() {
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
misskey.is_admin() {
	Bool "$(misskey.i | jq -r ".isAdmin")"
}
misskey.my_name() {
	misskey.i | jq -r ".name"
}
misskey.my_user_name() {
	misskey.i | jq -r ".username"
}
misskey.my_id() {
	misskey.i | jq -r ".id"
}
arch.get_mkinitcpio_preset_list() {
	find "/etc/mkinitcpio.d/" -name "*.preset" -type f | GetBaseName | RemoveFileExt
}
arch.get_kernel_src_list() {
	find "/usr/src" -mindepth 1 -maxdepth 1 -type l -name "linux*"
}
arch.get_kernel_file_list() {
	find "/boot" -maxdepth 1 -mindepth 1 -name "vmlinuz-*"
}
array.append() {
	local _ArrName="$1"
	shift 1 || return 1
	readarray -t -O "$(ArrayIndex "$_ArrName")" "$_ArrName" < <(cat)
}
array.shift() {
	readarray -t "$1" < <(PrintEvalArray "$1" | sed "1,${2-"1"}d")
}
array.push() {
	eval "PrintArray \"\${$1[@]}\"" | grep -qx "$2" && return 0
	eval "$1+=(\"$2\")"
}
array.from_str() {
	declare -a -x "$1"
	readarray -t "$1" < <(BreakChar)
}
array.pop() {
	readarray -t "$1" < <(PrintEvalArray "$1" | sed -e '$d')
}
array.rev() {
	readarray -t "$1" < <(PrintEvalArray "$1" | tac)
}
array.remove() {
	readarray -t "$1" < <(PrintEvalArray "$1" | RemoveMatchLine "$2")
}
array.print() {
	(($# >= 1)) || return 0
	printf "%s\n" "${@}"
}
array.last() {
	PrintEval "$1[$(array.last_index "$1")]"
}
array.eval() {
	eval "PrintArray \"\${$1[@]}\""
}
array.length() {
	PrintEval "#${1}[@]"
}
array.index_of() {
	local n=()
	readarray -t n < <(grep -x -n "$1" | cut -d ":" -f 1 | ForEach eval echo '$(( {} - 1 ))')
	(("${#n[@]}" >= 1)) || return 1
	PrintArray "${n[@]}"
	return 0
}
array.last_index() {
	CalcInt "$(array.length "$1")" - 1
}
array.includes() {
	PrintEvalArray "$1" | grep -qx "$2"
}
array.for_each() {
	PrintEvalArray "$1" | ForEach "${@:2}"
}
array.include() {
	array.includes "$@"
}
awk.cos() {
	awk.float "cos($*)"
}
awk.tan() {
	awk.float "sin($1)/tan($1)"
}
awk.sin() {
	awk.float "sin($*)"
}
awk.pi() {
	awk.float "atan2(0, -0)"
}
awk.print() {
	awk "BEGIN {print $*}"
}
awk.log() {
	awk.float "log(${2}) / log($1)"
}
awk.rad() {
	awk.float "$1 * $(awk.pi) / 180 "
}
awk.float() {
	awk "BEGIN {printf (\"%4.${AWKSCALE-"5"}f\n\", $*)}"
}
PrintEvalArray() {
	Array.Eval "$1"
}
ArrayAppend() {
	Array.Append "$1"
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
StrToCharList() {
	Array.FromStr "$1"
}
GetArrayIndex() {
	Array.IndexOf "$1"
}
ArrayIndex() {
	Array.Length "$1"
}
AddNewToArray() {
	Array.Push "$@"
}
FileType() {
	file --mime-type -b "$1"
}
RemoveFileExt() {
	local Ext
	ForEach eval 'Ext=$(GetFileExt <<< {}); sed "s|.$Ext$||g" <<< {}; unset Ext'
}
GetFileExt() {
	GetBaseName | rev | cut -d "." -f 1 | rev
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
ToLower() {
	local _Str="${1,,}"
	[[ -z ${_Str-""} ]] || echo "${_Str}"
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
PrintEval() {
	eval echo "\${$1}"
}
RemoveBlank() {
	sed "s|^ *||g; s| *$||g; s|^	*||g; s|	*$||g; /^$/d"
}
GetMaxWidth() {
	awk '{ if ( length > x && length > 0 ) { x = length } }END{ print x }'
}
RandomString() {
	base64 <"/dev/random" | fold -w "$1" | head -n 1
	return 0
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
GetLastSplitString() {
	rev <<<"$2" | cut -d "$1" -f 1 | rev
}
CutLastString() {
	echo "${1%%"${2}"}"
	return 0
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
ToArgs() {
	readarray -t args
	"$@" "${args[@]}"
}
cache.get_file_last_update() {
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
cache.exist() {
	local _File
	_File="$(cache.create_dir)/$1"
	[[ -e $_File ]] || return 1
	(("$(cache.get_time_diff_from_last_update "$_File")" > "${KEEPCACHESEC-"86400"}")) && return 2
	return 0
}
cache.get_time_diff_from_last_update() {
	local _Now _Last
	_Now="$(date "+%s")"
	_Last="$(cache.get_file_last_update "$1")"
	echo "$((_Now - _Last))"
	return 0
}
cache.get_id() {
	if [[ -z ${FSBLIB_CACHEID-""} ]]; then
		cache.create_dir >/dev/null
	fi
	echo "$FSBLIB_CACHEID"
}
cache.get_dir() {
	echo "${TMPDIR-"/tmp"}/$(cache.get_id)"
}
cache.get() {
	cat "$(cache.get_dir)/$1" 2>/dev/null || return 1
}
cache.create() {
	cache.create_dir >/dev/null
	cat >"$(cache.get_dir)/${1}"
	cat "$(cache.get_dir)/$1"
}
cache.create_dir() {
	FSBLIB_CACHEID="${FSBLIB_CACHEID-"$(RandomString "10")"}"
	export FSBLIB_CACHEID="$FSBLIB_CACHEID"
	local TMPDIR="${TMPDIR-"/tmp"}"
	local _Dir="$TMPDIR/${FSBLIB_CACHEID}"
	mkdir -p "$_Dir"
	echo "$_Dir"
	return 0
}
fsblib.require_lib() {
	local lib missing=() return=0
	for lib in "$@"; do
		if ! [[ ${FSBLIB_LIBLIST[*]} == *" $lib "* ]]; then
			missing+=("$lib")
			return=1
		fi
	done
	return "$return"
}
fsblib_env_check() {
	fsblib.env_check
}
fsblib.env_check() {
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
csv.to_bash_array() {
	local _RawCsvLine=() _Line _ClmCnt=0
	local ArrayPrefix="${ArrayPrefix-"{}"}"
	readarray -t _RawCsvLine < <(
		while read -r _Line; do
			(($(tr "${CSVDELIM-","}" "\n" <<<"$_Line" | wc -l) >= ${#})) && echo "$_Line"
		done < <(grep -v "^#")
	)
	_ClmCnt=$(PrintArray "${_RawCsvLine[@]}" | csv.get_clm_cnt)
	while read -r _Cnt; do
		readarray -t "$(sed "s|{}|$(eval "echo \"\${${_Cnt}}\"")|g" <<<"$ArrayPrefix")" < <(
			PrintArray "${_RawCsvLine[@]}" | cut -d "${CSVDELIM-","}" -f "$_Cnt"
		)
	done < <(seq 1 "$#")
}
csv.get_clm() {
	grep -v "^#" | sed "/^$/d" | cut -d "${CSVDELIM-","}" -f "$1"
}
csv.get_clm_cnt() {
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
em.get_world_pkg_list() {
	sed -E 's|:.+$||g' /var/lib/portage/world | xargs -I{} bash -c 'ls -d /var/db/pkg/{}-* | sed "s|/var/db/pkg/||g" | grep -E "{}-[0-9]"'
}
em.get_repo_pkg_list() {
	local _RepoPath
	_RepoPath="$(em.get_repo_location "$1")"
	find "$_RepoPath" -mindepth 3 -maxdepth 3 -type f -name '*.ebuild' | sed -e "s|${_RepoPath%/}/||g" -e 's|.ebuild$||g' | awk -F "/" '{print $1"/"$3}'
}
em.get_all_pkg_list() {
	em.get_repo_conf | sed -e 's/^ *//' -e 's/ *$//' | grep "^ *location *=" | sed -e 's/^location *= *//' | xargs -L1 realpath | xargs -I{} bash -c "find '{}' -mindepth 3 -maxdepth 3 -type f -name '*.ebuild' | sed -e 's|{}/||g' -e 's|.ebuild$||g'" | awk -F "/" '{print $1"/"$3}'
}
em.get_installed_pkg_list() {
	find /var/db/pkg/ -mindepth 2 -maxdepth 2 -type d | sed 's|/var/db/pkg/||g'
}
em.get_repo_location() {
	em.get_repo_conf | Ini.GetParam "$1" location
}
em.get_repo_conf() {
	cat /etc/portage/repos.conf /etc/portage/repos.conf/* 2>/dev/null
}
em.get_default_repo_name() {
	em.get_repo_conf | Ini.GetParam DEFAULT main-repo
}
em.no_version() {
	sed -E 's|\-[0-9]+.+||g'
}
esc.clear_screen() {
	printf "\033[2J" >/dev/tty
}
esc.return() {
	printf "\r" >/dev/tty
}
esc.clear_left() {
	printf "\033[1K" >/dev/tty
}
esc.clear_line() {
	printf "\033[2K" >/dev/tty
}
esc.clear_right() {
	printf "\033[0K" >/dev/tty
}
esc.get_y() {
	local _POS
	printf "\033[6n" >>/dev/tty
	read -r -s -d "R" _POS
	echo $(("$(printf "%s\n" "${_POS:2}" | cut -d";" -f1)" - 1))
}
esc.get_x() {
	local _POS
	printf "\033[6n" >>/dev/tty
	read -r -s -d "R" _POS
	echo $(("$(printf "%s\n" "${_POS:2}" | cut -d";" -f2)" - 1))
}
esc.get_term_x() {
	[[ -n ${COLUMNS-""} ]] && echo "$COLUMNS" && return 0
	tput cols
}
esc.move_cursor() {
	printf "\033[%d;%dH" "$1" "$2" >/dev/tty
}
esc.move_cursor_up() {
	printf "\033[%dA" "$1" >/dev/tty
}
esc.move_cursor_left() {
	printf "\033[%dD" "$1" >/dev/tty
}
esc.move_cursor_down() {
	printf "\033[%dB" "$1" >/dev/tty
}
esc.move_cursor_right() {
	printf "\033[%dC" "$1" >/dev/tty
}
esc.get_term_y() {
	[[ -n ${LINES-""} ]] && echo "$LINES" && return 0
	tput lines
}
esc.clear_line_and_return() {
	esc.clear_line
	esc.return
}
esc.clear_upper_lines() {
	for i in $(seq 1 "$1"); do
		esc.move_cursor_up 1
		esc.clear_line
	done
}
esc.italic() {
	printf "\033[3m" >/dev/tty
}
esc.green_background() {
	printf "\033[42m" >/dev/tty
}
esc.black_background() {
	printf "\033[40m" >/dev/tty
}
esc.blue_text() {
	printf "\033[34m" >/dev/tty
}
esc.underline() {
	printf "\033[4m" >/dev/tty
}
esc.white_text() {
	printf "\033[37m" >/dev/tty
}
esc.magenta_background() {
	printf "\033[45m" >/dev/tty
}
esc.cyan_background() {
	printf "\033[46m" >/dev/tty
}
esc.magenta_text() {
	printf "\033[35m" >/dev/tty
}
esc.yellow_text() {
	printf "\033[33m" >/dev/tty
}
esc.green_text() {
	printf "\033[32m" >/dev/tty
}
esc.white_background() {
	printf "\033[47m" >/dev/tty
}
esc.low_intensity() {
	printf "\033[2m" >/dev/tty
}
esc.yellow_background() {
	printf "\033[43m" >/dev/tty
}
esc.red_background() {
	printf "\033[41m" >/dev/tty
}
esc.reset_style() {
	printf "\033[0m" >/dev/tty
}
esc.rapid_blink() {
	printf "\033[6m" >/dev/tty
}
esc.reverse() {
	printf "\033[7m" >/dev/tty
}
esc.conceal() {
	printf "\033[8m" >/dev/tty
}
esc.blue_background() {
	printf "\033[44m" >/dev/tty
}
esc.cyan_text() {
	printf "\033[36m" >/dev/tty
}
esc.bold() {
	printf "\033[1m" >/dev/tty
}
esc.red_text() {
	printf "\033[31m" >/dev/tty
}
esc.crossed_out() {
	printf "\033[9m" >/dev/tty
}
esc.blink() {
	printf "\033[5m" >/dev/tty
}
esc.black_text() {
	printf "\033[30m" >/dev/tty
}
ini.get_last_param() {
	ini.get_param_list "$1" | tail -n 1
}
ini.get_section_list() {
	local _RawIniLine=()
	local _Line _LineNo=1 _Exit=0
	readarray -t _RawIniLine
	while read -r _Line; do
		ini.parse_line <<<"$_Line"
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
ini.get_param_list() {
	local _RawIniLine=()
	local _Line _LineNo=1 _Exit=0 _InSection=false
	readarray -t _RawIniLine
	while read -r _Line; do
		ini.parse_line <<<"$_Line"
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
ini.get_param() {
	local _RawIniLine=()
	local _Line _LineNo=1 _Exit=0 _InSection=false
	readarray -t _RawIniLine
	while read -r _Line; do
		ini.parse_line <<<"$_Line"
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
ini.parse_line() {
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
ini.new_param() {
	local IniContents=() Line
	local Section="$1" Param="$2"
	local InSection=false LineNo=0
	local NewIniContents=()
	readarray -t IniContents
	local BeforeParam
	local SectionLastParam
	local ParamAdded=false
	if ! PrintArray "${IniContents[@]}" | ini.get_param_list "$Section" | grep -qx "$Param"; then
		SectionLastParam="$(PrintEvalArray IniContents | ini.get_last_param "$Section")"
		for Line in "${IniContents[@]}"; do
			LineNo=$((LineNo + 1))
			ini.parse_line <<<"$Line"
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
ini.new_section() {
	local IniContents=()
	local Section="$1"
	readarray -t IniContents
	if PrintArray "${IniContents[@]}" | ini.get_section_list | grep -x "$Section" >/dev/null; then
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
ini.set_value() {
	local IniContents=()
	local Section="$1" Param="$2"
	readarray -t IniContents
	readarray -t IniContents < <(PrintArray "${IniContents[@]}" | ini.new_section "$Section" | ini.new_param "$Section" "$Param")
	PrintEvalArray IniContents
}
libretranslate.check() {
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
libretranslate.translate() {
	libretranslate.check || return 2
	__libre_translate_return="$(curl -s "$LIBRETRANSLATE_URL/translate" -X POST -d "q=${1:-""}&source=${2:-""}&target=${3:-""}&api_key=${LIBRETRANSLATE_APIKEY:-""}")"
	if [ "$(echo "${__libre_translate_return}" | jq -r '.error')" = "null" ]; then
		echo "${__libre_translate_return}" | jq -r '.translatedText'
		return 0
	else
		echo "${__libre_translate_return}" | jq -r '.error'
		return 1
	fi
}
libretranslate.detect() {
	libretranslate.check || return 2
	__libre_translate_return="$(curl -s "${LIBRETRANSLATE_URL}/detect" -X POST -d "q=${1:-""}&api_key=${LIBRETRANSLATE_APIKEY:-""}")"
	if [ "$(echo "${__libre_translate_return}" | jq -r '.[].error')" = "null" ]; then
		echo "${__libre_translate_return}" | jq -r '.[].language'
		return 0
	else
		echo "${__libre_translate_return}" | jq -r '.error'
		return 1
	fi
}
libretranslate.translate_auto() {
	libretranslate.check || return 2
	libretranslate.translate "${1:-""}" "$(libretranslate.detect "${1:-""}")" "${2:-""}"
}
libretranslate.languages() {
	libretranslate.check || return 2
	curl -s "${LIBRETRANSLATE_URL}/languages" | jq -r '.[].code'
}
msg.warn() {
	msg.common " Warn:" "${*}" stderr
}
msg.err() {
	msg.common "Error:" "${*}" stderr
}
msg.common() {
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
msg.debug() {
	msg.common "Debug:" "${*}" stderr
}
msg.info() {
	msg.common " Info:" "${*}" stdout
}
misskey.notes.renotes() {
	misskey.binding_base "notes/renotes" noteId limit sinceId untilId -- "$@"
}
misskey.notes.search() {
	misskey.binding_base "notes/search" query limit -- "$@"
}
misskey.notes.create() {
	misskey.binding_base "notes/create" text -- "$@"
}
misskey.users.show() {
	misskey.binding_base "users/show" userId -- "${1:-"$(misskey.my_id)"}" "${@:2}"
}
misskey.users.stats() {
	misskey.binding_base "users/stats" userId -- "${1:-"$(misskey.my_id)"}" "${@:2}"
}
misskey.users.get_frequently_replied_users() {
	misskey.binding_base "users/get-frequently-replied-users" userId -- "${1:-"$(misskey.my_id)"}" "${@:2}"
}
misskey.users.search_by_username_and_host() {
	misskey.binding_base "users/search-by-username-and-host" username -- "${1:-"$(misskey.my_user_name)"}" "${@:2}"
}
misskey.users.notes() {
	misskey.binding_base "users/notes" userId -- "${1:-"$(misskey.my_id)"}" "${@:2}"
}
misskey.users.pages() {
	misskey.binding_base "users/pages" userId -- "${1:-"$(misskey.my_id)"}" "${@:2}"
}
misskey.admin.server_info() {
	misskey.binding_base "/admin/server-info" -- "$@"
}
misskey.setup() {
	export MISSKEY_DOMAIN="${1-"${MISSKEY_DOMAIN-""}"}"
	export MISSKEY_TOKEN="${2-"${MISSKEY_TOKEN-""}"}"
	export MISSKEY_ENTRY="https://${MISSKEY_DOMAIN}/api"
}
misskey.i() {
	misskey.binding_base "/i" -- "$@"
}
misskey.server_info() {
	misskey.binding_base "/server-info" -- "$@"
}
misskey.meta() {
	misskey.binding_base "/meta" -- "$@"
}
misskey.binding_base() {
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
		misskey.setup "${MISSKEY_DOMAIN}" "$MISSKEY_TOKEN"
	fi
	misskey.send_req "${MISSKEY_ENTRY%/}/${_API#/}" "${_Args[@]}" "$@"
}
misskey.send_req() {
	local _Url="$1" _CurlArgs=()
	shift 1
	_CurlArgs+=(-s -L)
	_CurlArgs+=(-X POST)
	_CurlArgs+=(-H "Content-Type: application/json")
	_CurlArgs+=(-d "$(misskey.make_json "$@")")
	_CurlArgs+=("$_Url")
	Msg.Debug "Run: ${_CurlArgs[*]//"${MISSKEY_TOKEN}"/"TOKEN"}"
	curl "${_CurlArgs[@]}"
}
misskey.make_json() {
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
misskey.is_admin() {
	Bool "$(misskey.i | jq -r ".isAdmin")"
}
misskey.my_name() {
	misskey.i | jq -r ".name"
}
misskey.my_user_name() {
	misskey.i | jq -r ".username"
}
misskey.my_id() {
	misskey.i | jq -r ".id"
}
pm.check_pkg() {
	local p
	for p in "$@"; do
		pm.run -Qq "$p" >/dev/null 2>&1 || return 1
	done
	return 0
}
pm.get_latest_pkg_ver() {
	local _LANG="${LANG-""}"
	export LANG=C
	if [[ -z ${*} ]]; then
		cat
	else
		PrintArray "$@"
	fi | ForEach pm.run -Si "{}" | grep "^Version" | cut -d ":" -f 2 | RemoveBlank
	[[ -n $_LANG ]] && export LANG="$_LANG"
	return 0
}
pm.get_repo_list_from_conf() {
	pm.get_config --repo-list
}
pm.get_pacman_keyring_dir() {
	local _KeyringDir=""
	_KeyringDir="$(LANG=C pacman-key -h | RemoveBlank | grep -A 1 -- "^--populate" | tail -n 1 | cut -d "/" -f 2- | sed "s|'$||g")"
	: "${_KeyringDir="usr/share/pacman/keyrings"}"
	_KeyringDir="$(pm.get_root)/$_KeyringDir"
	_KeyringDir="$(sed -E "s|/+|/|g" <<<"$_KeyringDir")"
	if [[ -e $_KeyringDir ]]; then
		Readlinkf "$_KeyringDir"
	else
		echo "$_KeyringDir"
	fi
}
pm.get_repo_pkg_list() {
	pm.run -Slq "$@"
}
pm.get_repo_ver() {
	pm.run -Sp --print-format '%v' "$1"
}
pm.get_repo_server() {
	ForEach eval 'pm.get_config -r {}' | grep "^Server" | ForEach eval "Ini.ParseLine <<< '{}' ; printf '%s\n' \${VALUE}"
}
pm.is_repo_pkg() {
	pm.run -Slq | grep -qx "$(pm.get_name <<<"$1")"
}
pm.get_repo_conf() {
	ForEach eval 'echo [{}] && pm.get_config -r {}'
}
pm.get_root() {
	pm.get_config RootDir
}
pm.get_name() {
	cut -d "<" -f 1 | cut -d ">" -f 1 | cut -d "=" -f 1
}
pm.pacman_gpg() {
	gpg --homedir "$(pm.get_config GPGDir)" "$@"
}
pm.get_pacman_kernel_pkg() {
	echo "there is nothing"
}
pm.get_keyring_list() {
	find "$(@GetKeyringDir)" -name "*.gpg" | GetBaseName | RemoveFileExt
}
pm.get_installed_pkg_ver() {
	if [[ -z ${*} ]]; then
		cat
	else
		PrintArray "$@"
	fi | ForEach pacman -Q "{}" | cut -d " " -f 2
	PrintArray "${PIPESTATUS[@]}" | grep -qx "1" && return 1
	return 0
}
pm.run_key() {
	pacman-key --config "${PACMAN_CONF-"/etc/pacman.conf"}" "$@"
}
pm.run() {
	pacman --noconfirm --config "${PACMAN_CONF-"/etc/pacman.conf"}" "$@"
}
pm.get_config() {
	LANG=C pacman-conf --config="${PACMAN_CONF-"/etc/pacman.conf"}" "$@"
}
pm.get_db_section_list() {
	grep -E "^%.*%$"
}
pm.get_db_next_section() {
	pm.get_db_section_list | grep -x -A 1 "^%$1%$" | GetLine 2 | sed "s|^%||g; s|%$||g"
}
pm.get_db_section() {
	readarray -t _Stdin
	PrintArray "${_Stdin[@]}" | sed -ne "/^%$1%$/,/^%$(PrintEvalArray _Stdin | pm.get_db_next_section "$1")%$/p" | sed '1d; $d'
}
pm.opened_sync_db_list() {
	find "$(pm.get_db_tmp_dir)/sync/" -mindepth 1 -maxdepth 1 -type d
}
pm.create_db_tmp_dir() {
	mkdir -p "$(pm.get_db_tmp_dir)"
}
pm.get_sync_all_desc() {
	find "$(pm.get_db_tmp_dir)" -mindepth 3 -maxdepth 3 -name "desc" -type f
}
pm.is_opend_sync_db() {
	readarray -t _PkgDbList < <(find "$(pm.get_db_tmp_dir)/sync/$1" -mindepth 1 -maxdepth 1 -type d)
	(("${#_PkgDbList[@]}" > 0)) && return 0
	return 1
}
pm.get_virtual_pkg_list() {
	pm.get_repo_list_from_local_db | ForEach pm.open_sync_db {}
	pm.get_sync_all_desc | ForEach eval "pm.get_db_section PROVIDES < {}" | RemoveBlank
}
pm.get_db_tmp_dir() {
	echo "${TMPDIR-"/tmp"}/fasbashlib-pacman-db"
}
pm.get_sync_db_desc() {
	local _path
	_path="$(pm.get_sync_db_desc_path "$1")"
	[[ -e $_path ]] || return 1
	cat "$_path/desc"
}
pm.get_sync_db_desc_path() {
	local _repo
	_repo="$(pacman -Sp --print-format '%r' "$1")"
	{
		IsPacmanSyncDbOpend "$_repo" || OpenPacmanSyncDb "$_repo"
	} || return 1
	echo "$(pm.get_db_tmp_dir)/sync/$(pacman -Sp --print-format '%r/%n-%v' "$1")"
}
pm.parse_pkg_file_name() {
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
pm.get_repo_list_from_local_db() {
	find "$(pm.get_config DBPath)/sync" -mindepth 1 -maxdepth 1 -type f | GetBaseName | sed "s|.db$||g"
	return 0
}
pm.open_sync_db() {
	local _Dir _RepoDb
	pm.create_db_tmp_dir
	_Dir="$(pm.get_db_tmp_dir)/sync/$1"
	mkdir -p "$_Dir"
	_RepoDb="$(pm.get_config DBPath)/sync/$1.db"
	[[ -e $_RepoDb ]] || return 1
	tar -xzf "${_RepoDb}" -C "$_Dir" || return 1
}
pm.get_pkg_arch() {
	pm.get_sync_db_desc "$1" | pm.get_db_section ARCH | RemoveBlank
}
pm.delete_db_tmp_dir() {
	rm -rf "$(pm.get_db_tmp_dir)"
}
arch.get_mkinitcpio_preset_list() {
	find "/etc/mkinitcpio.d/" -name "*.preset" -type f | GetBaseName | RemoveFileExt
}
arch.get_kernel_src_list() {
	find "/usr/src" -mindepth 1 -maxdepth 1 -type l -name "linux*"
}
arch.get_kernel_file_list() {
	find "/boot" -maxdepth 1 -mindepth 1 -name "vmlinuz-*"
}
array.append() {
	local _ArrName="$1"
	shift 1 || return 1
	readarray -t -O "$(ArrayIndex "$_ArrName")" "$_ArrName" < <(cat)
}
array.shift() {
	readarray -t "$1" < <(PrintEvalArray "$1" | sed "1,${2-"1"}d")
}
array.push() {
	eval "PrintArray \"\${$1[@]}\"" | grep -qx "$2" && return 0
	eval "$1+=(\"$2\")"
}
array.from_str() {
	declare -a -x "$1"
	readarray -t "$1" < <(BreakChar)
}
array.pop() {
	readarray -t "$1" < <(PrintEvalArray "$1" | sed -e '$d')
}
array.rev() {
	readarray -t "$1" < <(PrintEvalArray "$1" | tac)
}
array.remove() {
	readarray -t "$1" < <(PrintEvalArray "$1" | RemoveMatchLine "$2")
}
array.print() {
	(($# >= 1)) || return 0
	printf "%s\n" "${@}"
}
array.last() {
	PrintEval "$1[$(array.last_index "$1")]"
}
array.eval() {
	eval "PrintArray \"\${$1[@]}\""
}
array.length() {
	PrintEval "#${1}[@]"
}
array.index_of() {
	local n=()
	readarray -t n < <(grep -x -n "$1" | cut -d ":" -f 1 | ForEach eval echo '$(( {} - 1 ))')
	(("${#n[@]}" >= 1)) || return 1
	PrintArray "${n[@]}"
	return 0
}
array.last_index() {
	CalcInt "$(array.length "$1")" - 1
}
array.includes() {
	PrintEvalArray "$1" | grep -qx "$2"
}
array.for_each() {
	PrintEvalArray "$1" | ForEach "${@:2}"
}
array.include() {
	array.includes "$@"
}
awk.cos() {
	awk.float "cos($*)"
}
awk.tan() {
	awk.float "sin($1)/tan($1)"
}
awk.sin() {
	awk.float "sin($*)"
}
awk.pi() {
	awk.float "atan2(0, -0)"
}
awk.print() {
	awk "BEGIN {print $*}"
}
awk.log() {
	awk.float "log(${2}) / log($1)"
}
awk.rad() {
	awk.float "$1 * $(awk.pi) / 180 "
}
awk.float() {
	awk "BEGIN {printf (\"%4.${AWKSCALE-"5"}f\n\", $*)}"
}
PrintEvalArray() {
	Array.Eval "$1"
}
ArrayAppend() {
	Array.Append "$1"
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
StrToCharList() {
	Array.FromStr "$1"
}
GetArrayIndex() {
	Array.IndexOf "$1"
}
ArrayIndex() {
	Array.Length "$1"
}
AddNewToArray() {
	Array.Push "$@"
}
FileType() {
	file --mime-type -b "$1"
}
RemoveFileExt() {
	local Ext
	ForEach eval 'Ext=$(GetFileExt <<< {}); sed "s|.$Ext$||g" <<< {}; unset Ext'
}
GetFileExt() {
	GetBaseName | rev | cut -d "." -f 1 | rev
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
ToLower() {
	local _Str="${1,,}"
	[[ -z ${_Str-""} ]] || echo "${_Str}"
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
PrintEval() {
	eval echo "\${$1}"
}
RemoveBlank() {
	sed "s|^ *||g; s| *$||g; s|^	*||g; s|	*$||g; /^$/d"
}
GetMaxWidth() {
	awk '{ if ( length > x && length > 0 ) { x = length } }END{ print x }'
}
RandomString() {
	base64 <"/dev/random" | fold -w "$1" | head -n 1
	return 0
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
GetLastSplitString() {
	rev <<<"$2" | cut -d "$1" -f 1 | rev
}
CutLastString() {
	echo "${1%%"${2}"}"
	return 0
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
ToArgs() {
	readarray -t args
	"$@" "${args[@]}"
}
cache.get_file_last_update() {
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
cache.exist() {
	local _File
	_File="$(cache.create_dir)/$1"
	[[ -e $_File ]] || return 1
	(("$(cache.get_time_diff_from_last_update "$_File")" > "${KEEPCACHESEC-"86400"}")) && return 2
	return 0
}
cache.get_time_diff_from_last_update() {
	local _Now _Last
	_Now="$(date "+%s")"
	_Last="$(cache.get_file_last_update "$1")"
	echo "$((_Now - _Last))"
	return 0
}
cache.get_id() {
	if [[ -z ${FSBLIB_CACHEID-""} ]]; then
		cache.create_dir >/dev/null
	fi
	echo "$FSBLIB_CACHEID"
}
cache.get_dir() {
	echo "${TMPDIR-"/tmp"}/$(cache.get_id)"
}
cache.get() {
	cat "$(cache.get_dir)/$1" 2>/dev/null || return 1
}
cache.create() {
	cache.create_dir >/dev/null
	cat >"$(cache.get_dir)/${1}"
	cat "$(cache.get_dir)/$1"
}
cache.create_dir() {
	FSBLIB_CACHEID="${FSBLIB_CACHEID-"$(RandomString "10")"}"
	export FSBLIB_CACHEID="$FSBLIB_CACHEID"
	local TMPDIR="${TMPDIR-"/tmp"}"
	local _Dir="$TMPDIR/${FSBLIB_CACHEID}"
	mkdir -p "$_Dir"
	echo "$_Dir"
	return 0
}
fsblib.require_lib() {
	local lib missing=() return=0
	for lib in "$@"; do
		if ! [[ ${FSBLIB_LIBLIST[*]} == *" $lib "* ]]; then
			missing+=("$lib")
			return=1
		fi
	done
	return "$return"
}
fsblib_env_check() {
	fsblib.env_check
}
fsblib.env_check() {
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
csv.to_bash_array() {
	local _RawCsvLine=() _Line _ClmCnt=0
	local ArrayPrefix="${ArrayPrefix-"{}"}"
	readarray -t _RawCsvLine < <(
		while read -r _Line; do
			(($(tr "${CSVDELIM-","}" "\n" <<<"$_Line" | wc -l) >= ${#})) && echo "$_Line"
		done < <(grep -v "^#")
	)
	_ClmCnt=$(PrintArray "${_RawCsvLine[@]}" | csv.get_clm_cnt)
	while read -r _Cnt; do
		readarray -t "$(sed "s|{}|$(eval "echo \"\${${_Cnt}}\"")|g" <<<"$ArrayPrefix")" < <(
			PrintArray "${_RawCsvLine[@]}" | cut -d "${CSVDELIM-","}" -f "$_Cnt"
		)
	done < <(seq 1 "$#")
}
csv.get_clm() {
	grep -v "^#" | sed "/^$/d" | cut -d "${CSVDELIM-","}" -f "$1"
}
csv.get_clm_cnt() {
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
em.get_world_pkg_list() {
	sed -E 's|:.+$||g' /var/lib/portage/world | xargs -I{} bash -c 'ls -d /var/db/pkg/{}-* | sed "s|/var/db/pkg/||g" | grep -E "{}-[0-9]"'
}
em.get_repo_pkg_list() {
	local _RepoPath
	_RepoPath="$(em.get_repo_location "$1")"
	find "$_RepoPath" -mindepth 3 -maxdepth 3 -type f -name '*.ebuild' | sed -e "s|${_RepoPath%/}/||g" -e 's|.ebuild$||g' | awk -F "/" '{print $1"/"$3}'
}
em.get_all_pkg_list() {
	em.get_repo_conf | sed -e 's/^ *//' -e 's/ *$//' | grep "^ *location *=" | sed -e 's/^location *= *//' | xargs -L1 realpath | xargs -I{} bash -c "find '{}' -mindepth 3 -maxdepth 3 -type f -name '*.ebuild' | sed -e 's|{}/||g' -e 's|.ebuild$||g'" | awk -F "/" '{print $1"/"$3}'
}
em.get_installed_pkg_list() {
	find /var/db/pkg/ -mindepth 2 -maxdepth 2 -type d | sed 's|/var/db/pkg/||g'
}
em.get_repo_location() {
	em.get_repo_conf | Ini.GetParam "$1" location
}
em.get_repo_conf() {
	cat /etc/portage/repos.conf /etc/portage/repos.conf/* 2>/dev/null
}
em.get_default_repo_name() {
	em.get_repo_conf | Ini.GetParam DEFAULT main-repo
}
em.no_version() {
	sed -E 's|\-[0-9]+.+||g'
}
esc.clear_screen() {
	printf "\033[2J" >/dev/tty
}
esc.return() {
	printf "\r" >/dev/tty
}
esc.clear_left() {
	printf "\033[1K" >/dev/tty
}
esc.clear_line() {
	printf "\033[2K" >/dev/tty
}
esc.clear_right() {
	printf "\033[0K" >/dev/tty
}
esc.get_y() {
	local _POS
	printf "\033[6n" >>/dev/tty
	read -r -s -d "R" _POS
	echo $(("$(printf "%s\n" "${_POS:2}" | cut -d";" -f1)" - 1))
}
esc.get_x() {
	local _POS
	printf "\033[6n" >>/dev/tty
	read -r -s -d "R" _POS
	echo $(("$(printf "%s\n" "${_POS:2}" | cut -d";" -f2)" - 1))
}
esc.get_term_x() {
	[[ -n ${COLUMNS-""} ]] && echo "$COLUMNS" && return 0
	tput cols
}
esc.move_cursor() {
	printf "\033[%d;%dH" "$1" "$2" >/dev/tty
}
esc.move_cursor_up() {
	printf "\033[%dA" "$1" >/dev/tty
}
esc.move_cursor_left() {
	printf "\033[%dD" "$1" >/dev/tty
}
esc.move_cursor_down() {
	printf "\033[%dB" "$1" >/dev/tty
}
esc.move_cursor_right() {
	printf "\033[%dC" "$1" >/dev/tty
}
esc.get_term_y() {
	[[ -n ${LINES-""} ]] && echo "$LINES" && return 0
	tput lines
}
esc.clear_line_and_return() {
	esc.clear_line
	esc.return
}
esc.clear_upper_lines() {
	for i in $(seq 1 "$1"); do
		esc.move_cursor_up 1
		esc.clear_line
	done
}
esc.italic() {
	printf "\033[3m" >/dev/tty
}
esc.green_background() {
	printf "\033[42m" >/dev/tty
}
esc.black_background() {
	printf "\033[40m" >/dev/tty
}
esc.blue_text() {
	printf "\033[34m" >/dev/tty
}
esc.underline() {
	printf "\033[4m" >/dev/tty
}
esc.white_text() {
	printf "\033[37m" >/dev/tty
}
esc.magenta_background() {
	printf "\033[45m" >/dev/tty
}
esc.cyan_background() {
	printf "\033[46m" >/dev/tty
}
esc.magenta_text() {
	printf "\033[35m" >/dev/tty
}
esc.yellow_text() {
	printf "\033[33m" >/dev/tty
}
esc.green_text() {
	printf "\033[32m" >/dev/tty
}
esc.white_background() {
	printf "\033[47m" >/dev/tty
}
esc.low_intensity() {
	printf "\033[2m" >/dev/tty
}
esc.yellow_background() {
	printf "\033[43m" >/dev/tty
}
esc.red_background() {
	printf "\033[41m" >/dev/tty
}
esc.reset_style() {
	printf "\033[0m" >/dev/tty
}
esc.rapid_blink() {
	printf "\033[6m" >/dev/tty
}
esc.reverse() {
	printf "\033[7m" >/dev/tty
}
esc.conceal() {
	printf "\033[8m" >/dev/tty
}
esc.blue_background() {
	printf "\033[44m" >/dev/tty
}
esc.cyan_text() {
	printf "\033[36m" >/dev/tty
}
esc.bold() {
	printf "\033[1m" >/dev/tty
}
esc.red_text() {
	printf "\033[31m" >/dev/tty
}
esc.crossed_out() {
	printf "\033[9m" >/dev/tty
}
esc.blink() {
	printf "\033[5m" >/dev/tty
}
esc.black_text() {
	printf "\033[30m" >/dev/tty
}
ini.get_last_param() {
	ini.get_param_list "$1" | tail -n 1
}
ini.get_section_list() {
	local _RawIniLine=()
	local _Line _LineNo=1 _Exit=0
	readarray -t _RawIniLine
	while read -r _Line; do
		ini.parse_line <<<"$_Line"
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
ini.get_param_list() {
	local _RawIniLine=()
	local _Line _LineNo=1 _Exit=0 _InSection=false
	readarray -t _RawIniLine
	while read -r _Line; do
		ini.parse_line <<<"$_Line"
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
ini.get_param() {
	local _RawIniLine=()
	local _Line _LineNo=1 _Exit=0 _InSection=false
	readarray -t _RawIniLine
	while read -r _Line; do
		ini.parse_line <<<"$_Line"
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
ini.parse_line() {
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
ini.new_param() {
	local IniContents=() Line
	local Section="$1" Param="$2"
	local InSection=false LineNo=0
	local NewIniContents=()
	readarray -t IniContents
	local BeforeParam
	local SectionLastParam
	local ParamAdded=false
	if ! PrintArray "${IniContents[@]}" | ini.get_param_list "$Section" | grep -qx "$Param"; then
		SectionLastParam="$(PrintEvalArray IniContents | ini.get_last_param "$Section")"
		for Line in "${IniContents[@]}"; do
			LineNo=$((LineNo + 1))
			ini.parse_line <<<"$Line"
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
ini.new_section() {
	local IniContents=()
	local Section="$1"
	readarray -t IniContents
	if PrintArray "${IniContents[@]}" | ini.get_section_list | grep -x "$Section" >/dev/null; then
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
ini.set_value() {
	local IniContents=()
	local Section="$1" Param="$2"
	readarray -t IniContents
	readarray -t IniContents < <(PrintArray "${IniContents[@]}" | ini.new_section "$Section" | ini.new_param "$Section" "$Param")
	PrintEvalArray IniContents
}
libretranslate.check() {
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
libretranslate.translate() {
	libretranslate.check || return 2
	__libre_translate_return="$(curl -s "$LIBRETRANSLATE_URL/translate" -X POST -d "q=${1:-""}&source=${2:-""}&target=${3:-""}&api_key=${LIBRETRANSLATE_APIKEY:-""}")"
	if [ "$(echo "${__libre_translate_return}" | jq -r '.error')" = "null" ]; then
		echo "${__libre_translate_return}" | jq -r '.translatedText'
		return 0
	else
		echo "${__libre_translate_return}" | jq -r '.error'
		return 1
	fi
}
libretranslate.detect() {
	libretranslate.check || return 2
	__libre_translate_return="$(curl -s "${LIBRETRANSLATE_URL}/detect" -X POST -d "q=${1:-""}&api_key=${LIBRETRANSLATE_APIKEY:-""}")"
	if [ "$(echo "${__libre_translate_return}" | jq -r '.[].error')" = "null" ]; then
		echo "${__libre_translate_return}" | jq -r '.[].language'
		return 0
	else
		echo "${__libre_translate_return}" | jq -r '.error'
		return 1
	fi
}
libretranslate.translate_auto() {
	libretranslate.check || return 2
	libretranslate.translate "${1:-""}" "$(libretranslate.detect "${1:-""}")" "${2:-""}"
}
libretranslate.languages() {
	libretranslate.check || return 2
	curl -s "${LIBRETRANSLATE_URL}/languages" | jq -r '.[].code'
}
msg.warn() {
	msg.common " Warn:" "${*}" stderr
}
msg.err() {
	msg.common "Error:" "${*}" stderr
}
msg.common() {
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
msg.debug() {
	msg.common "Debug:" "${*}" stderr
}
msg.info() {
	msg.common " Info:" "${*}" stdout
}
misskey.notes.renotes() {
	misskey.binding_base "notes/renotes" noteId limit sinceId untilId -- "$@"
}
misskey.notes.search() {
	misskey.binding_base "notes/search" query limit -- "$@"
}
misskey.notes.create() {
	misskey.binding_base "notes/create" text -- "$@"
}
misskey.users.show() {
	misskey.binding_base "users/show" userId -- "${1:-"$(misskey.my_id)"}" "${@:2}"
}
misskey.users.stats() {
	misskey.binding_base "users/stats" userId -- "${1:-"$(misskey.my_id)"}" "${@:2}"
}
misskey.users.get_frequently_replied_users() {
	misskey.binding_base "users/get-frequently-replied-users" userId -- "${1:-"$(misskey.my_id)"}" "${@:2}"
}
misskey.users.search_by_username_and_host() {
	misskey.binding_base "users/search-by-username-and-host" username -- "${1:-"$(misskey.my_user_name)"}" "${@:2}"
}
misskey.users.notes() {
	misskey.binding_base "users/notes" userId -- "${1:-"$(misskey.my_id)"}" "${@:2}"
}
misskey.users.pages() {
	misskey.binding_base "users/pages" userId -- "${1:-"$(misskey.my_id)"}" "${@:2}"
}
misskey.admin.server_info() {
	misskey.binding_base "/admin/server-info" -- "$@"
}
misskey.setup() {
	export MISSKEY_DOMAIN="${1-"${MISSKEY_DOMAIN-""}"}"
	export MISSKEY_TOKEN="${2-"${MISSKEY_TOKEN-""}"}"
	export MISSKEY_ENTRY="https://${MISSKEY_DOMAIN}/api"
}
misskey.i() {
	misskey.binding_base "/i" -- "$@"
}
misskey.server_info() {
	misskey.binding_base "/server-info" -- "$@"
}
misskey.meta() {
	misskey.binding_base "/meta" -- "$@"
}
misskey.binding_base() {
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
		misskey.setup "${MISSKEY_DOMAIN}" "$MISSKEY_TOKEN"
	fi
	misskey.send_req "${MISSKEY_ENTRY%/}/${_API#/}" "${_Args[@]}" "$@"
}
misskey.send_req() {
	local _Url="$1" _CurlArgs=()
	shift 1
	_CurlArgs+=(-s -L)
	_CurlArgs+=(-X POST)
	_CurlArgs+=(-H "Content-Type: application/json")
	_CurlArgs+=(-d "$(misskey.make_json "$@")")
	_CurlArgs+=("$_Url")
	Msg.Debug "Run: ${_CurlArgs[*]//"${MISSKEY_TOKEN}"/"TOKEN"}"
	curl "${_CurlArgs[@]}"
}
misskey.make_json() {
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
misskey.is_admin() {
	Bool "$(misskey.i | jq -r ".isAdmin")"
}
misskey.my_name() {
	misskey.i | jq -r ".name"
}
misskey.my_user_name() {
	misskey.i | jq -r ".username"
}
misskey.my_id() {
	misskey.i | jq -r ".id"
}
pm.check_pkg() {
	local p
	for p in "$@"; do
		pm.run -Qq "$p" >/dev/null 2>&1 || return 1
	done
	return 0
}
pm.get_latest_pkg_ver() {
	local _LANG="${LANG-""}"
	export LANG=C
	if [[ -z ${*} ]]; then
		cat
	else
		PrintArray "$@"
	fi | ForEach pm.run -Si "{}" | grep "^Version" | cut -d ":" -f 2 | RemoveBlank
	[[ -n $_LANG ]] && export LANG="$_LANG"
	return 0
}
pm.get_repo_list_from_conf() {
	pm.get_config --repo-list
}
pm.get_pacman_keyring_dir() {
	local _KeyringDir=""
	_KeyringDir="$(LANG=C pacman-key -h | RemoveBlank | grep -A 1 -- "^--populate" | tail -n 1 | cut -d "/" -f 2- | sed "s|'$||g")"
	: "${_KeyringDir="usr/share/pacman/keyrings"}"
	_KeyringDir="$(pm.get_root)/$_KeyringDir"
	_KeyringDir="$(sed -E "s|/+|/|g" <<<"$_KeyringDir")"
	if [[ -e $_KeyringDir ]]; then
		Readlinkf "$_KeyringDir"
	else
		echo "$_KeyringDir"
	fi
}
pm.get_repo_pkg_list() {
	pm.run -Slq "$@"
}
pm.get_repo_ver() {
	pm.run -Sp --print-format '%v' "$1"
}
pm.get_repo_server() {
	ForEach eval 'pm.get_config -r {}' | grep "^Server" | ForEach eval "Ini.ParseLine <<< '{}' ; printf '%s\n' \${VALUE}"
}
pm.is_repo_pkg() {
	pm.run -Slq | grep -qx "$(pm.get_name <<<"$1")"
}
pm.get_repo_conf() {
	ForEach eval 'echo [{}] && pm.get_config -r {}'
}
pm.get_root() {
	pm.get_config RootDir
}
pm.get_name() {
	cut -d "<" -f 1 | cut -d ">" -f 1 | cut -d "=" -f 1
}
pm.pacman_gpg() {
	gpg --homedir "$(pm.get_config GPGDir)" "$@"
}
pm.get_pacman_kernel_pkg() {
	echo "there is nothing"
}
pm.get_keyring_list() {
	find "$(@GetKeyringDir)" -name "*.gpg" | GetBaseName | RemoveFileExt
}
pm.get_installed_pkg_ver() {
	if [[ -z ${*} ]]; then
		cat
	else
		PrintArray "$@"
	fi | ForEach pacman -Q "{}" | cut -d " " -f 2
	PrintArray "${PIPESTATUS[@]}" | grep -qx "1" && return 1
	return 0
}
pm.run_key() {
	pacman-key --config "${PACMAN_CONF-"/etc/pacman.conf"}" "$@"
}
pm.run() {
	pacman --noconfirm --config "${PACMAN_CONF-"/etc/pacman.conf"}" "$@"
}
pm.get_config() {
	LANG=C pacman-conf --config="${PACMAN_CONF-"/etc/pacman.conf"}" "$@"
}
pm.get_db_section_list() {
	grep -E "^%.*%$"
}
pm.get_db_next_section() {
	pm.get_db_section_list | grep -x -A 1 "^%$1%$" | GetLine 2 | sed "s|^%||g; s|%$||g"
}
pm.get_db_section() {
	readarray -t _Stdin
	PrintArray "${_Stdin[@]}" | sed -ne "/^%$1%$/,/^%$(PrintEvalArray _Stdin | pm.get_db_next_section "$1")%$/p" | sed '1d; $d'
}
pm.opened_sync_db_list() {
	find "$(pm.get_db_tmp_dir)/sync/" -mindepth 1 -maxdepth 1 -type d
}
pm.create_db_tmp_dir() {
	mkdir -p "$(pm.get_db_tmp_dir)"
}
pm.get_sync_all_desc() {
	find "$(pm.get_db_tmp_dir)" -mindepth 3 -maxdepth 3 -name "desc" -type f
}
pm.is_opend_sync_db() {
	readarray -t _PkgDbList < <(find "$(pm.get_db_tmp_dir)/sync/$1" -mindepth 1 -maxdepth 1 -type d)
	(("${#_PkgDbList[@]}" > 0)) && return 0
	return 1
}
pm.get_virtual_pkg_list() {
	pm.get_repo_list_from_local_db | ForEach pm.open_sync_db {}
	pm.get_sync_all_desc | ForEach eval "pm.get_db_section PROVIDES < {}" | RemoveBlank
}
pm.get_db_tmp_dir() {
	echo "${TMPDIR-"/tmp"}/fasbashlib-pacman-db"
}
pm.get_sync_db_desc() {
	local _path
	_path="$(pm.get_sync_db_desc_path "$1")"
	[[ -e $_path ]] || return 1
	cat "$_path/desc"
}
pm.get_sync_db_desc_path() {
	local _repo
	_repo="$(pacman -Sp --print-format '%r' "$1")"
	{
		IsPacmanSyncDbOpend "$_repo" || OpenPacmanSyncDb "$_repo"
	} || return 1
	echo "$(pm.get_db_tmp_dir)/sync/$(pacman -Sp --print-format '%r/%n-%v' "$1")"
}
pm.parse_pkg_file_name() {
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
pm.get_repo_list_from_local_db() {
	find "$(pm.get_config DBPath)/sync" -mindepth 1 -maxdepth 1 -type f | GetBaseName | sed "s|.db$||g"
	return 0
}
pm.open_sync_db() {
	local _Dir _RepoDb
	pm.create_db_tmp_dir
	_Dir="$(pm.get_db_tmp_dir)/sync/$1"
	mkdir -p "$_Dir"
	_RepoDb="$(pm.get_config DBPath)/sync/$1.db"
	[[ -e $_RepoDb ]] || return 1
	tar -xzf "${_RepoDb}" -C "$_Dir" || return 1
}
pm.get_pkg_arch() {
	pm.get_sync_db_desc "$1" | pm.get_db_section ARCH | RemoveBlank
}
pm.delete_db_tmp_dir() {
	rm -rf "$(pm.get_db_tmp_dir)"
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
arch.get_mkinitcpio_preset_list() {
	find "/etc/mkinitcpio.d/" -name "*.preset" -type f | GetBaseName | RemoveFileExt
}
arch.get_kernel_src_list() {
	find "/usr/src" -mindepth 1 -maxdepth 1 -type l -name "linux*"
}
arch.get_kernel_file_list() {
	find "/boot" -maxdepth 1 -mindepth 1 -name "vmlinuz-*"
}
array.append() {
	local _ArrName="$1"
	shift 1 || return 1
	readarray -t -O "$(ArrayIndex "$_ArrName")" "$_ArrName" < <(cat)
}
array.shift() {
	readarray -t "$1" < <(PrintEvalArray "$1" | sed "1,${2-"1"}d")
}
array.push() {
	eval "PrintArray \"\${$1[@]}\"" | grep -qx "$2" && return 0
	eval "$1+=(\"$2\")"
}
array.from_str() {
	declare -a -x "$1"
	readarray -t "$1" < <(BreakChar)
}
array.pop() {
	readarray -t "$1" < <(PrintEvalArray "$1" | sed -e '$d')
}
array.rev() {
	readarray -t "$1" < <(PrintEvalArray "$1" | tac)
}
array.remove() {
	readarray -t "$1" < <(PrintEvalArray "$1" | RemoveMatchLine "$2")
}
array.print() {
	(($# >= 1)) || return 0
	printf "%s\n" "${@}"
}
array.last() {
	PrintEval "$1[$(array.last_index "$1")]"
}
array.eval() {
	eval "PrintArray \"\${$1[@]}\""
}
array.length() {
	PrintEval "#${1}[@]"
}
array.index_of() {
	local n=()
	readarray -t n < <(grep -x -n "$1" | cut -d ":" -f 1 | ForEach eval echo '$(( {} - 1 ))')
	(("${#n[@]}" >= 1)) || return 1
	PrintArray "${n[@]}"
	return 0
}
array.last_index() {
	CalcInt "$(array.length "$1")" - 1
}
array.includes() {
	PrintEvalArray "$1" | grep -qx "$2"
}
array.for_each() {
	PrintEvalArray "$1" | ForEach "${@:2}"
}
array.include() {
	array.includes "$@"
}
awk.cos() {
	awk.float "cos($*)"
}
awk.tan() {
	awk.float "sin($1)/tan($1)"
}
awk.sin() {
	awk.float "sin($*)"
}
awk.pi() {
	awk.float "atan2(0, -0)"
}
awk.print() {
	awk "BEGIN {print $*}"
}
awk.log() {
	awk.float "log(${2}) / log($1)"
}
awk.rad() {
	awk.float "$1 * $(awk.pi) / 180 "
}
awk.float() {
	awk "BEGIN {printf (\"%4.${AWKSCALE-"5"}f\n\", $*)}"
}
PrintEvalArray() {
	Array.Eval "$1"
}
ArrayAppend() {
	Array.Append "$1"
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
StrToCharList() {
	Array.FromStr "$1"
}
GetArrayIndex() {
	Array.IndexOf "$1"
}
ArrayIndex() {
	Array.Length "$1"
}
AddNewToArray() {
	Array.Push "$@"
}
FileType() {
	file --mime-type -b "$1"
}
RemoveFileExt() {
	local Ext
	ForEach eval 'Ext=$(GetFileExt <<< {}); sed "s|.$Ext$||g" <<< {}; unset Ext'
}
GetFileExt() {
	GetBaseName | rev | cut -d "." -f 1 | rev
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
ToLower() {
	local _Str="${1,,}"
	[[ -z ${_Str-""} ]] || echo "${_Str}"
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
PrintEval() {
	eval echo "\${$1}"
}
RemoveBlank() {
	sed "s|^ *||g; s| *$||g; s|^	*||g; s|	*$||g; /^$/d"
}
GetMaxWidth() {
	awk '{ if ( length > x && length > 0 ) { x = length } }END{ print x }'
}
RandomString() {
	base64 <"/dev/random" | fold -w "$1" | head -n 1
	return 0
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
GetLastSplitString() {
	rev <<<"$2" | cut -d "$1" -f 1 | rev
}
CutLastString() {
	echo "${1%%"${2}"}"
	return 0
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
ToArgs() {
	readarray -t args
	"$@" "${args[@]}"
}
cache.get_file_last_update() {
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
cache.exist() {
	local _File
	_File="$(cache.create_dir)/$1"
	[[ -e $_File ]] || return 1
	(("$(cache.get_time_diff_from_last_update "$_File")" > "${KEEPCACHESEC-"86400"}")) && return 2
	return 0
}
cache.get_time_diff_from_last_update() {
	local _Now _Last
	_Now="$(date "+%s")"
	_Last="$(cache.get_file_last_update "$1")"
	echo "$((_Now - _Last))"
	return 0
}
cache.get_id() {
	if [[ -z ${FSBLIB_CACHEID-""} ]]; then
		cache.create_dir >/dev/null
	fi
	echo "$FSBLIB_CACHEID"
}
cache.get_dir() {
	echo "${TMPDIR-"/tmp"}/$(cache.get_id)"
}
cache.get() {
	cat "$(cache.get_dir)/$1" 2>/dev/null || return 1
}
cache.create() {
	cache.create_dir >/dev/null
	cat >"$(cache.get_dir)/${1}"
	cat "$(cache.get_dir)/$1"
}
cache.create_dir() {
	FSBLIB_CACHEID="${FSBLIB_CACHEID-"$(RandomString "10")"}"
	export FSBLIB_CACHEID="$FSBLIB_CACHEID"
	local TMPDIR="${TMPDIR-"/tmp"}"
	local _Dir="$TMPDIR/${FSBLIB_CACHEID}"
	mkdir -p "$_Dir"
	echo "$_Dir"
	return 0
}
fsblib.require_lib() {
	local lib missing=() return=0
	for lib in "$@"; do
		if ! [[ ${FSBLIB_LIBLIST[*]} == *" $lib "* ]]; then
			missing+=("$lib")
			return=1
		fi
	done
	return "$return"
}
fsblib_env_check() {
	fsblib.env_check
}
fsblib.env_check() {
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
csv.to_bash_array() {
	local _RawCsvLine=() _Line _ClmCnt=0
	local ArrayPrefix="${ArrayPrefix-"{}"}"
	readarray -t _RawCsvLine < <(
		while read -r _Line; do
			(($(tr "${CSVDELIM-","}" "\n" <<<"$_Line" | wc -l) >= ${#})) && echo "$_Line"
		done < <(grep -v "^#")
	)
	_ClmCnt=$(PrintArray "${_RawCsvLine[@]}" | csv.get_clm_cnt)
	while read -r _Cnt; do
		readarray -t "$(sed "s|{}|$(eval "echo \"\${${_Cnt}}\"")|g" <<<"$ArrayPrefix")" < <(
			PrintArray "${_RawCsvLine[@]}" | cut -d "${CSVDELIM-","}" -f "$_Cnt"
		)
	done < <(seq 1 "$#")
}
csv.get_clm() {
	grep -v "^#" | sed "/^$/d" | cut -d "${CSVDELIM-","}" -f "$1"
}
csv.get_clm_cnt() {
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
em.get_world_pkg_list() {
	sed -E 's|:.+$||g' /var/lib/portage/world | xargs -I{} bash -c 'ls -d /var/db/pkg/{}-* | sed "s|/var/db/pkg/||g" | grep -E "{}-[0-9]"'
}
em.get_repo_pkg_list() {
	local _RepoPath
	_RepoPath="$(em.get_repo_location "$1")"
	find "$_RepoPath" -mindepth 3 -maxdepth 3 -type f -name '*.ebuild' | sed -e "s|${_RepoPath%/}/||g" -e 's|.ebuild$||g' | awk -F "/" '{print $1"/"$3}'
}
em.get_all_pkg_list() {
	em.get_repo_conf | sed -e 's/^ *//' -e 's/ *$//' | grep "^ *location *=" | sed -e 's/^location *= *//' | xargs -L1 realpath | xargs -I{} bash -c "find '{}' -mindepth 3 -maxdepth 3 -type f -name '*.ebuild' | sed -e 's|{}/||g' -e 's|.ebuild$||g'" | awk -F "/" '{print $1"/"$3}'
}
em.get_installed_pkg_list() {
	find /var/db/pkg/ -mindepth 2 -maxdepth 2 -type d | sed 's|/var/db/pkg/||g'
}
em.get_repo_location() {
	em.get_repo_conf | Ini.GetParam "$1" location
}
em.get_repo_conf() {
	cat /etc/portage/repos.conf /etc/portage/repos.conf/* 2>/dev/null
}
em.get_default_repo_name() {
	em.get_repo_conf | Ini.GetParam DEFAULT main-repo
}
em.no_version() {
	sed -E 's|\-[0-9]+.+||g'
}
esc.clear_screen() {
	printf "\033[2J" >/dev/tty
}
esc.return() {
	printf "\r" >/dev/tty
}
esc.clear_left() {
	printf "\033[1K" >/dev/tty
}
esc.clear_line() {
	printf "\033[2K" >/dev/tty
}
esc.clear_right() {
	printf "\033[0K" >/dev/tty
}
esc.get_y() {
	local _POS
	printf "\033[6n" >>/dev/tty
	read -r -s -d "R" _POS
	echo $(("$(printf "%s\n" "${_POS:2}" | cut -d";" -f1)" - 1))
}
esc.get_x() {
	local _POS
	printf "\033[6n" >>/dev/tty
	read -r -s -d "R" _POS
	echo $(("$(printf "%s\n" "${_POS:2}" | cut -d";" -f2)" - 1))
}
esc.get_term_x() {
	[[ -n ${COLUMNS-""} ]] && echo "$COLUMNS" && return 0
	tput cols
}
esc.move_cursor() {
	printf "\033[%d;%dH" "$1" "$2" >/dev/tty
}
esc.move_cursor_up() {
	printf "\033[%dA" "$1" >/dev/tty
}
esc.move_cursor_left() {
	printf "\033[%dD" "$1" >/dev/tty
}
esc.move_cursor_down() {
	printf "\033[%dB" "$1" >/dev/tty
}
esc.move_cursor_right() {
	printf "\033[%dC" "$1" >/dev/tty
}
esc.get_term_y() {
	[[ -n ${LINES-""} ]] && echo "$LINES" && return 0
	tput lines
}
esc.clear_line_and_return() {
	esc.clear_line
	esc.return
}
esc.clear_upper_lines() {
	for i in $(seq 1 "$1"); do
		esc.move_cursor_up 1
		esc.clear_line
	done
}
esc.italic() {
	printf "\033[3m" >/dev/tty
}
esc.green_background() {
	printf "\033[42m" >/dev/tty
}
esc.black_background() {
	printf "\033[40m" >/dev/tty
}
esc.blue_text() {
	printf "\033[34m" >/dev/tty
}
esc.underline() {
	printf "\033[4m" >/dev/tty
}
esc.white_text() {
	printf "\033[37m" >/dev/tty
}
esc.magenta_background() {
	printf "\033[45m" >/dev/tty
}
esc.cyan_background() {
	printf "\033[46m" >/dev/tty
}
esc.magenta_text() {
	printf "\033[35m" >/dev/tty
}
esc.yellow_text() {
	printf "\033[33m" >/dev/tty
}
esc.green_text() {
	printf "\033[32m" >/dev/tty
}
esc.white_background() {
	printf "\033[47m" >/dev/tty
}
esc.low_intensity() {
	printf "\033[2m" >/dev/tty
}
esc.yellow_background() {
	printf "\033[43m" >/dev/tty
}
esc.red_background() {
	printf "\033[41m" >/dev/tty
}
esc.reset_style() {
	printf "\033[0m" >/dev/tty
}
esc.rapid_blink() {
	printf "\033[6m" >/dev/tty
}
esc.reverse() {
	printf "\033[7m" >/dev/tty
}
esc.conceal() {
	printf "\033[8m" >/dev/tty
}
esc.blue_background() {
	printf "\033[44m" >/dev/tty
}
esc.cyan_text() {
	printf "\033[36m" >/dev/tty
}
esc.bold() {
	printf "\033[1m" >/dev/tty
}
esc.red_text() {
	printf "\033[31m" >/dev/tty
}
esc.crossed_out() {
	printf "\033[9m" >/dev/tty
}
esc.blink() {
	printf "\033[5m" >/dev/tty
}
esc.black_text() {
	printf "\033[30m" >/dev/tty
}
ini.get_last_param() {
	ini.get_param_list "$1" | tail -n 1
}
ini.get_section_list() {
	local _RawIniLine=()
	local _Line _LineNo=1 _Exit=0
	readarray -t _RawIniLine
	while read -r _Line; do
		ini.parse_line <<<"$_Line"
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
ini.get_param_list() {
	local _RawIniLine=()
	local _Line _LineNo=1 _Exit=0 _InSection=false
	readarray -t _RawIniLine
	while read -r _Line; do
		ini.parse_line <<<"$_Line"
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
ini.get_param() {
	local _RawIniLine=()
	local _Line _LineNo=1 _Exit=0 _InSection=false
	readarray -t _RawIniLine
	while read -r _Line; do
		ini.parse_line <<<"$_Line"
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
ini.parse_line() {
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
ini.new_param() {
	local IniContents=() Line
	local Section="$1" Param="$2"
	local InSection=false LineNo=0
	local NewIniContents=()
	readarray -t IniContents
	local BeforeParam
	local SectionLastParam
	local ParamAdded=false
	if ! PrintArray "${IniContents[@]}" | ini.get_param_list "$Section" | grep -qx "$Param"; then
		SectionLastParam="$(PrintEvalArray IniContents | ini.get_last_param "$Section")"
		for Line in "${IniContents[@]}"; do
			LineNo=$((LineNo + 1))
			ini.parse_line <<<"$Line"
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
ini.new_section() {
	local IniContents=()
	local Section="$1"
	readarray -t IniContents
	if PrintArray "${IniContents[@]}" | ini.get_section_list | grep -x "$Section" >/dev/null; then
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
ini.set_value() {
	local IniContents=()
	local Section="$1" Param="$2"
	readarray -t IniContents
	readarray -t IniContents < <(PrintArray "${IniContents[@]}" | ini.new_section "$Section" | ini.new_param "$Section" "$Param")
	PrintEvalArray IniContents
}
libretranslate.check() {
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
libretranslate.translate() {
	libretranslate.check || return 2
	__libre_translate_return="$(curl -s "$LIBRETRANSLATE_URL/translate" -X POST -d "q=${1:-""}&source=${2:-""}&target=${3:-""}&api_key=${LIBRETRANSLATE_APIKEY:-""}")"
	if [ "$(echo "${__libre_translate_return}" | jq -r '.error')" = "null" ]; then
		echo "${__libre_translate_return}" | jq -r '.translatedText'
		return 0
	else
		echo "${__libre_translate_return}" | jq -r '.error'
		return 1
	fi
}
libretranslate.detect() {
	libretranslate.check || return 2
	__libre_translate_return="$(curl -s "${LIBRETRANSLATE_URL}/detect" -X POST -d "q=${1:-""}&api_key=${LIBRETRANSLATE_APIKEY:-""}")"
	if [ "$(echo "${__libre_translate_return}" | jq -r '.[].error')" = "null" ]; then
		echo "${__libre_translate_return}" | jq -r '.[].language'
		return 0
	else
		echo "${__libre_translate_return}" | jq -r '.error'
		return 1
	fi
}
libretranslate.translate_auto() {
	libretranslate.check || return 2
	libretranslate.translate "${1:-""}" "$(libretranslate.detect "${1:-""}")" "${2:-""}"
}
libretranslate.languages() {
	libretranslate.check || return 2
	curl -s "${LIBRETRANSLATE_URL}/languages" | jq -r '.[].code'
}
msg.warn() {
	msg.common " Warn:" "${*}" stderr
}
msg.err() {
	msg.common "Error:" "${*}" stderr
}
msg.common() {
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
msg.debug() {
	msg.common "Debug:" "${*}" stderr
}
msg.info() {
	msg.common " Info:" "${*}" stdout
}
misskey.notes.renotes() {
	misskey.binding_base "notes/renotes" noteId limit sinceId untilId -- "$@"
}
misskey.notes.search() {
	misskey.binding_base "notes/search" query limit -- "$@"
}
misskey.notes.create() {
	misskey.binding_base "notes/create" text -- "$@"
}
misskey.users.show() {
	misskey.binding_base "users/show" userId -- "${1:-"$(misskey.my_id)"}" "${@:2}"
}
misskey.users.stats() {
	misskey.binding_base "users/stats" userId -- "${1:-"$(misskey.my_id)"}" "${@:2}"
}
misskey.users.get_frequently_replied_users() {
	misskey.binding_base "users/get-frequently-replied-users" userId -- "${1:-"$(misskey.my_id)"}" "${@:2}"
}
misskey.users.search_by_username_and_host() {
	misskey.binding_base "users/search-by-username-and-host" username -- "${1:-"$(misskey.my_user_name)"}" "${@:2}"
}
misskey.users.notes() {
	misskey.binding_base "users/notes" userId -- "${1:-"$(misskey.my_id)"}" "${@:2}"
}
misskey.users.pages() {
	misskey.binding_base "users/pages" userId -- "${1:-"$(misskey.my_id)"}" "${@:2}"
}
misskey.admin.server_info() {
	misskey.binding_base "/admin/server-info" -- "$@"
}
misskey.setup() {
	export MISSKEY_DOMAIN="${1-"${MISSKEY_DOMAIN-""}"}"
	export MISSKEY_TOKEN="${2-"${MISSKEY_TOKEN-""}"}"
	export MISSKEY_ENTRY="https://${MISSKEY_DOMAIN}/api"
}
misskey.i() {
	misskey.binding_base "/i" -- "$@"
}
misskey.server_info() {
	misskey.binding_base "/server-info" -- "$@"
}
misskey.meta() {
	misskey.binding_base "/meta" -- "$@"
}
misskey.binding_base() {
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
		misskey.setup "${MISSKEY_DOMAIN}" "$MISSKEY_TOKEN"
	fi
	misskey.send_req "${MISSKEY_ENTRY%/}/${_API#/}" "${_Args[@]}" "$@"
}
misskey.send_req() {
	local _Url="$1" _CurlArgs=()
	shift 1
	_CurlArgs+=(-s -L)
	_CurlArgs+=(-X POST)
	_CurlArgs+=(-H "Content-Type: application/json")
	_CurlArgs+=(-d "$(misskey.make_json "$@")")
	_CurlArgs+=("$_Url")
	Msg.Debug "Run: ${_CurlArgs[*]//"${MISSKEY_TOKEN}"/"TOKEN"}"
	curl "${_CurlArgs[@]}"
}
misskey.make_json() {
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
misskey.is_admin() {
	Bool "$(misskey.i | jq -r ".isAdmin")"
}
misskey.my_name() {
	misskey.i | jq -r ".name"
}
misskey.my_user_name() {
	misskey.i | jq -r ".username"
}
misskey.my_id() {
	misskey.i | jq -r ".id"
}
pm.check_pkg() {
	local p
	for p in "$@"; do
		pm.run -Qq "$p" >/dev/null 2>&1 || return 1
	done
	return 0
}
pm.get_latest_pkg_ver() {
	local _LANG="${LANG-""}"
	export LANG=C
	if [[ -z ${*} ]]; then
		cat
	else
		PrintArray "$@"
	fi | ForEach pm.run -Si "{}" | grep "^Version" | cut -d ":" -f 2 | RemoveBlank
	[[ -n $_LANG ]] && export LANG="$_LANG"
	return 0
}
pm.get_repo_list_from_conf() {
	pm.get_config --repo-list
}
pm.get_pacman_keyring_dir() {
	local _KeyringDir=""
	_KeyringDir="$(LANG=C pacman-key -h | RemoveBlank | grep -A 1 -- "^--populate" | tail -n 1 | cut -d "/" -f 2- | sed "s|'$||g")"
	: "${_KeyringDir="usr/share/pacman/keyrings"}"
	_KeyringDir="$(pm.get_root)/$_KeyringDir"
	_KeyringDir="$(sed -E "s|/+|/|g" <<<"$_KeyringDir")"
	if [[ -e $_KeyringDir ]]; then
		Readlinkf "$_KeyringDir"
	else
		echo "$_KeyringDir"
	fi
}
pm.get_repo_pkg_list() {
	pm.run -Slq "$@"
}
pm.get_repo_ver() {
	pm.run -Sp --print-format '%v' "$1"
}
pm.get_repo_server() {
	ForEach eval 'pm.get_config -r {}' | grep "^Server" | ForEach eval "Ini.ParseLine <<< '{}' ; printf '%s\n' \${VALUE}"
}
pm.is_repo_pkg() {
	pm.run -Slq | grep -qx "$(pm.get_name <<<"$1")"
}
pm.get_repo_conf() {
	ForEach eval 'echo [{}] && pm.get_config -r {}'
}
pm.get_root() {
	pm.get_config RootDir
}
pm.get_name() {
	cut -d "<" -f 1 | cut -d ">" -f 1 | cut -d "=" -f 1
}
pm.pacman_gpg() {
	gpg --homedir "$(pm.get_config GPGDir)" "$@"
}
pm.get_pacman_kernel_pkg() {
	echo "there is nothing"
}
pm.get_keyring_list() {
	find "$(@GetKeyringDir)" -name "*.gpg" | GetBaseName | RemoveFileExt
}
pm.get_installed_pkg_ver() {
	if [[ -z ${*} ]]; then
		cat
	else
		PrintArray "$@"
	fi | ForEach pacman -Q "{}" | cut -d " " -f 2
	PrintArray "${PIPESTATUS[@]}" | grep -qx "1" && return 1
	return 0
}
pm.run_key() {
	pacman-key --config "${PACMAN_CONF-"/etc/pacman.conf"}" "$@"
}
pm.run() {
	pacman --noconfirm --config "${PACMAN_CONF-"/etc/pacman.conf"}" "$@"
}
pm.get_config() {
	LANG=C pacman-conf --config="${PACMAN_CONF-"/etc/pacman.conf"}" "$@"
}
pm.get_db_section_list() {
	grep -E "^%.*%$"
}
pm.get_db_next_section() {
	pm.get_db_section_list | grep -x -A 1 "^%$1%$" | GetLine 2 | sed "s|^%||g; s|%$||g"
}
pm.get_db_section() {
	readarray -t _Stdin
	PrintArray "${_Stdin[@]}" | sed -ne "/^%$1%$/,/^%$(PrintEvalArray _Stdin | pm.get_db_next_section "$1")%$/p" | sed '1d; $d'
}
pm.opened_sync_db_list() {
	find "$(pm.get_db_tmp_dir)/sync/" -mindepth 1 -maxdepth 1 -type d
}
pm.create_db_tmp_dir() {
	mkdir -p "$(pm.get_db_tmp_dir)"
}
pm.get_sync_all_desc() {
	find "$(pm.get_db_tmp_dir)" -mindepth 3 -maxdepth 3 -name "desc" -type f
}
pm.is_opend_sync_db() {
	readarray -t _PkgDbList < <(find "$(pm.get_db_tmp_dir)/sync/$1" -mindepth 1 -maxdepth 1 -type d)
	(("${#_PkgDbList[@]}" > 0)) && return 0
	return 1
}
pm.get_virtual_pkg_list() {
	pm.get_repo_list_from_local_db | ForEach pm.open_sync_db {}
	pm.get_sync_all_desc | ForEach eval "pm.get_db_section PROVIDES < {}" | RemoveBlank
}
pm.get_db_tmp_dir() {
	echo "${TMPDIR-"/tmp"}/fasbashlib-pacman-db"
}
pm.get_sync_db_desc() {
	local _path
	_path="$(pm.get_sync_db_desc_path "$1")"
	[[ -e $_path ]] || return 1
	cat "$_path/desc"
}
pm.get_sync_db_desc_path() {
	local _repo
	_repo="$(pacman -Sp --print-format '%r' "$1")"
	{
		IsPacmanSyncDbOpend "$_repo" || OpenPacmanSyncDb "$_repo"
	} || return 1
	echo "$(pm.get_db_tmp_dir)/sync/$(pacman -Sp --print-format '%r/%n-%v' "$1")"
}
pm.parse_pkg_file_name() {
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
pm.get_repo_list_from_local_db() {
	find "$(pm.get_config DBPath)/sync" -mindepth 1 -maxdepth 1 -type f | GetBaseName | sed "s|.db$||g"
	return 0
}
pm.open_sync_db() {
	local _Dir _RepoDb
	pm.create_db_tmp_dir
	_Dir="$(pm.get_db_tmp_dir)/sync/$1"
	mkdir -p "$_Dir"
	_RepoDb="$(pm.get_config DBPath)/sync/$1.db"
	[[ -e $_RepoDb ]] || return 1
	tar -xzf "${_RepoDb}" -C "$_Dir" || return 1
}
pm.get_pkg_arch() {
	pm.get_sync_db_desc "$1" | pm.get_db_section ARCH | RemoveBlank
}
pm.delete_db_tmp_dir() {
	rm -rf "$(pm.get_db_tmp_dir)"
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
prog.bar() {
	local Max="$1" Counter="$2" Size="${3-"100"}"
	local SharpCount=$((Counter * Size / Max))
	local SpaceCount=$((Size - SharpCount))
	Esc.Return
	echo -n "$Counter/$Max [$(yes "#" | head -n "$SharpCount" 2>/dev/null | tr -d "\n")$(yes " " | head -n "$SpaceCount" 2>/dev/null | tr -d "\n")]"
}
prog.wide_bar() {
	local Max="$1" Counter="$2"
	local StatusString="$Counter/$Max"
	local Size=$(($(Esc.GetTermX) - ${#StatusString} - 3))
	prog.bar "$Max" "$Counter" "$Size"
}
prog.rotation() {
	local Count="$1" CharList=('|' '/' '-' '\')
	Esc.ClearLineAndReturn
	[[ -n ${2-""} ]] && echo -n "${2}" 1>&2
	printf "%s" "${CharList["$((Count % "${#CharList[@]}"))"]}" 1>&2
}
arch.get_mkinitcpio_preset_list() {
	find "/etc/mkinitcpio.d/" -name "*.preset" -type f | GetBaseName | RemoveFileExt
}
arch.get_kernel_src_list() {
	find "/usr/src" -mindepth 1 -maxdepth 1 -type l -name "linux*"
}
arch.get_kernel_file_list() {
	find "/boot" -maxdepth 1 -mindepth 1 -name "vmlinuz-*"
}
array.append() {
	local _ArrName="$1"
	shift 1 || return 1
	readarray -t -O "$(ArrayIndex "$_ArrName")" "$_ArrName" < <(cat)
}
array.shift() {
	readarray -t "$1" < <(PrintEvalArray "$1" | sed "1,${2-"1"}d")
}
array.push() {
	eval "PrintArray \"\${$1[@]}\"" | grep -qx "$2" && return 0
	eval "$1+=(\"$2\")"
}
array.from_str() {
	declare -a -x "$1"
	readarray -t "$1" < <(BreakChar)
}
array.pop() {
	readarray -t "$1" < <(PrintEvalArray "$1" | sed -e '$d')
}
array.rev() {
	readarray -t "$1" < <(PrintEvalArray "$1" | tac)
}
array.remove() {
	readarray -t "$1" < <(PrintEvalArray "$1" | RemoveMatchLine "$2")
}
array.print() {
	(($# >= 1)) || return 0
	printf "%s\n" "${@}"
}
array.last() {
	PrintEval "$1[$(array.last_index "$1")]"
}
array.eval() {
	eval "PrintArray \"\${$1[@]}\""
}
array.length() {
	PrintEval "#${1}[@]"
}
array.index_of() {
	local n=()
	readarray -t n < <(grep -x -n "$1" | cut -d ":" -f 1 | ForEach eval echo '$(( {} - 1 ))')
	(("${#n[@]}" >= 1)) || return 1
	PrintArray "${n[@]}"
	return 0
}
array.last_index() {
	CalcInt "$(array.length "$1")" - 1
}
array.includes() {
	PrintEvalArray "$1" | grep -qx "$2"
}
array.for_each() {
	PrintEvalArray "$1" | ForEach "${@:2}"
}
array.include() {
	array.includes "$@"
}
awk.cos() {
	awk.float "cos($*)"
}
awk.tan() {
	awk.float "sin($1)/tan($1)"
}
awk.sin() {
	awk.float "sin($*)"
}
awk.pi() {
	awk.float "atan2(0, -0)"
}
awk.print() {
	awk "BEGIN {print $*}"
}
awk.log() {
	awk.float "log(${2}) / log($1)"
}
awk.rad() {
	awk.float "$1 * $(awk.pi) / 180 "
}
awk.float() {
	awk "BEGIN {printf (\"%4.${AWKSCALE-"5"}f\n\", $*)}"
}
PrintEvalArray() {
	Array.Eval "$1"
}
ArrayAppend() {
	Array.Append "$1"
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
StrToCharList() {
	Array.FromStr "$1"
}
GetArrayIndex() {
	Array.IndexOf "$1"
}
ArrayIndex() {
	Array.Length "$1"
}
AddNewToArray() {
	Array.Push "$@"
}
FileType() {
	file --mime-type -b "$1"
}
RemoveFileExt() {
	local Ext
	ForEach eval 'Ext=$(GetFileExt <<< {}); sed "s|.$Ext$||g" <<< {}; unset Ext'
}
GetFileExt() {
	GetBaseName | rev | cut -d "." -f 1 | rev
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
ToLower() {
	local _Str="${1,,}"
	[[ -z ${_Str-""} ]] || echo "${_Str}"
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
PrintEval() {
	eval echo "\${$1}"
}
RemoveBlank() {
	sed "s|^ *||g; s| *$||g; s|^	*||g; s|	*$||g; /^$/d"
}
GetMaxWidth() {
	awk '{ if ( length > x && length > 0 ) { x = length } }END{ print x }'
}
RandomString() {
	base64 <"/dev/random" | fold -w "$1" | head -n 1
	return 0
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
GetLastSplitString() {
	rev <<<"$2" | cut -d "$1" -f 1 | rev
}
CutLastString() {
	echo "${1%%"${2}"}"
	return 0
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
ToArgs() {
	readarray -t args
	"$@" "${args[@]}"
}
cache.get_file_last_update() {
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
cache.exist() {
	local _File
	_File="$(cache.create_dir)/$1"
	[[ -e $_File ]] || return 1
	(("$(cache.get_time_diff_from_last_update "$_File")" > "${KEEPCACHESEC-"86400"}")) && return 2
	return 0
}
cache.get_time_diff_from_last_update() {
	local _Now _Last
	_Now="$(date "+%s")"
	_Last="$(cache.get_file_last_update "$1")"
	echo "$((_Now - _Last))"
	return 0
}
cache.get_id() {
	if [[ -z ${FSBLIB_CACHEID-""} ]]; then
		cache.create_dir >/dev/null
	fi
	echo "$FSBLIB_CACHEID"
}
cache.get_dir() {
	echo "${TMPDIR-"/tmp"}/$(cache.get_id)"
}
cache.get() {
	cat "$(cache.get_dir)/$1" 2>/dev/null || return 1
}
cache.create() {
	cache.create_dir >/dev/null
	cat >"$(cache.get_dir)/${1}"
	cat "$(cache.get_dir)/$1"
}
cache.create_dir() {
	FSBLIB_CACHEID="${FSBLIB_CACHEID-"$(RandomString "10")"}"
	export FSBLIB_CACHEID="$FSBLIB_CACHEID"
	local TMPDIR="${TMPDIR-"/tmp"}"
	local _Dir="$TMPDIR/${FSBLIB_CACHEID}"
	mkdir -p "$_Dir"
	echo "$_Dir"
	return 0
}
fsblib.require_lib() {
	local lib missing=() return=0
	for lib in "$@"; do
		if ! [[ ${FSBLIB_LIBLIST[*]} == *" $lib "* ]]; then
			missing+=("$lib")
			return=1
		fi
	done
	return "$return"
}
fsblib_env_check() {
	fsblib.env_check
}
fsblib.env_check() {
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
csv.to_bash_array() {
	local _RawCsvLine=() _Line _ClmCnt=0
	local ArrayPrefix="${ArrayPrefix-"{}"}"
	readarray -t _RawCsvLine < <(
		while read -r _Line; do
			(($(tr "${CSVDELIM-","}" "\n" <<<"$_Line" | wc -l) >= ${#})) && echo "$_Line"
		done < <(grep -v "^#")
	)
	_ClmCnt=$(PrintArray "${_RawCsvLine[@]}" | csv.get_clm_cnt)
	while read -r _Cnt; do
		readarray -t "$(sed "s|{}|$(eval "echo \"\${${_Cnt}}\"")|g" <<<"$ArrayPrefix")" < <(
			PrintArray "${_RawCsvLine[@]}" | cut -d "${CSVDELIM-","}" -f "$_Cnt"
		)
	done < <(seq 1 "$#")
}
csv.get_clm() {
	grep -v "^#" | sed "/^$/d" | cut -d "${CSVDELIM-","}" -f "$1"
}
csv.get_clm_cnt() {
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
em.get_world_pkg_list() {
	sed -E 's|:.+$||g' /var/lib/portage/world | xargs -I{} bash -c 'ls -d /var/db/pkg/{}-* | sed "s|/var/db/pkg/||g" | grep -E "{}-[0-9]"'
}
em.get_repo_pkg_list() {
	local _RepoPath
	_RepoPath="$(em.get_repo_location "$1")"
	find "$_RepoPath" -mindepth 3 -maxdepth 3 -type f -name '*.ebuild' | sed -e "s|${_RepoPath%/}/||g" -e 's|.ebuild$||g' | awk -F "/" '{print $1"/"$3}'
}
em.get_all_pkg_list() {
	em.get_repo_conf | sed -e 's/^ *//' -e 's/ *$//' | grep "^ *location *=" | sed -e 's/^location *= *//' | xargs -L1 realpath | xargs -I{} bash -c "find '{}' -mindepth 3 -maxdepth 3 -type f -name '*.ebuild' | sed -e 's|{}/||g' -e 's|.ebuild$||g'" | awk -F "/" '{print $1"/"$3}'
}
em.get_installed_pkg_list() {
	find /var/db/pkg/ -mindepth 2 -maxdepth 2 -type d | sed 's|/var/db/pkg/||g'
}
em.get_repo_location() {
	em.get_repo_conf | Ini.GetParam "$1" location
}
em.get_repo_conf() {
	cat /etc/portage/repos.conf /etc/portage/repos.conf/* 2>/dev/null
}
em.get_default_repo_name() {
	em.get_repo_conf | Ini.GetParam DEFAULT main-repo
}
em.no_version() {
	sed -E 's|\-[0-9]+.+||g'
}
esc.clear_screen() {
	printf "\033[2J" >/dev/tty
}
esc.return() {
	printf "\r" >/dev/tty
}
esc.clear_left() {
	printf "\033[1K" >/dev/tty
}
esc.clear_line() {
	printf "\033[2K" >/dev/tty
}
esc.clear_right() {
	printf "\033[0K" >/dev/tty
}
esc.get_y() {
	local _POS
	printf "\033[6n" >>/dev/tty
	read -r -s -d "R" _POS
	echo $(("$(printf "%s\n" "${_POS:2}" | cut -d";" -f1)" - 1))
}
esc.get_x() {
	local _POS
	printf "\033[6n" >>/dev/tty
	read -r -s -d "R" _POS
	echo $(("$(printf "%s\n" "${_POS:2}" | cut -d";" -f2)" - 1))
}
esc.get_term_x() {
	[[ -n ${COLUMNS-""} ]] && echo "$COLUMNS" && return 0
	tput cols
}
esc.move_cursor() {
	printf "\033[%d;%dH" "$1" "$2" >/dev/tty
}
esc.move_cursor_up() {
	printf "\033[%dA" "$1" >/dev/tty
}
esc.move_cursor_left() {
	printf "\033[%dD" "$1" >/dev/tty
}
esc.move_cursor_down() {
	printf "\033[%dB" "$1" >/dev/tty
}
esc.move_cursor_right() {
	printf "\033[%dC" "$1" >/dev/tty
}
esc.get_term_y() {
	[[ -n ${LINES-""} ]] && echo "$LINES" && return 0
	tput lines
}
esc.clear_line_and_return() {
	esc.clear_line
	esc.return
}
esc.clear_upper_lines() {
	for i in $(seq 1 "$1"); do
		esc.move_cursor_up 1
		esc.clear_line
	done
}
esc.italic() {
	printf "\033[3m" >/dev/tty
}
esc.green_background() {
	printf "\033[42m" >/dev/tty
}
esc.black_background() {
	printf "\033[40m" >/dev/tty
}
esc.blue_text() {
	printf "\033[34m" >/dev/tty
}
esc.underline() {
	printf "\033[4m" >/dev/tty
}
esc.white_text() {
	printf "\033[37m" >/dev/tty
}
esc.magenta_background() {
	printf "\033[45m" >/dev/tty
}
esc.cyan_background() {
	printf "\033[46m" >/dev/tty
}
esc.magenta_text() {
	printf "\033[35m" >/dev/tty
}
esc.yellow_text() {
	printf "\033[33m" >/dev/tty
}
esc.green_text() {
	printf "\033[32m" >/dev/tty
}
esc.white_background() {
	printf "\033[47m" >/dev/tty
}
esc.low_intensity() {
	printf "\033[2m" >/dev/tty
}
esc.yellow_background() {
	printf "\033[43m" >/dev/tty
}
esc.red_background() {
	printf "\033[41m" >/dev/tty
}
esc.reset_style() {
	printf "\033[0m" >/dev/tty
}
esc.rapid_blink() {
	printf "\033[6m" >/dev/tty
}
esc.reverse() {
	printf "\033[7m" >/dev/tty
}
esc.conceal() {
	printf "\033[8m" >/dev/tty
}
esc.blue_background() {
	printf "\033[44m" >/dev/tty
}
esc.cyan_text() {
	printf "\033[36m" >/dev/tty
}
esc.bold() {
	printf "\033[1m" >/dev/tty
}
esc.red_text() {
	printf "\033[31m" >/dev/tty
}
esc.crossed_out() {
	printf "\033[9m" >/dev/tty
}
esc.blink() {
	printf "\033[5m" >/dev/tty
}
esc.black_text() {
	printf "\033[30m" >/dev/tty
}
ini.get_last_param() {
	ini.get_param_list "$1" | tail -n 1
}
ini.get_section_list() {
	local _RawIniLine=()
	local _Line _LineNo=1 _Exit=0
	readarray -t _RawIniLine
	while read -r _Line; do
		ini.parse_line <<<"$_Line"
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
ini.get_param_list() {
	local _RawIniLine=()
	local _Line _LineNo=1 _Exit=0 _InSection=false
	readarray -t _RawIniLine
	while read -r _Line; do
		ini.parse_line <<<"$_Line"
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
ini.get_param() {
	local _RawIniLine=()
	local _Line _LineNo=1 _Exit=0 _InSection=false
	readarray -t _RawIniLine
	while read -r _Line; do
		ini.parse_line <<<"$_Line"
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
ini.parse_line() {
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
ini.new_param() {
	local IniContents=() Line
	local Section="$1" Param="$2"
	local InSection=false LineNo=0
	local NewIniContents=()
	readarray -t IniContents
	local BeforeParam
	local SectionLastParam
	local ParamAdded=false
	if ! PrintArray "${IniContents[@]}" | ini.get_param_list "$Section" | grep -qx "$Param"; then
		SectionLastParam="$(PrintEvalArray IniContents | ini.get_last_param "$Section")"
		for Line in "${IniContents[@]}"; do
			LineNo=$((LineNo + 1))
			ini.parse_line <<<"$Line"
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
ini.new_section() {
	local IniContents=()
	local Section="$1"
	readarray -t IniContents
	if PrintArray "${IniContents[@]}" | ini.get_section_list | grep -x "$Section" >/dev/null; then
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
ini.set_value() {
	local IniContents=()
	local Section="$1" Param="$2"
	readarray -t IniContents
	readarray -t IniContents < <(PrintArray "${IniContents[@]}" | ini.new_section "$Section" | ini.new_param "$Section" "$Param")
	PrintEvalArray IniContents
}
libretranslate.check() {
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
libretranslate.translate() {
	libretranslate.check || return 2
	__libre_translate_return="$(curl -s "$LIBRETRANSLATE_URL/translate" -X POST -d "q=${1:-""}&source=${2:-""}&target=${3:-""}&api_key=${LIBRETRANSLATE_APIKEY:-""}")"
	if [ "$(echo "${__libre_translate_return}" | jq -r '.error')" = "null" ]; then
		echo "${__libre_translate_return}" | jq -r '.translatedText'
		return 0
	else
		echo "${__libre_translate_return}" | jq -r '.error'
		return 1
	fi
}
libretranslate.detect() {
	libretranslate.check || return 2
	__libre_translate_return="$(curl -s "${LIBRETRANSLATE_URL}/detect" -X POST -d "q=${1:-""}&api_key=${LIBRETRANSLATE_APIKEY:-""}")"
	if [ "$(echo "${__libre_translate_return}" | jq -r '.[].error')" = "null" ]; then
		echo "${__libre_translate_return}" | jq -r '.[].language'
		return 0
	else
		echo "${__libre_translate_return}" | jq -r '.error'
		return 1
	fi
}
libretranslate.translate_auto() {
	libretranslate.check || return 2
	libretranslate.translate "${1:-""}" "$(libretranslate.detect "${1:-""}")" "${2:-""}"
}
libretranslate.languages() {
	libretranslate.check || return 2
	curl -s "${LIBRETRANSLATE_URL}/languages" | jq -r '.[].code'
}
msg.warn() {
	msg.common " Warn:" "${*}" stderr
}
msg.err() {
	msg.common "Error:" "${*}" stderr
}
msg.common() {
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
msg.debug() {
	msg.common "Debug:" "${*}" stderr
}
msg.info() {
	msg.common " Info:" "${*}" stdout
}
misskey.notes.renotes() {
	misskey.binding_base "notes/renotes" noteId limit sinceId untilId -- "$@"
}
misskey.notes.search() {
	misskey.binding_base "notes/search" query limit -- "$@"
}
misskey.notes.create() {
	misskey.binding_base "notes/create" text -- "$@"
}
misskey.users.show() {
	misskey.binding_base "users/show" userId -- "${1:-"$(misskey.my_id)"}" "${@:2}"
}
misskey.users.stats() {
	misskey.binding_base "users/stats" userId -- "${1:-"$(misskey.my_id)"}" "${@:2}"
}
misskey.users.get_frequently_replied_users() {
	misskey.binding_base "users/get-frequently-replied-users" userId -- "${1:-"$(misskey.my_id)"}" "${@:2}"
}
misskey.users.search_by_username_and_host() {
	misskey.binding_base "users/search-by-username-and-host" username -- "${1:-"$(misskey.my_user_name)"}" "${@:2}"
}
misskey.users.notes() {
	misskey.binding_base "users/notes" userId -- "${1:-"$(misskey.my_id)"}" "${@:2}"
}
misskey.users.pages() {
	misskey.binding_base "users/pages" userId -- "${1:-"$(misskey.my_id)"}" "${@:2}"
}
misskey.admin.server_info() {
	misskey.binding_base "/admin/server-info" -- "$@"
}
misskey.setup() {
	export MISSKEY_DOMAIN="${1-"${MISSKEY_DOMAIN-""}"}"
	export MISSKEY_TOKEN="${2-"${MISSKEY_TOKEN-""}"}"
	export MISSKEY_ENTRY="https://${MISSKEY_DOMAIN}/api"
}
misskey.i() {
	misskey.binding_base "/i" -- "$@"
}
misskey.server_info() {
	misskey.binding_base "/server-info" -- "$@"
}
misskey.meta() {
	misskey.binding_base "/meta" -- "$@"
}
misskey.binding_base() {
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
		misskey.setup "${MISSKEY_DOMAIN}" "$MISSKEY_TOKEN"
	fi
	misskey.send_req "${MISSKEY_ENTRY%/}/${_API#/}" "${_Args[@]}" "$@"
}
misskey.send_req() {
	local _Url="$1" _CurlArgs=()
	shift 1
	_CurlArgs+=(-s -L)
	_CurlArgs+=(-X POST)
	_CurlArgs+=(-H "Content-Type: application/json")
	_CurlArgs+=(-d "$(misskey.make_json "$@")")
	_CurlArgs+=("$_Url")
	Msg.Debug "Run: ${_CurlArgs[*]//"${MISSKEY_TOKEN}"/"TOKEN"}"
	curl "${_CurlArgs[@]}"
}
misskey.make_json() {
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
misskey.is_admin() {
	Bool "$(misskey.i | jq -r ".isAdmin")"
}
misskey.my_name() {
	misskey.i | jq -r ".name"
}
misskey.my_user_name() {
	misskey.i | jq -r ".username"
}
misskey.my_id() {
	misskey.i | jq -r ".id"
}
pm.check_pkg() {
	local p
	for p in "$@"; do
		pm.run -Qq "$p" >/dev/null 2>&1 || return 1
	done
	return 0
}
pm.get_latest_pkg_ver() {
	local _LANG="${LANG-""}"
	export LANG=C
	if [[ -z ${*} ]]; then
		cat
	else
		PrintArray "$@"
	fi | ForEach pm.run -Si "{}" | grep "^Version" | cut -d ":" -f 2 | RemoveBlank
	[[ -n $_LANG ]] && export LANG="$_LANG"
	return 0
}
pm.get_repo_list_from_conf() {
	pm.get_config --repo-list
}
pm.get_pacman_keyring_dir() {
	local _KeyringDir=""
	_KeyringDir="$(LANG=C pacman-key -h | RemoveBlank | grep -A 1 -- "^--populate" | tail -n 1 | cut -d "/" -f 2- | sed "s|'$||g")"
	: "${_KeyringDir="usr/share/pacman/keyrings"}"
	_KeyringDir="$(pm.get_root)/$_KeyringDir"
	_KeyringDir="$(sed -E "s|/+|/|g" <<<"$_KeyringDir")"
	if [[ -e $_KeyringDir ]]; then
		Readlinkf "$_KeyringDir"
	else
		echo "$_KeyringDir"
	fi
}
pm.get_repo_pkg_list() {
	pm.run -Slq "$@"
}
pm.get_repo_ver() {
	pm.run -Sp --print-format '%v' "$1"
}
pm.get_repo_server() {
	ForEach eval 'pm.get_config -r {}' | grep "^Server" | ForEach eval "Ini.ParseLine <<< '{}' ; printf '%s\n' \${VALUE}"
}
pm.is_repo_pkg() {
	pm.run -Slq | grep -qx "$(pm.get_name <<<"$1")"
}
pm.get_repo_conf() {
	ForEach eval 'echo [{}] && pm.get_config -r {}'
}
pm.get_root() {
	pm.get_config RootDir
}
pm.get_name() {
	cut -d "<" -f 1 | cut -d ">" -f 1 | cut -d "=" -f 1
}
pm.pacman_gpg() {
	gpg --homedir "$(pm.get_config GPGDir)" "$@"
}
pm.get_pacman_kernel_pkg() {
	echo "there is nothing"
}
pm.get_keyring_list() {
	find "$(@GetKeyringDir)" -name "*.gpg" | GetBaseName | RemoveFileExt
}
pm.get_installed_pkg_ver() {
	if [[ -z ${*} ]]; then
		cat
	else
		PrintArray "$@"
	fi | ForEach pacman -Q "{}" | cut -d " " -f 2
	PrintArray "${PIPESTATUS[@]}" | grep -qx "1" && return 1
	return 0
}
pm.run_key() {
	pacman-key --config "${PACMAN_CONF-"/etc/pacman.conf"}" "$@"
}
pm.run() {
	pacman --noconfirm --config "${PACMAN_CONF-"/etc/pacman.conf"}" "$@"
}
pm.get_config() {
	LANG=C pacman-conf --config="${PACMAN_CONF-"/etc/pacman.conf"}" "$@"
}
pm.get_db_section_list() {
	grep -E "^%.*%$"
}
pm.get_db_next_section() {
	pm.get_db_section_list | grep -x -A 1 "^%$1%$" | GetLine 2 | sed "s|^%||g; s|%$||g"
}
pm.get_db_section() {
	readarray -t _Stdin
	PrintArray "${_Stdin[@]}" | sed -ne "/^%$1%$/,/^%$(PrintEvalArray _Stdin | pm.get_db_next_section "$1")%$/p" | sed '1d; $d'
}
pm.opened_sync_db_list() {
	find "$(pm.get_db_tmp_dir)/sync/" -mindepth 1 -maxdepth 1 -type d
}
pm.create_db_tmp_dir() {
	mkdir -p "$(pm.get_db_tmp_dir)"
}
pm.get_sync_all_desc() {
	find "$(pm.get_db_tmp_dir)" -mindepth 3 -maxdepth 3 -name "desc" -type f
}
pm.is_opend_sync_db() {
	readarray -t _PkgDbList < <(find "$(pm.get_db_tmp_dir)/sync/$1" -mindepth 1 -maxdepth 1 -type d)
	(("${#_PkgDbList[@]}" > 0)) && return 0
	return 1
}
pm.get_virtual_pkg_list() {
	pm.get_repo_list_from_local_db | ForEach pm.open_sync_db {}
	pm.get_sync_all_desc | ForEach eval "pm.get_db_section PROVIDES < {}" | RemoveBlank
}
pm.get_db_tmp_dir() {
	echo "${TMPDIR-"/tmp"}/fasbashlib-pacman-db"
}
pm.get_sync_db_desc() {
	local _path
	_path="$(pm.get_sync_db_desc_path "$1")"
	[[ -e $_path ]] || return 1
	cat "$_path/desc"
}
pm.get_sync_db_desc_path() {
	local _repo
	_repo="$(pacman -Sp --print-format '%r' "$1")"
	{
		IsPacmanSyncDbOpend "$_repo" || OpenPacmanSyncDb "$_repo"
	} || return 1
	echo "$(pm.get_db_tmp_dir)/sync/$(pacman -Sp --print-format '%r/%n-%v' "$1")"
}
pm.parse_pkg_file_name() {
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
pm.get_repo_list_from_local_db() {
	find "$(pm.get_config DBPath)/sync" -mindepth 1 -maxdepth 1 -type f | GetBaseName | sed "s|.db$||g"
	return 0
}
pm.open_sync_db() {
	local _Dir _RepoDb
	pm.create_db_tmp_dir
	_Dir="$(pm.get_db_tmp_dir)/sync/$1"
	mkdir -p "$_Dir"
	_RepoDb="$(pm.get_config DBPath)/sync/$1.db"
	[[ -e $_RepoDb ]] || return 1
	tar -xzf "${_RepoDb}" -C "$_Dir" || return 1
}
pm.get_pkg_arch() {
	pm.get_sync_db_desc "$1" | pm.get_db_section ARCH | RemoveBlank
}
pm.delete_db_tmp_dir() {
	rm -rf "$(pm.get_db_tmp_dir)"
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
prog.bar() {
	local Max="$1" Counter="$2" Size="${3-"100"}"
	local SharpCount=$((Counter * Size / Max))
	local SpaceCount=$((Size - SharpCount))
	Esc.Return
	echo -n "$Counter/$Max [$(yes "#" | head -n "$SharpCount" 2>/dev/null | tr -d "\n")$(yes " " | head -n "$SpaceCount" 2>/dev/null | tr -d "\n")]"
}
prog.wide_bar() {
	local Max="$1" Counter="$2"
	local StatusString="$Counter/$Max"
	local Size=$(($(Esc.GetTermX) - ${#StatusString} - 3))
	prog.bar "$Max" "$Counter" "$Size"
}
prog.rotation() {
	local Count="$1" CharList=('|' '/' '-' '\')
	Esc.ClearLineAndReturn
	[[ -n ${2-""} ]] && echo -n "${2}" 1>&2
	printf "%s" "${CharList["$((Count % "${#CharList[@]}"))"]}" 1>&2
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
arch.get_mkinitcpio_preset_list() {
	find "/etc/mkinitcpio.d/" -name "*.preset" -type f | GetBaseName | RemoveFileExt
}
arch.get_kernel_src_list() {
	find "/usr/src" -mindepth 1 -maxdepth 1 -type l -name "linux*"
}
arch.get_kernel_file_list() {
	find "/boot" -maxdepth 1 -mindepth 1 -name "vmlinuz-*"
}
array.append() {
	local _ArrName="$1"
	shift 1 || return 1
	readarray -t -O "$(ArrayIndex "$_ArrName")" "$_ArrName" < <(cat)
}
array.shift() {
	readarray -t "$1" < <(PrintEvalArray "$1" | sed "1,${2-"1"}d")
}
array.push() {
	eval "PrintArray \"\${$1[@]}\"" | grep -qx "$2" && return 0
	eval "$1+=(\"$2\")"
}
array.from_str() {
	declare -a -x "$1"
	readarray -t "$1" < <(BreakChar)
}
array.pop() {
	readarray -t "$1" < <(PrintEvalArray "$1" | sed -e '$d')
}
array.rev() {
	readarray -t "$1" < <(PrintEvalArray "$1" | tac)
}
array.remove() {
	readarray -t "$1" < <(PrintEvalArray "$1" | RemoveMatchLine "$2")
}
array.print() {
	(($# >= 1)) || return 0
	printf "%s\n" "${@}"
}
array.last() {
	PrintEval "$1[$(array.last_index "$1")]"
}
array.eval() {
	eval "PrintArray \"\${$1[@]}\""
}
array.length() {
	PrintEval "#${1}[@]"
}
array.index_of() {
	local n=()
	readarray -t n < <(grep -x -n "$1" | cut -d ":" -f 1 | ForEach eval echo '$(( {} - 1 ))')
	(("${#n[@]}" >= 1)) || return 1
	PrintArray "${n[@]}"
	return 0
}
array.last_index() {
	CalcInt "$(array.length "$1")" - 1
}
array.includes() {
	PrintEvalArray "$1" | grep -qx "$2"
}
array.for_each() {
	PrintEvalArray "$1" | ForEach "${@:2}"
}
array.include() {
	array.includes "$@"
}
awk.cos() {
	awk.float "cos($*)"
}
awk.tan() {
	awk.float "sin($1)/tan($1)"
}
awk.sin() {
	awk.float "sin($*)"
}
awk.pi() {
	awk.float "atan2(0, -0)"
}
awk.print() {
	awk "BEGIN {print $*}"
}
awk.log() {
	awk.float "log(${2}) / log($1)"
}
awk.rad() {
	awk.float "$1 * $(awk.pi) / 180 "
}
awk.float() {
	awk "BEGIN {printf (\"%4.${AWKSCALE-"5"}f\n\", $*)}"
}
PrintEvalArray() {
	Array.Eval "$1"
}
ArrayAppend() {
	Array.Append "$1"
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
StrToCharList() {
	Array.FromStr "$1"
}
GetArrayIndex() {
	Array.IndexOf "$1"
}
ArrayIndex() {
	Array.Length "$1"
}
AddNewToArray() {
	Array.Push "$@"
}
FileType() {
	file --mime-type -b "$1"
}
RemoveFileExt() {
	local Ext
	ForEach eval 'Ext=$(GetFileExt <<< {}); sed "s|.$Ext$||g" <<< {}; unset Ext'
}
GetFileExt() {
	GetBaseName | rev | cut -d "." -f 1 | rev
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
ToLower() {
	local _Str="${1,,}"
	[[ -z ${_Str-""} ]] || echo "${_Str}"
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
PrintEval() {
	eval echo "\${$1}"
}
RemoveBlank() {
	sed "s|^ *||g; s| *$||g; s|^	*||g; s|	*$||g; /^$/d"
}
GetMaxWidth() {
	awk '{ if ( length > x && length > 0 ) { x = length } }END{ print x }'
}
RandomString() {
	base64 <"/dev/random" | fold -w "$1" | head -n 1
	return 0
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
GetLastSplitString() {
	rev <<<"$2" | cut -d "$1" -f 1 | rev
}
CutLastString() {
	echo "${1%%"${2}"}"
	return 0
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
ToArgs() {
	readarray -t args
	"$@" "${args[@]}"
}
cache.get_file_last_update() {
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
cache.exist() {
	local _File
	_File="$(cache.create_dir)/$1"
	[[ -e $_File ]] || return 1
	(("$(cache.get_time_diff_from_last_update "$_File")" > "${KEEPCACHESEC-"86400"}")) && return 2
	return 0
}
cache.get_time_diff_from_last_update() {
	local _Now _Last
	_Now="$(date "+%s")"
	_Last="$(cache.get_file_last_update "$1")"
	echo "$((_Now - _Last))"
	return 0
}
cache.get_id() {
	if [[ -z ${FSBLIB_CACHEID-""} ]]; then
		cache.create_dir >/dev/null
	fi
	echo "$FSBLIB_CACHEID"
}
cache.get_dir() {
	echo "${TMPDIR-"/tmp"}/$(cache.get_id)"
}
cache.get() {
	cat "$(cache.get_dir)/$1" 2>/dev/null || return 1
}
cache.create() {
	cache.create_dir >/dev/null
	cat >"$(cache.get_dir)/${1}"
	cat "$(cache.get_dir)/$1"
}
cache.create_dir() {
	FSBLIB_CACHEID="${FSBLIB_CACHEID-"$(RandomString "10")"}"
	export FSBLIB_CACHEID="$FSBLIB_CACHEID"
	local TMPDIR="${TMPDIR-"/tmp"}"
	local _Dir="$TMPDIR/${FSBLIB_CACHEID}"
	mkdir -p "$_Dir"
	echo "$_Dir"
	return 0
}
fsblib.require_lib() {
	local lib missing=() return=0
	for lib in "$@"; do
		if ! [[ ${FSBLIB_LIBLIST[*]} == *" $lib "* ]]; then
			missing+=("$lib")
			return=1
		fi
	done
	return "$return"
}
fsblib_env_check() {
	fsblib.env_check
}
fsblib.env_check() {
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
csv.to_bash_array() {
	local _RawCsvLine=() _Line _ClmCnt=0
	local ArrayPrefix="${ArrayPrefix-"{}"}"
	readarray -t _RawCsvLine < <(
		while read -r _Line; do
			(($(tr "${CSVDELIM-","}" "\n" <<<"$_Line" | wc -l) >= ${#})) && echo "$_Line"
		done < <(grep -v "^#")
	)
	_ClmCnt=$(PrintArray "${_RawCsvLine[@]}" | csv.get_clm_cnt)
	while read -r _Cnt; do
		readarray -t "$(sed "s|{}|$(eval "echo \"\${${_Cnt}}\"")|g" <<<"$ArrayPrefix")" < <(
			PrintArray "${_RawCsvLine[@]}" | cut -d "${CSVDELIM-","}" -f "$_Cnt"
		)
	done < <(seq 1 "$#")
}
csv.get_clm() {
	grep -v "^#" | sed "/^$/d" | cut -d "${CSVDELIM-","}" -f "$1"
}
csv.get_clm_cnt() {
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
em.get_world_pkg_list() {
	sed -E 's|:.+$||g' /var/lib/portage/world | xargs -I{} bash -c 'ls -d /var/db/pkg/{}-* | sed "s|/var/db/pkg/||g" | grep -E "{}-[0-9]"'
}
em.get_repo_pkg_list() {
	local _RepoPath
	_RepoPath="$(em.get_repo_location "$1")"
	find "$_RepoPath" -mindepth 3 -maxdepth 3 -type f -name '*.ebuild' | sed -e "s|${_RepoPath%/}/||g" -e 's|.ebuild$||g' | awk -F "/" '{print $1"/"$3}'
}
em.get_all_pkg_list() {
	em.get_repo_conf | sed -e 's/^ *//' -e 's/ *$//' | grep "^ *location *=" | sed -e 's/^location *= *//' | xargs -L1 realpath | xargs -I{} bash -c "find '{}' -mindepth 3 -maxdepth 3 -type f -name '*.ebuild' | sed -e 's|{}/||g' -e 's|.ebuild$||g'" | awk -F "/" '{print $1"/"$3}'
}
em.get_installed_pkg_list() {
	find /var/db/pkg/ -mindepth 2 -maxdepth 2 -type d | sed 's|/var/db/pkg/||g'
}
em.get_repo_location() {
	em.get_repo_conf | Ini.GetParam "$1" location
}
em.get_repo_conf() {
	cat /etc/portage/repos.conf /etc/portage/repos.conf/* 2>/dev/null
}
em.get_default_repo_name() {
	em.get_repo_conf | Ini.GetParam DEFAULT main-repo
}
em.no_version() {
	sed -E 's|\-[0-9]+.+||g'
}
esc.clear_screen() {
	printf "\033[2J" >/dev/tty
}
esc.return() {
	printf "\r" >/dev/tty
}
esc.clear_left() {
	printf "\033[1K" >/dev/tty
}
esc.clear_line() {
	printf "\033[2K" >/dev/tty
}
esc.clear_right() {
	printf "\033[0K" >/dev/tty
}
esc.get_y() {
	local _POS
	printf "\033[6n" >>/dev/tty
	read -r -s -d "R" _POS
	echo $(("$(printf "%s\n" "${_POS:2}" | cut -d";" -f1)" - 1))
}
esc.get_x() {
	local _POS
	printf "\033[6n" >>/dev/tty
	read -r -s -d "R" _POS
	echo $(("$(printf "%s\n" "${_POS:2}" | cut -d";" -f2)" - 1))
}
esc.get_term_x() {
	[[ -n ${COLUMNS-""} ]] && echo "$COLUMNS" && return 0
	tput cols
}
esc.move_cursor() {
	printf "\033[%d;%dH" "$1" "$2" >/dev/tty
}
esc.move_cursor_up() {
	printf "\033[%dA" "$1" >/dev/tty
}
esc.move_cursor_left() {
	printf "\033[%dD" "$1" >/dev/tty
}
esc.move_cursor_down() {
	printf "\033[%dB" "$1" >/dev/tty
}
esc.move_cursor_right() {
	printf "\033[%dC" "$1" >/dev/tty
}
esc.get_term_y() {
	[[ -n ${LINES-""} ]] && echo "$LINES" && return 0
	tput lines
}
esc.clear_line_and_return() {
	esc.clear_line
	esc.return
}
esc.clear_upper_lines() {
	for i in $(seq 1 "$1"); do
		esc.move_cursor_up 1
		esc.clear_line
	done
}
esc.italic() {
	printf "\033[3m" >/dev/tty
}
esc.green_background() {
	printf "\033[42m" >/dev/tty
}
esc.black_background() {
	printf "\033[40m" >/dev/tty
}
esc.blue_text() {
	printf "\033[34m" >/dev/tty
}
esc.underline() {
	printf "\033[4m" >/dev/tty
}
esc.white_text() {
	printf "\033[37m" >/dev/tty
}
esc.magenta_background() {
	printf "\033[45m" >/dev/tty
}
esc.cyan_background() {
	printf "\033[46m" >/dev/tty
}
esc.magenta_text() {
	printf "\033[35m" >/dev/tty
}
esc.yellow_text() {
	printf "\033[33m" >/dev/tty
}
esc.green_text() {
	printf "\033[32m" >/dev/tty
}
esc.white_background() {
	printf "\033[47m" >/dev/tty
}
esc.low_intensity() {
	printf "\033[2m" >/dev/tty
}
esc.yellow_background() {
	printf "\033[43m" >/dev/tty
}
esc.red_background() {
	printf "\033[41m" >/dev/tty
}
esc.reset_style() {
	printf "\033[0m" >/dev/tty
}
esc.rapid_blink() {
	printf "\033[6m" >/dev/tty
}
esc.reverse() {
	printf "\033[7m" >/dev/tty
}
esc.conceal() {
	printf "\033[8m" >/dev/tty
}
esc.blue_background() {
	printf "\033[44m" >/dev/tty
}
esc.cyan_text() {
	printf "\033[36m" >/dev/tty
}
esc.bold() {
	printf "\033[1m" >/dev/tty
}
esc.red_text() {
	printf "\033[31m" >/dev/tty
}
esc.crossed_out() {
	printf "\033[9m" >/dev/tty
}
esc.blink() {
	printf "\033[5m" >/dev/tty
}
esc.black_text() {
	printf "\033[30m" >/dev/tty
}
ini.get_last_param() {
	ini.get_param_list "$1" | tail -n 1
}
ini.get_section_list() {
	local _RawIniLine=()
	local _Line _LineNo=1 _Exit=0
	readarray -t _RawIniLine
	while read -r _Line; do
		ini.parse_line <<<"$_Line"
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
ini.get_param_list() {
	local _RawIniLine=()
	local _Line _LineNo=1 _Exit=0 _InSection=false
	readarray -t _RawIniLine
	while read -r _Line; do
		ini.parse_line <<<"$_Line"
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
ini.get_param() {
	local _RawIniLine=()
	local _Line _LineNo=1 _Exit=0 _InSection=false
	readarray -t _RawIniLine
	while read -r _Line; do
		ini.parse_line <<<"$_Line"
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
ini.parse_line() {
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
ini.new_param() {
	local IniContents=() Line
	local Section="$1" Param="$2"
	local InSection=false LineNo=0
	local NewIniContents=()
	readarray -t IniContents
	local BeforeParam
	local SectionLastParam
	local ParamAdded=false
	if ! PrintArray "${IniContents[@]}" | ini.get_param_list "$Section" | grep -qx "$Param"; then
		SectionLastParam="$(PrintEvalArray IniContents | ini.get_last_param "$Section")"
		for Line in "${IniContents[@]}"; do
			LineNo=$((LineNo + 1))
			ini.parse_line <<<"$Line"
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
ini.new_section() {
	local IniContents=()
	local Section="$1"
	readarray -t IniContents
	if PrintArray "${IniContents[@]}" | ini.get_section_list | grep -x "$Section" >/dev/null; then
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
ini.set_value() {
	local IniContents=()
	local Section="$1" Param="$2"
	readarray -t IniContents
	readarray -t IniContents < <(PrintArray "${IniContents[@]}" | ini.new_section "$Section" | ini.new_param "$Section" "$Param")
	PrintEvalArray IniContents
}
libretranslate.check() {
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
libretranslate.translate() {
	libretranslate.check || return 2
	__libre_translate_return="$(curl -s "$LIBRETRANSLATE_URL/translate" -X POST -d "q=${1:-""}&source=${2:-""}&target=${3:-""}&api_key=${LIBRETRANSLATE_APIKEY:-""}")"
	if [ "$(echo "${__libre_translate_return}" | jq -r '.error')" = "null" ]; then
		echo "${__libre_translate_return}" | jq -r '.translatedText'
		return 0
	else
		echo "${__libre_translate_return}" | jq -r '.error'
		return 1
	fi
}
libretranslate.detect() {
	libretranslate.check || return 2
	__libre_translate_return="$(curl -s "${LIBRETRANSLATE_URL}/detect" -X POST -d "q=${1:-""}&api_key=${LIBRETRANSLATE_APIKEY:-""}")"
	if [ "$(echo "${__libre_translate_return}" | jq -r '.[].error')" = "null" ]; then
		echo "${__libre_translate_return}" | jq -r '.[].language'
		return 0
	else
		echo "${__libre_translate_return}" | jq -r '.error'
		return 1
	fi
}
libretranslate.translate_auto() {
	libretranslate.check || return 2
	libretranslate.translate "${1:-""}" "$(libretranslate.detect "${1:-""}")" "${2:-""}"
}
libretranslate.languages() {
	libretranslate.check || return 2
	curl -s "${LIBRETRANSLATE_URL}/languages" | jq -r '.[].code'
}
msg.warn() {
	msg.common " Warn:" "${*}" stderr
}
msg.err() {
	msg.common "Error:" "${*}" stderr
}
msg.common() {
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
msg.debug() {
	msg.common "Debug:" "${*}" stderr
}
msg.info() {
	msg.common " Info:" "${*}" stdout
}
misskey.notes.renotes() {
	misskey.binding_base "notes/renotes" noteId limit sinceId untilId -- "$@"
}
misskey.notes.search() {
	misskey.binding_base "notes/search" query limit -- "$@"
}
misskey.notes.create() {
	misskey.binding_base "notes/create" text -- "$@"
}
misskey.users.show() {
	misskey.binding_base "users/show" userId -- "${1:-"$(misskey.my_id)"}" "${@:2}"
}
misskey.users.stats() {
	misskey.binding_base "users/stats" userId -- "${1:-"$(misskey.my_id)"}" "${@:2}"
}
misskey.users.get_frequently_replied_users() {
	misskey.binding_base "users/get-frequently-replied-users" userId -- "${1:-"$(misskey.my_id)"}" "${@:2}"
}
misskey.users.search_by_username_and_host() {
	misskey.binding_base "users/search-by-username-and-host" username -- "${1:-"$(misskey.my_user_name)"}" "${@:2}"
}
misskey.users.notes() {
	misskey.binding_base "users/notes" userId -- "${1:-"$(misskey.my_id)"}" "${@:2}"
}
misskey.users.pages() {
	misskey.binding_base "users/pages" userId -- "${1:-"$(misskey.my_id)"}" "${@:2}"
}
misskey.admin.server_info() {
	misskey.binding_base "/admin/server-info" -- "$@"
}
misskey.setup() {
	export MISSKEY_DOMAIN="${1-"${MISSKEY_DOMAIN-""}"}"
	export MISSKEY_TOKEN="${2-"${MISSKEY_TOKEN-""}"}"
	export MISSKEY_ENTRY="https://${MISSKEY_DOMAIN}/api"
}
misskey.i() {
	misskey.binding_base "/i" -- "$@"
}
misskey.server_info() {
	misskey.binding_base "/server-info" -- "$@"
}
misskey.meta() {
	misskey.binding_base "/meta" -- "$@"
}
misskey.binding_base() {
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
		misskey.setup "${MISSKEY_DOMAIN}" "$MISSKEY_TOKEN"
	fi
	misskey.send_req "${MISSKEY_ENTRY%/}/${_API#/}" "${_Args[@]}" "$@"
}
misskey.send_req() {
	local _Url="$1" _CurlArgs=()
	shift 1
	_CurlArgs+=(-s -L)
	_CurlArgs+=(-X POST)
	_CurlArgs+=(-H "Content-Type: application/json")
	_CurlArgs+=(-d "$(misskey.make_json "$@")")
	_CurlArgs+=("$_Url")
	Msg.Debug "Run: ${_CurlArgs[*]//"${MISSKEY_TOKEN}"/"TOKEN"}"
	curl "${_CurlArgs[@]}"
}
misskey.make_json() {
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
misskey.is_admin() {
	Bool "$(misskey.i | jq -r ".isAdmin")"
}
misskey.my_name() {
	misskey.i | jq -r ".name"
}
misskey.my_user_name() {
	misskey.i | jq -r ".username"
}
misskey.my_id() {
	misskey.i | jq -r ".id"
}
pm.check_pkg() {
	local p
	for p in "$@"; do
		pm.run -Qq "$p" >/dev/null 2>&1 || return 1
	done
	return 0
}
pm.get_latest_pkg_ver() {
	local _LANG="${LANG-""}"
	export LANG=C
	if [[ -z ${*} ]]; then
		cat
	else
		PrintArray "$@"
	fi | ForEach pm.run -Si "{}" | grep "^Version" | cut -d ":" -f 2 | RemoveBlank
	[[ -n $_LANG ]] && export LANG="$_LANG"
	return 0
}
pm.get_repo_list_from_conf() {
	pm.get_config --repo-list
}
pm.get_pacman_keyring_dir() {
	local _KeyringDir=""
	_KeyringDir="$(LANG=C pacman-key -h | RemoveBlank | grep -A 1 -- "^--populate" | tail -n 1 | cut -d "/" -f 2- | sed "s|'$||g")"
	: "${_KeyringDir="usr/share/pacman/keyrings"}"
	_KeyringDir="$(pm.get_root)/$_KeyringDir"
	_KeyringDir="$(sed -E "s|/+|/|g" <<<"$_KeyringDir")"
	if [[ -e $_KeyringDir ]]; then
		Readlinkf "$_KeyringDir"
	else
		echo "$_KeyringDir"
	fi
}
pm.get_repo_pkg_list() {
	pm.run -Slq "$@"
}
pm.get_repo_ver() {
	pm.run -Sp --print-format '%v' "$1"
}
pm.get_repo_server() {
	ForEach eval 'pm.get_config -r {}' | grep "^Server" | ForEach eval "Ini.ParseLine <<< '{}' ; printf '%s\n' \${VALUE}"
}
pm.is_repo_pkg() {
	pm.run -Slq | grep -qx "$(pm.get_name <<<"$1")"
}
pm.get_repo_conf() {
	ForEach eval 'echo [{}] && pm.get_config -r {}'
}
pm.get_root() {
	pm.get_config RootDir
}
pm.get_name() {
	cut -d "<" -f 1 | cut -d ">" -f 1 | cut -d "=" -f 1
}
pm.pacman_gpg() {
	gpg --homedir "$(pm.get_config GPGDir)" "$@"
}
pm.get_pacman_kernel_pkg() {
	echo "there is nothing"
}
pm.get_keyring_list() {
	find "$(@GetKeyringDir)" -name "*.gpg" | GetBaseName | RemoveFileExt
}
pm.get_installed_pkg_ver() {
	if [[ -z ${*} ]]; then
		cat
	else
		PrintArray "$@"
	fi | ForEach pacman -Q "{}" | cut -d " " -f 2
	PrintArray "${PIPESTATUS[@]}" | grep -qx "1" && return 1
	return 0
}
pm.run_key() {
	pacman-key --config "${PACMAN_CONF-"/etc/pacman.conf"}" "$@"
}
pm.run() {
	pacman --noconfirm --config "${PACMAN_CONF-"/etc/pacman.conf"}" "$@"
}
pm.get_config() {
	LANG=C pacman-conf --config="${PACMAN_CONF-"/etc/pacman.conf"}" "$@"
}
pm.get_db_section_list() {
	grep -E "^%.*%$"
}
pm.get_db_next_section() {
	pm.get_db_section_list | grep -x -A 1 "^%$1%$" | GetLine 2 | sed "s|^%||g; s|%$||g"
}
pm.get_db_section() {
	readarray -t _Stdin
	PrintArray "${_Stdin[@]}" | sed -ne "/^%$1%$/,/^%$(PrintEvalArray _Stdin | pm.get_db_next_section "$1")%$/p" | sed '1d; $d'
}
pm.opened_sync_db_list() {
	find "$(pm.get_db_tmp_dir)/sync/" -mindepth 1 -maxdepth 1 -type d
}
pm.create_db_tmp_dir() {
	mkdir -p "$(pm.get_db_tmp_dir)"
}
pm.get_sync_all_desc() {
	find "$(pm.get_db_tmp_dir)" -mindepth 3 -maxdepth 3 -name "desc" -type f
}
pm.is_opend_sync_db() {
	readarray -t _PkgDbList < <(find "$(pm.get_db_tmp_dir)/sync/$1" -mindepth 1 -maxdepth 1 -type d)
	(("${#_PkgDbList[@]}" > 0)) && return 0
	return 1
}
pm.get_virtual_pkg_list() {
	pm.get_repo_list_from_local_db | ForEach pm.open_sync_db {}
	pm.get_sync_all_desc | ForEach eval "pm.get_db_section PROVIDES < {}" | RemoveBlank
}
pm.get_db_tmp_dir() {
	echo "${TMPDIR-"/tmp"}/fasbashlib-pacman-db"
}
pm.get_sync_db_desc() {
	local _path
	_path="$(pm.get_sync_db_desc_path "$1")"
	[[ -e $_path ]] || return 1
	cat "$_path/desc"
}
pm.get_sync_db_desc_path() {
	local _repo
	_repo="$(pacman -Sp --print-format '%r' "$1")"
	{
		IsPacmanSyncDbOpend "$_repo" || OpenPacmanSyncDb "$_repo"
	} || return 1
	echo "$(pm.get_db_tmp_dir)/sync/$(pacman -Sp --print-format '%r/%n-%v' "$1")"
}
pm.parse_pkg_file_name() {
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
pm.get_repo_list_from_local_db() {
	find "$(pm.get_config DBPath)/sync" -mindepth 1 -maxdepth 1 -type f | GetBaseName | sed "s|.db$||g"
	return 0
}
pm.open_sync_db() {
	local _Dir _RepoDb
	pm.create_db_tmp_dir
	_Dir="$(pm.get_db_tmp_dir)/sync/$1"
	mkdir -p "$_Dir"
	_RepoDb="$(pm.get_config DBPath)/sync/$1.db"
	[[ -e $_RepoDb ]] || return 1
	tar -xzf "${_RepoDb}" -C "$_Dir" || return 1
}
pm.get_pkg_arch() {
	pm.get_sync_db_desc "$1" | pm.get_db_section ARCH | RemoveBlank
}
pm.delete_db_tmp_dir() {
	rm -rf "$(pm.get_db_tmp_dir)"
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
prog.bar() {
	local Max="$1" Counter="$2" Size="${3-"100"}"
	local SharpCount=$((Counter * Size / Max))
	local SpaceCount=$((Size - SharpCount))
	Esc.Return
	echo -n "$Counter/$Max [$(yes "#" | head -n "$SharpCount" 2>/dev/null | tr -d "\n")$(yes " " | head -n "$SpaceCount" 2>/dev/null | tr -d "\n")]"
}
prog.wide_bar() {
	local Max="$1" Counter="$2"
	local StatusString="$Counter/$Max"
	local Size=$(($(Esc.GetTermX) - ${#StatusString} - 3))
	prog.bar "$Max" "$Counter" "$Size"
}
prog.rotation() {
	local Count="$1" CharList=('|' '/' '-' '\')
	Esc.ClearLineAndReturn
	[[ -n ${2-""} ]] && echo -n "${2}" 1>&2
	printf "%s" "${CharList["$((Count % "${#CharList[@]}"))"]}" 1>&2
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
arch.get_mkinitcpio_preset_list() {
	find "/etc/mkinitcpio.d/" -name "*.preset" -type f | GetBaseName | RemoveFileExt
}
arch.get_kernel_src_list() {
	find "/usr/src" -mindepth 1 -maxdepth 1 -type l -name "linux*"
}
arch.get_kernel_file_list() {
	find "/boot" -maxdepth 1 -mindepth 1 -name "vmlinuz-*"
}
array.append() {
	local _ArrName="$1"
	shift 1 || return 1
	readarray -t -O "$(ArrayIndex "$_ArrName")" "$_ArrName" < <(cat)
}
array.shift() {
	readarray -t "$1" < <(PrintEvalArray "$1" | sed "1,${2-"1"}d")
}
array.push() {
	eval "PrintArray \"\${$1[@]}\"" | grep -qx "$2" && return 0
	eval "$1+=(\"$2\")"
}
array.from_str() {
	declare -a -x "$1"
	readarray -t "$1" < <(BreakChar)
}
array.pop() {
	readarray -t "$1" < <(PrintEvalArray "$1" | sed -e '$d')
}
array.rev() {
	readarray -t "$1" < <(PrintEvalArray "$1" | tac)
}
array.remove() {
	readarray -t "$1" < <(PrintEvalArray "$1" | RemoveMatchLine "$2")
}
array.print() {
	(($# >= 1)) || return 0
	printf "%s\n" "${@}"
}
array.last() {
	PrintEval "$1[$(array.last_index "$1")]"
}
array.eval() {
	eval "PrintArray \"\${$1[@]}\""
}
array.length() {
	PrintEval "#${1}[@]"
}
array.index_of() {
	local n=()
	readarray -t n < <(grep -x -n "$1" | cut -d ":" -f 1 | ForEach eval echo '$(( {} - 1 ))')
	(("${#n[@]}" >= 1)) || return 1
	PrintArray "${n[@]}"
	return 0
}
array.last_index() {
	CalcInt "$(array.length "$1")" - 1
}
array.includes() {
	PrintEvalArray "$1" | grep -qx "$2"
}
array.for_each() {
	PrintEvalArray "$1" | ForEach "${@:2}"
}
array.include() {
	array.includes "$@"
}
awk.cos() {
	awk.float "cos($*)"
}
awk.tan() {
	awk.float "sin($1)/tan($1)"
}
awk.sin() {
	awk.float "sin($*)"
}
awk.pi() {
	awk.float "atan2(0, -0)"
}
awk.print() {
	awk "BEGIN {print $*}"
}
awk.log() {
	awk.float "log(${2}) / log($1)"
}
awk.rad() {
	awk.float "$1 * $(awk.pi) / 180 "
}
awk.float() {
	awk "BEGIN {printf (\"%4.${AWKSCALE-"5"}f\n\", $*)}"
}
PrintEvalArray() {
	Array.Eval "$1"
}
ArrayAppend() {
	Array.Append "$1"
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
StrToCharList() {
	Array.FromStr "$1"
}
GetArrayIndex() {
	Array.IndexOf "$1"
}
ArrayIndex() {
	Array.Length "$1"
}
AddNewToArray() {
	Array.Push "$@"
}
FileType() {
	file --mime-type -b "$1"
}
RemoveFileExt() {
	local Ext
	ForEach eval 'Ext=$(GetFileExt <<< {}); sed "s|.$Ext$||g" <<< {}; unset Ext'
}
GetFileExt() {
	GetBaseName | rev | cut -d "." -f 1 | rev
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
ToLower() {
	local _Str="${1,,}"
	[[ -z ${_Str-""} ]] || echo "${_Str}"
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
PrintEval() {
	eval echo "\${$1}"
}
RemoveBlank() {
	sed "s|^ *||g; s| *$||g; s|^	*||g; s|	*$||g; /^$/d"
}
GetMaxWidth() {
	awk '{ if ( length > x && length > 0 ) { x = length } }END{ print x }'
}
RandomString() {
	base64 <"/dev/random" | fold -w "$1" | head -n 1
	return 0
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
GetLastSplitString() {
	rev <<<"$2" | cut -d "$1" -f 1 | rev
}
CutLastString() {
	echo "${1%%"${2}"}"
	return 0
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
ToArgs() {
	readarray -t args
	"$@" "${args[@]}"
}
cache.get_file_last_update() {
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
cache.exist() {
	local _File
	_File="$(cache.create_dir)/$1"
	[[ -e $_File ]] || return 1
	(("$(cache.get_time_diff_from_last_update "$_File")" > "${KEEPCACHESEC-"86400"}")) && return 2
	return 0
}
cache.get_time_diff_from_last_update() {
	local _Now _Last
	_Now="$(date "+%s")"
	_Last="$(cache.get_file_last_update "$1")"
	echo "$((_Now - _Last))"
	return 0
}
cache.get_id() {
	if [[ -z ${FSBLIB_CACHEID-""} ]]; then
		cache.create_dir >/dev/null
	fi
	echo "$FSBLIB_CACHEID"
}
cache.get_dir() {
	echo "${TMPDIR-"/tmp"}/$(cache.get_id)"
}
cache.get() {
	cat "$(cache.get_dir)/$1" 2>/dev/null || return 1
}
cache.create() {
	cache.create_dir >/dev/null
	cat >"$(cache.get_dir)/${1}"
	cat "$(cache.get_dir)/$1"
}
cache.create_dir() {
	FSBLIB_CACHEID="${FSBLIB_CACHEID-"$(RandomString "10")"}"
	export FSBLIB_CACHEID="$FSBLIB_CACHEID"
	local TMPDIR="${TMPDIR-"/tmp"}"
	local _Dir="$TMPDIR/${FSBLIB_CACHEID}"
	mkdir -p "$_Dir"
	echo "$_Dir"
	return 0
}
fsblib.require_lib() {
	local lib missing=() return=0
	for lib in "$@"; do
		if ! [[ ${FSBLIB_LIBLIST[*]} == *" $lib "* ]]; then
			missing+=("$lib")
			return=1
		fi
	done
	return "$return"
}
fsblib_env_check() {
	fsblib.env_check
}
fsblib.env_check() {
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
csv.to_bash_array() {
	local _RawCsvLine=() _Line _ClmCnt=0
	local ArrayPrefix="${ArrayPrefix-"{}"}"
	readarray -t _RawCsvLine < <(
		while read -r _Line; do
			(($(tr "${CSVDELIM-","}" "\n" <<<"$_Line" | wc -l) >= ${#})) && echo "$_Line"
		done < <(grep -v "^#")
	)
	_ClmCnt=$(PrintArray "${_RawCsvLine[@]}" | csv.get_clm_cnt)
	while read -r _Cnt; do
		readarray -t "$(sed "s|{}|$(eval "echo \"\${${_Cnt}}\"")|g" <<<"$ArrayPrefix")" < <(
			PrintArray "${_RawCsvLine[@]}" | cut -d "${CSVDELIM-","}" -f "$_Cnt"
		)
	done < <(seq 1 "$#")
}
csv.get_clm() {
	grep -v "^#" | sed "/^$/d" | cut -d "${CSVDELIM-","}" -f "$1"
}
csv.get_clm_cnt() {
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
em.get_world_pkg_list() {
	sed -E 's|:.+$||g' /var/lib/portage/world | xargs -I{} bash -c 'ls -d /var/db/pkg/{}-* | sed "s|/var/db/pkg/||g" | grep -E "{}-[0-9]"'
}
em.get_repo_pkg_list() {
	local _RepoPath
	_RepoPath="$(em.get_repo_location "$1")"
	find "$_RepoPath" -mindepth 3 -maxdepth 3 -type f -name '*.ebuild' | sed -e "s|${_RepoPath%/}/||g" -e 's|.ebuild$||g' | awk -F "/" '{print $1"/"$3}'
}
em.get_all_pkg_list() {
	em.get_repo_conf | sed -e 's/^ *//' -e 's/ *$//' | grep "^ *location *=" | sed -e 's/^location *= *//' | xargs -L1 realpath | xargs -I{} bash -c "find '{}' -mindepth 3 -maxdepth 3 -type f -name '*.ebuild' | sed -e 's|{}/||g' -e 's|.ebuild$||g'" | awk -F "/" '{print $1"/"$3}'
}
em.get_installed_pkg_list() {
	find /var/db/pkg/ -mindepth 2 -maxdepth 2 -type d | sed 's|/var/db/pkg/||g'
}
em.get_repo_location() {
	em.get_repo_conf | Ini.GetParam "$1" location
}
em.get_repo_conf() {
	cat /etc/portage/repos.conf /etc/portage/repos.conf/* 2>/dev/null
}
em.get_default_repo_name() {
	em.get_repo_conf | Ini.GetParam DEFAULT main-repo
}
em.no_version() {
	sed -E 's|\-[0-9]+.+||g'
}
esc.clear_screen() {
	printf "\033[2J" >/dev/tty
}
esc.return() {
	printf "\r" >/dev/tty
}
esc.clear_left() {
	printf "\033[1K" >/dev/tty
}
esc.clear_line() {
	printf "\033[2K" >/dev/tty
}
esc.clear_right() {
	printf "\033[0K" >/dev/tty
}
esc.get_y() {
	local _POS
	printf "\033[6n" >>/dev/tty
	read -r -s -d "R" _POS
	echo $(("$(printf "%s\n" "${_POS:2}" | cut -d";" -f1)" - 1))
}
esc.get_x() {
	local _POS
	printf "\033[6n" >>/dev/tty
	read -r -s -d "R" _POS
	echo $(("$(printf "%s\n" "${_POS:2}" | cut -d";" -f2)" - 1))
}
esc.get_term_x() {
	[[ -n ${COLUMNS-""} ]] && echo "$COLUMNS" && return 0
	tput cols
}
esc.move_cursor() {
	printf "\033[%d;%dH" "$1" "$2" >/dev/tty
}
esc.move_cursor_up() {
	printf "\033[%dA" "$1" >/dev/tty
}
esc.move_cursor_left() {
	printf "\033[%dD" "$1" >/dev/tty
}
esc.move_cursor_down() {
	printf "\033[%dB" "$1" >/dev/tty
}
esc.move_cursor_right() {
	printf "\033[%dC" "$1" >/dev/tty
}
esc.get_term_y() {
	[[ -n ${LINES-""} ]] && echo "$LINES" && return 0
	tput lines
}
esc.clear_line_and_return() {
	esc.clear_line
	esc.return
}
esc.clear_upper_lines() {
	for i in $(seq 1 "$1"); do
		esc.move_cursor_up 1
		esc.clear_line
	done
}
esc.italic() {
	printf "\033[3m" >/dev/tty
}
esc.green_background() {
	printf "\033[42m" >/dev/tty
}
esc.black_background() {
	printf "\033[40m" >/dev/tty
}
esc.blue_text() {
	printf "\033[34m" >/dev/tty
}
esc.underline() {
	printf "\033[4m" >/dev/tty
}
esc.white_text() {
	printf "\033[37m" >/dev/tty
}
esc.magenta_background() {
	printf "\033[45m" >/dev/tty
}
esc.cyan_background() {
	printf "\033[46m" >/dev/tty
}
esc.magenta_text() {
	printf "\033[35m" >/dev/tty
}
esc.yellow_text() {
	printf "\033[33m" >/dev/tty
}
esc.green_text() {
	printf "\033[32m" >/dev/tty
}
esc.white_background() {
	printf "\033[47m" >/dev/tty
}
esc.low_intensity() {
	printf "\033[2m" >/dev/tty
}
esc.yellow_background() {
	printf "\033[43m" >/dev/tty
}
esc.red_background() {
	printf "\033[41m" >/dev/tty
}
esc.reset_style() {
	printf "\033[0m" >/dev/tty
}
esc.rapid_blink() {
	printf "\033[6m" >/dev/tty
}
esc.reverse() {
	printf "\033[7m" >/dev/tty
}
esc.conceal() {
	printf "\033[8m" >/dev/tty
}
esc.blue_background() {
	printf "\033[44m" >/dev/tty
}
esc.cyan_text() {
	printf "\033[36m" >/dev/tty
}
esc.bold() {
	printf "\033[1m" >/dev/tty
}
esc.red_text() {
	printf "\033[31m" >/dev/tty
}
esc.crossed_out() {
	printf "\033[9m" >/dev/tty
}
esc.blink() {
	printf "\033[5m" >/dev/tty
}
esc.black_text() {
	printf "\033[30m" >/dev/tty
}
ini.get_last_param() {
	ini.get_param_list "$1" | tail -n 1
}
ini.get_section_list() {
	local _RawIniLine=()
	local _Line _LineNo=1 _Exit=0
	readarray -t _RawIniLine
	while read -r _Line; do
		ini.parse_line <<<"$_Line"
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
ini.get_param_list() {
	local _RawIniLine=()
	local _Line _LineNo=1 _Exit=0 _InSection=false
	readarray -t _RawIniLine
	while read -r _Line; do
		ini.parse_line <<<"$_Line"
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
ini.get_param() {
	local _RawIniLine=()
	local _Line _LineNo=1 _Exit=0 _InSection=false
	readarray -t _RawIniLine
	while read -r _Line; do
		ini.parse_line <<<"$_Line"
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
ini.parse_line() {
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
ini.new_param() {
	local IniContents=() Line
	local Section="$1" Param="$2"
	local InSection=false LineNo=0
	local NewIniContents=()
	readarray -t IniContents
	local BeforeParam
	local SectionLastParam
	local ParamAdded=false
	if ! PrintArray "${IniContents[@]}" | ini.get_param_list "$Section" | grep -qx "$Param"; then
		SectionLastParam="$(PrintEvalArray IniContents | ini.get_last_param "$Section")"
		for Line in "${IniContents[@]}"; do
			LineNo=$((LineNo + 1))
			ini.parse_line <<<"$Line"
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
ini.new_section() {
	local IniContents=()
	local Section="$1"
	readarray -t IniContents
	if PrintArray "${IniContents[@]}" | ini.get_section_list | grep -x "$Section" >/dev/null; then
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
ini.set_value() {
	local IniContents=()
	local Section="$1" Param="$2"
	readarray -t IniContents
	readarray -t IniContents < <(PrintArray "${IniContents[@]}" | ini.new_section "$Section" | ini.new_param "$Section" "$Param")
	PrintEvalArray IniContents
}
libretranslate.check() {
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
libretranslate.translate() {
	libretranslate.check || return 2
	__libre_translate_return="$(curl -s "$LIBRETRANSLATE_URL/translate" -X POST -d "q=${1:-""}&source=${2:-""}&target=${3:-""}&api_key=${LIBRETRANSLATE_APIKEY:-""}")"
	if [ "$(echo "${__libre_translate_return}" | jq -r '.error')" = "null" ]; then
		echo "${__libre_translate_return}" | jq -r '.translatedText'
		return 0
	else
		echo "${__libre_translate_return}" | jq -r '.error'
		return 1
	fi
}
libretranslate.detect() {
	libretranslate.check || return 2
	__libre_translate_return="$(curl -s "${LIBRETRANSLATE_URL}/detect" -X POST -d "q=${1:-""}&api_key=${LIBRETRANSLATE_APIKEY:-""}")"
	if [ "$(echo "${__libre_translate_return}" | jq -r '.[].error')" = "null" ]; then
		echo "${__libre_translate_return}" | jq -r '.[].language'
		return 0
	else
		echo "${__libre_translate_return}" | jq -r '.error'
		return 1
	fi
}
libretranslate.translate_auto() {
	libretranslate.check || return 2
	libretranslate.translate "${1:-""}" "$(libretranslate.detect "${1:-""}")" "${2:-""}"
}
libretranslate.languages() {
	libretranslate.check || return 2
	curl -s "${LIBRETRANSLATE_URL}/languages" | jq -r '.[].code'
}
msg.warn() {
	msg.common " Warn:" "${*}" stderr
}
msg.err() {
	msg.common "Error:" "${*}" stderr
}
msg.common() {
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
msg.debug() {
	msg.common "Debug:" "${*}" stderr
}
msg.info() {
	msg.common " Info:" "${*}" stdout
}
misskey.notes.renotes() {
	misskey.binding_base "notes/renotes" noteId limit sinceId untilId -- "$@"
}
misskey.notes.search() {
	misskey.binding_base "notes/search" query limit -- "$@"
}
misskey.notes.create() {
	misskey.binding_base "notes/create" text -- "$@"
}
misskey.users.show() {
	misskey.binding_base "users/show" userId -- "${1:-"$(misskey.my_id)"}" "${@:2}"
}
misskey.users.stats() {
	misskey.binding_base "users/stats" userId -- "${1:-"$(misskey.my_id)"}" "${@:2}"
}
misskey.users.get_frequently_replied_users() {
	misskey.binding_base "users/get-frequently-replied-users" userId -- "${1:-"$(misskey.my_id)"}" "${@:2}"
}
misskey.users.search_by_username_and_host() {
	misskey.binding_base "users/search-by-username-and-host" username -- "${1:-"$(misskey.my_user_name)"}" "${@:2}"
}
misskey.users.notes() {
	misskey.binding_base "users/notes" userId -- "${1:-"$(misskey.my_id)"}" "${@:2}"
}
misskey.users.pages() {
	misskey.binding_base "users/pages" userId -- "${1:-"$(misskey.my_id)"}" "${@:2}"
}
misskey.admin.server_info() {
	misskey.binding_base "/admin/server-info" -- "$@"
}
misskey.setup() {
	export MISSKEY_DOMAIN="${1-"${MISSKEY_DOMAIN-""}"}"
	export MISSKEY_TOKEN="${2-"${MISSKEY_TOKEN-""}"}"
	export MISSKEY_ENTRY="https://${MISSKEY_DOMAIN}/api"
}
misskey.i() {
	misskey.binding_base "/i" -- "$@"
}
misskey.server_info() {
	misskey.binding_base "/server-info" -- "$@"
}
misskey.meta() {
	misskey.binding_base "/meta" -- "$@"
}
misskey.binding_base() {
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
		misskey.setup "${MISSKEY_DOMAIN}" "$MISSKEY_TOKEN"
	fi
	misskey.send_req "${MISSKEY_ENTRY%/}/${_API#/}" "${_Args[@]}" "$@"
}
misskey.send_req() {
	local _Url="$1" _CurlArgs=()
	shift 1
	_CurlArgs+=(-s -L)
	_CurlArgs+=(-X POST)
	_CurlArgs+=(-H "Content-Type: application/json")
	_CurlArgs+=(-d "$(misskey.make_json "$@")")
	_CurlArgs+=("$_Url")
	Msg.Debug "Run: ${_CurlArgs[*]//"${MISSKEY_TOKEN}"/"TOKEN"}"
	curl "${_CurlArgs[@]}"
}
misskey.make_json() {
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
misskey.is_admin() {
	Bool "$(misskey.i | jq -r ".isAdmin")"
}
misskey.my_name() {
	misskey.i | jq -r ".name"
}
misskey.my_user_name() {
	misskey.i | jq -r ".username"
}
misskey.my_id() {
	misskey.i | jq -r ".id"
}
pm.check_pkg() {
	local p
	for p in "$@"; do
		pm.run -Qq "$p" >/dev/null 2>&1 || return 1
	done
	return 0
}
pm.get_latest_pkg_ver() {
	local _LANG="${LANG-""}"
	export LANG=C
	if [[ -z ${*} ]]; then
		cat
	else
		PrintArray "$@"
	fi | ForEach pm.run -Si "{}" | grep "^Version" | cut -d ":" -f 2 | RemoveBlank
	[[ -n $_LANG ]] && export LANG="$_LANG"
	return 0
}
pm.get_repo_list_from_conf() {
	pm.get_config --repo-list
}
pm.get_pacman_keyring_dir() {
	local _KeyringDir=""
	_KeyringDir="$(LANG=C pacman-key -h | RemoveBlank | grep -A 1 -- "^--populate" | tail -n 1 | cut -d "/" -f 2- | sed "s|'$||g")"
	: "${_KeyringDir="usr/share/pacman/keyrings"}"
	_KeyringDir="$(pm.get_root)/$_KeyringDir"
	_KeyringDir="$(sed -E "s|/+|/|g" <<<"$_KeyringDir")"
	if [[ -e $_KeyringDir ]]; then
		Readlinkf "$_KeyringDir"
	else
		echo "$_KeyringDir"
	fi
}
pm.get_repo_pkg_list() {
	pm.run -Slq "$@"
}
pm.get_repo_ver() {
	pm.run -Sp --print-format '%v' "$1"
}
pm.get_repo_server() {
	ForEach eval 'pm.get_config -r {}' | grep "^Server" | ForEach eval "Ini.ParseLine <<< '{}' ; printf '%s\n' \${VALUE}"
}
pm.is_repo_pkg() {
	pm.run -Slq | grep -qx "$(pm.get_name <<<"$1")"
}
pm.get_repo_conf() {
	ForEach eval 'echo [{}] && pm.get_config -r {}'
}
pm.get_root() {
	pm.get_config RootDir
}
pm.get_name() {
	cut -d "<" -f 1 | cut -d ">" -f 1 | cut -d "=" -f 1
}
pm.pacman_gpg() {
	gpg --homedir "$(pm.get_config GPGDir)" "$@"
}
pm.get_pacman_kernel_pkg() {
	echo "there is nothing"
}
pm.get_keyring_list() {
	find "$(@GetKeyringDir)" -name "*.gpg" | GetBaseName | RemoveFileExt
}
pm.get_installed_pkg_ver() {
	if [[ -z ${*} ]]; then
		cat
	else
		PrintArray "$@"
	fi | ForEach pacman -Q "{}" | cut -d " " -f 2
	PrintArray "${PIPESTATUS[@]}" | grep -qx "1" && return 1
	return 0
}
pm.run_key() {
	pacman-key --config "${PACMAN_CONF-"/etc/pacman.conf"}" "$@"
}
pm.run() {
	pacman --noconfirm --config "${PACMAN_CONF-"/etc/pacman.conf"}" "$@"
}
pm.get_config() {
	LANG=C pacman-conf --config="${PACMAN_CONF-"/etc/pacman.conf"}" "$@"
}
pm.get_db_section_list() {
	grep -E "^%.*%$"
}
pm.get_db_next_section() {
	pm.get_db_section_list | grep -x -A 1 "^%$1%$" | GetLine 2 | sed "s|^%||g; s|%$||g"
}
pm.get_db_section() {
	readarray -t _Stdin
	PrintArray "${_Stdin[@]}" | sed -ne "/^%$1%$/,/^%$(PrintEvalArray _Stdin | pm.get_db_next_section "$1")%$/p" | sed '1d; $d'
}
pm.opened_sync_db_list() {
	find "$(pm.get_db_tmp_dir)/sync/" -mindepth 1 -maxdepth 1 -type d
}
pm.create_db_tmp_dir() {
	mkdir -p "$(pm.get_db_tmp_dir)"
}
pm.get_sync_all_desc() {
	find "$(pm.get_db_tmp_dir)" -mindepth 3 -maxdepth 3 -name "desc" -type f
}
pm.is_opend_sync_db() {
	readarray -t _PkgDbList < <(find "$(pm.get_db_tmp_dir)/sync/$1" -mindepth 1 -maxdepth 1 -type d)
	(("${#_PkgDbList[@]}" > 0)) && return 0
	return 1
}
pm.get_virtual_pkg_list() {
	pm.get_repo_list_from_local_db | ForEach pm.open_sync_db {}
	pm.get_sync_all_desc | ForEach eval "pm.get_db_section PROVIDES < {}" | RemoveBlank
}
pm.get_db_tmp_dir() {
	echo "${TMPDIR-"/tmp"}/fasbashlib-pacman-db"
}
pm.get_sync_db_desc() {
	local _path
	_path="$(pm.get_sync_db_desc_path "$1")"
	[[ -e $_path ]] || return 1
	cat "$_path/desc"
}
pm.get_sync_db_desc_path() {
	local _repo
	_repo="$(pacman -Sp --print-format '%r' "$1")"
	{
		IsPacmanSyncDbOpend "$_repo" || OpenPacmanSyncDb "$_repo"
	} || return 1
	echo "$(pm.get_db_tmp_dir)/sync/$(pacman -Sp --print-format '%r/%n-%v' "$1")"
}
pm.parse_pkg_file_name() {
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
pm.get_repo_list_from_local_db() {
	find "$(pm.get_config DBPath)/sync" -mindepth 1 -maxdepth 1 -type f | GetBaseName | sed "s|.db$||g"
	return 0
}
pm.open_sync_db() {
	local _Dir _RepoDb
	pm.create_db_tmp_dir
	_Dir="$(pm.get_db_tmp_dir)/sync/$1"
	mkdir -p "$_Dir"
	_RepoDb="$(pm.get_config DBPath)/sync/$1.db"
	[[ -e $_RepoDb ]] || return 1
	tar -xzf "${_RepoDb}" -C "$_Dir" || return 1
}
pm.get_pkg_arch() {
	pm.get_sync_db_desc "$1" | pm.get_db_section ARCH | RemoveBlank
}
pm.delete_db_tmp_dir() {
	rm -rf "$(pm.get_db_tmp_dir)"
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
prog.bar() {
	local Max="$1" Counter="$2" Size="${3-"100"}"
	local SharpCount=$((Counter * Size / Max))
	local SpaceCount=$((Size - SharpCount))
	Esc.Return
	echo -n "$Counter/$Max [$(yes "#" | head -n "$SharpCount" 2>/dev/null | tr -d "\n")$(yes " " | head -n "$SpaceCount" 2>/dev/null | tr -d "\n")]"
}
prog.wide_bar() {
	local Max="$1" Counter="$2"
	local StatusString="$Counter/$Max"
	local Size=$(($(Esc.GetTermX) - ${#StatusString} - 3))
	prog.bar "$Max" "$Counter" "$Size"
}
prog.rotation() {
	local Count="$1" CharList=('|' '/' '-' '\')
	Esc.ClearLineAndReturn
	[[ -n ${2-""} ]] && echo -n "${2}" 1>&2
	printf "%s" "${CharList["$((Count % "${#CharList[@]}"))"]}" 1>&2
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
	readlinkf.posix "$@"
}
readlinkf.posix() {
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
readlinkf.readlink() {
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
arch.get_mkinitcpio_preset_list() {
	find "/etc/mkinitcpio.d/" -name "*.preset" -type f | GetBaseName | RemoveFileExt
}
arch.get_kernel_src_list() {
	find "/usr/src" -mindepth 1 -maxdepth 1 -type l -name "linux*"
}
arch.get_kernel_file_list() {
	find "/boot" -maxdepth 1 -mindepth 1 -name "vmlinuz-*"
}
array.append() {
	local _ArrName="$1"
	shift 1 || return 1
	readarray -t -O "$(ArrayIndex "$_ArrName")" "$_ArrName" < <(cat)
}
array.shift() {
	readarray -t "$1" < <(PrintEvalArray "$1" | sed "1,${2-"1"}d")
}
array.push() {
	eval "PrintArray \"\${$1[@]}\"" | grep -qx "$2" && return 0
	eval "$1+=(\"$2\")"
}
array.from_str() {
	declare -a -x "$1"
	readarray -t "$1" < <(BreakChar)
}
array.pop() {
	readarray -t "$1" < <(PrintEvalArray "$1" | sed -e '$d')
}
array.rev() {
	readarray -t "$1" < <(PrintEvalArray "$1" | tac)
}
array.remove() {
	readarray -t "$1" < <(PrintEvalArray "$1" | RemoveMatchLine "$2")
}
array.print() {
	(($# >= 1)) || return 0
	printf "%s\n" "${@}"
}
array.last() {
	PrintEval "$1[$(array.last_index "$1")]"
}
array.eval() {
	eval "PrintArray \"\${$1[@]}\""
}
array.length() {
	PrintEval "#${1}[@]"
}
array.index_of() {
	local n=()
	readarray -t n < <(grep -x -n "$1" | cut -d ":" -f 1 | ForEach eval echo '$(( {} - 1 ))')
	(("${#n[@]}" >= 1)) || return 1
	PrintArray "${n[@]}"
	return 0
}
array.last_index() {
	CalcInt "$(array.length "$1")" - 1
}
array.includes() {
	PrintEvalArray "$1" | grep -qx "$2"
}
array.for_each() {
	PrintEvalArray "$1" | ForEach "${@:2}"
}
array.include() {
	array.includes "$@"
}
awk.cos() {
	awk.float "cos($*)"
}
awk.tan() {
	awk.float "sin($1)/tan($1)"
}
awk.sin() {
	awk.float "sin($*)"
}
awk.pi() {
	awk.float "atan2(0, -0)"
}
awk.print() {
	awk "BEGIN {print $*}"
}
awk.log() {
	awk.float "log(${2}) / log($1)"
}
awk.rad() {
	awk.float "$1 * $(awk.pi) / 180 "
}
awk.float() {
	awk "BEGIN {printf (\"%4.${AWKSCALE-"5"}f\n\", $*)}"
}
PrintEvalArray() {
	Array.Eval "$1"
}
ArrayAppend() {
	Array.Append "$1"
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
StrToCharList() {
	Array.FromStr "$1"
}
GetArrayIndex() {
	Array.IndexOf "$1"
}
ArrayIndex() {
	Array.Length "$1"
}
AddNewToArray() {
	Array.Push "$@"
}
FileType() {
	file --mime-type -b "$1"
}
RemoveFileExt() {
	local Ext
	ForEach eval 'Ext=$(GetFileExt <<< {}); sed "s|.$Ext$||g" <<< {}; unset Ext'
}
GetFileExt() {
	GetBaseName | rev | cut -d "." -f 1 | rev
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
ToLower() {
	local _Str="${1,,}"
	[[ -z ${_Str-""} ]] || echo "${_Str}"
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
PrintEval() {
	eval echo "\${$1}"
}
RemoveBlank() {
	sed "s|^ *||g; s| *$||g; s|^	*||g; s|	*$||g; /^$/d"
}
GetMaxWidth() {
	awk '{ if ( length > x && length > 0 ) { x = length } }END{ print x }'
}
RandomString() {
	base64 <"/dev/random" | fold -w "$1" | head -n 1
	return 0
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
GetLastSplitString() {
	rev <<<"$2" | cut -d "$1" -f 1 | rev
}
CutLastString() {
	echo "${1%%"${2}"}"
	return 0
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
ToArgs() {
	readarray -t args
	"$@" "${args[@]}"
}
cache.get_file_last_update() {
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
cache.exist() {
	local _File
	_File="$(cache.create_dir)/$1"
	[[ -e $_File ]] || return 1
	(("$(cache.get_time_diff_from_last_update "$_File")" > "${KEEPCACHESEC-"86400"}")) && return 2
	return 0
}
cache.get_time_diff_from_last_update() {
	local _Now _Last
	_Now="$(date "+%s")"
	_Last="$(cache.get_file_last_update "$1")"
	echo "$((_Now - _Last))"
	return 0
}
cache.get_id() {
	if [[ -z ${FSBLIB_CACHEID-""} ]]; then
		cache.create_dir >/dev/null
	fi
	echo "$FSBLIB_CACHEID"
}
cache.get_dir() {
	echo "${TMPDIR-"/tmp"}/$(cache.get_id)"
}
cache.get() {
	cat "$(cache.get_dir)/$1" 2>/dev/null || return 1
}
cache.create() {
	cache.create_dir >/dev/null
	cat >"$(cache.get_dir)/${1}"
	cat "$(cache.get_dir)/$1"
}
cache.create_dir() {
	FSBLIB_CACHEID="${FSBLIB_CACHEID-"$(RandomString "10")"}"
	export FSBLIB_CACHEID="$FSBLIB_CACHEID"
	local TMPDIR="${TMPDIR-"/tmp"}"
	local _Dir="$TMPDIR/${FSBLIB_CACHEID}"
	mkdir -p "$_Dir"
	echo "$_Dir"
	return 0
}
fsblib.require_lib() {
	local lib missing=() return=0
	for lib in "$@"; do
		if ! [[ ${FSBLIB_LIBLIST[*]} == *" $lib "* ]]; then
			missing+=("$lib")
			return=1
		fi
	done
	return "$return"
}
fsblib_env_check() {
	fsblib.env_check
}
fsblib.env_check() {
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
csv.to_bash_array() {
	local _RawCsvLine=() _Line _ClmCnt=0
	local ArrayPrefix="${ArrayPrefix-"{}"}"
	readarray -t _RawCsvLine < <(
		while read -r _Line; do
			(($(tr "${CSVDELIM-","}" "\n" <<<"$_Line" | wc -l) >= ${#})) && echo "$_Line"
		done < <(grep -v "^#")
	)
	_ClmCnt=$(PrintArray "${_RawCsvLine[@]}" | csv.get_clm_cnt)
	while read -r _Cnt; do
		readarray -t "$(sed "s|{}|$(eval "echo \"\${${_Cnt}}\"")|g" <<<"$ArrayPrefix")" < <(
			PrintArray "${_RawCsvLine[@]}" | cut -d "${CSVDELIM-","}" -f "$_Cnt"
		)
	done < <(seq 1 "$#")
}
csv.get_clm() {
	grep -v "^#" | sed "/^$/d" | cut -d "${CSVDELIM-","}" -f "$1"
}
csv.get_clm_cnt() {
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
em.get_world_pkg_list() {
	sed -E 's|:.+$||g' /var/lib/portage/world | xargs -I{} bash -c 'ls -d /var/db/pkg/{}-* | sed "s|/var/db/pkg/||g" | grep -E "{}-[0-9]"'
}
em.get_repo_pkg_list() {
	local _RepoPath
	_RepoPath="$(em.get_repo_location "$1")"
	find "$_RepoPath" -mindepth 3 -maxdepth 3 -type f -name '*.ebuild' | sed -e "s|${_RepoPath%/}/||g" -e 's|.ebuild$||g' | awk -F "/" '{print $1"/"$3}'
}
em.get_all_pkg_list() {
	em.get_repo_conf | sed -e 's/^ *//' -e 's/ *$//' | grep "^ *location *=" | sed -e 's/^location *= *//' | xargs -L1 realpath | xargs -I{} bash -c "find '{}' -mindepth 3 -maxdepth 3 -type f -name '*.ebuild' | sed -e 's|{}/||g' -e 's|.ebuild$||g'" | awk -F "/" '{print $1"/"$3}'
}
em.get_installed_pkg_list() {
	find /var/db/pkg/ -mindepth 2 -maxdepth 2 -type d | sed 's|/var/db/pkg/||g'
}
em.get_repo_location() {
	em.get_repo_conf | Ini.GetParam "$1" location
}
em.get_repo_conf() {
	cat /etc/portage/repos.conf /etc/portage/repos.conf/* 2>/dev/null
}
em.get_default_repo_name() {
	em.get_repo_conf | Ini.GetParam DEFAULT main-repo
}
em.no_version() {
	sed -E 's|\-[0-9]+.+||g'
}
esc.clear_screen() {
	printf "\033[2J" >/dev/tty
}
esc.return() {
	printf "\r" >/dev/tty
}
esc.clear_left() {
	printf "\033[1K" >/dev/tty
}
esc.clear_line() {
	printf "\033[2K" >/dev/tty
}
esc.clear_right() {
	printf "\033[0K" >/dev/tty
}
esc.get_y() {
	local _POS
	printf "\033[6n" >>/dev/tty
	read -r -s -d "R" _POS
	echo $(("$(printf "%s\n" "${_POS:2}" | cut -d";" -f1)" - 1))
}
esc.get_x() {
	local _POS
	printf "\033[6n" >>/dev/tty
	read -r -s -d "R" _POS
	echo $(("$(printf "%s\n" "${_POS:2}" | cut -d";" -f2)" - 1))
}
esc.get_term_x() {
	[[ -n ${COLUMNS-""} ]] && echo "$COLUMNS" && return 0
	tput cols
}
esc.move_cursor() {
	printf "\033[%d;%dH" "$1" "$2" >/dev/tty
}
esc.move_cursor_up() {
	printf "\033[%dA" "$1" >/dev/tty
}
esc.move_cursor_left() {
	printf "\033[%dD" "$1" >/dev/tty
}
esc.move_cursor_down() {
	printf "\033[%dB" "$1" >/dev/tty
}
esc.move_cursor_right() {
	printf "\033[%dC" "$1" >/dev/tty
}
esc.get_term_y() {
	[[ -n ${LINES-""} ]] && echo "$LINES" && return 0
	tput lines
}
esc.clear_line_and_return() {
	esc.clear_line
	esc.return
}
esc.clear_upper_lines() {
	for i in $(seq 1 "$1"); do
		esc.move_cursor_up 1
		esc.clear_line
	done
}
esc.italic() {
	printf "\033[3m" >/dev/tty
}
esc.green_background() {
	printf "\033[42m" >/dev/tty
}
esc.black_background() {
	printf "\033[40m" >/dev/tty
}
esc.blue_text() {
	printf "\033[34m" >/dev/tty
}
esc.underline() {
	printf "\033[4m" >/dev/tty
}
esc.white_text() {
	printf "\033[37m" >/dev/tty
}
esc.magenta_background() {
	printf "\033[45m" >/dev/tty
}
esc.cyan_background() {
	printf "\033[46m" >/dev/tty
}
esc.magenta_text() {
	printf "\033[35m" >/dev/tty
}
esc.yellow_text() {
	printf "\033[33m" >/dev/tty
}
esc.green_text() {
	printf "\033[32m" >/dev/tty
}
esc.white_background() {
	printf "\033[47m" >/dev/tty
}
esc.low_intensity() {
	printf "\033[2m" >/dev/tty
}
esc.yellow_background() {
	printf "\033[43m" >/dev/tty
}
esc.red_background() {
	printf "\033[41m" >/dev/tty
}
esc.reset_style() {
	printf "\033[0m" >/dev/tty
}
esc.rapid_blink() {
	printf "\033[6m" >/dev/tty
}
esc.reverse() {
	printf "\033[7m" >/dev/tty
}
esc.conceal() {
	printf "\033[8m" >/dev/tty
}
esc.blue_background() {
	printf "\033[44m" >/dev/tty
}
esc.cyan_text() {
	printf "\033[36m" >/dev/tty
}
esc.bold() {
	printf "\033[1m" >/dev/tty
}
esc.red_text() {
	printf "\033[31m" >/dev/tty
}
esc.crossed_out() {
	printf "\033[9m" >/dev/tty
}
esc.blink() {
	printf "\033[5m" >/dev/tty
}
esc.black_text() {
	printf "\033[30m" >/dev/tty
}
ini.get_last_param() {
	ini.get_param_list "$1" | tail -n 1
}
ini.get_section_list() {
	local _RawIniLine=()
	local _Line _LineNo=1 _Exit=0
	readarray -t _RawIniLine
	while read -r _Line; do
		ini.parse_line <<<"$_Line"
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
ini.get_param_list() {
	local _RawIniLine=()
	local _Line _LineNo=1 _Exit=0 _InSection=false
	readarray -t _RawIniLine
	while read -r _Line; do
		ini.parse_line <<<"$_Line"
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
ini.get_param() {
	local _RawIniLine=()
	local _Line _LineNo=1 _Exit=0 _InSection=false
	readarray -t _RawIniLine
	while read -r _Line; do
		ini.parse_line <<<"$_Line"
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
ini.parse_line() {
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
ini.new_param() {
	local IniContents=() Line
	local Section="$1" Param="$2"
	local InSection=false LineNo=0
	local NewIniContents=()
	readarray -t IniContents
	local BeforeParam
	local SectionLastParam
	local ParamAdded=false
	if ! PrintArray "${IniContents[@]}" | ini.get_param_list "$Section" | grep -qx "$Param"; then
		SectionLastParam="$(PrintEvalArray IniContents | ini.get_last_param "$Section")"
		for Line in "${IniContents[@]}"; do
			LineNo=$((LineNo + 1))
			ini.parse_line <<<"$Line"
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
ini.new_section() {
	local IniContents=()
	local Section="$1"
	readarray -t IniContents
	if PrintArray "${IniContents[@]}" | ini.get_section_list | grep -x "$Section" >/dev/null; then
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
ini.set_value() {
	local IniContents=()
	local Section="$1" Param="$2"
	readarray -t IniContents
	readarray -t IniContents < <(PrintArray "${IniContents[@]}" | ini.new_section "$Section" | ini.new_param "$Section" "$Param")
	PrintEvalArray IniContents
}
libretranslate.check() {
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
libretranslate.translate() {
	libretranslate.check || return 2
	__libre_translate_return="$(curl -s "$LIBRETRANSLATE_URL/translate" -X POST -d "q=${1:-""}&source=${2:-""}&target=${3:-""}&api_key=${LIBRETRANSLATE_APIKEY:-""}")"
	if [ "$(echo "${__libre_translate_return}" | jq -r '.error')" = "null" ]; then
		echo "${__libre_translate_return}" | jq -r '.translatedText'
		return 0
	else
		echo "${__libre_translate_return}" | jq -r '.error'
		return 1
	fi
}
libretranslate.detect() {
	libretranslate.check || return 2
	__libre_translate_return="$(curl -s "${LIBRETRANSLATE_URL}/detect" -X POST -d "q=${1:-""}&api_key=${LIBRETRANSLATE_APIKEY:-""}")"
	if [ "$(echo "${__libre_translate_return}" | jq -r '.[].error')" = "null" ]; then
		echo "${__libre_translate_return}" | jq -r '.[].language'
		return 0
	else
		echo "${__libre_translate_return}" | jq -r '.error'
		return 1
	fi
}
libretranslate.translate_auto() {
	libretranslate.check || return 2
	libretranslate.translate "${1:-""}" "$(libretranslate.detect "${1:-""}")" "${2:-""}"
}
libretranslate.languages() {
	libretranslate.check || return 2
	curl -s "${LIBRETRANSLATE_URL}/languages" | jq -r '.[].code'
}
msg.warn() {
	msg.common " Warn:" "${*}" stderr
}
msg.err() {
	msg.common "Error:" "${*}" stderr
}
msg.common() {
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
msg.debug() {
	msg.common "Debug:" "${*}" stderr
}
msg.info() {
	msg.common " Info:" "${*}" stdout
}
misskey.notes.renotes() {
	misskey.binding_base "notes/renotes" noteId limit sinceId untilId -- "$@"
}
misskey.notes.search() {
	misskey.binding_base "notes/search" query limit -- "$@"
}
misskey.notes.create() {
	misskey.binding_base "notes/create" text -- "$@"
}
misskey.users.show() {
	misskey.binding_base "users/show" userId -- "${1:-"$(misskey.my_id)"}" "${@:2}"
}
misskey.users.stats() {
	misskey.binding_base "users/stats" userId -- "${1:-"$(misskey.my_id)"}" "${@:2}"
}
misskey.users.get_frequently_replied_users() {
	misskey.binding_base "users/get-frequently-replied-users" userId -- "${1:-"$(misskey.my_id)"}" "${@:2}"
}
misskey.users.search_by_username_and_host() {
	misskey.binding_base "users/search-by-username-and-host" username -- "${1:-"$(misskey.my_user_name)"}" "${@:2}"
}
misskey.users.notes() {
	misskey.binding_base "users/notes" userId -- "${1:-"$(misskey.my_id)"}" "${@:2}"
}
misskey.users.pages() {
	misskey.binding_base "users/pages" userId -- "${1:-"$(misskey.my_id)"}" "${@:2}"
}
misskey.admin.server_info() {
	misskey.binding_base "/admin/server-info" -- "$@"
}
misskey.setup() {
	export MISSKEY_DOMAIN="${1-"${MISSKEY_DOMAIN-""}"}"
	export MISSKEY_TOKEN="${2-"${MISSKEY_TOKEN-""}"}"
	export MISSKEY_ENTRY="https://${MISSKEY_DOMAIN}/api"
}
misskey.i() {
	misskey.binding_base "/i" -- "$@"
}
misskey.server_info() {
	misskey.binding_base "/server-info" -- "$@"
}
misskey.meta() {
	misskey.binding_base "/meta" -- "$@"
}
misskey.binding_base() {
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
		misskey.setup "${MISSKEY_DOMAIN}" "$MISSKEY_TOKEN"
	fi
	misskey.send_req "${MISSKEY_ENTRY%/}/${_API#/}" "${_Args[@]}" "$@"
}
misskey.send_req() {
	local _Url="$1" _CurlArgs=()
	shift 1
	_CurlArgs+=(-s -L)
	_CurlArgs+=(-X POST)
	_CurlArgs+=(-H "Content-Type: application/json")
	_CurlArgs+=(-d "$(misskey.make_json "$@")")
	_CurlArgs+=("$_Url")
	Msg.Debug "Run: ${_CurlArgs[*]//"${MISSKEY_TOKEN}"/"TOKEN"}"
	curl "${_CurlArgs[@]}"
}
misskey.make_json() {
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
misskey.is_admin() {
	Bool "$(misskey.i | jq -r ".isAdmin")"
}
misskey.my_name() {
	misskey.i | jq -r ".name"
}
misskey.my_user_name() {
	misskey.i | jq -r ".username"
}
misskey.my_id() {
	misskey.i | jq -r ".id"
}
pm.check_pkg() {
	local p
	for p in "$@"; do
		pm.run -Qq "$p" >/dev/null 2>&1 || return 1
	done
	return 0
}
pm.get_latest_pkg_ver() {
	local _LANG="${LANG-""}"
	export LANG=C
	if [[ -z ${*} ]]; then
		cat
	else
		PrintArray "$@"
	fi | ForEach pm.run -Si "{}" | grep "^Version" | cut -d ":" -f 2 | RemoveBlank
	[[ -n $_LANG ]] && export LANG="$_LANG"
	return 0
}
pm.get_repo_list_from_conf() {
	pm.get_config --repo-list
}
pm.get_pacman_keyring_dir() {
	local _KeyringDir=""
	_KeyringDir="$(LANG=C pacman-key -h | RemoveBlank | grep -A 1 -- "^--populate" | tail -n 1 | cut -d "/" -f 2- | sed "s|'$||g")"
	: "${_KeyringDir="usr/share/pacman/keyrings"}"
	_KeyringDir="$(pm.get_root)/$_KeyringDir"
	_KeyringDir="$(sed -E "s|/+|/|g" <<<"$_KeyringDir")"
	if [[ -e $_KeyringDir ]]; then
		Readlinkf "$_KeyringDir"
	else
		echo "$_KeyringDir"
	fi
}
pm.get_repo_pkg_list() {
	pm.run -Slq "$@"
}
pm.get_repo_ver() {
	pm.run -Sp --print-format '%v' "$1"
}
pm.get_repo_server() {
	ForEach eval 'pm.get_config -r {}' | grep "^Server" | ForEach eval "Ini.ParseLine <<< '{}' ; printf '%s\n' \${VALUE}"
}
pm.is_repo_pkg() {
	pm.run -Slq | grep -qx "$(pm.get_name <<<"$1")"
}
pm.get_repo_conf() {
	ForEach eval 'echo [{}] && pm.get_config -r {}'
}
pm.get_root() {
	pm.get_config RootDir
}
pm.get_name() {
	cut -d "<" -f 1 | cut -d ">" -f 1 | cut -d "=" -f 1
}
pm.pacman_gpg() {
	gpg --homedir "$(pm.get_config GPGDir)" "$@"
}
pm.get_pacman_kernel_pkg() {
	echo "there is nothing"
}
pm.get_keyring_list() {
	find "$(@GetKeyringDir)" -name "*.gpg" | GetBaseName | RemoveFileExt
}
pm.get_installed_pkg_ver() {
	if [[ -z ${*} ]]; then
		cat
	else
		PrintArray "$@"
	fi | ForEach pacman -Q "{}" | cut -d " " -f 2
	PrintArray "${PIPESTATUS[@]}" | grep -qx "1" && return 1
	return 0
}
pm.run_key() {
	pacman-key --config "${PACMAN_CONF-"/etc/pacman.conf"}" "$@"
}
pm.run() {
	pacman --noconfirm --config "${PACMAN_CONF-"/etc/pacman.conf"}" "$@"
}
pm.get_config() {
	LANG=C pacman-conf --config="${PACMAN_CONF-"/etc/pacman.conf"}" "$@"
}
pm.get_db_section_list() {
	grep -E "^%.*%$"
}
pm.get_db_next_section() {
	pm.get_db_section_list | grep -x -A 1 "^%$1%$" | GetLine 2 | sed "s|^%||g; s|%$||g"
}
pm.get_db_section() {
	readarray -t _Stdin
	PrintArray "${_Stdin[@]}" | sed -ne "/^%$1%$/,/^%$(PrintEvalArray _Stdin | pm.get_db_next_section "$1")%$/p" | sed '1d; $d'
}
pm.opened_sync_db_list() {
	find "$(pm.get_db_tmp_dir)/sync/" -mindepth 1 -maxdepth 1 -type d
}
pm.create_db_tmp_dir() {
	mkdir -p "$(pm.get_db_tmp_dir)"
}
pm.get_sync_all_desc() {
	find "$(pm.get_db_tmp_dir)" -mindepth 3 -maxdepth 3 -name "desc" -type f
}
pm.is_opend_sync_db() {
	readarray -t _PkgDbList < <(find "$(pm.get_db_tmp_dir)/sync/$1" -mindepth 1 -maxdepth 1 -type d)
	(("${#_PkgDbList[@]}" > 0)) && return 0
	return 1
}
pm.get_virtual_pkg_list() {
	pm.get_repo_list_from_local_db | ForEach pm.open_sync_db {}
	pm.get_sync_all_desc | ForEach eval "pm.get_db_section PROVIDES < {}" | RemoveBlank
}
pm.get_db_tmp_dir() {
	echo "${TMPDIR-"/tmp"}/fasbashlib-pacman-db"
}
pm.get_sync_db_desc() {
	local _path
	_path="$(pm.get_sync_db_desc_path "$1")"
	[[ -e $_path ]] || return 1
	cat "$_path/desc"
}
pm.get_sync_db_desc_path() {
	local _repo
	_repo="$(pacman -Sp --print-format '%r' "$1")"
	{
		IsPacmanSyncDbOpend "$_repo" || OpenPacmanSyncDb "$_repo"
	} || return 1
	echo "$(pm.get_db_tmp_dir)/sync/$(pacman -Sp --print-format '%r/%n-%v' "$1")"
}
pm.parse_pkg_file_name() {
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
pm.get_repo_list_from_local_db() {
	find "$(pm.get_config DBPath)/sync" -mindepth 1 -maxdepth 1 -type f | GetBaseName | sed "s|.db$||g"
	return 0
}
pm.open_sync_db() {
	local _Dir _RepoDb
	pm.create_db_tmp_dir
	_Dir="$(pm.get_db_tmp_dir)/sync/$1"
	mkdir -p "$_Dir"
	_RepoDb="$(pm.get_config DBPath)/sync/$1.db"
	[[ -e $_RepoDb ]] || return 1
	tar -xzf "${_RepoDb}" -C "$_Dir" || return 1
}
pm.get_pkg_arch() {
	pm.get_sync_db_desc "$1" | pm.get_db_section ARCH | RemoveBlank
}
pm.delete_db_tmp_dir() {
	rm -rf "$(pm.get_db_tmp_dir)"
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
prog.bar() {
	local Max="$1" Counter="$2" Size="${3-"100"}"
	local SharpCount=$((Counter * Size / Max))
	local SpaceCount=$((Size - SharpCount))
	Esc.Return
	echo -n "$Counter/$Max [$(yes "#" | head -n "$SharpCount" 2>/dev/null | tr -d "\n")$(yes " " | head -n "$SpaceCount" 2>/dev/null | tr -d "\n")]"
}
prog.wide_bar() {
	local Max="$1" Counter="$2"
	local StatusString="$Counter/$Max"
	local Size=$(($(Esc.GetTermX) - ${#StatusString} - 3))
	prog.bar "$Max" "$Counter" "$Size"
}
prog.rotation() {
	local Count="$1" CharList=('|' '/' '-' '\')
	Esc.ClearLineAndReturn
	[[ -n ${2-""} ]] && echo -n "${2}" 1>&2
	printf "%s" "${CharList["$((Count % "${#CharList[@]}"))"]}" 1>&2
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
	readlinkf.posix "$@"
}
readlinkf.posix() {
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
readlinkf.readlink() {
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
sqlite3.select() {
	local _table="$1" _args=()
	shift 1 || return 1
	local _values=("$@")
	_args+=(select)
	ForEach eval '_args+=("\"{}\"" ,)' < <(PrintEvalArray _values)
	Array.Pop _args
	_args+=("from" "$_table" ";")
	sqlite3.call "${_args[*]}"
}
sqlite3.call() {
	Msg.Debug sqlite3 "${SQLITE3_OPTIONS[@]}" "$SQLITE3_DBPATH" "$@" 1>&2
	sqlite3 "${SQLITE3_OPTIONS[@]}" "$SQLITE3_DBPATH" "$@"
}
sqlite3.current_db() {
	if [[ -z ${SQLITE3_DBPATH-""} ]]; then
		Msg.Err "No datebase is connected."
		return 1
	fi
	echo "${SQLITE3_DBPATH}"
	return 0
}
sqlite3.select_all() {
	local _table="$1" _args=()
	shift 1 || return 1
	sqlite3.call "select * from $_table"
}
sqlite3.exist_table() {
	local _result
	_result="$(sqlite3.call "SELECT COUNT(*) 
                            FROM sqlite_master 
                            WHERE TYPE='table' AND name='$1';
            ")"
	if ((_result > 0)); then
		return 0
	fi
	return 1
}
sqlite3.exist_field() {
	_result="$(sqlite3.call "SELECT * FROM '$1' WHERE $2 = '$3' LIMIT 1;")"
	if [[ -n ${_result-""} ]]; then
		return 0
	fi
	return 1
}
sqlite3.delete() {
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
	sqlite3.call "${_args[*]}"
}
sqlite3.insert() {
	local _table="$1" _args=()
	shift 1 || return 1
	local _values=("$@")
	_args+=(insert into "$_table" values '(')
	ForEach eval '_args+=("\"{}\"" ,)' < <(PrintEvalArray _values)
	Array.Pop _args
	_args+=(");")
	sqlite3.call "${_args[*]}"
}
sqlite3.create() {
	local _table="$1" _args=() _columns=()
	shift 1 || return 1
	_columns=("$@")
	_args+=(create table "$_table" "(")
	ForEach eval '_args+=("\"{}\"" ,)' < <(PrintEvalArray _columns)
	Array.Pop _args
	_args+=(")")
	sqlite3.call "${_args[*]}"
}
sqlite3.connect() {
	export SQLITE3_DBPATH="$1"
	echo ".open \"$SQLITE3_DBPATH\"" | sqlite3
	return 0
}
arch.get_mkinitcpio_preset_list() {
	find "/etc/mkinitcpio.d/" -name "*.preset" -type f | GetBaseName | RemoveFileExt
}
arch.get_kernel_src_list() {
	find "/usr/src" -mindepth 1 -maxdepth 1 -type l -name "linux*"
}
arch.get_kernel_file_list() {
	find "/boot" -maxdepth 1 -mindepth 1 -name "vmlinuz-*"
}
array.append() {
	local _ArrName="$1"
	shift 1 || return 1
	readarray -t -O "$(ArrayIndex "$_ArrName")" "$_ArrName" < <(cat)
}
array.shift() {
	readarray -t "$1" < <(PrintEvalArray "$1" | sed "1,${2-"1"}d")
}
array.push() {
	eval "PrintArray \"\${$1[@]}\"" | grep -qx "$2" && return 0
	eval "$1+=(\"$2\")"
}
array.from_str() {
	declare -a -x "$1"
	readarray -t "$1" < <(BreakChar)
}
array.pop() {
	readarray -t "$1" < <(PrintEvalArray "$1" | sed -e '$d')
}
array.rev() {
	readarray -t "$1" < <(PrintEvalArray "$1" | tac)
}
array.remove() {
	readarray -t "$1" < <(PrintEvalArray "$1" | RemoveMatchLine "$2")
}
array.print() {
	(($# >= 1)) || return 0
	printf "%s\n" "${@}"
}
array.last() {
	PrintEval "$1[$(array.last_index "$1")]"
}
array.eval() {
	eval "PrintArray \"\${$1[@]}\""
}
array.length() {
	PrintEval "#${1}[@]"
}
array.index_of() {
	local n=()
	readarray -t n < <(grep -x -n "$1" | cut -d ":" -f 1 | ForEach eval echo '$(( {} - 1 ))')
	(("${#n[@]}" >= 1)) || return 1
	PrintArray "${n[@]}"
	return 0
}
array.last_index() {
	CalcInt "$(array.length "$1")" - 1
}
array.includes() {
	PrintEvalArray "$1" | grep -qx "$2"
}
array.for_each() {
	PrintEvalArray "$1" | ForEach "${@:2}"
}
array.include() {
	array.includes "$@"
}
awk.cos() {
	awk.float "cos($*)"
}
awk.tan() {
	awk.float "sin($1)/tan($1)"
}
awk.sin() {
	awk.float "sin($*)"
}
awk.pi() {
	awk.float "atan2(0, -0)"
}
awk.print() {
	awk "BEGIN {print $*}"
}
awk.log() {
	awk.float "log(${2}) / log($1)"
}
awk.rad() {
	awk.float "$1 * $(awk.pi) / 180 "
}
awk.float() {
	awk "BEGIN {printf (\"%4.${AWKSCALE-"5"}f\n\", $*)}"
}
PrintEvalArray() {
	Array.Eval "$1"
}
ArrayAppend() {
	Array.Append "$1"
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
StrToCharList() {
	Array.FromStr "$1"
}
GetArrayIndex() {
	Array.IndexOf "$1"
}
ArrayIndex() {
	Array.Length "$1"
}
AddNewToArray() {
	Array.Push "$@"
}
FileType() {
	file --mime-type -b "$1"
}
RemoveFileExt() {
	local Ext
	ForEach eval 'Ext=$(GetFileExt <<< {}); sed "s|.$Ext$||g" <<< {}; unset Ext'
}
GetFileExt() {
	GetBaseName | rev | cut -d "." -f 1 | rev
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
ToLower() {
	local _Str="${1,,}"
	[[ -z ${_Str-""} ]] || echo "${_Str}"
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
PrintEval() {
	eval echo "\${$1}"
}
RemoveBlank() {
	sed "s|^ *||g; s| *$||g; s|^	*||g; s|	*$||g; /^$/d"
}
GetMaxWidth() {
	awk '{ if ( length > x && length > 0 ) { x = length } }END{ print x }'
}
RandomString() {
	base64 <"/dev/random" | fold -w "$1" | head -n 1
	return 0
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
GetLastSplitString() {
	rev <<<"$2" | cut -d "$1" -f 1 | rev
}
CutLastString() {
	echo "${1%%"${2}"}"
	return 0
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
ToArgs() {
	readarray -t args
	"$@" "${args[@]}"
}
cache.get_file_last_update() {
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
cache.exist() {
	local _File
	_File="$(cache.create_dir)/$1"
	[[ -e $_File ]] || return 1
	(("$(cache.get_time_diff_from_last_update "$_File")" > "${KEEPCACHESEC-"86400"}")) && return 2
	return 0
}
cache.get_time_diff_from_last_update() {
	local _Now _Last
	_Now="$(date "+%s")"
	_Last="$(cache.get_file_last_update "$1")"
	echo "$((_Now - _Last))"
	return 0
}
cache.get_id() {
	if [[ -z ${FSBLIB_CACHEID-""} ]]; then
		cache.create_dir >/dev/null
	fi
	echo "$FSBLIB_CACHEID"
}
cache.get_dir() {
	echo "${TMPDIR-"/tmp"}/$(cache.get_id)"
}
cache.get() {
	cat "$(cache.get_dir)/$1" 2>/dev/null || return 1
}
cache.create() {
	cache.create_dir >/dev/null
	cat >"$(cache.get_dir)/${1}"
	cat "$(cache.get_dir)/$1"
}
cache.create_dir() {
	FSBLIB_CACHEID="${FSBLIB_CACHEID-"$(RandomString "10")"}"
	export FSBLIB_CACHEID="$FSBLIB_CACHEID"
	local TMPDIR="${TMPDIR-"/tmp"}"
	local _Dir="$TMPDIR/${FSBLIB_CACHEID}"
	mkdir -p "$_Dir"
	echo "$_Dir"
	return 0
}
fsblib.require_lib() {
	local lib missing=() return=0
	for lib in "$@"; do
		if ! [[ ${FSBLIB_LIBLIST[*]} == *" $lib "* ]]; then
			missing+=("$lib")
			return=1
		fi
	done
	return "$return"
}
fsblib_env_check() {
	fsblib.env_check
}
fsblib.env_check() {
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
csv.to_bash_array() {
	local _RawCsvLine=() _Line _ClmCnt=0
	local ArrayPrefix="${ArrayPrefix-"{}"}"
	readarray -t _RawCsvLine < <(
		while read -r _Line; do
			(($(tr "${CSVDELIM-","}" "\n" <<<"$_Line" | wc -l) >= ${#})) && echo "$_Line"
		done < <(grep -v "^#")
	)
	_ClmCnt=$(PrintArray "${_RawCsvLine[@]}" | csv.get_clm_cnt)
	while read -r _Cnt; do
		readarray -t "$(sed "s|{}|$(eval "echo \"\${${_Cnt}}\"")|g" <<<"$ArrayPrefix")" < <(
			PrintArray "${_RawCsvLine[@]}" | cut -d "${CSVDELIM-","}" -f "$_Cnt"
		)
	done < <(seq 1 "$#")
}
csv.get_clm() {
	grep -v "^#" | sed "/^$/d" | cut -d "${CSVDELIM-","}" -f "$1"
}
csv.get_clm_cnt() {
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
em.get_world_pkg_list() {
	sed -E 's|:.+$||g' /var/lib/portage/world | xargs -I{} bash -c 'ls -d /var/db/pkg/{}-* | sed "s|/var/db/pkg/||g" | grep -E "{}-[0-9]"'
}
em.get_repo_pkg_list() {
	local _RepoPath
	_RepoPath="$(em.get_repo_location "$1")"
	find "$_RepoPath" -mindepth 3 -maxdepth 3 -type f -name '*.ebuild' | sed -e "s|${_RepoPath%/}/||g" -e 's|.ebuild$||g' | awk -F "/" '{print $1"/"$3}'
}
em.get_all_pkg_list() {
	em.get_repo_conf | sed -e 's/^ *//' -e 's/ *$//' | grep "^ *location *=" | sed -e 's/^location *= *//' | xargs -L1 realpath | xargs -I{} bash -c "find '{}' -mindepth 3 -maxdepth 3 -type f -name '*.ebuild' | sed -e 's|{}/||g' -e 's|.ebuild$||g'" | awk -F "/" '{print $1"/"$3}'
}
em.get_installed_pkg_list() {
	find /var/db/pkg/ -mindepth 2 -maxdepth 2 -type d | sed 's|/var/db/pkg/||g'
}
em.get_repo_location() {
	em.get_repo_conf | Ini.GetParam "$1" location
}
em.get_repo_conf() {
	cat /etc/portage/repos.conf /etc/portage/repos.conf/* 2>/dev/null
}
em.get_default_repo_name() {
	em.get_repo_conf | Ini.GetParam DEFAULT main-repo
}
em.no_version() {
	sed -E 's|\-[0-9]+.+||g'
}
esc.clear_screen() {
	printf "\033[2J" >/dev/tty
}
esc.return() {
	printf "\r" >/dev/tty
}
esc.clear_left() {
	printf "\033[1K" >/dev/tty
}
esc.clear_line() {
	printf "\033[2K" >/dev/tty
}
esc.clear_right() {
	printf "\033[0K" >/dev/tty
}
esc.get_y() {
	local _POS
	printf "\033[6n" >>/dev/tty
	read -r -s -d "R" _POS
	echo $(("$(printf "%s\n" "${_POS:2}" | cut -d";" -f1)" - 1))
}
esc.get_x() {
	local _POS
	printf "\033[6n" >>/dev/tty
	read -r -s -d "R" _POS
	echo $(("$(printf "%s\n" "${_POS:2}" | cut -d";" -f2)" - 1))
}
esc.get_term_x() {
	[[ -n ${COLUMNS-""} ]] && echo "$COLUMNS" && return 0
	tput cols
}
esc.move_cursor() {
	printf "\033[%d;%dH" "$1" "$2" >/dev/tty
}
esc.move_cursor_up() {
	printf "\033[%dA" "$1" >/dev/tty
}
esc.move_cursor_left() {
	printf "\033[%dD" "$1" >/dev/tty
}
esc.move_cursor_down() {
	printf "\033[%dB" "$1" >/dev/tty
}
esc.move_cursor_right() {
	printf "\033[%dC" "$1" >/dev/tty
}
esc.get_term_y() {
	[[ -n ${LINES-""} ]] && echo "$LINES" && return 0
	tput lines
}
esc.clear_line_and_return() {
	esc.clear_line
	esc.return
}
esc.clear_upper_lines() {
	for i in $(seq 1 "$1"); do
		esc.move_cursor_up 1
		esc.clear_line
	done
}
esc.italic() {
	printf "\033[3m" >/dev/tty
}
esc.green_background() {
	printf "\033[42m" >/dev/tty
}
esc.black_background() {
	printf "\033[40m" >/dev/tty
}
esc.blue_text() {
	printf "\033[34m" >/dev/tty
}
esc.underline() {
	printf "\033[4m" >/dev/tty
}
esc.white_text() {
	printf "\033[37m" >/dev/tty
}
esc.magenta_background() {
	printf "\033[45m" >/dev/tty
}
esc.cyan_background() {
	printf "\033[46m" >/dev/tty
}
esc.magenta_text() {
	printf "\033[35m" >/dev/tty
}
esc.yellow_text() {
	printf "\033[33m" >/dev/tty
}
esc.green_text() {
	printf "\033[32m" >/dev/tty
}
esc.white_background() {
	printf "\033[47m" >/dev/tty
}
esc.low_intensity() {
	printf "\033[2m" >/dev/tty
}
esc.yellow_background() {
	printf "\033[43m" >/dev/tty
}
esc.red_background() {
	printf "\033[41m" >/dev/tty
}
esc.reset_style() {
	printf "\033[0m" >/dev/tty
}
esc.rapid_blink() {
	printf "\033[6m" >/dev/tty
}
esc.reverse() {
	printf "\033[7m" >/dev/tty
}
esc.conceal() {
	printf "\033[8m" >/dev/tty
}
esc.blue_background() {
	printf "\033[44m" >/dev/tty
}
esc.cyan_text() {
	printf "\033[36m" >/dev/tty
}
esc.bold() {
	printf "\033[1m" >/dev/tty
}
esc.red_text() {
	printf "\033[31m" >/dev/tty
}
esc.crossed_out() {
	printf "\033[9m" >/dev/tty
}
esc.blink() {
	printf "\033[5m" >/dev/tty
}
esc.black_text() {
	printf "\033[30m" >/dev/tty
}
ini.get_last_param() {
	ini.get_param_list "$1" | tail -n 1
}
ini.get_section_list() {
	local _RawIniLine=()
	local _Line _LineNo=1 _Exit=0
	readarray -t _RawIniLine
	while read -r _Line; do
		ini.parse_line <<<"$_Line"
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
ini.get_param_list() {
	local _RawIniLine=()
	local _Line _LineNo=1 _Exit=0 _InSection=false
	readarray -t _RawIniLine
	while read -r _Line; do
		ini.parse_line <<<"$_Line"
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
ini.get_param() {
	local _RawIniLine=()
	local _Line _LineNo=1 _Exit=0 _InSection=false
	readarray -t _RawIniLine
	while read -r _Line; do
		ini.parse_line <<<"$_Line"
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
ini.parse_line() {
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
ini.new_param() {
	local IniContents=() Line
	local Section="$1" Param="$2"
	local InSection=false LineNo=0
	local NewIniContents=()
	readarray -t IniContents
	local BeforeParam
	local SectionLastParam
	local ParamAdded=false
	if ! PrintArray "${IniContents[@]}" | ini.get_param_list "$Section" | grep -qx "$Param"; then
		SectionLastParam="$(PrintEvalArray IniContents | ini.get_last_param "$Section")"
		for Line in "${IniContents[@]}"; do
			LineNo=$((LineNo + 1))
			ini.parse_line <<<"$Line"
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
ini.new_section() {
	local IniContents=()
	local Section="$1"
	readarray -t IniContents
	if PrintArray "${IniContents[@]}" | ini.get_section_list | grep -x "$Section" >/dev/null; then
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
ini.set_value() {
	local IniContents=()
	local Section="$1" Param="$2"
	readarray -t IniContents
	readarray -t IniContents < <(PrintArray "${IniContents[@]}" | ini.new_section "$Section" | ini.new_param "$Section" "$Param")
	PrintEvalArray IniContents
}
libretranslate.check() {
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
libretranslate.translate() {
	libretranslate.check || return 2
	__libre_translate_return="$(curl -s "$LIBRETRANSLATE_URL/translate" -X POST -d "q=${1:-""}&source=${2:-""}&target=${3:-""}&api_key=${LIBRETRANSLATE_APIKEY:-""}")"
	if [ "$(echo "${__libre_translate_return}" | jq -r '.error')" = "null" ]; then
		echo "${__libre_translate_return}" | jq -r '.translatedText'
		return 0
	else
		echo "${__libre_translate_return}" | jq -r '.error'
		return 1
	fi
}
libretranslate.detect() {
	libretranslate.check || return 2
	__libre_translate_return="$(curl -s "${LIBRETRANSLATE_URL}/detect" -X POST -d "q=${1:-""}&api_key=${LIBRETRANSLATE_APIKEY:-""}")"
	if [ "$(echo "${__libre_translate_return}" | jq -r '.[].error')" = "null" ]; then
		echo "${__libre_translate_return}" | jq -r '.[].language'
		return 0
	else
		echo "${__libre_translate_return}" | jq -r '.error'
		return 1
	fi
}
libretranslate.translate_auto() {
	libretranslate.check || return 2
	libretranslate.translate "${1:-""}" "$(libretranslate.detect "${1:-""}")" "${2:-""}"
}
libretranslate.languages() {
	libretranslate.check || return 2
	curl -s "${LIBRETRANSLATE_URL}/languages" | jq -r '.[].code'
}
msg.warn() {
	msg.common " Warn:" "${*}" stderr
}
msg.err() {
	msg.common "Error:" "${*}" stderr
}
msg.common() {
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
msg.debug() {
	msg.common "Debug:" "${*}" stderr
}
msg.info() {
	msg.common " Info:" "${*}" stdout
}
misskey.notes.renotes() {
	misskey.binding_base "notes/renotes" noteId limit sinceId untilId -- "$@"
}
misskey.notes.search() {
	misskey.binding_base "notes/search" query limit -- "$@"
}
misskey.notes.create() {
	misskey.binding_base "notes/create" text -- "$@"
}
misskey.users.show() {
	misskey.binding_base "users/show" userId -- "${1:-"$(misskey.my_id)"}" "${@:2}"
}
misskey.users.stats() {
	misskey.binding_base "users/stats" userId -- "${1:-"$(misskey.my_id)"}" "${@:2}"
}
misskey.users.get_frequently_replied_users() {
	misskey.binding_base "users/get-frequently-replied-users" userId -- "${1:-"$(misskey.my_id)"}" "${@:2}"
}
misskey.users.search_by_username_and_host() {
	misskey.binding_base "users/search-by-username-and-host" username -- "${1:-"$(misskey.my_user_name)"}" "${@:2}"
}
misskey.users.notes() {
	misskey.binding_base "users/notes" userId -- "${1:-"$(misskey.my_id)"}" "${@:2}"
}
misskey.users.pages() {
	misskey.binding_base "users/pages" userId -- "${1:-"$(misskey.my_id)"}" "${@:2}"
}
misskey.admin.server_info() {
	misskey.binding_base "/admin/server-info" -- "$@"
}
misskey.setup() {
	export MISSKEY_DOMAIN="${1-"${MISSKEY_DOMAIN-""}"}"
	export MISSKEY_TOKEN="${2-"${MISSKEY_TOKEN-""}"}"
	export MISSKEY_ENTRY="https://${MISSKEY_DOMAIN}/api"
}
misskey.i() {
	misskey.binding_base "/i" -- "$@"
}
misskey.server_info() {
	misskey.binding_base "/server-info" -- "$@"
}
misskey.meta() {
	misskey.binding_base "/meta" -- "$@"
}
misskey.binding_base() {
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
		misskey.setup "${MISSKEY_DOMAIN}" "$MISSKEY_TOKEN"
	fi
	misskey.send_req "${MISSKEY_ENTRY%/}/${_API#/}" "${_Args[@]}" "$@"
}
misskey.send_req() {
	local _Url="$1" _CurlArgs=()
	shift 1
	_CurlArgs+=(-s -L)
	_CurlArgs+=(-X POST)
	_CurlArgs+=(-H "Content-Type: application/json")
	_CurlArgs+=(-d "$(misskey.make_json "$@")")
	_CurlArgs+=("$_Url")
	Msg.Debug "Run: ${_CurlArgs[*]//"${MISSKEY_TOKEN}"/"TOKEN"}"
	curl "${_CurlArgs[@]}"
}
misskey.make_json() {
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
misskey.is_admin() {
	Bool "$(misskey.i | jq -r ".isAdmin")"
}
misskey.my_name() {
	misskey.i | jq -r ".name"
}
misskey.my_user_name() {
	misskey.i | jq -r ".username"
}
misskey.my_id() {
	misskey.i | jq -r ".id"
}
pm.check_pkg() {
	local p
	for p in "$@"; do
		pm.run -Qq "$p" >/dev/null 2>&1 || return 1
	done
	return 0
}
pm.get_latest_pkg_ver() {
	local _LANG="${LANG-""}"
	export LANG=C
	if [[ -z ${*} ]]; then
		cat
	else
		PrintArray "$@"
	fi | ForEach pm.run -Si "{}" | grep "^Version" | cut -d ":" -f 2 | RemoveBlank
	[[ -n $_LANG ]] && export LANG="$_LANG"
	return 0
}
pm.get_repo_list_from_conf() {
	pm.get_config --repo-list
}
pm.get_pacman_keyring_dir() {
	local _KeyringDir=""
	_KeyringDir="$(LANG=C pacman-key -h | RemoveBlank | grep -A 1 -- "^--populate" | tail -n 1 | cut -d "/" -f 2- | sed "s|'$||g")"
	: "${_KeyringDir="usr/share/pacman/keyrings"}"
	_KeyringDir="$(pm.get_root)/$_KeyringDir"
	_KeyringDir="$(sed -E "s|/+|/|g" <<<"$_KeyringDir")"
	if [[ -e $_KeyringDir ]]; then
		Readlinkf "$_KeyringDir"
	else
		echo "$_KeyringDir"
	fi
}
pm.get_repo_pkg_list() {
	pm.run -Slq "$@"
}
pm.get_repo_ver() {
	pm.run -Sp --print-format '%v' "$1"
}
pm.get_repo_server() {
	ForEach eval 'pm.get_config -r {}' | grep "^Server" | ForEach eval "Ini.ParseLine <<< '{}' ; printf '%s\n' \${VALUE}"
}
pm.is_repo_pkg() {
	pm.run -Slq | grep -qx "$(pm.get_name <<<"$1")"
}
pm.get_repo_conf() {
	ForEach eval 'echo [{}] && pm.get_config -r {}'
}
pm.get_root() {
	pm.get_config RootDir
}
pm.get_name() {
	cut -d "<" -f 1 | cut -d ">" -f 1 | cut -d "=" -f 1
}
pm.pacman_gpg() {
	gpg --homedir "$(pm.get_config GPGDir)" "$@"
}
pm.get_pacman_kernel_pkg() {
	echo "there is nothing"
}
pm.get_keyring_list() {
	find "$(@GetKeyringDir)" -name "*.gpg" | GetBaseName | RemoveFileExt
}
pm.get_installed_pkg_ver() {
	if [[ -z ${*} ]]; then
		cat
	else
		PrintArray "$@"
	fi | ForEach pacman -Q "{}" | cut -d " " -f 2
	PrintArray "${PIPESTATUS[@]}" | grep -qx "1" && return 1
	return 0
}
pm.run_key() {
	pacman-key --config "${PACMAN_CONF-"/etc/pacman.conf"}" "$@"
}
pm.run() {
	pacman --noconfirm --config "${PACMAN_CONF-"/etc/pacman.conf"}" "$@"
}
pm.get_config() {
	LANG=C pacman-conf --config="${PACMAN_CONF-"/etc/pacman.conf"}" "$@"
}
pm.get_db_section_list() {
	grep -E "^%.*%$"
}
pm.get_db_next_section() {
	pm.get_db_section_list | grep -x -A 1 "^%$1%$" | GetLine 2 | sed "s|^%||g; s|%$||g"
}
pm.get_db_section() {
	readarray -t _Stdin
	PrintArray "${_Stdin[@]}" | sed -ne "/^%$1%$/,/^%$(PrintEvalArray _Stdin | pm.get_db_next_section "$1")%$/p" | sed '1d; $d'
}
pm.opened_sync_db_list() {
	find "$(pm.get_db_tmp_dir)/sync/" -mindepth 1 -maxdepth 1 -type d
}
pm.create_db_tmp_dir() {
	mkdir -p "$(pm.get_db_tmp_dir)"
}
pm.get_sync_all_desc() {
	find "$(pm.get_db_tmp_dir)" -mindepth 3 -maxdepth 3 -name "desc" -type f
}
pm.is_opend_sync_db() {
	readarray -t _PkgDbList < <(find "$(pm.get_db_tmp_dir)/sync/$1" -mindepth 1 -maxdepth 1 -type d)
	(("${#_PkgDbList[@]}" > 0)) && return 0
	return 1
}
pm.get_virtual_pkg_list() {
	pm.get_repo_list_from_local_db | ForEach pm.open_sync_db {}
	pm.get_sync_all_desc | ForEach eval "pm.get_db_section PROVIDES < {}" | RemoveBlank
}
pm.get_db_tmp_dir() {
	echo "${TMPDIR-"/tmp"}/fasbashlib-pacman-db"
}
pm.get_sync_db_desc() {
	local _path
	_path="$(pm.get_sync_db_desc_path "$1")"
	[[ -e $_path ]] || return 1
	cat "$_path/desc"
}
pm.get_sync_db_desc_path() {
	local _repo
	_repo="$(pacman -Sp --print-format '%r' "$1")"
	{
		IsPacmanSyncDbOpend "$_repo" || OpenPacmanSyncDb "$_repo"
	} || return 1
	echo "$(pm.get_db_tmp_dir)/sync/$(pacman -Sp --print-format '%r/%n-%v' "$1")"
}
pm.parse_pkg_file_name() {
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
pm.get_repo_list_from_local_db() {
	find "$(pm.get_config DBPath)/sync" -mindepth 1 -maxdepth 1 -type f | GetBaseName | sed "s|.db$||g"
	return 0
}
pm.open_sync_db() {
	local _Dir _RepoDb
	pm.create_db_tmp_dir
	_Dir="$(pm.get_db_tmp_dir)/sync/$1"
	mkdir -p "$_Dir"
	_RepoDb="$(pm.get_config DBPath)/sync/$1.db"
	[[ -e $_RepoDb ]] || return 1
	tar -xzf "${_RepoDb}" -C "$_Dir" || return 1
}
pm.get_pkg_arch() {
	pm.get_sync_db_desc "$1" | pm.get_db_section ARCH | RemoveBlank
}
pm.delete_db_tmp_dir() {
	rm -rf "$(pm.get_db_tmp_dir)"
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
prog.bar() {
	local Max="$1" Counter="$2" Size="${3-"100"}"
	local SharpCount=$((Counter * Size / Max))
	local SpaceCount=$((Size - SharpCount))
	Esc.Return
	echo -n "$Counter/$Max [$(yes "#" | head -n "$SharpCount" 2>/dev/null | tr -d "\n")$(yes " " | head -n "$SpaceCount" 2>/dev/null | tr -d "\n")]"
}
prog.wide_bar() {
	local Max="$1" Counter="$2"
	local StatusString="$Counter/$Max"
	local Size=$(($(Esc.GetTermX) - ${#StatusString} - 3))
	prog.bar "$Max" "$Counter" "$Size"
}
prog.rotation() {
	local Count="$1" CharList=('|' '/' '-' '\')
	Esc.ClearLineAndReturn
	[[ -n ${2-""} ]] && echo -n "${2}" 1>&2
	printf "%s" "${CharList["$((Count % "${#CharList[@]}"))"]}" 1>&2
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
	readlinkf.posix "$@"
}
readlinkf.posix() {
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
readlinkf.readlink() {
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
sqlite3.select() {
	local _table="$1" _args=()
	shift 1 || return 1
	local _values=("$@")
	_args+=(select)
	ForEach eval '_args+=("\"{}\"" ,)' < <(PrintEvalArray _values)
	Array.Pop _args
	_args+=("from" "$_table" ";")
	sqlite3.call "${_args[*]}"
}
sqlite3.call() {
	Msg.Debug sqlite3 "${SQLITE3_OPTIONS[@]}" "$SQLITE3_DBPATH" "$@" 1>&2
	sqlite3 "${SQLITE3_OPTIONS[@]}" "$SQLITE3_DBPATH" "$@"
}
sqlite3.current_db() {
	if [[ -z ${SQLITE3_DBPATH-""} ]]; then
		Msg.Err "No datebase is connected."
		return 1
	fi
	echo "${SQLITE3_DBPATH}"
	return 0
}
sqlite3.select_all() {
	local _table="$1" _args=()
	shift 1 || return 1
	sqlite3.call "select * from $_table"
}
sqlite3.exist_table() {
	local _result
	_result="$(sqlite3.call "SELECT COUNT(*) 
                            FROM sqlite_master 
                            WHERE TYPE='table' AND name='$1';
            ")"
	if ((_result > 0)); then
		return 0
	fi
	return 1
}
sqlite3.exist_field() {
	_result="$(sqlite3.call "SELECT * FROM '$1' WHERE $2 = '$3' LIMIT 1;")"
	if [[ -n ${_result-""} ]]; then
		return 0
	fi
	return 1
}
sqlite3.delete() {
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
	sqlite3.call "${_args[*]}"
}
sqlite3.insert() {
	local _table="$1" _args=()
	shift 1 || return 1
	local _values=("$@")
	_args+=(insert into "$_table" values '(')
	ForEach eval '_args+=("\"{}\"" ,)' < <(PrintEvalArray _values)
	Array.Pop _args
	_args+=(");")
	sqlite3.call "${_args[*]}"
}
sqlite3.create() {
	local _table="$1" _args=() _columns=()
	shift 1 || return 1
	_columns=("$@")
	_args+=(create table "$_table" "(")
	ForEach eval '_args+=("\"{}\"" ,)' < <(PrintEvalArray _columns)
	Array.Pop _args
	_args+=(")")
	sqlite3.call "${_args[*]}"
}
sqlite3.connect() {
	export SQLITE3_DBPATH="$1"
	echo ".open \"$SQLITE3_DBPATH\"" | sqlite3
	return 0
}
srcinfo.get_value() {
	local _SrcInfo=()
	local _Output=()
	local _PkgBaseValues=("pkgver" "pkgrel" "epoch")
	local _AllValues=("pkgdesc" "url" "install" "changelog")
	local _AllArrays=("arch" "groups" "license" "noextract" "options" "backup" "validpgpkeys")
	local _AllArraysWithArch=("source" "depends" "checkdepends" "makedepends" "optdepends" "provides" "conflicts" "replaces" "md5sums" "sha1sums" "sha224sums" "sha256sums" "sha384sums" "sha512sums")
	ArrayAppend _SrcInfo
	ArrayIncludes _PkgBaseValues "$1" && {
		PrintEvalArray _SrcInfo | srcinfo.get_value_in_pkg_base "$1"
		return 0
	}
	[[ -n ${2-""} ]] || {
		echo "No pkgname or pkgbase is specified" 1>&2
		return 1
	}
	if ArrayIncludes _AllValues "$1" || ArrayIncludes _AllArrays "$1"; then
		ArrayAppend _Output < <(PrintEvalArray _SrcInfo | srcinfo.get_value_in_pkg_base "$1")
		ArrayAppend _Output < <(PrintEvalArray _SrcInfo | srcinfo.get_value_in_pkg_name "$2" "$1")
		PrintArray "${_Output[@]}" | tail -n 1
		return 0
	fi
	ArrayIncludes _AllArraysWithArch "$1" || return 1
	local _Arch _ArchList=()
	if [[ -z ${3-""} ]]; then
		ArrayAppend _ArchList < <(PrintEvalArray _SrcInfo | srcinfo.get_value arch "$2")
	else
		ArrayAppend _ArchList < <(tr "," "\n" <<<"$3" | RemoveBlank)
	fi
	ArrayAppend _Output < <(PrintEvalArray _SrcInfo | srcinfo.get_value_in_pkg_base "$1")
	ArrayAppend _Output < <(PrintEvalArray _SrcInfo | srcinfo.get_value_in_pkg_name "$2" "$1")
	for _Arch in "${_ArchList[@]}"; do
		ArrayAppend _Output < <(PrintEvalArray _SrcInfo | srcinfo.get_value_in_pkg_base "$1_${_Arch}")
		ArrayAppend _Output < <(PrintEvalArray _SrcInfo | srcinfo.get_value_in_pkg_name "$2" "$1_${_Arch}")
	done
	PrintEvalArray _Output
	return 0
}
srcinfo.format() {
	RemoveBlank | sed "/^$/d" | grep -v "^#" | ForEach eval 'srcinfo.parse Line <<< "{}"'
}
srcinfo.get_section_list() {
	srcinfo.format | grep -e "^pkgbase" -e "^pkgname"
}
srcinfo.get_value_in_pkg_name() {
	local _Line
	while read -r _Line; do
		_Key="$(srcinfo.parse Key <<<"$_Line")"
		case "$_Key" in
		"$2")
			srcinfo.parse Value <<<"$_Line"
			;;
		esac
	done < <(srcinfo.get_pkg_name "$1")
}
srcinfo.parse() {
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
srcinfo.get_pkg_name() {
	local _Line _Key _InSection=false _TargetPkgName="$1"
	while read -r _Line; do
		_Key="$(srcinfo.parse Key <<<"$_Line")"
		case "$_Key" in
		"pkgname")
			if [[ "$(srcinfo.parse Value <<<"$_Line")" == "$_TargetPkgName" ]]; then
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
	done < <(srcinfo.format)
}
srcinfo.get_pkg_base() {
	local _Line _Key _InSection=false
	while read -r _Line; do
		_Key="$(srcinfo.parse Key <<<"$_Line")"
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
	done < <(srcinfo.format)
}
srcinfo.get_value_in_pkg_base() {
	local _Line
	while read -r _Line; do
		_Key="$(srcinfo.parse Key <<<"$_Line")"
		case "$_Key" in
		"$1")
			srcinfo.parse Value <<<"$_Line"
			;;
		esac
	done < <(srcinfo.get_pkg_base)
}
srcinfo.get_key_list() {
	srcinfo.format | cut -d "=" -f 1
}
arch.get_mkinitcpio_preset_list() {
	find "/etc/mkinitcpio.d/" -name "*.preset" -type f | GetBaseName | RemoveFileExt
}
arch.get_kernel_src_list() {
	find "/usr/src" -mindepth 1 -maxdepth 1 -type l -name "linux*"
}
arch.get_kernel_file_list() {
	find "/boot" -maxdepth 1 -mindepth 1 -name "vmlinuz-*"
}
array.append() {
	local _ArrName="$1"
	shift 1 || return 1
	readarray -t -O "$(ArrayIndex "$_ArrName")" "$_ArrName" < <(cat)
}
array.shift() {
	readarray -t "$1" < <(PrintEvalArray "$1" | sed "1,${2-"1"}d")
}
array.push() {
	eval "PrintArray \"\${$1[@]}\"" | grep -qx "$2" && return 0
	eval "$1+=(\"$2\")"
}
array.from_str() {
	declare -a -x "$1"
	readarray -t "$1" < <(BreakChar)
}
array.pop() {
	readarray -t "$1" < <(PrintEvalArray "$1" | sed -e '$d')
}
array.rev() {
	readarray -t "$1" < <(PrintEvalArray "$1" | tac)
}
array.remove() {
	readarray -t "$1" < <(PrintEvalArray "$1" | RemoveMatchLine "$2")
}
array.print() {
	(($# >= 1)) || return 0
	printf "%s\n" "${@}"
}
array.last() {
	PrintEval "$1[$(array.last_index "$1")]"
}
array.eval() {
	eval "PrintArray \"\${$1[@]}\""
}
array.length() {
	PrintEval "#${1}[@]"
}
array.index_of() {
	local n=()
	readarray -t n < <(grep -x -n "$1" | cut -d ":" -f 1 | ForEach eval echo '$(( {} - 1 ))')
	(("${#n[@]}" >= 1)) || return 1
	PrintArray "${n[@]}"
	return 0
}
array.last_index() {
	CalcInt "$(array.length "$1")" - 1
}
array.includes() {
	PrintEvalArray "$1" | grep -qx "$2"
}
array.for_each() {
	PrintEvalArray "$1" | ForEach "${@:2}"
}
array.include() {
	array.includes "$@"
}
awk.cos() {
	awk.float "cos($*)"
}
awk.tan() {
	awk.float "sin($1)/tan($1)"
}
awk.sin() {
	awk.float "sin($*)"
}
awk.pi() {
	awk.float "atan2(0, -0)"
}
awk.print() {
	awk "BEGIN {print $*}"
}
awk.log() {
	awk.float "log(${2}) / log($1)"
}
awk.rad() {
	awk.float "$1 * $(awk.pi) / 180 "
}
awk.float() {
	awk "BEGIN {printf (\"%4.${AWKSCALE-"5"}f\n\", $*)}"
}
PrintEvalArray() {
	Array.Eval "$1"
}
ArrayAppend() {
	Array.Append "$1"
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
StrToCharList() {
	Array.FromStr "$1"
}
GetArrayIndex() {
	Array.IndexOf "$1"
}
ArrayIndex() {
	Array.Length "$1"
}
AddNewToArray() {
	Array.Push "$@"
}
FileType() {
	file --mime-type -b "$1"
}
RemoveFileExt() {
	local Ext
	ForEach eval 'Ext=$(GetFileExt <<< {}); sed "s|.$Ext$||g" <<< {}; unset Ext'
}
GetFileExt() {
	GetBaseName | rev | cut -d "." -f 1 | rev
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
ToLower() {
	local _Str="${1,,}"
	[[ -z ${_Str-""} ]] || echo "${_Str}"
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
PrintEval() {
	eval echo "\${$1}"
}
RemoveBlank() {
	sed "s|^ *||g; s| *$||g; s|^	*||g; s|	*$||g; /^$/d"
}
GetMaxWidth() {
	awk '{ if ( length > x && length > 0 ) { x = length } }END{ print x }'
}
RandomString() {
	base64 <"/dev/random" | fold -w "$1" | head -n 1
	return 0
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
GetLastSplitString() {
	rev <<<"$2" | cut -d "$1" -f 1 | rev
}
CutLastString() {
	echo "${1%%"${2}"}"
	return 0
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
ToArgs() {
	readarray -t args
	"$@" "${args[@]}"
}
cache.get_file_last_update() {
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
cache.exist() {
	local _File
	_File="$(cache.create_dir)/$1"
	[[ -e $_File ]] || return 1
	(("$(cache.get_time_diff_from_last_update "$_File")" > "${KEEPCACHESEC-"86400"}")) && return 2
	return 0
}
cache.get_time_diff_from_last_update() {
	local _Now _Last
	_Now="$(date "+%s")"
	_Last="$(cache.get_file_last_update "$1")"
	echo "$((_Now - _Last))"
	return 0
}
cache.get_id() {
	if [[ -z ${FSBLIB_CACHEID-""} ]]; then
		cache.create_dir >/dev/null
	fi
	echo "$FSBLIB_CACHEID"
}
cache.get_dir() {
	echo "${TMPDIR-"/tmp"}/$(cache.get_id)"
}
cache.get() {
	cat "$(cache.get_dir)/$1" 2>/dev/null || return 1
}
cache.create() {
	cache.create_dir >/dev/null
	cat >"$(cache.get_dir)/${1}"
	cat "$(cache.get_dir)/$1"
}
cache.create_dir() {
	FSBLIB_CACHEID="${FSBLIB_CACHEID-"$(RandomString "10")"}"
	export FSBLIB_CACHEID="$FSBLIB_CACHEID"
	local TMPDIR="${TMPDIR-"/tmp"}"
	local _Dir="$TMPDIR/${FSBLIB_CACHEID}"
	mkdir -p "$_Dir"
	echo "$_Dir"
	return 0
}
fsblib.require_lib() {
	local lib missing=() return=0
	for lib in "$@"; do
		if ! [[ ${FSBLIB_LIBLIST[*]} == *" $lib "* ]]; then
			missing+=("$lib")
			return=1
		fi
	done
	return "$return"
}
fsblib_env_check() {
	fsblib.env_check
}
fsblib.env_check() {
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
csv.to_bash_array() {
	local _RawCsvLine=() _Line _ClmCnt=0
	local ArrayPrefix="${ArrayPrefix-"{}"}"
	readarray -t _RawCsvLine < <(
		while read -r _Line; do
			(($(tr "${CSVDELIM-","}" "\n" <<<"$_Line" | wc -l) >= ${#})) && echo "$_Line"
		done < <(grep -v "^#")
	)
	_ClmCnt=$(PrintArray "${_RawCsvLine[@]}" | csv.get_clm_cnt)
	while read -r _Cnt; do
		readarray -t "$(sed "s|{}|$(eval "echo \"\${${_Cnt}}\"")|g" <<<"$ArrayPrefix")" < <(
			PrintArray "${_RawCsvLine[@]}" | cut -d "${CSVDELIM-","}" -f "$_Cnt"
		)
	done < <(seq 1 "$#")
}
csv.get_clm() {
	grep -v "^#" | sed "/^$/d" | cut -d "${CSVDELIM-","}" -f "$1"
}
csv.get_clm_cnt() {
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
em.get_world_pkg_list() {
	sed -E 's|:.+$||g' /var/lib/portage/world | xargs -I{} bash -c 'ls -d /var/db/pkg/{}-* | sed "s|/var/db/pkg/||g" | grep -E "{}-[0-9]"'
}
em.get_repo_pkg_list() {
	local _RepoPath
	_RepoPath="$(em.get_repo_location "$1")"
	find "$_RepoPath" -mindepth 3 -maxdepth 3 -type f -name '*.ebuild' | sed -e "s|${_RepoPath%/}/||g" -e 's|.ebuild$||g' | awk -F "/" '{print $1"/"$3}'
}
em.get_all_pkg_list() {
	em.get_repo_conf | sed -e 's/^ *//' -e 's/ *$//' | grep "^ *location *=" | sed -e 's/^location *= *//' | xargs -L1 realpath | xargs -I{} bash -c "find '{}' -mindepth 3 -maxdepth 3 -type f -name '*.ebuild' | sed -e 's|{}/||g' -e 's|.ebuild$||g'" | awk -F "/" '{print $1"/"$3}'
}
em.get_installed_pkg_list() {
	find /var/db/pkg/ -mindepth 2 -maxdepth 2 -type d | sed 's|/var/db/pkg/||g'
}
em.get_repo_location() {
	em.get_repo_conf | Ini.GetParam "$1" location
}
em.get_repo_conf() {
	cat /etc/portage/repos.conf /etc/portage/repos.conf/* 2>/dev/null
}
em.get_default_repo_name() {
	em.get_repo_conf | Ini.GetParam DEFAULT main-repo
}
em.no_version() {
	sed -E 's|\-[0-9]+.+||g'
}
esc.clear_screen() {
	printf "\033[2J" >/dev/tty
}
esc.return() {
	printf "\r" >/dev/tty
}
esc.clear_left() {
	printf "\033[1K" >/dev/tty
}
esc.clear_line() {
	printf "\033[2K" >/dev/tty
}
esc.clear_right() {
	printf "\033[0K" >/dev/tty
}
esc.get_y() {
	local _POS
	printf "\033[6n" >>/dev/tty
	read -r -s -d "R" _POS
	echo $(("$(printf "%s\n" "${_POS:2}" | cut -d";" -f1)" - 1))
}
esc.get_x() {
	local _POS
	printf "\033[6n" >>/dev/tty
	read -r -s -d "R" _POS
	echo $(("$(printf "%s\n" "${_POS:2}" | cut -d";" -f2)" - 1))
}
esc.get_term_x() {
	[[ -n ${COLUMNS-""} ]] && echo "$COLUMNS" && return 0
	tput cols
}
esc.move_cursor() {
	printf "\033[%d;%dH" "$1" "$2" >/dev/tty
}
esc.move_cursor_up() {
	printf "\033[%dA" "$1" >/dev/tty
}
esc.move_cursor_left() {
	printf "\033[%dD" "$1" >/dev/tty
}
esc.move_cursor_down() {
	printf "\033[%dB" "$1" >/dev/tty
}
esc.move_cursor_right() {
	printf "\033[%dC" "$1" >/dev/tty
}
esc.get_term_y() {
	[[ -n ${LINES-""} ]] && echo "$LINES" && return 0
	tput lines
}
esc.clear_line_and_return() {
	esc.clear_line
	esc.return
}
esc.clear_upper_lines() {
	for i in $(seq 1 "$1"); do
		esc.move_cursor_up 1
		esc.clear_line
	done
}
esc.italic() {
	printf "\033[3m" >/dev/tty
}
esc.green_background() {
	printf "\033[42m" >/dev/tty
}
esc.black_background() {
	printf "\033[40m" >/dev/tty
}
esc.blue_text() {
	printf "\033[34m" >/dev/tty
}
esc.underline() {
	printf "\033[4m" >/dev/tty
}
esc.white_text() {
	printf "\033[37m" >/dev/tty
}
esc.magenta_background() {
	printf "\033[45m" >/dev/tty
}
esc.cyan_background() {
	printf "\033[46m" >/dev/tty
}
esc.magenta_text() {
	printf "\033[35m" >/dev/tty
}
esc.yellow_text() {
	printf "\033[33m" >/dev/tty
}
esc.green_text() {
	printf "\033[32m" >/dev/tty
}
esc.white_background() {
	printf "\033[47m" >/dev/tty
}
esc.low_intensity() {
	printf "\033[2m" >/dev/tty
}
esc.yellow_background() {
	printf "\033[43m" >/dev/tty
}
esc.red_background() {
	printf "\033[41m" >/dev/tty
}
esc.reset_style() {
	printf "\033[0m" >/dev/tty
}
esc.rapid_blink() {
	printf "\033[6m" >/dev/tty
}
esc.reverse() {
	printf "\033[7m" >/dev/tty
}
esc.conceal() {
	printf "\033[8m" >/dev/tty
}
esc.blue_background() {
	printf "\033[44m" >/dev/tty
}
esc.cyan_text() {
	printf "\033[36m" >/dev/tty
}
esc.bold() {
	printf "\033[1m" >/dev/tty
}
esc.red_text() {
	printf "\033[31m" >/dev/tty
}
esc.crossed_out() {
	printf "\033[9m" >/dev/tty
}
esc.blink() {
	printf "\033[5m" >/dev/tty
}
esc.black_text() {
	printf "\033[30m" >/dev/tty
}
ini.get_last_param() {
	ini.get_param_list "$1" | tail -n 1
}
ini.get_section_list() {
	local _RawIniLine=()
	local _Line _LineNo=1 _Exit=0
	readarray -t _RawIniLine
	while read -r _Line; do
		ini.parse_line <<<"$_Line"
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
ini.get_param_list() {
	local _RawIniLine=()
	local _Line _LineNo=1 _Exit=0 _InSection=false
	readarray -t _RawIniLine
	while read -r _Line; do
		ini.parse_line <<<"$_Line"
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
ini.get_param() {
	local _RawIniLine=()
	local _Line _LineNo=1 _Exit=0 _InSection=false
	readarray -t _RawIniLine
	while read -r _Line; do
		ini.parse_line <<<"$_Line"
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
ini.parse_line() {
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
ini.new_param() {
	local IniContents=() Line
	local Section="$1" Param="$2"
	local InSection=false LineNo=0
	local NewIniContents=()
	readarray -t IniContents
	local BeforeParam
	local SectionLastParam
	local ParamAdded=false
	if ! PrintArray "${IniContents[@]}" | ini.get_param_list "$Section" | grep -qx "$Param"; then
		SectionLastParam="$(PrintEvalArray IniContents | ini.get_last_param "$Section")"
		for Line in "${IniContents[@]}"; do
			LineNo=$((LineNo + 1))
			ini.parse_line <<<"$Line"
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
ini.new_section() {
	local IniContents=()
	local Section="$1"
	readarray -t IniContents
	if PrintArray "${IniContents[@]}" | ini.get_section_list | grep -x "$Section" >/dev/null; then
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
ini.set_value() {
	local IniContents=()
	local Section="$1" Param="$2"
	readarray -t IniContents
	readarray -t IniContents < <(PrintArray "${IniContents[@]}" | ini.new_section "$Section" | ini.new_param "$Section" "$Param")
	PrintEvalArray IniContents
}
libretranslate.check() {
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
libretranslate.translate() {
	libretranslate.check || return 2
	__libre_translate_return="$(curl -s "$LIBRETRANSLATE_URL/translate" -X POST -d "q=${1:-""}&source=${2:-""}&target=${3:-""}&api_key=${LIBRETRANSLATE_APIKEY:-""}")"
	if [ "$(echo "${__libre_translate_return}" | jq -r '.error')" = "null" ]; then
		echo "${__libre_translate_return}" | jq -r '.translatedText'
		return 0
	else
		echo "${__libre_translate_return}" | jq -r '.error'
		return 1
	fi
}
libretranslate.detect() {
	libretranslate.check || return 2
	__libre_translate_return="$(curl -s "${LIBRETRANSLATE_URL}/detect" -X POST -d "q=${1:-""}&api_key=${LIBRETRANSLATE_APIKEY:-""}")"
	if [ "$(echo "${__libre_translate_return}" | jq -r '.[].error')" = "null" ]; then
		echo "${__libre_translate_return}" | jq -r '.[].language'
		return 0
	else
		echo "${__libre_translate_return}" | jq -r '.error'
		return 1
	fi
}
libretranslate.translate_auto() {
	libretranslate.check || return 2
	libretranslate.translate "${1:-""}" "$(libretranslate.detect "${1:-""}")" "${2:-""}"
}
libretranslate.languages() {
	libretranslate.check || return 2
	curl -s "${LIBRETRANSLATE_URL}/languages" | jq -r '.[].code'
}
msg.warn() {
	msg.common " Warn:" "${*}" stderr
}
msg.err() {
	msg.common "Error:" "${*}" stderr
}
msg.common() {
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
msg.debug() {
	msg.common "Debug:" "${*}" stderr
}
msg.info() {
	msg.common " Info:" "${*}" stdout
}
misskey.notes.renotes() {
	misskey.binding_base "notes/renotes" noteId limit sinceId untilId -- "$@"
}
misskey.notes.search() {
	misskey.binding_base "notes/search" query limit -- "$@"
}
misskey.notes.create() {
	misskey.binding_base "notes/create" text -- "$@"
}
misskey.users.show() {
	misskey.binding_base "users/show" userId -- "${1:-"$(misskey.my_id)"}" "${@:2}"
}
misskey.users.stats() {
	misskey.binding_base "users/stats" userId -- "${1:-"$(misskey.my_id)"}" "${@:2}"
}
misskey.users.get_frequently_replied_users() {
	misskey.binding_base "users/get-frequently-replied-users" userId -- "${1:-"$(misskey.my_id)"}" "${@:2}"
}
misskey.users.search_by_username_and_host() {
	misskey.binding_base "users/search-by-username-and-host" username -- "${1:-"$(misskey.my_user_name)"}" "${@:2}"
}
misskey.users.notes() {
	misskey.binding_base "users/notes" userId -- "${1:-"$(misskey.my_id)"}" "${@:2}"
}
misskey.users.pages() {
	misskey.binding_base "users/pages" userId -- "${1:-"$(misskey.my_id)"}" "${@:2}"
}
misskey.admin.server_info() {
	misskey.binding_base "/admin/server-info" -- "$@"
}
misskey.setup() {
	export MISSKEY_DOMAIN="${1-"${MISSKEY_DOMAIN-""}"}"
	export MISSKEY_TOKEN="${2-"${MISSKEY_TOKEN-""}"}"
	export MISSKEY_ENTRY="https://${MISSKEY_DOMAIN}/api"
}
misskey.i() {
	misskey.binding_base "/i" -- "$@"
}
misskey.server_info() {
	misskey.binding_base "/server-info" -- "$@"
}
misskey.meta() {
	misskey.binding_base "/meta" -- "$@"
}
misskey.binding_base() {
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
		misskey.setup "${MISSKEY_DOMAIN}" "$MISSKEY_TOKEN"
	fi
	misskey.send_req "${MISSKEY_ENTRY%/}/${_API#/}" "${_Args[@]}" "$@"
}
misskey.send_req() {
	local _Url="$1" _CurlArgs=()
	shift 1
	_CurlArgs+=(-s -L)
	_CurlArgs+=(-X POST)
	_CurlArgs+=(-H "Content-Type: application/json")
	_CurlArgs+=(-d "$(misskey.make_json "$@")")
	_CurlArgs+=("$_Url")
	Msg.Debug "Run: ${_CurlArgs[*]//"${MISSKEY_TOKEN}"/"TOKEN"}"
	curl "${_CurlArgs[@]}"
}
misskey.make_json() {
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
misskey.is_admin() {
	Bool "$(misskey.i | jq -r ".isAdmin")"
}
misskey.my_name() {
	misskey.i | jq -r ".name"
}
misskey.my_user_name() {
	misskey.i | jq -r ".username"
}
misskey.my_id() {
	misskey.i | jq -r ".id"
}
pm.check_pkg() {
	local p
	for p in "$@"; do
		pm.run -Qq "$p" >/dev/null 2>&1 || return 1
	done
	return 0
}
pm.get_latest_pkg_ver() {
	local _LANG="${LANG-""}"
	export LANG=C
	if [[ -z ${*} ]]; then
		cat
	else
		PrintArray "$@"
	fi | ForEach pm.run -Si "{}" | grep "^Version" | cut -d ":" -f 2 | RemoveBlank
	[[ -n $_LANG ]] && export LANG="$_LANG"
	return 0
}
pm.get_repo_list_from_conf() {
	pm.get_config --repo-list
}
pm.get_pacman_keyring_dir() {
	local _KeyringDir=""
	_KeyringDir="$(LANG=C pacman-key -h | RemoveBlank | grep -A 1 -- "^--populate" | tail -n 1 | cut -d "/" -f 2- | sed "s|'$||g")"
	: "${_KeyringDir="usr/share/pacman/keyrings"}"
	_KeyringDir="$(pm.get_root)/$_KeyringDir"
	_KeyringDir="$(sed -E "s|/+|/|g" <<<"$_KeyringDir")"
	if [[ -e $_KeyringDir ]]; then
		Readlinkf "$_KeyringDir"
	else
		echo "$_KeyringDir"
	fi
}
pm.get_repo_pkg_list() {
	pm.run -Slq "$@"
}
pm.get_repo_ver() {
	pm.run -Sp --print-format '%v' "$1"
}
pm.get_repo_server() {
	ForEach eval 'pm.get_config -r {}' | grep "^Server" | ForEach eval "Ini.ParseLine <<< '{}' ; printf '%s\n' \${VALUE}"
}
pm.is_repo_pkg() {
	pm.run -Slq | grep -qx "$(pm.get_name <<<"$1")"
}
pm.get_repo_conf() {
	ForEach eval 'echo [{}] && pm.get_config -r {}'
}
pm.get_root() {
	pm.get_config RootDir
}
pm.get_name() {
	cut -d "<" -f 1 | cut -d ">" -f 1 | cut -d "=" -f 1
}
pm.pacman_gpg() {
	gpg --homedir "$(pm.get_config GPGDir)" "$@"
}
pm.get_pacman_kernel_pkg() {
	echo "there is nothing"
}
pm.get_keyring_list() {
	find "$(@GetKeyringDir)" -name "*.gpg" | GetBaseName | RemoveFileExt
}
pm.get_installed_pkg_ver() {
	if [[ -z ${*} ]]; then
		cat
	else
		PrintArray "$@"
	fi | ForEach pacman -Q "{}" | cut -d " " -f 2
	PrintArray "${PIPESTATUS[@]}" | grep -qx "1" && return 1
	return 0
}
pm.run_key() {
	pacman-key --config "${PACMAN_CONF-"/etc/pacman.conf"}" "$@"
}
pm.run() {
	pacman --noconfirm --config "${PACMAN_CONF-"/etc/pacman.conf"}" "$@"
}
pm.get_config() {
	LANG=C pacman-conf --config="${PACMAN_CONF-"/etc/pacman.conf"}" "$@"
}
pm.get_db_section_list() {
	grep -E "^%.*%$"
}
pm.get_db_next_section() {
	pm.get_db_section_list | grep -x -A 1 "^%$1%$" | GetLine 2 | sed "s|^%||g; s|%$||g"
}
pm.get_db_section() {
	readarray -t _Stdin
	PrintArray "${_Stdin[@]}" | sed -ne "/^%$1%$/,/^%$(PrintEvalArray _Stdin | pm.get_db_next_section "$1")%$/p" | sed '1d; $d'
}
pm.opened_sync_db_list() {
	find "$(pm.get_db_tmp_dir)/sync/" -mindepth 1 -maxdepth 1 -type d
}
pm.create_db_tmp_dir() {
	mkdir -p "$(pm.get_db_tmp_dir)"
}
pm.get_sync_all_desc() {
	find "$(pm.get_db_tmp_dir)" -mindepth 3 -maxdepth 3 -name "desc" -type f
}
pm.is_opend_sync_db() {
	readarray -t _PkgDbList < <(find "$(pm.get_db_tmp_dir)/sync/$1" -mindepth 1 -maxdepth 1 -type d)
	(("${#_PkgDbList[@]}" > 0)) && return 0
	return 1
}
pm.get_virtual_pkg_list() {
	pm.get_repo_list_from_local_db | ForEach pm.open_sync_db {}
	pm.get_sync_all_desc | ForEach eval "pm.get_db_section PROVIDES < {}" | RemoveBlank
}
pm.get_db_tmp_dir() {
	echo "${TMPDIR-"/tmp"}/fasbashlib-pacman-db"
}
pm.get_sync_db_desc() {
	local _path
	_path="$(pm.get_sync_db_desc_path "$1")"
	[[ -e $_path ]] || return 1
	cat "$_path/desc"
}
pm.get_sync_db_desc_path() {
	local _repo
	_repo="$(pacman -Sp --print-format '%r' "$1")"
	{
		IsPacmanSyncDbOpend "$_repo" || OpenPacmanSyncDb "$_repo"
	} || return 1
	echo "$(pm.get_db_tmp_dir)/sync/$(pacman -Sp --print-format '%r/%n-%v' "$1")"
}
pm.parse_pkg_file_name() {
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
pm.get_repo_list_from_local_db() {
	find "$(pm.get_config DBPath)/sync" -mindepth 1 -maxdepth 1 -type f | GetBaseName | sed "s|.db$||g"
	return 0
}
pm.open_sync_db() {
	local _Dir _RepoDb
	pm.create_db_tmp_dir
	_Dir="$(pm.get_db_tmp_dir)/sync/$1"
	mkdir -p "$_Dir"
	_RepoDb="$(pm.get_config DBPath)/sync/$1.db"
	[[ -e $_RepoDb ]] || return 1
	tar -xzf "${_RepoDb}" -C "$_Dir" || return 1
}
pm.get_pkg_arch() {
	pm.get_sync_db_desc "$1" | pm.get_db_section ARCH | RemoveBlank
}
pm.delete_db_tmp_dir() {
	rm -rf "$(pm.get_db_tmp_dir)"
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
prog.bar() {
	local Max="$1" Counter="$2" Size="${3-"100"}"
	local SharpCount=$((Counter * Size / Max))
	local SpaceCount=$((Size - SharpCount))
	Esc.Return
	echo -n "$Counter/$Max [$(yes "#" | head -n "$SharpCount" 2>/dev/null | tr -d "\n")$(yes " " | head -n "$SpaceCount" 2>/dev/null | tr -d "\n")]"
}
prog.wide_bar() {
	local Max="$1" Counter="$2"
	local StatusString="$Counter/$Max"
	local Size=$(($(Esc.GetTermX) - ${#StatusString} - 3))
	prog.bar "$Max" "$Counter" "$Size"
}
prog.rotation() {
	local Count="$1" CharList=('|' '/' '-' '\')
	Esc.ClearLineAndReturn
	[[ -n ${2-""} ]] && echo -n "${2}" 1>&2
	printf "%s" "${CharList["$((Count % "${#CharList[@]}"))"]}" 1>&2
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
	readlinkf.posix "$@"
}
readlinkf.posix() {
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
readlinkf.readlink() {
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
sqlite3.select() {
	local _table="$1" _args=()
	shift 1 || return 1
	local _values=("$@")
	_args+=(select)
	ForEach eval '_args+=("\"{}\"" ,)' < <(PrintEvalArray _values)
	Array.Pop _args
	_args+=("from" "$_table" ";")
	sqlite3.call "${_args[*]}"
}
sqlite3.call() {
	Msg.Debug sqlite3 "${SQLITE3_OPTIONS[@]}" "$SQLITE3_DBPATH" "$@" 1>&2
	sqlite3 "${SQLITE3_OPTIONS[@]}" "$SQLITE3_DBPATH" "$@"
}
sqlite3.current_db() {
	if [[ -z ${SQLITE3_DBPATH-""} ]]; then
		Msg.Err "No datebase is connected."
		return 1
	fi
	echo "${SQLITE3_DBPATH}"
	return 0
}
sqlite3.select_all() {
	local _table="$1" _args=()
	shift 1 || return 1
	sqlite3.call "select * from $_table"
}
sqlite3.exist_table() {
	local _result
	_result="$(sqlite3.call "SELECT COUNT(*) 
                            FROM sqlite_master 
                            WHERE TYPE='table' AND name='$1';
            ")"
	if ((_result > 0)); then
		return 0
	fi
	return 1
}
sqlite3.exist_field() {
	_result="$(sqlite3.call "SELECT * FROM '$1' WHERE $2 = '$3' LIMIT 1;")"
	if [[ -n ${_result-""} ]]; then
		return 0
	fi
	return 1
}
sqlite3.delete() {
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
	sqlite3.call "${_args[*]}"
}
sqlite3.insert() {
	local _table="$1" _args=()
	shift 1 || return 1
	local _values=("$@")
	_args+=(insert into "$_table" values '(')
	ForEach eval '_args+=("\"{}\"" ,)' < <(PrintEvalArray _values)
	Array.Pop _args
	_args+=(");")
	sqlite3.call "${_args[*]}"
}
sqlite3.create() {
	local _table="$1" _args=() _columns=()
	shift 1 || return 1
	_columns=("$@")
	_args+=(create table "$_table" "(")
	ForEach eval '_args+=("\"{}\"" ,)' < <(PrintEvalArray _columns)
	Array.Pop _args
	_args+=(")")
	sqlite3.call "${_args[*]}"
}
sqlite3.connect() {
	export SQLITE3_DBPATH="$1"
	echo ".open \"$SQLITE3_DBPATH\"" | sqlite3
	return 0
}
srcinfo.get_value() {
	local _SrcInfo=()
	local _Output=()
	local _PkgBaseValues=("pkgver" "pkgrel" "epoch")
	local _AllValues=("pkgdesc" "url" "install" "changelog")
	local _AllArrays=("arch" "groups" "license" "noextract" "options" "backup" "validpgpkeys")
	local _AllArraysWithArch=("source" "depends" "checkdepends" "makedepends" "optdepends" "provides" "conflicts" "replaces" "md5sums" "sha1sums" "sha224sums" "sha256sums" "sha384sums" "sha512sums")
	ArrayAppend _SrcInfo
	ArrayIncludes _PkgBaseValues "$1" && {
		PrintEvalArray _SrcInfo | srcinfo.get_value_in_pkg_base "$1"
		return 0
	}
	[[ -n ${2-""} ]] || {
		echo "No pkgname or pkgbase is specified" 1>&2
		return 1
	}
	if ArrayIncludes _AllValues "$1" || ArrayIncludes _AllArrays "$1"; then
		ArrayAppend _Output < <(PrintEvalArray _SrcInfo | srcinfo.get_value_in_pkg_base "$1")
		ArrayAppend _Output < <(PrintEvalArray _SrcInfo | srcinfo.get_value_in_pkg_name "$2" "$1")
		PrintArray "${_Output[@]}" | tail -n 1
		return 0
	fi
	ArrayIncludes _AllArraysWithArch "$1" || return 1
	local _Arch _ArchList=()
	if [[ -z ${3-""} ]]; then
		ArrayAppend _ArchList < <(PrintEvalArray _SrcInfo | srcinfo.get_value arch "$2")
	else
		ArrayAppend _ArchList < <(tr "," "\n" <<<"$3" | RemoveBlank)
	fi
	ArrayAppend _Output < <(PrintEvalArray _SrcInfo | srcinfo.get_value_in_pkg_base "$1")
	ArrayAppend _Output < <(PrintEvalArray _SrcInfo | srcinfo.get_value_in_pkg_name "$2" "$1")
	for _Arch in "${_ArchList[@]}"; do
		ArrayAppend _Output < <(PrintEvalArray _SrcInfo | srcinfo.get_value_in_pkg_base "$1_${_Arch}")
		ArrayAppend _Output < <(PrintEvalArray _SrcInfo | srcinfo.get_value_in_pkg_name "$2" "$1_${_Arch}")
	done
	PrintEvalArray _Output
	return 0
}
srcinfo.format() {
	RemoveBlank | sed "/^$/d" | grep -v "^#" | ForEach eval 'srcinfo.parse Line <<< "{}"'
}
srcinfo.get_section_list() {
	srcinfo.format | grep -e "^pkgbase" -e "^pkgname"
}
srcinfo.get_value_in_pkg_name() {
	local _Line
	while read -r _Line; do
		_Key="$(srcinfo.parse Key <<<"$_Line")"
		case "$_Key" in
		"$2")
			srcinfo.parse Value <<<"$_Line"
			;;
		esac
	done < <(srcinfo.get_pkg_name "$1")
}
srcinfo.parse() {
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
srcinfo.get_pkg_name() {
	local _Line _Key _InSection=false _TargetPkgName="$1"
	while read -r _Line; do
		_Key="$(srcinfo.parse Key <<<"$_Line")"
		case "$_Key" in
		"pkgname")
			if [[ "$(srcinfo.parse Value <<<"$_Line")" == "$_TargetPkgName" ]]; then
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
	done < <(srcinfo.format)
}
srcinfo.get_pkg_base() {
	local _Line _Key _InSection=false
	while read -r _Line; do
		_Key="$(srcinfo.parse Key <<<"$_Line")"
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
	done < <(srcinfo.format)
}
srcinfo.get_value_in_pkg_base() {
	local _Line
	while read -r _Line; do
		_Key="$(srcinfo.parse Key <<<"$_Line")"
		case "$_Key" in
		"$1")
			srcinfo.parse Value <<<"$_Line"
			;;
		esac
	done < <(srcinfo.get_pkg_base)
}
srcinfo.get_key_list() {
	srcinfo.format | cut -d "=" -f 1
}
url.scheme() {
	cut -d ":" -f 1
}
url.no_scheme() {
	cut -d ":" -f 2-
}
url.path_and_query_and_fragment() {
	local i
	while read -r i; do
		sed "s|^//$(url.authority <<<"$i")||g" <<<"$(url.no_scheme <<<"$i")"
	done
}
url.query() {
	local i
	while read -r i; do
		url.path_and_query_and_fragment <<<"$i" | sed "s|#$(url.fragment <<<"$i")||g" | cut -d "?" -f 2-
	done
}
url.port() {
	local i
	while read -r i; do
		[[ $i == *":"* ]] || {
			continue
		}
		cut -d ":" -f 2 <<<"$i"
	done < <(url.authority)
}
url.user() {
	local i
	while read -r i; do
		[[ $i == *"@"* ]] || {
			echo ""
			continue
		}
		cut -d "@" -f 1 <<<"$i"
	done < <(url.authority)
}
url.authority() {
	local i _NoScheme
	while read -r i; do
		_NoScheme=$(url.no_scheme <<<"$i")
		[[ $_NoScheme == "//"* ]] || return 1
		cut -d "/" -f 1 < <(sed "s|^//||g" <<<"$_NoScheme")
	done
}
url.host() {
	url.authority | cut -d "@" -f 2- | cut -d ":" -f 1
}
url.path() {
	url.path_and_query_and_fragment | cut -d "#" -f 1 | cut -d "?" -f 1
}
url.fragment() {
	local i
	i="$(url.path_and_query_and_fragment)"
	[[ $i == *"#"* ]] || return 0
	cut -d "#" -f 2- <<<"$i"
}
url.has_user() {
	local i="${1-""}"
	[[ -n $i ]] || read -r i
	[[ "$(url.authority <<<"$i")" == *"@"* ]]
}
url.has_authority() {
	local i="${1-""}"
	[[ -n $i ]] || read -r i
	[[ "$(url.no_scheme <<<"$i")" == "//"* ]]
}
url.has_fragment() {
	local i="${1-""}"
	[[ -n $i ]] || read -r i
	[[ "$(url.path_and_query_and_fragment <<<"$i")" == *"#"* ]]
}
url.has_port() {
	local i="${1-""}"
	[[ -n $i ]] || read -r i
	[[ "$(url.authority <<<"$i")" == *":"* ]]
}
url.has_query() {
	local i="${1-""}"
	[[ -n $i ]] || read -r i
	[[ "$(url.path_and_query_and_fragment <<<"$i")" == *"?"* ]]
}
url.parse() {
	local i="${1-""}"
	if [[ -z ${i} ]]; then
		read -r i
	fi
	url.scheme <<<"$i"
	echo ":"
	if url.has_authority "$i"; then
		if url.has_user "$i"; then
			url.user <<<"$i"
			echo "@"
		fi
		url.host <<<"$i"
		if url.has_port "$i"; then
			echo ":"
			url.port <<<"$i"
		fi
	fi
	url.path <<<"$i"
	if url.has_fragment "$i"; then
		echo "#"
		url.fragment <<<"$i"
	fi
	if url.has_query "$i"; then
		echo "?"
		url.query <<<"$i"
	fi
}
url.get_query() {
	grep "^ *$1=" | cut -d "=" -f 2-
}
url.parse_query() {
	local i="${1-""}"
	if [[ -z ${i} ]]; then
		read -r i
	fi
	if grep -q "[a-zA-Z]://" <<<"$i"; then
		i="$(url.query <<<"$i")"
	fi
	i="$(sed "s|^\?||g" <<<"$i")"
	tr "&" "\n" <<<"$i" | cut -d "#" -f 1
}
