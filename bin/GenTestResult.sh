#!/usr/bin/env bash
# shellcheck disable=SC1090,SC1091

set -Eeu
set -o pipefail
set -o errtrace

MainDir="$(cd "$(dirname "${0}")/../" || exit 1 ; pwd)"
BinDir="$MainDir/bin"
TestsDir="$MainDir/tests"

# Parse args
while [[ -n "${1-""}" ]]; do
    [[ "$1" == "-"* ]] || break
    case "${1}" in
        "-r")
            echo "Result.txtに書き込まず結果を標準出力します" >&2
            OutputFile="/dev/stdout"
            shift 1
            ;;
        "--")
            shift 1
            break
            ;;
        *)
            echo "Usage: $(basename "$0") [-r]"
            [[ "${1}" = "-h" ]] && exit 0
            exit 1
            ;;
    esac
done

Lib="$1" FuncToTest="$2"
: "${OutputFile="$TestsDir/$Lib/$FuncToTest/Result.txt"}"


# Build fasbashlib
MainLibFile="${TMPDIR-"/tmp"}/fasbashlib.sh"
"$BinDir/SingleFile.sh" -out "$MainLibFile" "${Lib}" 1> /dev/null 2>&1

if [[ ! -e "$TestsDir/$Lib/$FuncToTest/Run.sh" ]]; then
    echo "テストに必要なファイルが見つかりませんでした" >&2
    exit 1
fi


sed "s|%LIBPATH%|${MainLibFile}|g" "$MainDir/static/test-head.sh" | \
    cat "/dev/stdin" "$TestsDir/$Lib/$FuncToTest/Run.sh" | bash -x -v -o pipefail -o errtrace > "${OutputFile}" || { 
    echo "異常終了しました (コード: $?)"
    exit 1
}

echo "${OutputFile} を作成しました"
