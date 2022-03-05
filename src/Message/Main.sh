#!/usr/bin/env bash
# @file Message
# @brief A library to echo messages with simple label
# @description
#    このライブラリはechoコマンドのシンプルなラッパーです。
#
#    メッセージをラベルと共に適切な場所へ出力します。例えば、Error メッセージはstdoutへ出力されます。

Common(){
    local i
    for i in $(seq "$(echo -e "${*}" | wc -l)"); do
        echo -e "${*}" | head -n "${i}" | tail -n 1
    done
}

# @description Output error to stderr
#
# @example MsgErr "File does not exist!\nPlease check the path."
#
# @arg $* string A value to print
#
# @exitcode 0 This script return only 0
Err(){
    @ Msg.Common "Error: ${*}" >&2
}

# @description Output info to stdout
#
# @example MsgInfo "Found file.\nCopy it to the dir."
#
# @arg $* string A value to print
#
# @exitcode 0 This script return only 0
Info(){
    @ Msg.Common " Info: ${*}" >&1
}

# @description Output warning to stderr
#
# @example MsgWarn "File does not exist!\nSkip it."
#
# @arg $* string A value to print
#
# @exitcode 0 This script return only 0
Warn(){
    @ Msg.Common " Warn: ${*}" >&2
}

# @description Output debug message to stderr
#
# @example MsgDebug "Current user is ${USER}\nHome is $HOME"
#
# @arg $* string A value to print
#
# @exitcode 0 This script return only 0
MsgDebug(){
    @ MsgCommon "Debug: ${*}" >&2
}

