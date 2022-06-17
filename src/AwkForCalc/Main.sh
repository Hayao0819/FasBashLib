#!/usr/bin/env bash


Print(){
    awk "BEGIN {print $*}"
}

Float(){
    local AWKSCALE="${AWKSCALE-"5"}"
    awk "BEGIN {printf (\"%4.${AWKSCALE}f\n\", $*)}"
}

# log10(100)=2
# Log 10 100
Log(){
    local _Base="$1" _Number="$2"
    @Float "log(${_Number}) / log($_Base)"
}

Pi(){
    @Float "atan2(0, -0)"
}

# 180:pi = 45:x
# 180x=45pi
# x=
Rad(){
    @Float "$1 * $(@Pi) / 180 "
}

Cos(){
    @Float "cos($*)"
}

Sin(){
    @Float "sin($*)"
}

Tan(){
    @Float "sin($1)/tan($1)"
}
