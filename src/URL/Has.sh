#!/usr/bin/env bash

# HasAuthority <URL>
HasAuthority(){
    [[ "$(@NoScheme <<< "$1")" = "//"* ]]
}

#HasUser <URL>
HasUser(){
    [[ "$(@Authority <<< "$1")" = *"@"* ]]
}

#HasPort <URL>
HasPort(){
    [[ "$(@Authority <<< "$1")" = *":"* ]]
}

#HasQuery <URL>
HasQuery(){
    [[ "$(@PathAndQueryAndFragment <<< "$1")" = *"?"* ]]
}

HasFragment(){
    [[ "$(@PathAndQueryAndFragment <<< "$1")" = *"#"* ]]
}

