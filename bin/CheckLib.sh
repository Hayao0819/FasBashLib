#!/usr/bin/env bash

set -Eeu

MainDir="$(cd "$(dirname "${0}")/../" || exit 1 ; pwd)"
SrcDir="$MainDir/src"
LibDir="$MainDir/lib"
ShellList=("ModernBash" "Any" "LegacySh")
Errors=0

while read -r Dir; do
    echo "$(basename "$Dir"): Checking ..."

    # ディレクトリ名とMetaのNameを確認
    if [[ "$(basename "$Dir")" != "$("$LibDir/GetMeta.sh" "$(basename "$Dir")" "Name")" ]]; then
        echo "$(basename "$Dir"): ディレクトリ名とMeta.iniが一致していません" >&2
        Errors=$(( Errors + 1 ))
    fi

    # ShellCheckを実行
    while read -r File; do
        if [[ "$(file --mime-type "$File" | cut -d " " -f 2)" = "text/x-shellscript" ]]; then
            echo "Run shell check $File"
            shellcheck -s bash -x "$File" || Errors=$(( Errors + 1 ))
        fi
    done < <(find "$Dir" -type f)

    # 依存関係をテスト
    "$LibDir/SolveRequire.sh" "$(basename "$Dir")" 1> /dev/null 2>&1 || Errors=$(( Errors + 1 ))

    # シェルを確認
    if ! printf "%s\n" "${ShellList[@]}" | grep -qx "$("$LibDir/GetMeta.sh" "$(basename "$Dir")" "Shell")"; then
        echo "$(basename "$Dir"): 不正なシェルが設定されています" >&2
        Errors=$(( Errors + 1 ))
    fi

    # ファイルの存在を確認
    while read -r File; do
        if ! [[ -e "$Dir/$File" ]]; then
            echo "$(basename "$Dir"): $File が存在しません"
            Errors=$(( Errors + 1 ))
        fi
    done < <("$LibDir/GetMeta.sh" "$(basename "$Dir")" "Files")

done < <(find "${SrcDir}" -type d -mindepth 1 -maxdepth 1 )

if (( Errors == 0 )); then
    exit 0
else
    echo "$Errors つのエラーが見つかりました"
    exit 1
fi
