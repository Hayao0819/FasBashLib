#!/usr/bin/env bash
# shellcheck disable=SC1090,SC1091,SC2154

# shellcheck source=/dev/null
source "$(cd "$(dirname "${0}")/../" || exit 1 ; pwd)/lib/Common.sh"

# Temp
TmpDir="$(mktemp -d -t "fasbashlib.XXXXX")"
TmpOutFile="${TmpDir}/fasbashlib-1.sh" # ビルドされたソースコードはここに書いてください OutFileへの書き込みは行わないでください
TmpFile_FuncList="${TmpDir}/fasbashlib-list.sh" # スネークケース置き換え用の関数一覧: <prefix> = <func>の形式で記述されます

# Build Configs
OutFile="${MainDir}/fasbashlib.sh"
Delimiter="."
NoRequire=false
OneLine=false # うまく動かないよ
NoIgnore=false # すべてのIgnore設定を無視

CodeType="Upper"
#CodeType="Lower"
#CodeType="Snake"

# Debug
Debug=false
DontRunAtMarkReplacement=false
GenerateFuncList=false

# Environment
Version=""
RequireShell="Any"

# Global Array
TargetLib=() # 最終的なビルド対象のライブラリ
LoadedFiles=() # ロード済みのファイル

IgnoreLib=() # 引数なしの際に無視する
RequireLib=() # 引数ありの際に依存関係になっているライブラリ
ForceLoadLib=() # 引数なしの際に強制ロードするライブラリ

# Set default
DefaultCodeType="Upper"
: "${CodeType="$DefaultCodeType"}"

#-- Funcions --#
ToSnakeCase(){
    sed -E 's/(.)([A-Z])/\1_\2/g' | ForEach ToLower "{}" | sed "s|^_||g; s|\._|.|g"

    # ToLower実行した後のsedは、「Misskey.Notes.Create」を変換した際に「misskey.notes._create」となってしまうバグを防ぐための回避策です
    # 最初のsedで一気に処理させる方法がわからんかったのでこれで暫定対処
    # sedの複数回呼び出しで速度に影響が出てるのでいずれ改善したいところではある
}

ToLowerCase(){
    #awk '{ print toupper(substr($0, 1, 1)) substr($0, 2, length($0) - 1) }'
    local s 
    while read -r s; do
        echo "${s,}"
    done

}

# MakeFuncName <Prefix> <Name>
MakeFuncName(){
    local _P _N
    if (( "$#" >= 2 )); then
        _P="$1" _N="$2"
    else
        _N="$1"
    fi

    if [[ -z "${_P-""}" ]]; then
        # プレフィックスなし
        case "${CodeType}" in
            "Upper")
                echo "${_N}"
                ;;
            "Snake")
                ToSnakeCase <<< "$_N"
                ;;
            "Lower")
                ToLowerCase <<< "$_N"
                ;;
        esac
    else
        case "${CodeType}" in
            "Upper")
                echo "${_P}${Delimiter}${_N}"
                ;;
            "Snake")
                echo "$(ToLower "${_P}")${Delimiter}$(ToSnakeCase <<< "$_N")"
                ;;
            "Lower")
                echo "${_P}${Delimiter}$(ToLowerCase <<< "$_N")"
                ;;
        esac
    fi
    return 0
}


_Check_Dependency(){
    which shfmt >/dev/null 2>&1 || {
        echo "shfmt is not installed." >&2
        exit 1
    }
}

# Set version
_Make_Version(){
    # 初期化
    Version="${Version%-snake}"

    # 引数で既にバージョンが設定済みの場合
    if [[ -n "${Version-""}" ]]; then
        return 0
    fi

    # Versionが未設定の場合
    if [[ -e "$MainDir/.git" ]]; then
        echo "Found git. Use git tag and id as version." >&2
        Version="$(git -C "$MainDir" describe --long --tags | sed 's/\([^-]*-g\)/r\1/;s/-/./g')"
    else
        Version="0.2.x-dev"
    fi

    return 0
}

_Make_CodeType(){
    case "${CodeType}" in
        "Snake")
            Version="${Version}-snake" # バージョンの末尾に-snakeをつける
            ;;
        "Upper")
            Version="${Version}-upper" # バージョンの末尾に-snakeをつける
            ;;
        "Lower")
            Version="$Version-lower"
            ;;
        *)
            ;;
    esac
    return 0
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

