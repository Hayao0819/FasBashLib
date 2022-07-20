#!/usr/bin/env bash

Xml(){
    sh <(
cat << 'SCRIPTEOF' | grep -v '^ *#'
%SCRIPT_PARSRX%
SCRIPTEOF
    )
}

XmlToJson(){
    sh <(
cat << 'SCRIPTEOF' | grep -v '^ *#'
%SCRIPT_CONVX2J%
SCRIPTEOF
    )
}
