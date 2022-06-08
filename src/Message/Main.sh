#!/usr/bin/env bash
# @file Message
# @brief A library to echo messages with simple label
# @description
#    このライブラリはechoコマンドのシンプルなラッパーです。
#
#    メッセージをラベルと共に適切な場所へ出力します。例えば、Error メッセージはstdoutへ出力されます。
#
#    FSBLIB_MSG 環境変数を設定することで出力先を変更できます

# Common <Label> <Message> <Output>
# @internal
Common(){
    local i l="$1" string="$2" out="${3-""}"
    shift 2 || return 1
    { [[ -z "${out-""}" ]] && { [[ "${l^^}" = *"ERR"* ]] || [[ "${l^^}" = *"WARN"* ]] || [[ "${l^^}" = *"DEBUG"* ]];}; } && out="stderr"
    case "${FSBLIB_MSG-"${out:-"stdout"}"}" in
        "stdout")
            for i in $(seq "$(echo -e "${string}" | wc -l)"); do
                echo -n "$l "
                echo -e "${string}" | head -n "${i}" | tail -n 1 
            done
            ;;
        "stderr")
            for i in $(seq "$(echo -e "${string}" | wc -l)"); do
                echo -n "$l " >&2
                echo -e "${string}" | head -n "${i}" | tail -n 1 >&2
            done
            ;;
    esac
}

# @description Output error to stderr
#
# @example MsgErr "File does not exist!\nPlease check the path."
#
# @arg $* string A value to print
#
# @exitcode 0 This script return only 0
Err(){
    @Common "Error:" "${*}" stderr
}

# @description Output info to stdout
#
# @example Msg.Info "Found file.\nCopy it to the dir."
#
# @arg $* string A value to print
#
# @exitcode 0 This script return only 0
Info(){
    @Common " Info:" "${*}" stdout
}

# @description Output warning to stderr
#
# @example Msg.Warn "File does not exist!\nSkip it."
#
# @arg $* string A value to print
#
# @exitcode 0 This script return only 0
Warn(){
    @Common " Warn:" "${*}" stderr
}

# @description Output debug message to stderr
#
# @example MsgDebug "Current user is ${USER}\nHome is $HOME"
#
# @arg $* string A value to print
#
# @exitcode 0 This script return only 0
Debug(){
    @Common "Debug:" "${*}" stderr
}