# ライブラリが引数によって明示的に指定された場合に依存関係を解決します
# 引数が指定されていない場合は無視します
_Make_Require(){
    # 依存関係を解決する読み込むライブラリの一覧
    local _LibToLoad=() Lib
    for Lib in "$@"; do
        #if ! PrintArray "${IgnoreLib[@]}" | grep -qx "$(basename "$Lib")"; then
            _LibToLoad+=("${Lib}")
        #fi
    done

    # Solve require
    if [[ "$NoRequire" = false ]]; then
        for Lib in "${_LibToLoad[@]}"; do
            "${Debug}" && echo "Solving require of $Lib" >&2
            readarray -O "${#RequireLib[@]}" -t RequireLib < <("$LibDir/SolveRequire.sh" "$Lib" | grep -xv "$Lib")
        done
        unset Lib
    fi
}

_Make_TargetLib(){
    declare -a -g TargetLib=()
    local _LibLoaded=false

    # 引数が指定されている場合
    if [[ "$_LibLoaded" = false ]] && (( "$#" > 0 )); then
        readarray -t TargetLib < <(printf "${SrcDir}/%s\n" "${RequireLib[@]}" "${@}")
        _LibLoaded=true
    fi

    # 引数が指定されていない + 完全にすべてをビルドする場合
    if [[ "$_LibLoaded" = false ]] && [[ "$NoIgnore" = true ]]; then
        readarray -t TargetLib < <("${BinDir}/List.sh" -q | ForEach printf "${SrcDir}/{}\n")
        _LibLoaded=true
    fi

    # 引数が指定されていない + 一部を除外する場合
    if [[ "$_LibLoaded" = false ]]; then
        local _isSkipped
        _isSkipped(){
            if PrintArray "${ForceLoadLib[@]}" | grep -qx "$1"; then
                return 1
            elif { ! PrintArray "${IgnoreLib[@]}" | grep -qx "$1"; } && [[ ! "$(GetMeta "$1" ExcludeFromAll)" == "true" ]]; then
                return 1
            fi
            return 0
        }

        while read -r Lib; do
            if ! _isSkipped "$Lib"; then
                TargetLib+=("$SrcDir/$Lib")
            else
                echo "Skip $Lib" >&2
            fi
        done < <("$BinDir/List.sh" -q)
    fi

    readarray -t TargetLib < <(printf "%s\n" "${TargetLib[@]}" | sort )
    echo "Load libs: $(printf "%s\n" "${TargetLib[@]}" | xargs -L 1 basename | tr "\n" " ")" >&2

    return 0
}

# _Make_TargetLibを書き直す前のやつ
# 動作はこっちに準拠する
_Make_TargetLib_old(){
    # 読み込むライブラリの一覧
    # TargetLib配列にはライブラリのディレクトリへのフルパスが代入されています
    readarray -t TargetLib < <(
        local LoadLibDir=()
        if (( "${#}" > 0 )); then
            # 引数が指定されている場合
            readarray -t LoadLibDir < <(printf "${SrcDir}/%s\n" "${RequireLib[@]}" "${@}")
        else
            local Lib _FullLibList=()
            readarray -t _FullLibList < <(find "$SrcDir" -mindepth 1 -maxdepth 1 -type d )
            # IgnoreListのものを除外
            for Lib in "${_FullLibList[@]}"; do
                if [[ "${NoIgnore}" = true ]] || { ! PrintArray "${IgnoreLib[@]}" | grep -qx "$(basename "$Lib")" && ! [[ "$(GetMeta "$(basename "$Lib")" ExcludeFromAll | RemoveBlank | tr "[:upper:]" "[:lower:]" )" = "true" ]]; }; then # IgnoreLibに含まれていないことを確認
                    LoadLibDir+=("$Lib")
                elif PrintArray "${ForceLoadLib[@]}" | grep -qx "$(basename "$Lib")"; then
                    LoadLibDir+=("$Lib")
                else
                    echo "Skip $Lib" >&2
                fi

            done
        fi
        readarray -t LoadLibDir < <(printf "%s\n" "${LoadLibDir[@]}" | sort)
        echo "Load libs: $(printf "%s\n" "${LoadLibDir[@]}" | xargs -L 1 basename | tr "\n" " ")" >&2
        printf "%s\n" "${LoadLibDir[@]}"
        unset LoadLibDir
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
    local __Make_FUNCLIST
    __Make_FUNCLIST(){
        #sed "s| = |.|g" "$TmpFile_FuncList" | sed "s|^\.||g" | sed -e "s|^|\"|g" -e "s|$|\"|g" | tr "\n" " "; echo

        local _Prefix _Name
        echo "Making function list..." >&2
        # shellcheck disable=SC2016
        ForEach eval 'IFS=" = " read -r _Prefix _Name <<< "{}"; MakeFuncName "$_Prefix" "$_Name"' < "$TmpFile_FuncList" | sed -e "s|^|\"|g" -e "s|$|\"|g" | tr "\n" " "
    }

    #sed \
    #    -e "s|%LIBLIST%|$(PrintArray "${TargetLib[@]}" | GetBaseName | sed 's|^|"|g; s|$|"|g' | tr "\n" " ")|g" \
    #    -e "s|%FUNCLIST%||g" \
    #    "${StaticDir}/script-head.sh" > "$TmpDir/Internal/Header.sh"

    sed \
        -e "s|%LIBLIST%|$(PrintArray "${TargetLib[@]}" | GetBaseName | sed 's|^|"|g; s|$|"|g' | tr "\n" " ")|g" \
        -e "s|%FUNCLIST%|$(__Make_FUNCLIST)|g" \
        "${StaticDir}/script-head.sh" > "$TmpDir/Internal/Header.sh"

    # ヘッダーをファイルに書き込む
    #cat "$TmpDir/Internal/Header.sh" > "$TmpOutFile"

    # 作成に失敗した場合に終了
    [[ -e "$TmpDir/Internal/Header.sh" ]] || exit 1
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
        source "${_File}" || {
            echo "Failed to load shell file" >&2
            exit 1
        }

        # 関数を出力
        typeset -f "$_Func"
    )
}

