#!/usr/bin/env bash
# shellcheck disable=SC1090,SC1091

MainDir="$(cd "$(dirname "${0}")/../" || exit 1 ; pwd)"
LibDir="$MainDir/lib" BinDir="$MainDir/bin" TestsDir="$MainDir/tests"

# Parse argument
if (( $# < 2)) || [[ "${1}" = "-h" ]]  ; then
    echo "Usage: $(basename "$0") -- [Lib] [Function] [Name]"
    [[ "$1" = "-h" ]] && exit 0
    exit 1
fi

# Set variavles
LibName="$1" FuncName="$2" TestName="${3-""}"
FuncTestDir="$TestsDir/$LibName/${FuncName}/"
[[ -n "${FuncTestDir-""}" ]] && FuncTestDir="$TestsDir/$LibName/${FuncName}/$TestName"

# Check
"$BinDir/List.sh" -q | grep -qx "${LibName}" || {
    echo "No such library found." >&2
    exit 1
}

"$LibDir/GetFuncList.sh" -noprefix "$LibName" | grep -qx "$FuncName" || {
    echo "No such function found." >&2
    exit 1
}

# Create files
mkdir -p "$FuncTestDir"
[[ -e "$FuncTestDir/Run.sh"    ]] || echo "# shellcheck disable=SC2148,SC2034" >  "$FuncTestDir/Run.sh"
[[ -e "$FuncTestDir/Result.txt" ]] || echo > "$FuncTestDir/Result.txt"
[[ -e "$FuncTestDir/Exit.txt" ]] || echo "0" > "$FuncTestDir/Exit.txt"
