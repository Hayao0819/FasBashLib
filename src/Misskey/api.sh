#!/usr/bin/env bash


# Setup <Domain> <TOKEN>
Setup(){
    export MISSKEY_DOMAIN="${1-"${MISSKEY_DOMAIN-""}"}"
    export MISSKEY_TOKEN="${2-"${MISSKEY_TOKEN-""}"}"
    export MISSKEY_ENTRY="https://${MISSKEY_DOMAIN}/api"
}
