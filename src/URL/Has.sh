#!/usr/bin/env bash

# HasAuthority <URL>
HasAuthority(){
    local i="${1-""}"
    [[ -n "$i" ]] || read -r i
    [[ "$(@NoScheme <<< "$i")" = "//"* ]]
}

#HasUser <URL>
HasUser(){
    local i="${1-""}"
    [[ -n "$i" ]] || read -r i
    [[ "$(@Authority <<< "$i")" = *"@"* ]]
}

#HasPort <URL>
HasPort(){
    local i="${1-""}"
    [[ -n "$i" ]] || read -r i
    [[ "$(@Authority <<< "$i")" = *":"* ]]
}

#HasQuery <URL>
HasQuery(){
    local i="${1-""}"
    [[ -n "$i" ]] || read -r i
    [[ "$(@PathAndQueryAndFragment <<< "$i")" = *"?"* ]]
}

HasFragment(){
    local i="${1-""}"
    [[ -n "$i" ]] || read -r i
    [[ "$(@PathAndQueryAndFragment <<< "$i")" = *"#"* ]]
}