_MakeOneLineFunc(){
    sed "$ s|^}$|;}|g" | grep -v "^ *\#" | RemoveBlank | sed "s|^| |g; s|$| |g" | sed "s|^ *}|;}|g" | tr -d "\n"| RemoveBlank | sed -E "s| +| |g"
    #sed ":a s/[\]$//; N; s/[\]$//; s/\n/ /; t a ;"
    echo
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
    local _DefinedFuncInFile _DefinedFuncInLib _NoPrefixFunc # 配列
    local Func File Dir # ループ変数
    local ReplacePrefix=true

    # ライブラリをサブシェル内で読み込んでファイルに追記
    echo -n > "$TmpFile_FuncList"
    for Dir in "${TargetLib[@]}"; do
        _DefinedFuncInLib=()
        LibName="$(basename "$Dir")"
        LibPrefix="$("$LibDir/GetMeta.sh" "$LibName" "Prefix")"
        TmpLibFile="$TmpDir/LibFiles/$LibName.sh"
        ReplacePrefix=true

        # ファイルの初期化
        mkdir -p "$(dirname "$TmpLibFile")"
        mkdir -p "$TmpDir/Internal"
        echo -n > "$TmpLibFile"

        #Prefix置換えを行うかどうか
        if [[ -z "${LibPrefix-""}" ]]; then
            ReplacePrefix=false
        fi

        readarray -t _NoPrefixFunc < <(GetMeta -c "$LibName" "NoPrefixFunc")

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

            for Func in "${_DefinedFuncInFile[@]}"; do
                ReplacePrefix=true
                if PrintArray "${_NoPrefixFunc[@]}" | grep -qx "$Func"; then
                    ReplacePrefix=false
                fi

                if [[ "${ReplacePrefix}" = false ]] && [[ "$CodeType" = "$DefaultCodeType" ]]; then
                    # 関数の置き換えを一切行わない場合
                    echo " = $Func" >> "$TmpFile_FuncList"
                    "$Debug" && echo "${Func}を${TmpLibFile}に書き込み" >&2
                    if "${OneLine-"false"}"; then
                        _GetFuncCodeFromFile "${Dir}/${File}" "$Func" | _MakeOneLineFunc >> "$TmpLibFile"
                    else
                        _GetFuncCodeFromFile "${Dir}/${File}" "$Func" >> "$TmpLibFile"
                    fi
                    continue
                else
                    # 関数の定義部分を書き換え
                    local NewFuncName=""
                    echo "${LibPrefix-""} = ${Func}" >> "$TmpFile_FuncList"
                    NewFuncName="$(MakeFuncName "${LibPrefix-""}" "$Func")"
                    "${Debug}" && echo "置き換え1: 関数定義の${Func}を${NewFuncName}に置き換えて${TmpLibFile}に書き込み" >&2

                    # 関数を1行にまとめられないかなって...
                    if "${OneLine-"false"}"; then
                        _GetFuncCodeFromFile "${Dir}/${File}" "$Func" | sed "1 s|${Func} ()|${NewFuncName} ()|g" | \
                            grep -v "^ *\#" | _MakeOneLineFunc >> "$TmpLibFile"
                        echo >> "$TmpLibFile"
                    else
                        _GetFuncCodeFromFile "${Dir}/${File}" "$Func" | sed "1 s|${Func} ()|${NewFuncName} ()|g" | grep -v "^ *\#" >> "$TmpLibFile"
                    fi
                fi
            done
        #done < <("$LibDir/GetMeta.sh" "${LibName}" "Files" | tr "," "\n")
        done < <("$LibDir/GetFileList.sh" "${LibName}" | GetBaseName)

        if [[ "${DontRunAtMarkReplacement}" = false ]]; then
            local NewLibPrefix="$LibPrefix" #LibPrefixの置換え用変数

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
                #if [[ "${SnakeCase}" = true ]]; then
                if [[ "$CodeType" = "Snake" ]]; then
                    NewLibPrefix="$(ToLower "${LibPrefix}")"
                fi

                # Func: ソースコードに記述されたそのままの関数名
                # 例えば、SrcInfo.GetValueなら"GetValue"の部分
                for Func in "${_DefinedFuncInLib[@]}"; do
                    # NoPrefixに指定されている場合の処理
                    if PrintArray "${_NoPrefixFunc[@]}" | grep -qx "$Func"; then
                        "$Debug" && echo "NoPrefixに指定されているため${Func}の置き換えをスキップ" >&2
                        continue
                    fi
    
                    # ドット以降の関数名を変換
                    NewFuncName=$(MakeFuncName "" "$Func")
                    "${Debug}" && echo "置き換え2: ${TmpLibFile}内の@${Func}を${NewLibPrefix}${Delimiter}${NewFuncName}に置き換え" >&2

                    # 1つめは行末に書かれた関数の置き換え
                    # 2つめは関数の後に数字やアルファベット以外がある場合の置き換え
                    SedI \
                        -e "s|@${Func}$|${NewLibPrefix}${Delimiter}${NewFuncName}|g" \
                        -e "s|@${Func}\([^a-zA-Z0-9]\)|${NewLibPrefix}${Delimiter}${NewFuncName}\1|g" \
                        "$TmpLibFile"
                done
            fi
        fi

        # ファイル埋め込みを実行
        local EmbeddedFile=""
        while read -r Embedded; do
            EmbeddedFile="$Dir/$(GetMeta "$LibName" "$Embedded" "Embedded")"
            if [[ ! -e "$EmbeddedFile"  ]]; then
                echo -e "Failed to load ${EmbeddedFile}\nNo such file." >&2
                return 1
            fi
            echo "Load file: $EmbeddedFile" >&2
            SedI "/^%$Embedded%$/r ${EmbeddedFile}" "$TmpLibFile"
            SedI "/^%$Embedded%$/d" "$TmpLibFile"
            
        done < <(GetMetaParam "$LibName" "Embedded")
        

        # 完成したライブラリを全体に追加
        #cat "$TmpLibFile" >> "$TmpOutFile"
        cat "$TmpLibFile" >> "$TmpDir/Internal/Funcs.sh"
    done
}

