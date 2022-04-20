#!/usr/bin/env bash
# shellcheck disable=SC1090,SC1091

set -Eeu
set -o pipefail
set -o errtrace

MainDir="$(cd "$(dirname "${0}")/../" || exit 1 ; pwd)"
BinDir="$MainDir/bin"
TestsDir="$MainDir/tests"
BashDebug=()

# Parse args
while [[ -n "${1-""}" ]]; do
    [[ "$1" == "-"* ]] || break
    case "${1}" in
        "-r")
            echo "Result.txtに書き込まず結果を標準出力します" >&2
            OutputFile="/dev/stdout"
            shift 1
            ;;
        "-debug")
            BashDebug+=("-x")
            shift 1
            ;;
        "-verbose")
            BashDebug+=("-v")
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

Lib="$1" FuncToTest="$2" TestName="$3"
: "${OutputFile="$TestsDir/$Lib/$FuncToTest/$TestName/Result.txt"}"
: "${ExitFile="$TestsDir/$Lib/$FuncToTest/$TestName/Exit.txt"}"
ExitCode=0

# Build fasbashlib
MainLibFile="${TMPDIR-"/tmp"}/fasbashlib.sh"
"$BinDir/SingleFile.sh" -out "$MainLibFile" "${Lib}" 1> /dev/null 2>&1

if [[ ! -e "$TestsDir/$Lib/$FuncToTest/$TestName/Run.sh" ]]; then
    echo "テストに必要なファイルが見つかりませんでした" >&2
    exit 1
fi

sed "s|%LIBPATH%|${MainLibFile}|g" "$MainDir/static/test-head.sh" | \
    cat "/dev/stdin" "$TestsDir/$Lib/$FuncToTest/$TestName/Run.sh" | bash "${BashDebug[@]}" -o pipefail -o errtrace > "${OutputFile}" || ExitCode="$?"

if ! [[ "${OutputFile}" = "/dev/stdout" ]]; then
    echo "$ExitCode" > "$ExitFile"
    echo "${ExitFile} を作成しました"
fi

if ! [[ "${OutputFile}" = "/dev/stdout" ]]; then
    echo "${OutputFile} を作成しました"
fi
