#!/usr/bin/env bash

# ParseQuery <<< QueryString
ParseQuery(){
    local i="${1-""}"
    if [[ -z "${i}" ]]; then
        read -r i
    fi

    #if [[ "$i" = [a-zA-Z]"://"* ]]; then
    if grep -q "[a-zA-Z]://" <<< "$i"; then
        i="$(@Query <<< "$i")"
    fi
    # shellcheck disable=SC2001
    i="$(sed "s|^\?||g" <<< "$i")"

    tr "&" "\n" <<< "$i" | cut -d "#" -f 1

}

# URL.ParseQuery | URL.GetQuery <Name>
GetQuery(){
    grep "^ *$1=" | cut -d "=" -f 2-
}
