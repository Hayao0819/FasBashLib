#!/usr/bin/env bash

XML(){
    sh <(
cat << 'SCRIPTEOF' | grep -v '^ *#'
%SCRIPT_PARSRX%
SCRIPTEOF
    )
}
