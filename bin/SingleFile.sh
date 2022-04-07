#!/usr/bin/env bash
# Do not use FasBashLib in this file
# shellcheck disable=SC1090,SC1091

set -Eeu

# Directory
MainDir="$(cd "$(dirname "${0}")/../" || exit 1 ; pwd)"
SrcDir="$MainDir/src"
LibDir="$MainDir/lib"
StaticDir="${MainDir}/static"

# Temp
TmpDir="$(mktemp -d -t "fasbashlib.XXXXX")"
TmpOutFile="${TmpDir}/fasbashlib-1.sh" # ビルドされたソースコードはここに書いてください OutFileへの書き込みは行わないでください
TmpFile_FuncList="${TmpDir}/fasbashlib-list.sh" # スネークケース置き換え用の関数一覧: <prefix> = <func>の形式で記述されます

# Build Configs
OutFile="${MainDir}/fasbashlib.sh"
NoRequire=false
SnakeCase=false

# Debug
Debug=false
DontRunAtMarkReplacement=false
GenerateFuncList=false

# Environment
Version=""
RequireShell="Any"

# Global Array
LoadedFiles=()
TargetLib=()
RequireLib=()

_ToSnakeCase(){
    sed -E 's/(.)([A-Z])/\1_\2/g' | tr '[:upper:]' '[:lower:]'
}

SedI(){
    local SedArgs=()

    # BSDかGNUか
    if sed -h 2>&1 | grep -q "GNU"; then
        SedArgs=("-i" "${SedArgs[@]}")
    else
        SedArgs=("-i" "" "${SedArgs[@]}")
    fi

    sed "${SedArgs[@]}" "$@"
}

_Make_Version(){
    # Set version
    if [[ -e "$MainDir/.git" ]]; then
        echo "Found git. Use git tag and id as version." >&2
        Version="$(git describe --long --tags | sed 's/\([^-]*-g\)/r\1/;s/-/./g')"
    else
        Version="0.2.x-dev"
    fi
}

_Make_Prepare(){
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
}

_Make_Require(){
    # Solve require
    if [[ "$NoRequire" = false ]]; then
        for Lib in "${@}"; do
            "${Debug}" && echo "Solving require of $Lib" >&2
            readarray -O "${#RequireLib[@]}" -t RequireLib < <("$LibDir/SolveRequire.sh" "$Lib" | grep -xv "$Lib")
        done
        unset Lib
    fi
}

_Make_TargetLib(){
    # 読み込むライブラリの一覧
    # 配列にはライブラリのディレクトリへのフルパスが代入されています
    readarray -t TargetLib < <(
        LoadLibDir=()
        if (( "${#}" > 0 )); then
            readarray -t LoadLibDir < <(printf "${SrcDir}/%s\n" "${RequireLib[@]}" "${@}")
        else
            readarray -t LoadLibDir < <(find "$SrcDir" -mindepth 1 -maxdepth 1 -type d )
        fi
        echo "Load libs: $(printf "%s\n" "${LoadLibDir[@]}" | xargs -L 1 basename | tr "\n" " ")" >&2
        printf "%s\n" "${LoadLibDir[@]}"
    )
}

_Make_Shell(){
    local ShellList=()

    # Shellに設定可能な値の一覧と優先順位
    readarray -t ShellList < <(grep -v "^#" "$StaticDir/shell.txt" | grep -v "^$")

    # 要求されるシェル
    RequireShell=$(
        local MaxIndex=0 Shell Index
        while read -r Shell; do
            Index=$(grep -x -n "$Shell" < <(printf "%s\n" "${ShellList[@]}") | cut -d ":" -f 1)
            if (( MaxIndex < Index )); then
                MaxIndex="$Index"
            fi
        done < <(
            # 読み込む
            local Lib
            for Lib in "${TargetLib[@]}"; do
                "${LibDir}/GetMeta.sh" "$(basename "$Lib")" "Shell"
            done
        )
        printf "%s\n" "${ShellList[@]}" | head -n "$MaxIndex" | tail -n 1
        unset Shell Index MaxIndex
    )
}

_Make_Header(){
    # Create temp file with header
    #cat "$StaticDir/script-head.sh" > "$TmpOutFile"
    sed \
        -e "s|%VERSION%|${Version-""}|g" \
        -e "s|%REQUIRE%|${RequireShell}|g" \
        "${StaticDir}/script-head.sh" > "$TmpOutFile"

    # 作成に失敗した場合に終了
    [[ -e "$TmpOutFile" ]] || exit 1
}