_Make_All_Replace(){
    # 全ての呼び出しのスネークケース置き換え
    # TmpFile_FuncListを元に生成されたスクリプト全体を置き換えます
    if [[ ! "$CodeType" = "Upper" ]]; then
        # 関数一覧をプレフィックスを含んだ
        while read -r Line; do
            LibPrefix="$(cut -d "=" -f 1 <<< "$Line" | sed "s|^ *||g; s| *$||g")"
            Func="$(cut -d "=" -f 2 <<< "$Line" | sed "s|^ *||g; s| *$||g")"
            
            OldFuncName="$Func"
            [[ -n "$LibPrefix" ]] && OldFuncName="${LibPrefix}.${Func}"
            NewFuncName=$(MakeFuncName "${LibPrefix-""}" "$Func")

            "${Debug}" && echo "置き換え3: 全ての${OldFuncName}を${NewFuncName}に置き換え" >&2
            SedI "s|${OldFuncName}|${NewFuncName}|g" "$TmpDir/Internal/Funcs.sh"
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
            SedI "s|${OldFuncName}|${NewFuncName}|g" "$TmpDir/Internal/Funcs.sh"
        done < "$TmpFile_FuncList"
    fi
}

_Make_Const(){
    local Lib Var VarNameStart='' Prefix AddLine=() ConstList=() DuplicateTest="" Error=()

    # ハードコーディングされた定数
    ConstList+=("Core:FSBLIB_VERSION" "Core:FSBLIB_REQUIRE")
    AddLine+=(
        "declare -r FSBLIB_VERSION='${Version-""}'"
        "declare -r FSBLIB_REQUIRE='${RequireShell-""}'"
    )

    # ライブラリの定数
    while read -r Lib; do
        # ライブラリごとの設定
        Prefix="$(GetMeta "$Lib" Prefix)"
        VarNameStart="FSBLIB_"
        if [[ -n "$Prefix" ]]; then
            VarNameStart="FSBLIB_${Prefix}_"
        fi

        # 個々の定数
        while read -r Var; do
            # 変数名が適切かどうか確認
            if [[ "${Var^^}" = "${VarNameStart^^}"* ]]; then
                echo "Found Constant $Var in $Lib" >&2

                # 重複テスト
                DuplicateTest="$(PrintArray "${ConstList[@]}" | grep -Ex "[^:]*:$Var" | cut -d ":" -f 1 || true)"
                if [[ -n "${DuplicateTest}" ]] ; then
                    Error+=("Duplicate constants $Var in $Lib and $DuplicateTest")
                    continue
                fi

                # 定数を追加
                ConstList+=("${Lib}:${Var}") # 重複の確認に使う配列
                AddLine+=("declare -r ${Var}='$(GetMeta "$Lib" "$Var" "Const" | RemoveBlank | sed "s|^\"||g; s|\"$||g")'")
            else
                # 定数名エラー
                Error+=("Constant '$Var' in $Lib is missing name. Its name should be started with '$VarNameStart'")
                continue
            fi
        done < <(GetMetaParam "$Lib" Const)
    done < <(PrintArray "${TargetLib[@]}" | GetBaseName)
    
    if [[ -n "${Error[*]}" ]]; then
        # エラーはError配列に保持して最後にまとめて出力
        PrintArray "${Error[@]}"
        return 1
    else
        PrintArray "${AddLine[@]}" "" >> "$TmpDir/Internal/Consts.sh"
        return 0
    fi
}

