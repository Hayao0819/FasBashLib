#!/usr/bin/env bash
# shellcheck disable=SC2154

# shellcheck source=/dev/null
source "$(cd "$(dirname "${0}")/../" || exit 1 ; pwd)/lib/Common.sh"
OutFile="$MainDir/fasbashlib.json"

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
    echo "${Lib}の情報を収集中..." >&2
    Require="$("$LibDir/SolveRequire.sh" -nomyself "$Lib" | LineToJsonArray)"
    Depends=$(GetMeta "$Lib" Depends | LineToJsonArray)

    Json="$(
        MakeJson \
            "name=${Lib}" \
            "description=$(GetMeta "$Lib" "Description")"\
            "require=$Require" \
            "depends=$Depends" \
            "shell=$(GetMeta "$Lib" "Shell")" \
            "prefix=$(GetMeta "$Lib" "Prefix")"
        )"

    Args+=("${Lib}=$Json")

done < <(GetLibList)

MakeJson "${Args[@]}" > "$OutFile"