_Make_Lib(){
    # ライブラリをサブシェル内で読み込んでファイルに追記
    echo -n > "$TmpFile_FuncList"
    for Dir in "${TargetLib[@]}"; do
        LibName="$(basename "$Dir")"
        LibPrefix="$("$LibDir/GetMeta.sh" "$LibName" "Prefix")"
        TmpLibFile="$TmpDir/$LibName.sh"
        Lib_RawFuncList="$TmpDir/$LibName-FuncList.sh" #置き換え前のプレフィックスなしの純粋な関数名の一覧


        # ファイルの初期化
        echo -n > "${Lib_RawFuncList}"
        echo -n > "$TmpLibFile"

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
                # このスクリプトで定義された関数を削除する
                while read -r Func; do
                    #echo "Unset $Func" >&2
                    unset "$Func"
                done < <(declare -F | cut -d " " -f 3)
                unset Func

                # ライブラリのソースコードを読み込む
                "${Debug}" && echo "Load ${Dir}/${File}" >&2
                source "${Dir}/${File}" || {
                    echo "Failed to load shell file" >&2
                    exit 1
                }

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
                    local NewFuncName=""
                    if [[ -z "$LibPrefix" ]]; then
                        # プレフィックスなし、スネークケース置き換え
                        echo " = $Func" >> "$TmpFile_FuncList"
                        NewFuncName="$(_ToSnakeCase <<< "$Func")"
                    else
                        echo "${LibPrefix} = ${Func}" >> "$TmpFile_FuncList"
                        if [[ "$SnakeCase" = true ]]; then
                            # プレフィックスあり、スネークケース置き換えあり
                            #NewFuncName="$(eval "${ToSnakeCase[@]}" <<< "$LibPrefix").$(eval "${ToSnakeCase[@]}" <<< "$Func")"
                            NewFuncName="$(tr '[:upper:]' '[:lower:]' <<< "$LibPrefix").$(_ToSnakeCase <<< "$Func")"
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
                # プレフィックスが設定されていない場合、@関数は存在しない
                # スネークケースへの置き換えは全てまとめて最後に行う
            else
                # スネークケースが有効化されている場合、プレフィックスは小文字にする
                if [[ "${SnakeCase}" = true ]]; then
                    LibPrefix=$(tr '[:upper:]' '[:lower:]' <<< "$LibPrefix")
                fi

                # Func: ソースコードに記述されたそのままの関数名
                # 例えば、SrcInfo.GetValueなら"GetValue"の部分
                while read -r Func; do
                    # ドット以降の関数名を_ToSnakeCaseに渡す
                    if [[ "$SnakeCase" = true ]]; then
                        NewFuncName="$(_ToSnakeCase <<< "$Func")"
                    else
                        NewFuncName="$Func"
                    fi
                
                    "${Debug}" && echo "置き換え2: 関数内の@${Func}を${LibPrefix}.${NewFuncName}に置き換え" >&2

                    # 1つめは行末に書かれた関数の置き換え
                    # 2つめは関数の後に数字やアルファベット以外がある場合の置き換え
                    SedI \
                        -e "s|@${Func}$|${LibPrefix}\.${NewFuncName}|g" \
                        -e "s|@${Func}\([^a-zA-Z0-9]\)|${LibPrefix}\.${NewFuncName}\1|g" \
                        "$TmpLibFile"
                done < "${Lib_RawFuncList}"
            fi
        fi

        # ライブラリごとの関数リストを削除
        rm -rf "${Lib_RawFuncList}"

        # 完成したライブラリを全体に追加
        cat "$TmpLibFile" >> "$TmpOutFile"

        unset LibPrefix FuncPrefix LibName
    done
    unset Dir File
}

_Make_All_Replace(){
    # 全ての呼び出しのスネークケース置き換え
    # TmpFile_FuncListを元に生成されたスクリプト全体を置き換えます
    if [[ "$SnakeCase" = true ]]; then
        # 関数一覧をプレフィックスを含んだ
        while read -r Line; do
            LibPrefix="$(cut -d "=" -f 1 <<< "$Line" | sed "s|^ *||g; s| *$||g")"
            Func="$(cut -d "=" -f 2 <<< "$Line" | sed "s|^ *||g; s| *$||g")"
            
            if [[ -z "$LibPrefix" ]]; then
                OldFuncName="$Func"
                NewFuncName="$(_ToSnakeCase <<< "$Func")"
            else
                OldFuncName="${LibPrefix}.$Func"
                NewFuncName="$(tr '[:upper:]' '[:lower:]' <<< "$LibPrefix").$(_ToSnakeCase <<< "$Func")"
            fi

            "${Debug}" && echo "置き換え3: 全ての${OldFuncName}を${NewFuncName}に置き換え" >&2
            SedI "s|${OldFuncName}|${NewFuncName}|g" "$TmpOutFile"
        done < "$TmpFile_FuncList"
    fi
}

_Make_OutFile(){
    # Minify
    #bash "$LibDir/minifier/Minify.sh" -f="$TmpOutFile" > "$OutFile"
    cat "$TmpOutFile" > "$OutFile"
    if [[ "$GenerateFuncList" = true ]]; then
        cat "$TmpFile_FuncList" > "${OutFile%.sh}-list"
    fi
    rm -rf "$TmpDir"
    echo "$OutFile にビルドされました" >&2
}

# Parse args
NoArg=()
while [[ -n "${1-""}" ]]; do
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


_Make_Version
_Make_Prepare
_Make_Require "$@"
_Make_TargetLib "$@"
_Make_Shell
_Make_Header
_Make_Lib
_Make_All_Replace
_Make_OutFile
