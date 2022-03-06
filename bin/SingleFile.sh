#!/usr/bin/env bash
# Do not use FasBashLib in this file
# shellcheck disable=SC1090,SC1091

set -Eeu

# Init
MainDir="$(cd "$(dirname "${0}")/../" || exit 1 ; pwd)"
#BinDir="$MainDir/bin"
LibDir="$MainDir/lib"
TmpFile="/tmp/fasbashlib.sh"
OutFile="${MainDir}/fasbashlib.sh"
NoRequire=false
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

# Create temp file with header
#cat "$StaticDir/head.sh" > "$TmpFile"
sed "s|%VERSION%|${Version-""}|g" "${StaticDir}/head.sh" > "$TmpFile"

# 作成に失敗した場合に終了
[[ -e "$TmpFile" ]] || exit 1

# ライブラリをサブシェル内で読み込んでファイルに追記
while read -r Dir; do
    LibName="$(basename "$Dir")"
    LibPrefix="$("$LibDir/GetMeta.sh" "$LibName" "Prefix")"

    while read -r File; do
        echo "Load file: ${Dir}/${File}" >&2
        (
            source "${Dir}/${File}" || {
                echo "Failed to load shell file" >&2
                exit 1
            }

            while read -r Func; do
                if [[ -z "${LibPrefix}" ]]; then
                    typeset -f "$Func" >> "$TmpFile"
                else
                    typeset -f "$Func" | sed "1 s|${Func} ()|${LibPrefix}.${Func} ()|g" >> "$TmpFile"
                fi
            done < <(typeset -F | cut -d " " -f 3)
        )
    done < <("$LibDir/GetMeta.sh" "${LibName}" "Files" | tr "," "\n")

    unset LibPrefix FuncPrefix LibName
done < <(
    LoadLibDir=()
    if (( "${#TargetLib[@]}" > 0 )); then
        printf "${SrcDir}/%s\n" "${RequireLib[@]}" "${TargetLib[@]}"
        exit 0
    else
        readarray -t LoadLibDir < <(find "$SrcDir" -mindepth 1 -maxdepth 1 -type d )
    fi
    echo "Load libs: $(printf "%s\n" "${LoadLibDir[@]}" | xargs -L 1 basename | tr "\n" " ")" >&2
    printf "%s\n" "${LoadLibDir[@]}"
    )
unset Dir File


# Minify
#bash "$LibDir/minifier/Minify.sh" -f="$TmpFile" > "$OutFile"
cat "$TmpFile" > "$OutFile"
echo "$OutFile にビルドされました" >&2
