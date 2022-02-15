#!/usr/bin/env bash
# Do not use FasBashLib in this file
# shellcheck disable=SC1090,SC1091

set -Eeu

# Init
MainDir="$(cd "$(dirname "${0}")/../" || exit 1 ; pwd)"
SrcDir="$MainDir/src"
BinDir="$MainDir/bin"
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

source /dev/stdin < <("$BinDir/SingleFile.sh" -out "/dev/stdout" "$LibName" 2> /dev/null )

"$FuncName" "$@"