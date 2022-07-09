#!/usr/bin/env bash
# shellcheck disable=SC2154

# shellcheck source=/dev/null
source "$(cd "$(dirname "${0}")/../" || exit 1 ; pwd)/lib/Common.sh"

ShellList=("ModernBash" "Any" "LegacySh")
Errors=0

while read -r Dir; do
    Name="$(basename "$Dir")"

    echo "${Name}: Checking ..."

    # ディレクトリ名とMetaのNameを確認
    if [[ "${Name}" != "$("$LibDir/GetMeta.sh" "${Name}" "Name")" ]]; then
        echo "${Name}: ディレクトリ名とMeta.iniが一致していません" >&2
        Errors=$(( Errors + 1 ))
    fi

    # ShellCheckを実行
    while read -r File; do
        if [[ "$(file --mime-type "$File" | cut -d " " -f 2)" = "text/x-shellscript" ]]; then
            echo "Run shell check $File" >&2
            shellcheck -s bash -x "$File" || Errors=$(( Errors + 1 ))
        fi
    done < <(find "$Dir" -type f)

    # 依存関係をテスト
    "$LibDir/SolveRequire.sh" "${Name}" 1> /dev/null || Errors=$(( Errors + 1 ))

    # シェルを確認
    if ! printf "%s\n" "${ShellList[@]}" | grep -qx "$("$LibDir/GetMeta.sh" "${Name}" "Shell")"; then
        echo "${Name}: 不正なシェルが設定されています" >&2
        echo "${Name}: 利用可能なシェル: ${ShellList[*]}"
        Errors=$(( Errors + 1 ))
    fi

    # ファイルの存在を確認
    readarray -t _FileList < <("$LibDir/GetMeta.sh" "${Name}" "Files" | tr "," "\n" | sed "s|^ *||g; s| *$||g; s|^	*||g; s|	*$||g; /^$/d" | sed "s|^|${Dir}/|g")
    for File in "${_FileList[@]}"; do
        if ! [[ -e "$File" ]]; then
            echo "${Name}: $File が存在しません"
            Errors=$(( Errors + 1 ))
        fi
    done

    # Filesに設定されていないファイル
    while read -r File; do
        readarray -t _FileList < <(PrintArray "${_FileList[@]}" | ForEach realpath "{}")
        if ! printf "%s\n" "${_FileList[@]}"| grep -qx "$(realpath "$File")"; then
            echo "${Name}: $File はライブラリとして認識されていません"
            Errors=$(( Errors + 1 ))
        fi
    done < <(find "$Dir" -name "*.sh" -mindepth 1)

    # テストを実行
    #"${BinDir}/Test-Run.sh" "$Name"

    unset File _FileList Name
done < <(
    if (( "${#}" > 0 )); then
        printf "${SrcDir}/%s\n" "$@"
    else
        find "${SrcDir}" -mindepth 1 -maxdepth 1 -type d 
    fi )

if (( Errors == 0 )); then
    exit 0
else
    echo "$Errors つのエラーが見つかりました"
    exit 1
fi
