#!/usr/bin/env bash

Rotation(){
    local Chr AnimeID="${1-""}"
    [[ -z "${AnimeID}" ]] && return 1
    [[ -n "${2-""}" ]] &&  echo -n "${2}" >&2
    echo "${$}-${AnimeID}=$BASHPID" >> "$TMPDIR/$FSBLIB_PROG_PIDFILEPATH"
    while true; do
        for Chr in "-" "\\" "|" "/"; do
            # 改行を有効化する場合
            #printf "%s\n" "$Chr" >&2
            #sleep 0.1
            #Esc.MoveCursorUp 1
            #Esc.MoveCursorRight "$((${#2}))"
    
            printf "%s" "$Chr" >&2
            sleep 0.1
            Esc.MoveCursorLeft 1
        done
    done
}

Kill(){
    local AnimeID="${1-""}"
    [[ -z "${AnimeID}" ]] && return 1
    local TargetPID
    TargetPID="$(grep -o "$$-${AnimeID}=[0-9]*" "$TMPDIR/${FSBLIB_PROG_PIDFILEPATH}" | cut -d "=" -f 2)"
    [[ -n "${TargetPID}" ]] && kill -9 "${TargetPID}"
}


Bar(){
    local Max="$1" Counter="$2"
    local SharpCount=$((Counter * 100 / Max))
    local SpaceCount=$((100 - SharpCount))
    Esc.Return
    if (( Counter == 0 )); then
        echo -n "$Counter/$Max [$(yes " " | head -n "$Max" | tr -d "\n")]"
    else
        echo -n "$Counter/$Max [$(yes "#" | head -n "$SharpCount" | tr -d "\n")$(yes " " | head -n "$SpaceCount" | tr -d "\n")]"
    fi
}
