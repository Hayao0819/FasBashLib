#!/usr/bin/env bash
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
Delimiter="."
NoRequire=false
SnakeCase=false

# Debug
Debug=false
DontRunAtMarkReplacement=false
GenerateFuncList=false

# Environment
Version=""
RequireShell="Any"
GNUSed=false

# Global Array
LoadedFiles=()
TargetLib=()
RequireLib=()


#-- BSD or GNU --#
if sed -h 2>&1 | grep -q "GNU"; then
    GNUSed=true
else
    GNUSed=false
fi


#-- FasBashLib --#
GetFuncList(){
    declare -F | cut -d " " -f 3
}

UnsetAllFunc(){
    #ForEach eval "unset \"{}\"" < <(GetFuncList)
    local Func
    while read -r Func; do
        unset "$Func"
    done < <(GetFuncList)
}

PrintArray(){
    (( $# >= 1 )) || return 0
    printf "%s\n" "${@}"
}

ForEach(){
    local _Item
    while read -r _Item; do
        "${@//"{}"/"${_Item}"}" || return "${?}"
    done
}

SedI(){
    local SedArgs=()

    # BSDかGNUか
    if "${GNUSed}"; then
        SedArgs=("-i" "${SedArgs[@]}")
    else
        SedArgs=("-i" "" "${SedArgs[@]}")
    fi

    sed "${SedArgs[@]}" "$@"
}

# ToLower <文字列>
ToLower(){
    local _Str="${1,,}"
    [[ -z "${_Str-""}" ]] || echo "${_Str}"
}

ToSnakeCase(){
    sed -E 's/(.)([A-Z])/\1_\2/g' | ForEach ToLower "{}"
}

# Set version
_Make_Version(){
    # 引数で既にバージョンが設定済みの場合
    if [[ -n "${Version-""}" ]]; then
        [[ "${SnakeCase}" = true ]] || return 0 # スネークケースでない場合何もしないでこの関数を終了
        Version="${Version%-snake}-snake" # バージョンの末尾に-snakeをつける
        return 0
    fi

    # Versionが未設定の場合
    if [[ -e "$MainDir/.git" ]]; then
        echo "Found git. Use git tag and id as version." >&2
        Version="$(git describe --long --tags | sed 's/\([^-]*-g\)/r\1/;s/-/./g')"
    else
        Version="0.2.x-dev"
    fi

    if [[ "${SnakeCase}" = true ]]; then
        Version="${Version%-snake}-snake" # バージョンの末尾に-snakeをつける
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
        echo "BASH_VERSION=$BASH_VERSION"
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
            # shellcheck disable=SC2016
            PrintArray "${TargetLib[@]}" | ForEach eval '${LibDir}/GetMeta.sh $(basename "{}") Shell'
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

# _GetFuncListFromFile <File>
_GetFuncListFromFile(){
    local _File="$1"
    (
        # すべての関数をリセット
        UnsetAllFunc

        # ファイルをsource
        source "${Dir}/${File}" || {
            echo "Failed to load shell file" >&2
            exit 1
        }

        # 関数のリストを出力
        declare -F | cut -d " " -f 3
    )
}

# _GetFuncCodeFromFile _ 
_GetFuncCodeFromFile(){
    local _File="$1" _Func="$2"
    (
        # すべての関数をリセット
        UnsetAllFunc

        # ファイルをsource
        source "${Dir}/${File}" || {
            echo "Failed to load shell file" >&2
            exit 1
        }

        # 関数を出力
        typeset -f "$_Func"
    )
}

# _CheckLoadedFile <Path>
# $? = 0: 読み込まれていません
# $? = 1: 既に読み込まれています
_CheckLoadedFile(){
    local _File="$1"
    printf "%s\n" "${LoadedFiles[@]}" | grep -qx "${_File}" && {
        "$Debug" && echo "Already loaded $_File" >&2
        return 1
    }

    echo "Load file: ${_File}" >&2
    LoadedFiles+=("${_File}")
    return 0
}

_Make_Lib(){
    local LibName LibPrefix TmpLibFile NewFuncName # 文字列変数
    local _DefinedFuncInFile _DefinedFuncInLib # 配列
    local Func File Dir # ループ変数

    # ライブラリをサブシェル内で読み込んでファイルに追記
    echo -n > "$TmpFile_FuncList"
    for Dir in "${TargetLib[@]}"; do
        _DefinedFuncInLib=()
        LibName="$(basename "$Dir")"
        LibPrefix="$("$LibDir/GetMeta.sh" "$LibName" "Prefix")"
        TmpLibFile="$TmpDir/$LibName.sh"

        # ファイルの初期化
        echo -n > "$TmpLibFile"

        # ライブラリのファイルごとに関数を読み取ってTmpLibFileに関数を書き込み
        # この際に関数定義部分のプレフィックスとスネークケース置き換えを行う
        while read -r File; do
            _CheckLoadedFile "${Dir}/${File}" || continue

            # _DefinedFuncInFile と _DefinedFuncInLib はライブラリごとの関数の一覧
            # プレフィックスは除外されており、元のソースコードの関数名がそのまま記述されます。
            # それに対してTmpFile_FuncListはプレフィックス置き換えまで済ませた全てのライブラリの関数をグローバルに列挙します。
            # TmpFile_FuncListは最終処理で他ライブラリの関数呼び出しをスネークケースに置き換えるのに使用されます。
            readarray -t _DefinedFuncInFile < <(_GetFuncListFromFile "${Dir}/${File}")
            _DefinedFuncInLib+=("${_DefinedFuncInFile[@]}")

            # 関数の置き換えを一切行わない場合
            if [[ -z "${LibPrefix}" ]] && [[ "$SnakeCase" = false ]]; then
                for Func in "${_DefinedFuncInFile[@]}"; do
                    echo " = $Func" >> "$TmpFile_FuncList"
                    "$Debug" && echo "${Func}を追加" >&2
                    _GetFuncCodeFromFile "${Dir}/${File}" "$Func" >> "$TmpLibFile"
                done
            else
                # 関数の定義部分を書き換え
                for Func in "${_DefinedFuncInFile[@]}"; do
                    # 置き換えあり
                    local NewFuncName=""
                    if [[ -z "$LibPrefix" ]]; then
                        # プレフィックスなし、スネークケース置き換え
                        echo " = $Func" >> "$TmpFile_FuncList"
                        NewFuncName="$(ToSnakeCase <<< "$Func")"
                    else
                        echo "${LibPrefix} = ${Func}" >> "$TmpFile_FuncList"
                        if [[ "$SnakeCase" = true ]]; then
                            # プレフィックスあり、スネークケース置き換えあり
                            NewFuncName="$(ToLower "$LibPrefix")${Delimiter}$(ToSnakeCase <<< "$Func")"
                        else
                            # プレフィックスあり、スネークケースなし
                            NewFuncName="${LibPrefix}${Delimiter}${Func}"
                        fi
                    fi
                    "${Debug}" && echo "置き換え1: 関数定義の${Func}を${NewFuncName}に置き換え" >&2
                    _GetFuncCodeFromFile "${Dir}/${File}" "$Func" | sed "1 s|${Func} ()|${NewFuncName} ()|g" >> "$TmpLibFile"
                done
            fi
        done < <("$LibDir/GetMeta.sh" "${LibName}" "Files" | tr "," "\n")

        if [[ "${DontRunAtMarkReplacement}" = false ]]; then
            # 同じライブラリ内での関数呼び出し(@関数)を置き換え
            # 置き換えは全てTmpLibFileのみで完結します
            # 置き換える関数の一覧は _DefinedFuncInLib から取得
            "$Debug" && echo "${LibName}の@呼び出しを置き換え" >&2
            if [[ -z "${LibPrefix-""}" ]]; then
                "${Debug}" && echo "プレフィックスが設定されていないため、${LibName}の置き換えをスキップ" >&2
                # プレフィックスが設定されていない場合、@関数は存在しない
                # スネークケースへの置き換えは全てまとめて最後に行う
            else
                # スネークケースが有効化されている場合、プレフィックスは小文字にする
                if [[ "${SnakeCase}" = true ]]; then
                    LibPrefix=$(ToLower "${LibPrefix}")
                fi

                # Func: ソースコードに記述されたそのままの関数名
                # 例えば、SrcInfo.GetValueなら"GetValue"の部分
                for Func in "${_DefinedFuncInLib[@]}"; do
                    # ドット以降の関数名をToSnakeCaseに渡す
                    if [[ "$SnakeCase" = true ]]; then
                        NewFuncName="$(ToSnakeCase <<< "$Func")"
                    else
                        NewFuncName="$Func"
                    fi
                
                    "${Debug}" && echo "置き換え2: 関数内の@${Func}を${LibPrefix}${Delimiter}${NewFuncName}に置き換え" >&2

                    # 1つめは行末に書かれた関数の置き換え
                    # 2つめは関数の後に数字やアルファベット以外がある場合の置き換え
                    SedI \
                        -e "s|@${Func}$|${LibPrefix}${Delimiter}${NewFuncName}|g" \
                        -e "s|@${Func}\([^a-zA-Z0-9]\)|${LibPrefix}${Delimiter}${NewFuncName}\1|g" \
                        "$TmpLibFile"
                done
            fi
        fi

        # 完成したライブラリを全体に追加
        cat "$TmpLibFile" >> "$TmpOutFile"
    done
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
                NewFuncName="$(ToSnakeCase <<< "$Func")"
            else
                OldFuncName="${LibPrefix}.${Func}"
                NewFuncName="$(ToLower "$LibPrefix")${Delimiter}$(ToSnakeCase <<< "$Func")"
            fi

            "${Debug}" && echo "置き換え3: 全ての${OldFuncName}を${NewFuncName}に置き換え" >&2
            SedI "s|${OldFuncName}|${NewFuncName}|g" "$TmpOutFile"
        done < "$TmpFile_FuncList"
    elif [[ "$Delimiter" != "." ]]; then
        # 区切り文字の置き換え
        while read -r Line; do
            LibPrefix="$(cut -d "=" -f 1 <<< "$Line" | sed "s|^ *||g; s| *$||g")"
            Func="$(cut -d "=" -f 2 <<< "$Line" | sed "s|^ *||g; s| *$||g")"
            
            [[ -z "$LibPrefix" ]] && continue
            
            OldFuncName="${LibPrefix}.${Func}"
            NewFuncName="${LibPrefix}${Delimiter}${Func}"

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
        "-verbose")
            set -xv
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
