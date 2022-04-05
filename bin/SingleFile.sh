#!/usr/bin/env bash
# Do not use FasBashLib in this file
# shellcheck disable=SC1090,SC1091

set -Eeu

# Init
MainDir="$(cd "$(dirname "${0}")/../" || exit 1 ; pwd)"
#BinDir="$MainDir/bin"
LibDir="$MainDir/lib"
TmpDir="$(mktemp -d -t "fasbashlib.XXXXX")"
TmpOutFile="${TmpDir}/fasbashlib-1.sh"
TmpFile_FuncList="${TmpDir}/fasbashlib-list.sh" # スネークケース置き換え用の関数一覧: <prefix> = <func>の形式で記述されます
OutFile="${MainDir}/fasbashlib.sh"
NoRequire=false
Version=""
LoadedFiles=()
Debug=false
SnakeCase=false
GenerateFuncList=false
DontRunAtMarkReplacement=false

# 擬似関数
#ToSnakeCase=(sed -r -e 's/^([A-Z])/\L\1\E/' -e 's/([A-Z])/_\L\1\E/g')
ToSnakeCase=(sed -E 's/(.)([A-Z])/\1_\2/g')

# Set version
if [[ -e "$MainDir/.git" ]]; then
    echo "Found git. Use git tag and id as version." >&2
    Version="$(git describe --long --tags | sed 's/\([^-]*-g\)/r\1/;s/-/./g')"
else
    Version="0.2.x-dev"
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
        "-list")
            GenerateFuncList=true
            shift 1
            ;;
        "-debug")
            Debug=true
            shift 1
            ;;
        "-snake")
            SnakeCase=true
            shift 1
            ;;
        "--")
            shift 1
            break
            ;;
        "-"*)
            echo "Usage: $(basename "$0") [-out File] [-ver Version] [-noreq] [-debug] [-snake] [-list] [Lib1] [Lib2] ..." >&2
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

# 環境表示
if "$Debug"; then
    echo "TmpDir=$TmpDir"
    echo "TmpFile=$TmpOutFile"
    echo "TmpFile_FuncList=$TmpFile_FuncList"
fi

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
#cat "$StaticDir/script-head.sh" > "$TmpOutFile"
sed "s|%VERSION%|${Version-""}|g" "${StaticDir}/script-head.sh" > "$TmpOutFile"

# 作成に失敗した場合に終了
[[ -e "$TmpOutFile" ]] || exit 1

