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
FSBLIB_VERSION='v0.2.7.1.r433.g840bdd7-upper'
FSBLIB_REQUIRE='ModernBash'
FSBLIB_PROG_PIDFILEPATH='FSBLIB_PROGRESS_PIDLIST'

Arch.GetKernelSrcList() {
	find "/usr/src" -mindepth 1 -maxdepth 1 -type l -name "linux*"
}
Arch.GetKernelSrcList() {
	find "/usr/src" -mindepth 1 -maxdepth 1 -type l -name "linux*"
}
Array.Include() {
	Array.Includes "$@"
}
Arch.GetKernelSrcList() {
	find "/usr/src" -mindepth 1 -maxdepth 1 -type l -name "linux*"
}
Array.Include() {
	Array.Includes "$@"
}
Awk.Float() {
	awk "BEGIN {printf (\"%4.${AWKSCALE-"5"}f\n\", $*)}"
}
Arch.GetKernelSrcList() {
	find "/usr/src" -mindepth 1 -maxdepth 1 -type l -name "linux*"
}
Array.Include() {
	Array.Includes "$@"
}
Awk.Float() {
	awk "BEGIN {printf (\"%4.${AWKSCALE-"5"}f\n\", $*)}"
}
ToArgs() {
	readarray -t args
	"$@" "${args[@]}"
}
Arch.GetKernelSrcList() {
	find "/usr/src" -mindepth 1 -maxdepth 1 -type l -name "linux*"
}
Array.Include() {
	Array.Includes "$@"
}
Awk.Float() {
	awk "BEGIN {printf (\"%4.${AWKSCALE-"5"}f\n\", $*)}"
}
ToArgs() {
	readarray -t args
	"$@" "${args[@]}"
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
Arch.GetKernelSrcList() {
	find "/usr/src" -mindepth 1 -maxdepth 1 -type l -name "linux*"
}
Array.Include() {
	Array.Includes "$@"
}
Awk.Float() {
	awk "BEGIN {printf (\"%4.${AWKSCALE-"5"}f\n\", $*)}"
}
ToArgs() {
	readarray -t args
	"$@" "${args[@]}"
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
Arch.GetKernelSrcList() {
	find "/usr/src" -mindepth 1 -maxdepth 1 -type l -name "linux*"
}
Array.Include() {
	Array.Includes "$@"
}
Awk.Float() {
	awk "BEGIN {printf (\"%4.${AWKSCALE-"5"}f\n\", $*)}"
}
ToArgs() {
	readarray -t args
	"$@" "${args[@]}"
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
Arch.GetKernelSrcList() {
	find "/usr/src" -mindepth 1 -maxdepth 1 -type l -name "linux*"
}
Array.Include() {
	Array.Includes "$@"
}
Awk.Float() {
	awk "BEGIN {printf (\"%4.${AWKSCALE-"5"}f\n\", $*)}"
}
ToArgs() {
	readarray -t args
	"$@" "${args[@]}"
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
Em.NoVersion() {
	sed -E 's|\-[0-9]+.+||g'
}
Arch.GetKernelSrcList() {
	find "/usr/src" -mindepth 1 -maxdepth 1 -type l -name "linux*"
}
Array.Include() {
	Array.Includes "$@"
}
Awk.Float() {
	awk "BEGIN {printf (\"%4.${AWKSCALE-"5"}f\n\", $*)}"
}
ToArgs() {
	readarray -t args
	"$@" "${args[@]}"
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
Em.NoVersion() {
	sed -E 's|\-[0-9]+.+||g'
}
Esc.BlackText() {
	printf "\033[30m" >/dev/tty
}
Arch.GetKernelSrcList() {
	find "/usr/src" -mindepth 1 -maxdepth 1 -type l -name "linux*"
}
Array.Include() {
	Array.Includes "$@"
}
Awk.Float() {
	awk "BEGIN {printf (\"%4.${AWKSCALE-"5"}f\n\", $*)}"
}
ToArgs() {
	readarray -t args
	"$@" "${args[@]}"
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
Em.NoVersion() {
	sed -E 's|\-[0-9]+.+||g'
}
Esc.BlackText() {
	printf "\033[30m" >/dev/tty
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
Arch.GetKernelSrcList() {
	find "/usr/src" -mindepth 1 -maxdepth 1 -type l -name "linux*"
}
Array.Include() {
	Array.Includes "$@"
}
Awk.Float() {
	awk "BEGIN {printf (\"%4.${AWKSCALE-"5"}f\n\", $*)}"
}
ToArgs() {
	readarray -t args
	"$@" "${args[@]}"
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
Em.NoVersion() {
	sed -E 's|\-[0-9]+.+||g'
}
Esc.BlackText() {
	printf "\033[30m" >/dev/tty
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
LibreTranslate.TranslateAuto() {
	LibreTranslate.Check || return 2
	LibreTranslate.Translate "${1:-""}" "$(LibreTranslate.Detect "${1:-""}")" "${2:-""}"
}
Arch.GetKernelSrcList() {
	find "/usr/src" -mindepth 1 -maxdepth 1 -type l -name "linux*"
}
Array.Include() {
	Array.Includes "$@"
}
Awk.Float() {
	awk "BEGIN {printf (\"%4.${AWKSCALE-"5"}f\n\", $*)}"
}
ToArgs() {
	readarray -t args
	"$@" "${args[@]}"
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
Em.NoVersion() {
	sed -E 's|\-[0-9]+.+||g'
}
Esc.BlackText() {
	printf "\033[30m" >/dev/tty
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
LibreTranslate.TranslateAuto() {
	LibreTranslate.Check || return 2
	LibreTranslate.Translate "${1:-""}" "$(LibreTranslate.Detect "${1:-""}")" "${2:-""}"
}
Msg.Debug() {
	Msg.Common "Debug:" "${*}" stderr
}
Arch.GetKernelSrcList() {
	find "/usr/src" -mindepth 1 -maxdepth 1 -type l -name "linux*"
}
Array.Include() {
	Array.Includes "$@"
}
Awk.Float() {
	awk "BEGIN {printf (\"%4.${AWKSCALE-"5"}f\n\", $*)}"
}
ToArgs() {
	readarray -t args
	"$@" "${args[@]}"
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
Em.NoVersion() {
	sed -E 's|\-[0-9]+.+||g'
}
Esc.BlackText() {
	printf "\033[30m" >/dev/tty
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
LibreTranslate.TranslateAuto() {
	LibreTranslate.Check || return 2
	LibreTranslate.Translate "${1:-""}" "$(LibreTranslate.Detect "${1:-""}")" "${2:-""}"
}
Msg.Debug() {
	Msg.Common "Debug:" "${*}" stderr
}
Misskey.MyUserName() {
	Misskey.I | jq -r ".username"
}
Arch.GetKernelSrcList() {
	find "/usr/src" -mindepth 1 -maxdepth 1 -type l -name "linux*"
}
Array.Include() {
	Array.Includes "$@"
}
Awk.Float() {
	awk "BEGIN {printf (\"%4.${AWKSCALE-"5"}f\n\", $*)}"
}
ToArgs() {
	readarray -t args
	"$@" "${args[@]}"
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
Em.NoVersion() {
	sed -E 's|\-[0-9]+.+||g'
}
Esc.BlackText() {
	printf "\033[30m" >/dev/tty
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
LibreTranslate.TranslateAuto() {
	LibreTranslate.Check || return 2
	LibreTranslate.Translate "${1:-""}" "$(LibreTranslate.Detect "${1:-""}")" "${2:-""}"
}
Msg.Debug() {
	Msg.Common "Debug:" "${*}" stderr
}
Misskey.MyUserName() {
	Misskey.I | jq -r ".username"
}
Pm.DeleteDbTmpDir() {
	rm -rf "$(Pm.GetDbTmpDir)"
}
Arch.GetKernelSrcList() {
	find "/usr/src" -mindepth 1 -maxdepth 1 -type l -name "linux*"
}
Array.Include() {
	Array.Includes "$@"
}
Awk.Float() {
	awk "BEGIN {printf (\"%4.${AWKSCALE-"5"}f\n\", $*)}"
}
ToArgs() {
	readarray -t args
	"$@" "${args[@]}"
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
Em.NoVersion() {
	sed -E 's|\-[0-9]+.+||g'
}
Esc.BlackText() {
	printf "\033[30m" >/dev/tty
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
LibreTranslate.TranslateAuto() {
	LibreTranslate.Check || return 2
	LibreTranslate.Translate "${1:-""}" "$(LibreTranslate.Detect "${1:-""}")" "${2:-""}"
}
Msg.Debug() {
	Msg.Common "Debug:" "${*}" stderr
}
Misskey.MyUserName() {
	Misskey.I | jq -r ".username"
}
Pm.DeleteDbTmpDir() {
	rm -rf "$(Pm.GetDbTmpDir)"
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
Arch.GetKernelSrcList() {
	find "/usr/src" -mindepth 1 -maxdepth 1 -type l -name "linux*"
}
Array.Include() {
	Array.Includes "$@"
}
Awk.Float() {
	awk "BEGIN {printf (\"%4.${AWKSCALE-"5"}f\n\", $*)}"
}
ToArgs() {
	readarray -t args
	"$@" "${args[@]}"
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
Em.NoVersion() {
	sed -E 's|\-[0-9]+.+||g'
}
Esc.BlackText() {
	printf "\033[30m" >/dev/tty
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
LibreTranslate.TranslateAuto() {
	LibreTranslate.Check || return 2
	LibreTranslate.Translate "${1:-""}" "$(LibreTranslate.Detect "${1:-""}")" "${2:-""}"
}
Msg.Debug() {
	Msg.Common "Debug:" "${*}" stderr
}
Misskey.MyUserName() {
	Misskey.I | jq -r ".username"
}
Pm.DeleteDbTmpDir() {
	rm -rf "$(Pm.GetDbTmpDir)"
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
Prog.Bar() {
	local Max="$1" Counter="$2" Size="${3-"100"}"
	local SharpCount=$((Counter * Size / Max))
	local SpaceCount=$((Size - SharpCount))
	Esc.Return
	echo -n "$Counter/$Max [$(yes "#" | head -n "$SharpCount" 2>/dev/null | tr -d "\n")$(yes " " | head -n "$SpaceCount" 2>/dev/null | tr -d "\n")]"
}
Arch.GetKernelSrcList() {
	find "/usr/src" -mindepth 1 -maxdepth 1 -type l -name "linux*"
}
Array.Include() {
	Array.Includes "$@"
}
Awk.Float() {
	awk "BEGIN {printf (\"%4.${AWKSCALE-"5"}f\n\", $*)}"
}
ToArgs() {
	readarray -t args
	"$@" "${args[@]}"
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
Em.NoVersion() {
	sed -E 's|\-[0-9]+.+||g'
}
Esc.BlackText() {
	printf "\033[30m" >/dev/tty
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
LibreTranslate.TranslateAuto() {
	LibreTranslate.Check || return 2
	LibreTranslate.Translate "${1:-""}" "$(LibreTranslate.Detect "${1:-""}")" "${2:-""}"
}
Msg.Debug() {
	Msg.Common "Debug:" "${*}" stderr
}
Misskey.MyUserName() {
	Misskey.I | jq -r ".username"
}
Pm.DeleteDbTmpDir() {
	rm -rf "$(Pm.GetDbTmpDir)"
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
Prog.Bar() {
	local Max="$1" Counter="$2" Size="${3-"100"}"
	local SharpCount=$((Counter * Size / Max))
	local SpaceCount=$((Size - SharpCount))
	Esc.Return
	echo -n "$Counter/$Max [$(yes "#" | head -n "$SharpCount" 2>/dev/null | tr -d "\n")$(yes " " | head -n "$SpaceCount" 2>/dev/null | tr -d "\n")]"
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
Arch.GetKernelSrcList() {
	find "/usr/src" -mindepth 1 -maxdepth 1 -type l -name "linux*"
}
Array.Include() {
	Array.Includes "$@"
}
Awk.Float() {
	awk "BEGIN {printf (\"%4.${AWKSCALE-"5"}f\n\", $*)}"
}
ToArgs() {
	readarray -t args
	"$@" "${args[@]}"
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
Em.NoVersion() {
	sed -E 's|\-[0-9]+.+||g'
}
Esc.BlackText() {
	printf "\033[30m" >/dev/tty
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
LibreTranslate.TranslateAuto() {
	LibreTranslate.Check || return 2
	LibreTranslate.Translate "${1:-""}" "$(LibreTranslate.Detect "${1:-""}")" "${2:-""}"
}
Msg.Debug() {
	Msg.Common "Debug:" "${*}" stderr
}
Misskey.MyUserName() {
	Misskey.I | jq -r ".username"
}
Pm.DeleteDbTmpDir() {
	rm -rf "$(Pm.GetDbTmpDir)"
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
Prog.Bar() {
	local Max="$1" Counter="$2" Size="${3-"100"}"
	local SharpCount=$((Counter * Size / Max))
	local SpaceCount=$((Size - SharpCount))
	Esc.Return
	echo -n "$Counter/$Max [$(yes "#" | head -n "$SharpCount" 2>/dev/null | tr -d "\n")$(yes " " | head -n "$SpaceCount" 2>/dev/null | tr -d "\n")]"
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
Readlinkf_Readlink() {
	Readlinkf.Readlink "$@"
}
Arch.GetKernelSrcList() {
	find "/usr/src" -mindepth 1 -maxdepth 1 -type l -name "linux*"
}
Array.Include() {
	Array.Includes "$@"
}
Awk.Float() {
	awk "BEGIN {printf (\"%4.${AWKSCALE-"5"}f\n\", $*)}"
}
ToArgs() {
	readarray -t args
	"$@" "${args[@]}"
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
Em.NoVersion() {
	sed -E 's|\-[0-9]+.+||g'
}
Esc.BlackText() {
	printf "\033[30m" >/dev/tty
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
LibreTranslate.TranslateAuto() {
	LibreTranslate.Check || return 2
	LibreTranslate.Translate "${1:-""}" "$(LibreTranslate.Detect "${1:-""}")" "${2:-""}"
}
Msg.Debug() {
	Msg.Common "Debug:" "${*}" stderr
}
Misskey.MyUserName() {
	Misskey.I | jq -r ".username"
}
Pm.DeleteDbTmpDir() {
	rm -rf "$(Pm.GetDbTmpDir)"
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
Prog.Bar() {
	local Max="$1" Counter="$2" Size="${3-"100"}"
	local SharpCount=$((Counter * Size / Max))
	local SpaceCount=$((Size - SharpCount))
	Esc.Return
	echo -n "$Counter/$Max [$(yes "#" | head -n "$SharpCount" 2>/dev/null | tr -d "\n")$(yes " " | head -n "$SpaceCount" 2>/dev/null | tr -d "\n")]"
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
Readlinkf.Readlink() {
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
Readlinkf_Readlink() {
	Readlinkf.Readlink "$@"
}
Arch.GetKernelSrcList() {
	find "/usr/src" -mindepth 1 -maxdepth 1 -type l -name "linux*"
}
Array.Include() {
	Array.Includes "$@"
}
Awk.Float() {
	awk "BEGIN {printf (\"%4.${AWKSCALE-"5"}f\n\", $*)}"
}
ToArgs() {
	readarray -t args
	"$@" "${args[@]}"
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
Em.NoVersion() {
	sed -E 's|\-[0-9]+.+||g'
}
Esc.BlackText() {
	printf "\033[30m" >/dev/tty
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
LibreTranslate.TranslateAuto() {
	LibreTranslate.Check || return 2
	LibreTranslate.Translate "${1:-""}" "$(LibreTranslate.Detect "${1:-""}")" "${2:-""}"
}
Msg.Debug() {
	Msg.Common "Debug:" "${*}" stderr
}
Misskey.MyUserName() {
	Misskey.I | jq -r ".username"
}
Pm.DeleteDbTmpDir() {
	rm -rf "$(Pm.GetDbTmpDir)"
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
Prog.Bar() {
	local Max="$1" Counter="$2" Size="${3-"100"}"
	local SharpCount=$((Counter * Size / Max))
	local SpaceCount=$((Size - SharpCount))
	Esc.Return
	echo -n "$Counter/$Max [$(yes "#" | head -n "$SharpCount" 2>/dev/null | tr -d "\n")$(yes " " | head -n "$SpaceCount" 2>/dev/null | tr -d "\n")]"
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
Readlinkf.Readlink() {
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
Readlinkf_Readlink() {
	Readlinkf.Readlink "$@"
}
Sqlite3.Connect() {
	export SQLITE3_DBPATH="$1"
	echo ".open \"$SQLITE3_DBPATH\"" | sqlite3
	return 0
}
Arch.GetKernelSrcList() {
	find "/usr/src" -mindepth 1 -maxdepth 1 -type l -name "linux*"
}
Array.Include() {
	Array.Includes "$@"
}
Awk.Float() {
	awk "BEGIN {printf (\"%4.${AWKSCALE-"5"}f\n\", $*)}"
}
ToArgs() {
	readarray -t args
	"$@" "${args[@]}"
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
Em.NoVersion() {
	sed -E 's|\-[0-9]+.+||g'
}
Esc.BlackText() {
	printf "\033[30m" >/dev/tty
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
LibreTranslate.TranslateAuto() {
	LibreTranslate.Check || return 2
	LibreTranslate.Translate "${1:-""}" "$(LibreTranslate.Detect "${1:-""}")" "${2:-""}"
}
Msg.Debug() {
	Msg.Common "Debug:" "${*}" stderr
}
Misskey.MyUserName() {
	Misskey.I | jq -r ".username"
}
Pm.DeleteDbTmpDir() {
	rm -rf "$(Pm.GetDbTmpDir)"
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
Prog.Bar() {
	local Max="$1" Counter="$2" Size="${3-"100"}"
	local SharpCount=$((Counter * Size / Max))
	local SpaceCount=$((Size - SharpCount))
	Esc.Return
	echo -n "$Counter/$Max [$(yes "#" | head -n "$SharpCount" 2>/dev/null | tr -d "\n")$(yes " " | head -n "$SpaceCount" 2>/dev/null | tr -d "\n")]"
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
Readlinkf.Readlink() {
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
Readlinkf_Readlink() {
	Readlinkf.Readlink "$@"
}
Sqlite3.Connect() {
	export SQLITE3_DBPATH="$1"
	echo ".open \"$SQLITE3_DBPATH\"" | sqlite3
	return 0
}
SrcInfo.GetSectionList() {
	SrcInfo.Format | grep -e "^pkgbase" -e "^pkgname"
}
Arch.GetKernelSrcList() {
	find "/usr/src" -mindepth 1 -maxdepth 1 -type l -name "linux*"
}
Array.Include() {
	Array.Includes "$@"
}
Awk.Float() {
	awk "BEGIN {printf (\"%4.${AWKSCALE-"5"}f\n\", $*)}"
}
ToArgs() {
	readarray -t args
	"$@" "${args[@]}"
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
Em.NoVersion() {
	sed -E 's|\-[0-9]+.+||g'
}
Esc.BlackText() {
	printf "\033[30m" >/dev/tty
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
LibreTranslate.TranslateAuto() {
	LibreTranslate.Check || return 2
	LibreTranslate.Translate "${1:-""}" "$(LibreTranslate.Detect "${1:-""}")" "${2:-""}"
}
Msg.Debug() {
	Msg.Common "Debug:" "${*}" stderr
}
Misskey.MyUserName() {
	Misskey.I | jq -r ".username"
}
Pm.DeleteDbTmpDir() {
	rm -rf "$(Pm.GetDbTmpDir)"
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
Prog.Bar() {
	local Max="$1" Counter="$2" Size="${3-"100"}"
	local SharpCount=$((Counter * Size / Max))
	local SpaceCount=$((Size - SharpCount))
	Esc.Return
	echo -n "$Counter/$Max [$(yes "#" | head -n "$SharpCount" 2>/dev/null | tr -d "\n")$(yes " " | head -n "$SpaceCount" 2>/dev/null | tr -d "\n")]"
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
Readlinkf.Readlink() {
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
Readlinkf_Readlink() {
	Readlinkf.Readlink "$@"
}
Sqlite3.Connect() {
	export SQLITE3_DBPATH="$1"
	echo ".open \"$SQLITE3_DBPATH\"" | sqlite3
	return 0
}
SrcInfo.GetSectionList() {
	SrcInfo.Format | grep -e "^pkgbase" -e "^pkgname"
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
