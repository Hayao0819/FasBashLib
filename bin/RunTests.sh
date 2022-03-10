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
ActualResultTmp="$(mktemp -t "fasbashlib.XXXXX")"

# Build fasbashlib
echo "ライブラリをビルドしています..." >&2
"$BinDir/SingleFile.sh" -out "$MainLibFile" "${LibToRunTest[@]}" 1> /dev/null 2>&1



for Lib in "${LibToRunTest[@]}"; do

    while read -r Cmd; do
        which "$Cmd" 1> /dev/null 2>&1 || {
            echo -e "$Cmd is not found in PATH. Cannot test ${Lib}" >&2
            exit 1
        }
    done < <("${LibDir}/GetMeta.sh" "$Lib" "Depends" | tr "," "\n")


    while read -r FuncToTest; do 
        echo -n "${Lib}の${FuncToTest}をテスト中..." >&2

        if [[ ! -e "$TestsDir/$Lib/$FuncToTest/Result.txt" ]] || [[ ! -e "$TestsDir/$Lib/$FuncToTest/Run.sh" ]]; then
            echo "テストに必要なファイルが見つかりませんでした" >&2
            continue
        fi

        case "$(cat)" in
            "EMPTY")
                echo
                continue
                ;;
            "OK")
                echo "成功"
                ;;
            "FAILED")
                echo "失敗"
                ;;
            esac < <(
                # Initilize
                echo > "${ActualResultTmp}"

                # run
                sed "s|%LIBPATH%|${MainLibFile}|g" "$MainDir/static/test-head.sh" | \
                    cat "/dev/stdin" "$TestsDir/$Lib/$FuncToTest/Run.sh" | bash -o pipefail -o errtrace > "${ActualResultTmp}" || {
                        echo "FAILED"
                        exit 1
                    }
                
                # Get result
                readarray -t ExpectedResult < "$TestsDir/$Lib/$FuncToTest/Result.txt"
                readarray -t ActualResult < "${ActualResultTmp}"

                # check
                if [[ -z "${ExpectedResult[*]}" ]] || [[ -z "${ActualResult[*]}" ]]; then
                    echo "EMPTY"
                elif [[ "${ExpectedResult[*]}" = "${ActualResult[*]}" ]]; then
                    echo "OK"
                else
                    echo "FAILED"
                fi
            )
    done < <(find "$TestsDir/$Lib/" -mindepth 1 -maxdepth 1 -type d -print0  2> /dev/null | xargs -0 -L 1 basename )
done
