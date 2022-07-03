#!/usr/bin/env bash

MyId(){
    @I | jq -r ".id"
}

MyName(){
    @I | jq -r ".name"
}

MyUserName(){
    @I | jq -r ".username"
}

IsAdmin(){
    Bool "$(@I | jq -r ".isAdmin")"
}


