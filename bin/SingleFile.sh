#!/usr/bin/env bash
# Do not use FasBashLib in this file
# shellcheck disable=SC1090,SC1091

set -Eeu

# Init
MainDir="$(cd "$(dirname "${0}")/../" || exit 1 ; pwd)"
TmpFile="/tmp/fasbashlib.sh"
OutFile="${MainDir}/fasbashlib.sh"
NoRequire=false
NameSpace=""
Version="0.1.x-dev"

# Parse args
NoArg=()
while [[ -n "${1-""}" ]]; do
    #[[ "$1" == "-"* ]] || break
    case "${1}" in
        "-out")
            [[ -n "${2-""}" ]] || { echo "No file is specified" >&2 ; exit 1; }
            OutFile="${2}"
            shift 2 || break
            ;;
        "-noreq")
            NoRequire=true
            shift 1
            ;;
        "-ns")
            NameSpace="$2"
            shift 2
            ;;
        "-ver")
            Version="$2"
            shift 2
            ;;
        "--")
            shift 1
            break
            ;;
        "-"*)
            echo "Usage: $(basename "$0") [-out File] [-noreq] [Lib1] [Lib2] ..." >&2
            [[ "${1}" = "-h" ]] && exit 0
            exit 1
            ;;
        *)
            NoArg+=("$1")
            shift 1
            ;;
    esac
done
set -- "${NoArg[@]}"

TargetLib=("$@")
RequireLib=()

# Ccnfigure dir
SrcDir="$MainDir/src"
StaticDir="$MainDir/static"
LibDir="$MainDir/lib"

# Check dir
for Dir in "$SrcDir" "$StaticDir" "$LibDir"; do
    [[ -d "$Dir" ]]  || {
        echo "Missing directory: $Dir" >&2
        exit 1
    }
done

# Check function
while read -r Func; do
    echo "Unset $Func" >&2
    unset "$Func"
done < <(declare -F | cut -d " " -f 3)
unset Func

# Solve require
if [[ "$NoRequire" = false ]]; then
    for Lib in "${TargetLib[@]}"; do
        readarray -O "${#RequireLib[@]}" -t RequireLib < <("$LibDir/SolveRequire.sh" "$Lib")
    done
    unset Lib
fi

# Load src
while read -r Dir; do
    while read -r File; do
        echo "Load file: ${Dir}/${File}" >&2
        source "${Dir}/${File}" || {
            echo "Failed to load shell file" >&2
            exit 1
        }
    done < <("$LibDir/GetMeta.sh" "$(basename "$Dir")" "Files" | tr "," "\n")
done < <(
    LoadLibDir=()
    if (( "${#TargetLib[@]}" > 0 )); then
        printf "${SrcDir}/%s\n" "${RequireLib[@]}" "${TargetLib[@]}"
        exit 0
    else
        readarray -t LoadLibDir < <(find "$SrcDir" -type d -mindepth 1 -maxdepth 1)
    fi
    echo "Load libs: $(printf "%s\n" "${LoadLibDir[@]}" | xargs -L 1 basename | tr "\n" " ")" >&2
    printf "%s\n" "${LoadLibDir[@]}"
    )
unset Dir File

# Output to temp
#cat "$StaticDir/head.sh" > "$TmpFile"
sed "s|%VERSION%|${Version-""}|g; s|%LIBNAMESPACE%|${NameSpace-""}|g" "${StaticDir}/head.sh" > "$TmpFile"
if [[ -z "${NameSpace-""}" ]]; then
    typeset -f >> "$TmpFile"
else
    while read -r Func; do
        typeset -f "$Func" | sed "1 s|${Func} ()|${NameSpace}.${Func} ()|g" >> "$TmpFile"
    done < <(typeset -F | cut -d " " -f 3)
fi
[[ -e "$TmpFile" ]] || exit 1

# Minify
#bash "$LibDir/minifier/Minify.sh" -f="$TmpFile" > "$OutFile"
cat "$TmpFile" > "$OutFile"
echo "$OutFile にビルドされました" >&2