_Make_TmpOutFile(){
    mkdir -p "$(dirname "$TmpOutFile")"
    cat "$TmpDir/Internal/Header.sh" "$TmpDir/Internal/Consts.sh" "$TmpDir/Internal/Funcs.sh" > "$TmpOutFile"
    #cat "$TmpOutFile"
    [[ -e "$TmpOutFile" ]] || exit 1
    return 0
}

_Make_OutFile(){
    # Minify
    #bash "$LibDir/minifier/Minify.sh" -f="$TmpOutFile" > "$OutFile"

    # 出力先ディレクトリの作成
    mkdir -p "$(dirname "${OutFile}")"

    # 出力
    #cat "$TmpOutFile" > "$OutFile"
    #grep -v "^$" "${TmpOutFile}" > "$OutFile"
    shfmt -ln bash -i 0 -s "$TmpOutFile" > "$OutFile"

    # 関数リストの作成
    if [[ "$GenerateFuncList" = true ]]; then
        cat "$TmpFile_FuncList" > "${OutFile%.sh}-list"
    fi

    # 一時ディレクトリの削除
    rm -rf "$TmpDir"
    echo "$OutFile にビルドされました" >&2
    return 0
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
            CodeType="Snake"
            shift 1
            ;;
        "-lower")
            CodeType="Lower"
            shift 1
            ;;
        "-ignore")
            readarray -O "${#IgnoreLib[@]}" IgnoreLib < <(tr "," "\n" <<< "$2")
            shift 2
            ;;
        "-verbose")
            set -xv
            shift 1
            ;;
        "-noignore")
            NoIgnore=true
            shift 1
            ;;
        "-forceadd")
            ForceLoadLib+=("$2")
            shift 2
            ;;
        "--")
            shift 1
            break
            ;;
        "-"*)
            echo "Usage: $(basename "$0") [-out File] [-ver Version] [-noreq] [-debug] [-noignore] [-ignore Lib1,Lib2, ...] [-snake] [-list] [Lib1] [Lib2] ..." >&2
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


_Check_Dependency
_Make_Version
_Make_CodeType
_Make_Prepare
_Make_Require "$@"
_Make_TargetLib "$@"
_Make_Shell
_Make_Lib
_Make_Const
_Make_All_Replace
_Make_Header
_Make_TmpOutFile
_Make_OutFile
