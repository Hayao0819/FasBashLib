#!/usr/bin/env bash
# shellcheck disable=SC1090,SC1091,SC2154

# shellcheck source=/dev/null
source "$(cd "$(dirname "${0}")/../" || exit 1 ; pwd)/lib/Common.sh"

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
            echo "Usage: $(basename "$0") -- [-lib] [Lib]"
            [[ "$1" = "-h" ]] && exit 0
            exit 1
            ;;
    esac
done

LibList+=("${1-""}")
if [[ -z "${1-""}" ]]; then
    readarray -t LibList < <("$BinDir/List.sh" -q)
fi

for Lib in "${LibList[@]}"; do
    while read -r Func; do
        FuncTestDir="$TestsDir/$Lib/${Func}/"
        { [[ -e "$FuncTestDir" ]] && [[ -n "$(ls "${FuncTestDir}")" ]]; }|| {
            echo "$Lib/$Func"
        }
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

