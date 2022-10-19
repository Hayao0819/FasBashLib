#!/usr/bin/env bash

Rotation(){
    local Chr AnimeID="${1-""}"
    [[ -z "${AnimeID}" ]] && return 1
    [[ -n "${2-""}" ]] &&  echo -n "${2}" >&2
    echo "${$}-${AnimeID}=$BASHPID" >> "$TMPDIR/$FSBLIB_PROG_PIDFILEPATH"
    while true; do
        for Chr in "-" "\\" "|" "/"; do
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


