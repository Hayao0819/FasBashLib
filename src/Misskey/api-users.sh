#!/usr/bin/env bash

Users.Notes(){
    @BindingBase "users/notes" userId -- "$@"
}

Users.SearchByUsernameAndHost(){
    @BindingBase "users/search-by-username-and-host" username host limit detail -- "${1}" "${2-"$MISSKEY_DOMAIN"}" "${@:3}"
}
