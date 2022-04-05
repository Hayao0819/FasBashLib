#!/usr/bin/env bash
# Do not use FasBashLib in this file
# shellcheck disable=SC1090,SC1091

set -Eeu -o pipefail

# Init
MainDir="$(cd "$(dirname "${0}")/../" || exit 1 ; pwd)"
SrcDir="$MainDir/src"
BinDir="$MainDir/bin"
LibDir="$MainDir/lib"
#TmpFile="/tmp/single_runfunc.sh"

(( $# >= 2 )) || {
    echo "Usage: $(basename "$0") <Lib> <Func>" 
    exit 1
}

LibName="${1}"
FuncName="$2"

shift 2

if [[ ! -e "$SrcDir/$LibName/Meta.ini" ]]; then
    echo "$SrcDir/$LibName/Meta.ini does not found!" >&2
    exit 1
fi

LibPrefix="$("$LibDir/GetMeta.sh" "$LibName" "Prefix")"

source /dev/stdin < <("$BinDir/SingleFile.sh" -out "/dev/stdout" "$LibName")

Func="${LibPrefix}.$FuncName"

typeset -f "${Func}" 1> /dev/null || {
    echo "$Func is not defined." >&2
    exit 1
}

echo "---Function Start---" >&2
"$Func" "$@"
echo "---Function End" >&2
