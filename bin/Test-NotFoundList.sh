#!/usr/bin/env bash
# shellcheck disable=SC1090,SC1091,SC2154

# shellcheck source=/dev/null
source "$(cd "$(dirname "${0}")/../" || exit 1 ; pwd)/lib/Common.sh"

LibList=()
FuncList=()

ShowOnlyLib=false

# Parse args
while [[ -n "${1-""}" ]]; do
    [[ "$1" == "-"* ]] || break
    case "${1}" in
        "-lib")
            ShowOnlyLib=true
            shift 1
            ;;
        "--")
            shift 1
            break
            ;;
        *)
            echo "Usage: $(basename "$0") -- [-lib] [Lib]"
            [[ "$1" = "-h" ]] && exit 0
            exit 1
            ;;
    esac
done

LibList+=("${1-""}")
if [[ -z "${1-""}" ]]; then
    readarray -t LibList < <("$BinDir/List.sh" -q)
fi

# IsThisFuncATestTarget <Lib> <Func>
# 対象なら正常終了
IsThisFuncATestTarget(){
    local l="$1" f="$2"
    if "${LibDir}/GetMeta.sh" "$l" "DoFunc" "Test" | grep -qx "$f"; then
        # 関数がDoFuncの一部
        return 0
    elif [[ "$("${LibDir}/GetMeta.sh" "$l" "SkipAll" "Test" )" = true ]]; then
        return 1
    elif "${LibDir}/GetMeta.sh" "$l" "DoFunc" "SkipTest" | grep -qx "$f"; then
        return 1
    else
        return 0
    fi
}   

for Lib in "${LibList[@]}"; do
    while read -r Func; do
        FuncTestDir="$TestsDir/$Lib/${Func}/"

        # テスト対象かどうかを確認
        IsThisFuncATestTarget "$Lib" "$Func" || continue
        { [[ -e "$FuncTestDir" ]] && [[ -n "$(ls "${FuncTestDir}")" ]]; }|| {
            echo "$Lib/$Func"
        }
    done < <(
        if (( "${#FuncList[@]}" > 0 )); then
            printf "%s\n" "${FuncList[@]}"
        else
            "$LibDir/GetFuncList.sh" -noprefix "$Lib"
        fi
    )
done |  if [[ "${ShowOnlyLib}" = true ]]; then
            cut -d "/" -f 1 | sort | uniq
        else
            cat
        fi

