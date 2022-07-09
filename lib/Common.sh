#!/usr/bin/env bash
# shellcheck disable=SC2034

set -Eeu -o pipefail

MainDir="${MainDir="$(cd "$(dirname "${0}")/../" || exit 1 ; pwd)"}"
LibDir="$MainDir/lib"
SrcDir="$MainDir/src"
StaticDir="$MainDir/static"
BinDir="$MainDir/bin"
DocsDir="$MainDir/docs"
TestsDir="$MainDir/tests"
DockerDir="$MainDir/docker"

FindCommand=""
SedCommand=""

# sedコマンド
if sed --help 2>&1 | grep -q "GNU"; then
    GNUSed=true
else
    GNUSed=false
fi

# findコマンド
if find --help 2> /dev/null| grep -q "GNU"; then
    FindCommand="find"
elif command gfind --help 2>&1 | grep -q "GNU"; then
    FindCommand="gfind"
fi

# sedコマンド
if sed --help 2> /dev/null | grep -q "GNU"; then
    SedCommand="sed"
elif command gsed --help 2>&1 | grep -q "GNU"; then
    SedCommand="gsed"
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

find(){
    [[ -n "${FindCommand-""}" ]] || return
    command "$FindCommand" "$@"
}

#sed(){
#    [[ -n "${SedCommand-""}" ]] || return
#    command "$SedCommand" "$@"
#}

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

RemoveBlank () { 
    sed "s|^ *||g; s| *$||g; s|^	*||g; s|	*$||g; /^$/d"
}


ForEach(){
    local _Item
    while read -r _Item; do
        "${@//"{}"/"${_Item}"}" || return "${?}"
    done
}

GetBaseName(){
    ForEach basename "{}"
}

# ToLower <文字列>
ToLower(){
    local _Str="${1,,}"
    [[ -z "${_Str-""}" ]] || echo "${_Str}"
}


GetMeta(){
    "$LibDir/GetMeta.sh" "$@"
}

GetLibList(){
    "$BinDir/List.sh" -q
}

GetLibFileList(){
    "${LibDir}/GetFileList.sh" "$@"
}

GetLibFuncList(){
    "${LibDir}/GetFuncList.sh" "$@"
}

GetMetaParam(){
    "${LibDir}/GetMetaParam.sh" "$@"
}

# JSONを作成する
# ビルドされたMisskey.MakeJsonからコピー
MakeJson () 
{ 
    local i _Key _Value;
    for i in "$@";
    do
        _Key=$(cut -d "=" -f 1 <<< "$i");
        _Value=$(cut -d "=" -f 2- <<< "$i");
        if [[ "$_Value" =~ ^[0-9]+$ ]] || [[ "$_Value" = true ]] || [[ "$_Value" = false ]] || [[ "$_Value" = "{"*"}" ]] || [[ "$_Value" = "["*"]" ]]; then
            echo -n "{\"$_Key\": $_Value}";
        else
            echo -n "{\"$_Key\": \"$_Value\"}";
        fi;
    done | sed "s|}{|,|g" | jq -c -M
}
