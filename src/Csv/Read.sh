#!/usr/bin/env bash
# @file Csv
# @brief Csvファイルを解析します
# @description
#    Csvファイルを解析してシェルスクリプト内で扱えるようにします
#    `CSVDELIM 変数でCSVの区切りを制御できます`

GetCsvColumnCnt(){
    local _RawCsvLine=()
    local _Line _ClmCnt=0
    readarray -t _RawCsvLine

    while read -r _Line;do
        grep -qE "^#" <<< "$_Line" && continue
        _CurrentClmCnt=$(tr "${CSVDELIM=","}" "\n" | wc -l)
        (( _CurrentClmCnt > _ClmCnt )) && _ClmCnt="$_CurrentClmCnt"
    done < <(PrintArray "${_RawCsvLine[@]}")
    RemoveBlank <<< "$_ClmCnt"
    return 0
}

# CsvToBashArray Array1 Array2 ...
# ArrayPrefix="{}"
CsvToBashArray(){
    # 変数、並列を定義
    local _RawCsvLine=() _Line _ClmCnt=0
    local ArrayPrefix="${ArrayPrefix-"{}"}"
    readarray -t _RawCsvLine < <(
        # 標準入力からCSVのみを抽出
        while read -r _Line; do
            # shellcheck disable=SC2031
            (( $(tr "${CSVDELIM-","}" "\n" <<< "$_Line" | wc -l) >= ${#} )) && echo "$_Line"
        done < <(grep -v "^#")
    )

    # カラム数を取得
    _ClmCnt=$(PrintArray "${_RawCsvLine[@]}" | GetCsvColumnCnt)
    #echo $#

    # Prefixに従って配列を生成
    while read -r _Cnt; do
        #shellcheck disable=SC2001
        readarray -t "$(sed "s|{}|$(eval "echo \"\${${_Cnt}}\"")|g" <<< "$ArrayPrefix")" < <(
            # shellcheck disable=SC2031
            PrintArray "${_RawCsvLine[@]}" | cut -d "${CSVDELIM-","}" -f "$_Cnt"
        )
    done < <(seq 1 "$#")
}

# getCsvClm <num>
GetCsvClm(){
    # shellcheck disable=SC2031
    grep -v "^#" | sed "/^$/d" | cut -d "${CSVDELIM-","}" -f "$1"
}
