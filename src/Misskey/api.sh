#!/usr/bin/env bash


# Setup <Domain> <TOKEN>
Setup(){
    export MISSKEY_DOMAIN="${MISSKEY_DOMAIN-"${1}"}"
    export MISSKEY_TOKEN="${MISSKEY_TOKEN-"${2}"}"
    export MISSKEY_ENTRY="https://${MISSKEY_DOMAIN}/api"
}
