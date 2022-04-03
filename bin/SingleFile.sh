#!/usr/bin/env bash
# Do not use FasBashLib in this file
# shellcheck disable=SC1090,SC1091

set -Eeu

# Init
MainDir="$(cd "$(dirname "${0}")/../" || exit 1 ; pwd)"
#BinDir="$MainDir/bin"
LibDir="$MainDir/lib"
TmpDir="$(mktemp -d -t "fasbashlib.XXXXX")"
TmpFile_Stage1="${TmpDir}/fasbashlib-1.sh"
TmpFile_Stage2="${TmpDir}/fasbashlib-2.sh"
OutFile="${MainDir}/fasbashlib.sh"
NoRequire=false
Version=""
LoadedFiles=()
Debug=false
SnakeCase=false

# 擬似関数
ToSnakeCase=(sed -r -e 's/^([A-Z])/\L\1\E/' -e 's/([A-Z])/_\L\1\E/g')

# Set version
if [[ -e "$MainDir/.git" ]]; then
    echo "Found git. Use git tag and id as version." >&2
    Version="$(git describe --long --tags | sed 's/\([^-]*-g\)/r\1/;s/-/./g')"
else
    Version="0.1.x-dev"
fi

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
        "-debug")
            Debug=true
            shift 1
            ;;
        "-snake")
            SnakeCase=true
            ;;
        "--")
            shift 1
            break
            ;;
        "-"*)
            echo "Usage: $(basename "$0") [-out File] [-ver Version] [-noreq] [-debug] [Lib1] [Lib2] ..." >&2
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
#cat "$StaticDir/script-head.sh" > "$TmpFile_Stage1"
sed "s|%VERSION%|${Version-""}|g" "${StaticDir}/script-head.sh" > "$TmpFile_Stage1"

# 作成に失敗した場合に終了
[[ -e "$TmpFile_Stage1" ]] || exit 1

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
            "${Debug}" && echo "Load ${Dir}/${File}" >&2
            source "${Dir}/${File}" || {
                echo "Failed to load shell file" >&2
                exit 1
            }

            touch "$TmpLibFile"

            # 関数の定義部分を書き換え
            while read -r Func; do
                # 置き換えなし
                if [[ -z "${LibPrefix}" ]] && [[ "$SnakeCase" = false ]]; then
                    "$Debug" && echo "${Func}を追加" >&2
                    typeset -f "$Func" >> "$TmpLibFile"
                    continue
                fi

                # 置き換えあり
                NewFuncName=""
                if [[ -z "$LibPrefix" ]]; then
                    # プレフィックスなし、スネークケース置き換え
                    NewFuncName="$("${ToSnakeCase[@]}" <<< "$Func")"
                else
                    if [[ "$SnakeCase" = true ]]; then
                        # プレフィックスあり、スネークケース置き換えあり
                        NewFuncName="$("${ToSnakeCase[@]}" <<< "$LibPrefix").$("${ToSnakeCase[@]}" <<< "$Func")"
                    else
                        # プレフィックスあり、スネークケースなし
                        NewFuncName="${LibPrefix}.${Func}"
                    fi
                fi
                "${Debug}" && echo "${Func}を${NewFuncName}に置き換え" >&2
                typeset -f "$Func" | sed "1 s|${Func} ()|${NewFuncName} ()|g" >> "$TmpLibFile"
            done < <(typeset -F | cut -d " " -f 3)
        )
    done < <("$LibDir/GetMeta.sh" "${LibName}" "Files" | tr "," "\n")

    # 一時ファイルを元に関数内のコードを置き換え
    if [[ -z "${LibPrefix-""}" ]]; then
        "${Debug}" && echo "プレフィックスが設定されていないため、${LibName}の置き換えをスキップ" >&2
    else
        (
            source "${TmpLibFile}" 
            SedArgs=()
            while read -r Func; do
                "${Debug}" && echo "ソースコード内の@${Func}を${LibPrefix}.${Func}に置き換え" >&2
                # sed の共通コマンド
                SedArgs=("s|@${Func}|${LibPrefix}\.${Func}|g" "$TmpLibFile")

                # BSDかGNUか
                if sed -h 2>&1 | grep -q "GNU"; then
                    SedArgs=("-i" "${SedArgs[@]}")
                else
                    SedArgs=("-i" "" "${SedArgs[@]}")
                fi

                sed "${SedArgs[@]}"
                unset SedArgs
            done < <(typeset -F | cut -d " " -f 3 | sed "s|^${LibPrefix}\.||g")
        ) 
    fi
    cat "$TmpLibFile" >> "$TmpFile_Stage1"
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

# @のスネークケース置き換え
if [[ "$SnakeCase" = true ]]; then
    :
else
    cat "$TmpFile_Stage1" > "$TmpFile_Stage2"
fi


# Minify
#bash "$LibDir/minifier/Minify.sh" -f="$TmpFile_Stage1" > "$OutFile"
cat "$TmpFile_Stage1" > "$OutFile"
rm -rf "$TmpDir"
echo "$OutFile にビルドされました" >&2
