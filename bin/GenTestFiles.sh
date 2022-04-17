#!/usr/bin/env bash
# shellcheck disable=SC1090,SC1091

MainDir="$(cd "$(dirname "${0}")/../" || exit 1 ; pwd)"
LibDir="$MainDir/lib"
BinDir="$MainDir/bin"
TestsDir="$MainDir/tests"

LibList=()
FuncList=()

# Parse args
while [[ -n "${1-""}" ]]; do
    [[ "$1" == "-"* ]] || break
    case "${1}" in
        "--")
            shift 1
            break
            ;;
        *)
            echo "Usage: $(basename "$0") -- [Lib] [Function] ..."
            [[ "${1}" = "-h" ]] && exit 0
            exit 1
            ;;
    esac
done

# Get library list
if (( "${#}" > 0 )); then
    LibList=("${1}")
    FuncList=("${2}")
else
    readarray -t LibList < <("$BinDir/GetLibList.sh" -q)
fi

# Create lib dirs
printf "%s\n" "${LibList[@]}" | xargs -I{} mkdir -p "$TestsDir/{}"

# Create function dirs
for Lib in "${LibList[@]}"; do
    while read -r Func; do
        FuncTestDir="$TestsDir/$Lib/${Func}/"
        mkdir -p "$FuncTestDir"

        [[ -e "$FuncTestDir/Run.sh"    ]] || echo "# shellcheck disable=SC2148,SC2034" >  "$FuncTestDir/Run.sh"
        [[ -e "$FuncTestDir/Result.txt" ]] || echo > "$FuncTestDir/Result.txt"
    done < <(
        if (( "${#FuncList[@]}" > 0 )); then
            printf "%s\n" "${FuncList[@]}"
        else
            "$LibDir/GetFuncList.sh" "$Lib"
        fi
        )
done
