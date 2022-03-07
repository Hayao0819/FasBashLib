#!/usr/bin/env bash
# shellcheck disable=SC1090,SC1091

set -Eeu

MainDir="$(cd "$(dirname "${0}")/../" || exit 1 ; pwd)"
LibDir="$MainDir/lib"
SrcDir="$MainDir/src"
BinDir="$MainDir/bin"
TestsDir="$MainDir/tests"

LibToRunTest=("${@}")
if (( "${#LibToRunTest[@]}" < 1 )); then
    readarray -t LibToRunTest < <("$BinDir/GetLibList.sh" -q)
fi

# Build fasbashlib
"$BinDir/SingleFile.sh" -out "${TMPDIR-"/tmp"}/fasbashlib.sh" "${LibToRunTest[@]}"

for Lib in "${LibToRunTest[@]}"; do
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
                source "${TMPDIR-"/tmp"}/fasbashlib.sh"
                readarray -t ExpectedResult < "$TestsDir/$Lib/$FuncToTest/Result.txt"
                readarray -t ActualResult < <(source "$TestsDir/$Lib/$FuncToTest/Run.sh" )
                if [[ -z "${ExpectedResult[*]}" ]] || [[ -z "${ActualResult[*]}" ]]; then
                    echo "EMPTY"
                elif [[ "${ExpectedResult[*]}" = "${ActualResult[*]}" ]]; then
                    echo "OK"
                else
                    echo "FAILED"
                fi
            )
    done < <(find "$TestsDir/$Lib/" -mindepth 1 -maxdepth 1 -type d -print0 | xargs -0 -L 1 basename )
done
