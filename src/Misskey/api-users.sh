#!/usr/bin/env bash

Users.Notes(){
    @BindingBase "users/notes" userId -- "${1:-"$(@MyId)"}" "${@:2}"
}

Users.SearchByUsernameAndHost(){
    @BindingBase "users/search-by-username-and-host" username -- "${1:-"$(@MyUserName)"}" "${@:2}"
}

Users.Show(){
    @BindingBase "users/show" userId -- "${1:-"$(@MyId)"}" "${@:2}"
}

Users.Stats(){
    @BindingBase "users/stats" userId -- "${1:-"$(@MyId)"}" "${@:2}"
}

Users.Pages(){
    @BindingBase "users/pages" userId -- "${1:-"$(@MyId)"}" "${@:2}"
}

Users.GetFrequentlyRepliedUsers(){
    @BindingBase "users/get-frequently-replied-users" userId -- "${1:-"$(@MyId)"}" "${@:2}"
}

