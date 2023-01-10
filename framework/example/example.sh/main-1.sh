#!/usr/bin/env bash

readme(){
    local readme=()
    readarray -t readme <<EOF
%README_TXT%
EOF
    for line in "${readme[@]}"; do
        [[ -z "$line" ]] && continue
        libre_translate_translate_auto "$line" "ja"
    done
}

hoge(){
    cat <<EOF
%TARGETJSON%
EOF
}
