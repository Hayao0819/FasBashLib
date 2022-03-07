#!/usr/bin/env bash
# shellcheck disable=SC1090,SC1091

set -Eeu

MainDir="$(cd "$(dirname "${0}")/../" || exit 1 ; pwd)"
LibDir="$MainDir/lib"
SrcDir="$MainDir/src"
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
"$BinDir/SingleFile.sh" -out "${TMPDIR-"/tmp"}/fasbashlib.sh" "${Lib}" 1> /dev/null 2>&1

if [[ ! -e "$TestsDir/$Lib/$FuncToTest/Run.sh" ]]; then
    echo "テストに必要なファイルが見つかりませんでした" >&2
    exit 1
fi

(
    source "${TMPDIR-"/tmp"}/fasbashlib.sh" 1> /dev/null 2>&1
    source "$TestsDir/$Lib/$FuncToTest/Run.sh"
) > "$OutputFile"

echo "${OutputFile} を作成しました"