# ライブラリをサブシェル内で読み込んでファイルに追記
echo -n > "$TmpFile_FuncList"
while read -r Dir; do
    LibName="$(basename "$Dir")"
    LibPrefix="$("$LibDir/GetMeta.sh" "$LibName" "Prefix")"
    TmpLibFile="$TmpDir/$LibName.sh"
    Lib_RawFuncList="$TmpDir/$LibName-FuncList.sh" #置き換え前のプレフィックスなしの純粋な関数名の一覧
    echo -n >> "${Lib_RawFuncList}"

    # ライブラリのファイルごとに関数を読み取ってTmpLibFileに関数を書き込み
    # この際に関数定義部分のプレフィックスとスネークケース置き換えを行う
    while read -r File; do
        printf "%s\n" "${LoadedFiles[@]}" | grep -qx "${Dir}/${File}" && {
            "$Debug" && echo "Already loaded $Dir/$File" >&2
            continue
        }

        echo "Load file: ${Dir}/${File}" >&2
        LoadedFiles+=("${Dir}/${File}")

        # 関数を読み込んで一時ファイルに書き込み
        # sourceを使用するためサブシェル内で実行
        (
            "${Debug}" && echo "Load ${Dir}/${File}" >&2
            source "${Dir}/${File}" || {
                echo "Failed to load shell file" >&2
                exit 1
            }

            touch "$TmpLibFile"

            # 関数の定義部分を書き換え
            while read -r Func; do
                # Lib_RawFuncListはライブラリごとの関数の一覧
                # プレフィックスは除外されており、元のソースコードの関数名がそのまま記述されます。
                # それに対してTmpFile_FuncListはプレフィックス置き換えまで済ませた全てのライブラリの関数をグローバルに列挙します。
                # TmpFile_FuncListは最終処理で他ライブラリの関数呼び出しをスネークケースに置き換えるのに使用されます。
                echo "$Func" >> "${Lib_RawFuncList}"

                # 置き換えなし
                if [[ -z "${LibPrefix}" ]] && [[ "$SnakeCase" = false ]]; then
                    echo " = $Func" >> "$TmpFile_FuncList"
                    "$Debug" && echo "${Func}を追加" >&2
                    typeset -f "$Func" >> "$TmpLibFile"
                    continue
                fi

                # 置き換えあり
                NewFuncName=""
                if [[ -z "$LibPrefix" ]]; then
                    # プレフィックスなし、スネークケース置き換え
                    echo " = $Func" >> "$TmpFile_FuncList"
                    NewFuncName="$("${ToSnakeCase[@]}" <<< "$Func" | tr '[:upper:]' '[:lower:]')"
                else
                    echo "${LibPrefix} = ${Func}" >> "$TmpFile_FuncList"
                    if [[ "$SnakeCase" = true ]]; then
                        # プレフィックスあり、スネークケース置き換えあり
                        #NewFuncName="$(eval "${ToSnakeCase[@]}" <<< "$LibPrefix").$(eval "${ToSnakeCase[@]}" <<< "$Func")"
                        NewFuncName="$(tr '[:upper:]' '[:lower:]' <<< "$LibPrefix").$("${ToSnakeCase[@]}" <<< "$Func" | tr '[:upper:]' '[:lower:]')"
                        
                    else
                        # プレフィックスあり、スネークケースなし
                        NewFuncName="${LibPrefix}.${Func}"
                    fi
                fi

                "${Debug}" && echo "置き換え1: 関数定義の${Func}を${NewFuncName}に置き換え" >&2
                typeset -f "$Func" | sed "1 s|${Func} ()|${NewFuncName} ()|g" >> "$TmpLibFile"
            done < <(typeset -F | cut -d " " -f 3)
        )
    done < <("$LibDir/GetMeta.sh" "${LibName}" "Files" | tr "," "\n")


    if [[ "${DontRunAtMarkReplacement}" = false ]]; then
        # 同じライブラリ内での関数呼び出し(@関数)を置き換え
        # 置き換えは全てTmpLibFileのみで完結します
        # 置き換える関数の一覧はLib_RawFuncListから取得
        "$Debug" && echo "${LibName}の@呼び出しを置き換え" >&2
        if [[ -z "${LibPrefix-""}" ]]; then
            "${Debug}" && echo "プレフィックスが設定されていないため、${LibName}の置き換えをスキップ" >&2
        else
            if [[ "${SnakeCase}" = true ]]; then
                LibPrefix=$(tr '[:upper:]' '[:lower:]' <<< "$LibPrefix")
            fi

            # Func: ソースコードに記述されたそのままの関数名
            # 例えば、SrcInfo.GetValueなら"GetValue"の部分
            while read -r Func; do
                if [[ "$SnakeCase" = true ]]; then
                    NewFuncName="$("${ToSnakeCase[@]}" <<< "$Func" | tr '[:upper:]' '[:lower:]')"
                else
                    NewFuncName="$Func"
                fi
            
                "${Debug}" && echo "置き換え2: 関数内の@${Func}を${LibPrefix}.${NewFuncName}に置き換え" >&2
                # sed の共通コマンド
                SedArgs=()
                SedArgs+=(-e "s|@${Func}$|${LibPrefix}\.${NewFuncName}|g") #行末に書かれた関数用の置き換え
                SedArgs+=(-e "s|@${Func}\([^a-zA-Z0-9]\)|${LibPrefix}\.${NewFuncName}\1|g")
                SedArgs+=("$TmpLibFile")
                # BSDかGNUか
                if sed -h 2>&1 | grep -q "GNU"; then
                    SedArgs=("-i" "${SedArgs[@]}")
                else
                    SedArgs=("-i" "" "${SedArgs[@]}")
                fi

                sed "${SedArgs[@]}"
                unset SedArgs
            done < "${Lib_RawFuncList}"
        fi
    fi

    # ライブラリごとの関数リストを削除
    rm -rf "${Lib_RawFuncList}"

    # 完成したライブラリを全体に追加
    cat "$TmpLibFile" >> "$TmpOutFile"

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

# 全ての呼び出しのスネークケース置き換え
# TmpFile_FuncListを元に生成されたスクリプト全体を置き換えます
if [[ "$SnakeCase" = true ]]; then
    # 関数一覧をプレフィックスを含んだ
    while read -r Line; do
        #NewFuncName="$(eval "${ToSnakeCase[@]}" <<< "$Func")"
        LibPrefix="$(cut -d "=" -f 1 <<< "$Line" | sed "s|^ *||g; s| *$||g")"
        Func="$(cut -d "=" -f 2 <<< "$Line" | sed "s|^ *||g; s| *$||g")"
        
        #NewFuncName="$("${ToSnakeCase[@]}" <<< "$Func" | tr '[:upper:]' '[:lower:]')"
        if [[ -z "$LibPrefix" ]]; then
            OldFuncName="$Func"
            NewFuncName="$("${ToSnakeCase[@]}" <<< "$Func" | tr '[:upper:]' '[:lower:]')"
        else
            OldFuncName="${LibPrefix}.$Func"
            NewFuncName="$(tr '[:upper:]' '[:lower:]' <<< "$LibPrefix").$("${ToSnakeCase[@]}" <<< "$Func" | tr '[:upper:]' '[:lower:]')"
        fi

        "${Debug}" && echo "置き換え3: 全ての${OldFuncName}を${NewFuncName}に置き換え" >&2
        # sed の共通コマンド
        SedArgs=("s|${OldFuncName}|${NewFuncName}|g" "$TmpOutFile")

        # BSDかGNUか
        if sed -h 2>&1 | grep -q "GNU"; then
            SedArgs=("-i" "${SedArgs[@]}")
        else
            SedArgs=("-i" "" "${SedArgs[@]}")
        fi

        sed "${SedArgs[@]}"
        unset SedArgs
    done < <(cat "$TmpFile_FuncList")
fi


# Minify
#bash "$LibDir/minifier/Minify.sh" -f="$TmpOutFile" > "$OutFile"
cat "$TmpOutFile" > "$OutFile"
if [[ "$GenerateFuncList" = true ]]; then
    cat "$TmpFile_FuncList" > "${OutFile%.sh}-list"
fi
rm -rf "$TmpDir"
echo "$OutFile にビルドされました" >&2
