#!/usr/bin/env bash


AwkPrint(){
    awk "BEGIN {print $*}"
}

# log10(100)=2
# Log 10 100
Log(){
    local _Base="$1" _Number="$2"
    @Calc "log(${_Number}) / log($_Base)"
}

Pi(){
    @Calc "atan2(0, -0)"
}

# 180:pi = 45:x
# 180x=45pi
# x=
Rad(){
    @Calc "$1 * $(@Pi) / 180 "
}

Cos(){
    @Calc "cos($*)"
}

Sin(){
    @Calc "sin($*)"
}

Tan(){
    @Calc "sin($1)/tan($1)"
}
