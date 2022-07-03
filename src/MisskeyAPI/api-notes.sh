#!/usr/bin/env bash

# Misskey.Notes.Search <Query> <Limit>
Notes.Search(){
    @BindingBase "notes/search" query limit -- "$@"
}

Notes.Renotes(){
    @BindingBase "notes/renotes" noteId limit sinceId untilId -- "$@"
}

Notes.Create(){
    @BindingBase "notes/create" text -- "$@"
}


