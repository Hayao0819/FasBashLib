#!/usr/bin/env bash


# Iniの値を書き換えます
# FSBLIB_INI_REPLACEALL変数で複数設定されている場合にすべてを変更するかどうかを指定できます。
# デフォルトでは最初の設定した値を使用します。
# Ini.Set SECTION PARAM VALUE
SetValue(){
    local IniContents=()
    local Section="$1" Param="$2" #Value="$3"
    readarray -t IniContents

    # セクションとパラメータを作成
    readarray -t IniContents < <(PrintArray "${IniContents[@]}" | @NewSection "$Section" | @NewParam "$Section" "$Param")
    PrintEvalArray IniContents


}

NewSection(){
    local IniContents=()
    local Section="$1"
    readarray -t IniContents

    if PrintArray "${IniContents[@]}" | @GetSectionList | grep -x "$Section" > /dev/null; then
        PrintEvalArray IniContents
        return 0
    fi

    if [[ -z "$(Array.Last IniContents )" ]]; then
        Array.Pop IniContents
    fi
    IniContents+=("" "[$Section]")
    PrintEvalArray IniContents

    return 0
}

NewParam(){
    local IniContents=() Line
    local Section="$1" Param="$2"
    local InSection=false LineNo=0
    local NewIniContents=() # 出力される新しいIni
    readarray -t IniContents
    local BeforeParam #前回処理されたパラメータ 
    local SectionLastParam # 指定されたセクションの現在の最後のパラメータ
    local ParamAdded=false # すでにパラメータを追加したかどうか

    # Check if the param exists
    if ! PrintArray "${IniContents[@]}" | @GetParamList "$Section" | grep -qx "$Param"; then
        # 最後のパラメータを取得
        SectionLastParam="$(PrintEvalArray IniContents | @GetLastParam "$Section" )"

        for Line in "${IniContents[@]}"; do
            # 行の情報を更新
            LineNo=$(( LineNo + 1  ))

            # 行を解析
            @ParseLine <<< "$Line"
            case "$FSBLIB_INI_PARSED_TYPE" in
                "SECTION")
                    if [[ "$FSBLIB_INI_PARSED_SECTION" = "$Section" ]]; then
                        InSection=true
                    else
                        InSection=false
                    fi
                    ;;
                "PARAM-VALUE")
                    if [[ "$InSection" = true ]]; then
                        BeforeParam="$FSBLIB_INI_PARSED_PARAM"
                    fi
                    ;;
                "ERROR")
                    echo "Line $LineNo: Failed to parse Ini" >&2
                    return 1
                    ;;
            esac
            NewIniContents+=("$Line")

            # 現在指定されたセクション内にいるかつ前回のループがセクションの最後だった場合
            if { ! Bool "$ParamAdded"; }  && Bool "$InSection" && [[ "$SectionLastParam" = "${BeforeParam-""}" ]]; then
                NewIniContents+=("$Param=")
                ParamAdded=true
            fi
        done
    fi
    PrintEvalArray NewIniContents
    return 0
}
