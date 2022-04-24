#!/usr/bin/env bash
# shellcheck disable=SC2034

set -Eeu -o pipefail

MainDir="$(cd "$(dirname "${0}")/../" || exit 1 ; pwd)"
LibDir="$MainDir/lib"
SrcDir="$MainDir/src"
StaticDir="$MainDir/static"
BinDir="$MainDir/bin"
DocsDir="$MainDir/docs"
TestsDir="$MainDir/tests"

# sedコマンド
if sed -h 2>&1 | grep -q "GNU"; then
    GNUSed=true
else
    GNUSed=false
fi

# SedI
SedI(){
    local SedArgs=()

    # BSDかGNUか
    if "${GNUSed}"; then
        SedArgs=("-i" "${SedArgs[@]}")
    else
        SedArgs=("-i" "" "${SedArgs[@]}")
    fi

    sed "${SedArgs[@]}" "$@"
}

# _GetFuncListFromStdin
_GetFuncListFromStdin(){
    (
        # すべての関数をリセット
        local Func
        while read -r Func; do
            unset "$Func"
        done < <(declare -F | cut -d " " -f 3)

        # ファイルをsource
        # shellcheck source=/dev/null
        source "/dev/stdin"

        # 関数のリストを出力
        declare -F | cut -d " " -f 3
    )
}

GetFuncList(){
    declare -F | cut -d " " -f 3
}

UnsetAllFunc(){
    #ForEach eval "unset \"{}\"" < <(GetFuncList)
    local Func
    while read -r Func; do
        unset "$Func"
    done < <(GetFuncList)
}

PrintArray(){
    (( $# >= 1 )) || return 0
    printf "%s\n" "${@}"
}


ForEach(){
    local _Item
    while read -r _Item; do
        "${@//"{}"/"${_Item}"}" || return "${?}"
    done
}

# ToLower <文字列>
ToLower(){
    local _Str="${1,,}"
    [[ -z "${_Str-""}" ]] || echo "${_Str}"
}
