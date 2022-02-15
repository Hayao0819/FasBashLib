#!/usr/bin/env bash

set -Eeu

MainDir="$(cd "$(dirname "${0}")/../" || exit 1 ; pwd)"
SrcDir="$MainDir/src"
LibDir="$MainDir/lib"
ShellList=("ModernBash" "Any" "LegacySh")


while read -r Dir; do
    echo "$(basename "$Dir"): Checking ..."

    # ディレクトリ名とMetaのNameを確認
    if [[ "$(basename "$Dir")" != "$("$LibDir/GetMeta.sh" "$(basename "$Dir")" "Name")" ]]; then
        echo "$(basename "$Dir"): ディレクトリ名とMeta.iniが一致していません" >&2
        exit 1
    fi

    # ShellCheckを実行
    while read -r File; do
        if [[ "$(file --mime-type "$File" | cut -d " " -f 2)" = "text/x-shellscript" ]]; then
            shellcheck -s bash -x "$File"
        fi
    done < <(find "$Dir" -type f)

    # 依存関係をテスト
    "$LibDir/SolveRequire.sh" "$(basename "$Dir")" 1> /dev/null 2>&1

    # シェルを確認
    printf "%s\n" "${ShellList[@]}" | grep -qx "$("$LibDir/GetMeta.sh" "$(basename "$Dir")" "Shell")" || {
        echo "$(basename "$Dir"): 不正なシェルが設定されています"
    }

done < <(find "${SrcDir}" -type d -mindepth 1 -maxdepth 1 )
