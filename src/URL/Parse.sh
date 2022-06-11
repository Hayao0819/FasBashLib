#!/usr/bin/env bash

# Parse <URL>
Parse(){
    local i="${1-""}"
    if [[ -z "${i}" ]]; then
        read -r i
    fi

    @Scheme <<< "$i"
    echo ":"
    if @HasAuthority "$i"; then
        if @HasUser "$i"; then
            @User <<< "$i"
            echo "@"
        fi
        @Host <<< "$i"
        if @HasPort "$i"; then
            echo ":"
            @Port <<< "$i"
        fi
    fi
    @Path <<< "$i"
    if @HasFragment "$i"; then
        echo "#"
        @Fragment <<< "$i"
    fi
    if @HasQuery "$i";then
        echo "?"
        @Query <<< "$i"
    fi
}
