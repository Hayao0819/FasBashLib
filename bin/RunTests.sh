#!/usr/bin/env bash
# shellcheck disable=SC1090,SC1091

set -Eeu

MainDir="$(cd "$(dirname "${0}")/../" || exit 1 ; pwd)"
BinDir="$MainDir/bin"
LibDir="$MainDir/lib"
TestsDir="$MainDir/tests"

LibToRunTest=("${@}")
if (( "${#LibToRunTest[@]}" < 1 )); then
    readarray -t LibToRunTest < <("$BinDir/GetLibList.sh" -q)
fi

MainLibFile="${TMPDIR-"/tmp"}/fasbashlib.sh"
ResultFile="${TMPDIR-"/tmp"}/fasbashlib-result.txt"


# Build fasbashlib
echo "ライブラリをビルドしています..." >&2
"$BinDir/SingleFile.sh" -out "$MainLibFile" "${LibToRunTest[@]}"

# RunFuncTest <Lib> <Func>
# exit 0: 正常に終了。
# exit 1: 必要なファイルが見つかりません。
# exit 2: ファイルが空です。
# exit 3: 終了コードが異常です。
# exit 4: 想定された標準出力と一致しません。 
RunFuncTest(){
    local ActualResultTmp
    ActualResultTmp="$(mktemp -t "fasbashlib.result.XXXXX")"

    if [[ ! -e "$TestsDir/$Lib/$FuncToTest/Result.txt" ]] || [[ ! -e "$TestsDir/$Lib/$FuncToTest/Run.sh" ]]; then
        echo "テストに必要なファイルが見つかりませんでした" >&2
        return 1
    fi

    echo "${1}の${2}をテスト中..." >&2

    # Initilize
    echo > "${ActualResultTmp}"

    # run
    sed "s|%LIBPATH%|${MainLibFile}|g" "$MainDir/static/test-head.sh" | \
        cat "/dev/stdin" "$TestsDir/$1/$2/Run.sh" | bash -o pipefail -o errtrace > "${ActualResultTmp}" || {
            return 3
        }
    
    # Get result
    readarray -t ExpectedResult < "$TestsDir/$1/$2/Result.txt"
    readarray -t ActualResult < "${ActualResultTmp}"
    rm -rf "${ActualResultTmp}"

    # check
    if [[ -z "${ExpectedResult[*]}" ]] || [[ -z "${ActualResult[*]}" ]]; then
        return 2
    elif [[ "${ExpectedResult[*]}" = "${ActualResult[*]}" ]]; then
        return 0
    else
        return 4
    fi
}

# Initilize
echo -n > "${ResultFile}"

for Lib in "${LibToRunTest[@]}"; do
    while read -r Cmd; do
        {
            which "$Cmd" 1> /dev/null 2>&1 || {
                echo -e "$Cmd is not found in PATH. Cannot test ${Lib}" >&2
                echo "Lib: $Lib=Missing depends($Cmd)" >> "${ResultFile}"
            }
        } &
    done < <("${LibDir}/GetDepends.sh" "$Lib")
    while read -r FuncToTest; do 
        {
            ExitCode=0
            RunFuncTest "$Lib" "$FuncToTest" || ExitCode="$?"
            case "$ExitCode" in
                "0")
                    #echo "Function: $Lib.$FuncToTest=Passed" >> "${ResultFile}"
                    ;;
                "1")
                    echo "Function: $Lib.$FuncToTest=No File" >> "${ResultFile}"
                    ;;
                "2")
                    echo "Function: $Lib.$FuncToTest=Empty" >> "${ResultFile}"
                    ;;
                "3")
                    echo "Function: $Lib.$FuncToTest=FAILED" >> "${ResultFile}"
                    ;;
                "4")
                    echo "Function: $Lib.$FuncToTest=No Match With Result" >> "${ResultFile}"
                    ;;
                *)
                    echo "Function: $Lib.$FuncToTest=Unknown Error" >> "${ResultFile}"
                    ;;
            esac
        } &
    done < <(find "$TestsDir/$Lib/" -mindepth 1 -maxdepth 1 -type d -print0  2> /dev/null | xargs -0 -L 1 basename )
done

sleep 0.5
echo "テストの終了を待機中..." >&2
wait

echo "=====TEST LOG=====" >&2
cat "$ResultFile"
rm -rf "$ResultFile"
