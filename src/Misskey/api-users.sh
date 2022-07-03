#!/usr/bin/env bash

Users.Notes(){
    @BindingBase "users/notes" userId -- "${1:-"$(@MyId)"}" "${@:2}"
}

Users.SearchByUsernameAndHost(){
    @BindingBase "users/search-by-username-and-host" username -- "${1:-"$(@MyUserName)"}" "${@:2}"
}
