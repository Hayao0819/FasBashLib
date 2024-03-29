#!/usr/bin/env bash
# shellcheck disable=SC2154

# shellcheck source=/dev/null
source "$(cd "$(dirname "${0}")/../" || exit 1 ; pwd)/lib/Common.sh"
OutFile="$MainDir/fasbashlib.json"
TmpDir="$(mktemp -d -t "fasbashlib-build-info.XXXXX")"

while [[ -n "${1-""}" ]]; do
    case "${1}" in
        "-out")
            [[ -n "${2-""}" ]] || { echo "No file is specified" >&2 ; exit 1; }
            OutFile="${2}"
            shift 2 || break
            ;;
        *)
            echo "Usage: $(basename "$0") [-out Dir]"
            exit 0
        ;;

    esac
done

LineToJsonArray(){
    echo -n "["
    sed "s|^|\"|g; s|$|\"|g" | tr "\n" "," | sed "s|,$||g"
    echo "]"
}

Args=()

while read -r Lib; do
    {
    echo "${Lib}の情報を収集中..." >&2
    Require="$("$LibDir/SolveRequire.sh" -nomyself "$Lib" | LineToJsonArray)"
    Depends=$(GetMeta -c "$Lib" Depends | LineToJsonArray)
    FuncList="$("$LibDir/GetFuncList.sh" -noprefix "$Lib" | LineToJsonArray)"
    MakeJson \
        "name=${Lib}" \
        "description=$(GetMeta "$Lib" "Description")"\
        "require=$Require" \
        "depends=$Depends" \
        "functions=$FuncList" \
        "shell=$(GetMeta "$Lib" "Shell")" \
        "prefix=$(GetMeta "$Lib" "Prefix")" > "$TmpDir/$Lib"
    } &
done < <(GetLibList)
wait

for Lib in "${TmpDir}/"*; do
    Args+=("$(basename "$Lib")=$(cat "$Lib")")
done

MakeJson "${Args[@]}" > "$OutFile"
rm -rf "$TmpDir"
