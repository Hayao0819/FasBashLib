#!/usr/bin/env bash
# Do not use FasBashLib in this file
# shellcheck disable=SC1090,SC1091

set -Eeu

# Init
MainDir="$(cd "$(dirname "${0}")/../" || exit 1 ; pwd)"
#BinDir="$MainDir/bin"
LibDir="$MainDir/lib"
TmpDir="$(mktemp -d -t "fasbashlib.XXXXX")"
TmpFile="${TmpDir}/fasbashlib.sh"
OutFile="${MainDir}/fasbashlib.sh"
NoRequire=false
Version="0.1.x-dev"
LoadedFiles=()
Debug=false

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
        -debug)
            Debug=true
            shift 1
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
        "${Debug}" && echo "Solving require of $Lib" >&2
        readarray -O "${#RequireLib[@]}" -t RequireLib < <("$LibDir/SolveRequire.sh" "$Lib" | grep -xv "$Lib")
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
    TmpLibFile="$TmpDir/$LibName.sh"

    while read -r File; do
        printf "%s\n" "${LoadedFiles[@]}" | grep -qx "${Dir}/${File}" && {
            "$Debug" && echo "Already loaded $Dir/$File" >&2
            continue
        }

        echo "Load file: ${Dir}/${File}" >&2
        LoadedFiles+=("${Dir}/${File}")

        # 関数を読み込んで一時ファイルに書き込み
        (
            source "${Dir}/${File}" || {
                echo "Failed to load shell file" >&2
                exit 1
            }

            touch "$TmpLibFile"
            while read -r Func; do
                if [[ -z "${LibPrefix}" ]]; then
                    typeset -f "$Func" >> "$TmpLibFile"
                else
                    "${Debug}" && echo "${Func}を${LibPrefix}.${Func}に置き換え" >&2
                    typeset -f "$Func" | sed "1 s|${Func} ()|${LibPrefix}.${Func} ()|g" >> "$TmpLibFile"
                fi
            done < <(typeset -F | cut -d " " -f 3)
        )
    done < <("$LibDir/GetMeta.sh" "${LibName}" "Files" | tr "," "\n")

    # 一時ファイルを元に関数内のコードを置き換え
    if [[ -z "${LibPrefix-""}" ]]; then
        "${Debug}" && echo "プレフィックスが設定されていないため、${LibName}の置き換えをスキップ" >&2
    else
        (
            source "${TmpLibFile}" 
            while read -r Func; do
                "${Debug}" && echo "ソースコード内の@${Func}を${LibPrefix}.${Func}に置き換え" >&2
                sed -i "" "s|@${Func}|${LibPrefix}\.${Func}|g" "$TmpLibFile"
            done < <(typeset -F | cut -d " " -f 3 | sed "s|^${LibPrefix}\.||g")
        ) 
    fi
    cat "$TmpLibFile" >> "$TmpFile"
    unset LibPrefix FuncPrefix LibName
done < <(
    LoadLibDir=()
    if (( "${#TargetLib[@]}" > 0 )); then
        readarray -t LoadLibDir < <(printf "${SrcDir}/%s\n" "${RequireLib[@]}" "${TargetLib[@]}")
    else
        readarray -t LoadLibDir < <(find "$SrcDir" -mindepth 1 -maxdepth 1 -type d )
    fi
    echo "Load libs: $(printf "%s\n" "${LoadLibDir[@]}" | xargs -L 1 basename | tr "\n" " ")" >&2
    printf "%s\n" "${LoadLibDir[@]}"
    )
unset Dir File

# @を置き換え


# Minify
#bash "$LibDir/minifier/Minify.sh" -f="$TmpFile" > "$OutFile"
cat "$TmpFile" > "$OutFile"
rm -rf "$TmpDir"
echo "$OutFile にビルドされました" >&2
