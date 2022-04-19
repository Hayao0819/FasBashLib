#!/usr/bin/env bash
# shellcheck disable=SC1090,SC1091

set -Eeu

MainDir="$(cd "$(dirname "${0}")/../" || exit 1 ; pwd)"
LibDir="$MainDir/lib"
BinDir="$MainDir/bin"
TestsDir="$MainDir/tests"

LibList=()
FuncList=()

ShowOnlyLib=false

# Parse args
while [[ -n "${1-""}" ]]; do
    [[ "$1" == "-"* ]] || break
    case "${1}" in
        "-lib")
            ShowOnlyLib=true
            shift 1
            ;;
        "--")
            shift 1
            break
            ;;
        *)
            echo "Usage: $(basename "$0") -- [Lib]"
            [[ "$1" = "-h" ]] && exit 0
            exit 1
            ;;
    esac
done

LibList+=("${1-""}")
if [[ -z "${1-""}" ]]; then
    readarray -t LibList < <("$BinDir/GetLibList.sh" -q)
fi

for Lib in "${LibList[@]}"; do
    while read -r Func; do
        FuncTestDir="$TestsDir/$Lib/${Func}/"
        if [[ -e "$FuncTestDir" ]]; then
            if [[ -e "${FuncTestDir}/Run.sh" ]]; then
                echo "$Lib/$Func"
            fi
        fi
    done < <(
        if (( "${#FuncList[@]}" > 0 )); then
            printf "%s\n" "${FuncList[@]}"
        else
            "$LibDir/GetFuncList.sh" -noprefix "$Lib"
        fi
    )
done |  if [[ "${ShowOnlyLib}" = true ]]; then
            cut -d "/" -f 1 | sort | uniq
        else
            cat
        fi

