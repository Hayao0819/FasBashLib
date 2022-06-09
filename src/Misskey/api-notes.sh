#!/usr/bin/env bash

# Misskey.Notes.Search <Query> <Limit>
Misskey.Notes.Search(){
    BindingBase "notes/search" query limit -- "$@"
}

Misskey.Notes.Renotes(){
    BindingBase "notes/renotes" noteId limit sinceId untilId -- "$@"
}

Misskey.Notes.Create(){
    BindingBase "notes/create" text -- "$@"
}


