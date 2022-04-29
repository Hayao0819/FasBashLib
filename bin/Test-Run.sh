#!/usr/bin/env bash
# shellcheck disable=SC1090,SC1091,SC2154

# shellcheck source=/dev/null
source "$(cd "$(dirname "${0}")/../" || exit 1 ; pwd)/lib/Common.sh"

LibToRunTest=("${@}")
if (( "${#LibToRunTest[@]}" < 1 )); then
    readarray -t LibToRunTest < <("$BinDir/List.sh" -q)
fi

MainLibFile="${TMPDIR-"/tmp"}/fasbashlib.sh"
ResultFile="${TMPDIR-"/tmp"}/fasbashlib-result.txt"
ExitCode=0


# Build fasbashlib
echo "ライブラリをビルドしています..." >&2
"$BinDir/Build-Single.sh" -out "$MainLibFile" "${LibToRunTest[@]}" 2> /dev/null || {
    echo "Failed to build library!" >&2
    exit 1
}

# RunFuncTest <Lib> <Func> <Name>
# exit 0: 正常に終了。
# exit 1: 必要なファイルが見つかりません。
# exit 2: ファイルが空です。
# exit 3: 終了コードが異常です。
# exit 4: 想定された標準出力と一致しません。 
#
# Set: ExitTestStatus テストスクリプトの終了コード
RunFuncTest(){
    local ActualResultTmp
    ExitTestStatus=0
    ActualResultTmp="$(mktemp -t "fasbashlib.result.XXXXX")"

    local _TargetDir="$TestsDir/${1}/${2}${3+"/${3}/"}"

    local _F
    # $TestsDir/$1/$2
    for _F in "Result.txt" "Run.sh" "Exit.txt"; do
        [[ -e "${_TargetDir}/$_F" ]] || {
            [[ -z "${3-""}" ]] || echo "${1}/${2}: テストに必要なファイルが見つかりませんでした" >&2
            return 1
        }
    done

    if [[ -n "${3-""}" ]]; then
        echo "${1}/${2}の${3}をテスト中..." >&2
    else
        echo "${1}の${2}をテスト中..." >&2
    fi

    # Initilize
    echo > "${ActualResultTmp}"

    # run
    sed "s|%LIBPATH%|${MainLibFile}|g" "$MainDir/static/test-head.sh" | \
        cat "/dev/stdin" "$_TargetDir/Run.sh" | bash -o pipefail -o errtrace > "${ActualResultTmp}" || ExitTestStatus="$?"

    # Get result
    ExpectedExitStatus="$(grep -v "^$" "$_TargetDir/Exit.txt")"
    readarray -t ExpectedResult < "$_TargetDir/Result.txt"
    readarray -t ActualResult < "${ActualResultTmp}"
    rm -rf "${ActualResultTmp}"

    # Check Exit status
    if [[ "$ExitTestStatus" != "${ExpectedExitStatus}" ]]; then
        return 3
    fi

    # check
    #if [[ -z "${ExpectedResult[*]}" ]] || [[ -z "${ActualResult[*]}" ]]; then
    #    return 2
    #elif [[ "${ExpectedResult[*]}" = "${ActualResult[*]}" ]]; then
    if [[ "${ExpectedResult[*]}" = "${ActualResult[*]}" ]]; then
        return 0
    else
        return 4
    fi
}

RunTestAndWriteResult(){
    local ExitCode=0 Args=("$Lib" "$FuncToTest")
    [[ -z "${TestName-""}" ]] || Args+=("${TestName}")
    RunFuncTest "${Args[@]}" || ExitCode="$?"
    case "$ExitCode" in
        "0")
            #echo "0| Function: $Lib.$FuncToTest=Passed"
            ;;
        "1")
            #echo "1| Function: $Lib.$FuncToTest=No File"
            ;;
        "2")
            echo "2| Function: $Lib.$FuncToTest=Empty"
            ;;
        "3")
            echo "3| Function: $Lib.$FuncToTest=Missing exit code (Expect: ${ExpectedExitStatus} Result: ${ExitTestStatus})"
            ;;
        "4")
            echo "4| Function: $Lib.$FuncToTest=No Match With Result"
            ;;
        *)
            echo "*| Function: $Lib.$FuncToTest=Unknown Error"
            ;;
    esac
}

# Initilize
echo -n > "${ResultFile}"

for Lib in "${LibToRunTest[@]}"; do
    while read -r Cmd; do
        {
            type -P "$Cmd" 1> /dev/null 2>&1 || {
                echo -e "$Cmd is not found in PATH. Cannot test ${Lib}" >&2
                echo "5| Lib: $Lib=Missing depends($Cmd)" >> "${ResultFile}"
            }
        } &
    done < <("${LibDir}/GetDepends.sh" "$Lib")
    while read -r FuncToTest; do
        RunTestAndWriteResult >> "${ResultFile}"
        while read -r TestName; do
            RunTestAndWriteResult >> "${ResultFile}"
        done < <(find "${TestsDir}/${Lib}/${FuncToTest}/" -mindepth 1 -maxdepth 1 -type d 2> /dev/null | GetBaseName )
    done < <(find "$TestsDir/$Lib/" -mindepth 1 -maxdepth 1 -type d  2> /dev/null  | GetBaseName )
done

# Print log
sleep 0.5
echo "テストの終了を待機中..." >&2
wait
echo "=====TEST LOG=====" >&2
cat "$ResultFile"

# Set exit code
# shellcheck disable=SC2143
[[ -n "$(cut -d "|" -f 1 < "$ResultFile" | grep -v "^5")" ]] && ExitCode="1"

# Clean up
rm -rf "$ResultFile"
exit "$ExitCode"
