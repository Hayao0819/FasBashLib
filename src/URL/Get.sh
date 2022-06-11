#!/usr/bin/env bash

Scheme(){ cut -d ":" -f 1; }

NoScheme(){ cut -d ":" -f 2-; }

Authority(){
    local i _NoScheme
    while read -r i; do
        _NoScheme=$(@NoScheme <<< "$i")
        [[ "$_NoScheme" == "//"* ]] || return 1

        # shellcheck disable=SC2001
        cut -d "/" -f 1 < <(sed "s|^//||g" <<< "$_NoScheme")
    done
}

Host(){
    @Authority | cut -d "@" -f 2- | cut -d ":" -f 1
}

Port(){
    local i
    while read -r i; do
        [[ "$i" == *":"* ]] || {
            echo "80"
            continue
        }
        cut -d ":" -f 2 <<< "$i"
    done < <(@Authority)
}

User(){
    local i
    while read -r i; do
        [[ "$i" == *"@"* ]] || {
            echo ""
            continue
        }
        cut -d "@" -f 1 <<< "$i"
    done < <(@Authority)
}

PathAndQueryAndFragment(){
    local i
    while read -r i; do
        # shellcheck disable=SC2001
        sed "s|^//$(@Authority <<< "$i")||g" <<< "$(@NoScheme <<< "$i")"
    done
}

Query(){
    local i
    while read -r i; do
        @PathAndQueryAndFragment <<< "$i" | sed "s|#$(@Fragment <<< "$i")||g" | cut -d "?" -f 2-
    done
    
}

Fragment(){
    @PathAndQueryAndFragment | cut -d "#" -f 2-
}

Path(){
    @PathAndQueryAndFragment | cut -d "#" -f 1 | cut -d "?" -f 1
}
