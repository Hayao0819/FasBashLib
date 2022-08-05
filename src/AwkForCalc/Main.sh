#!/bin/sh


Print(){
    awk "BEGIN {print $*}"
}

Float(){
    awk "BEGIN {printf (\"%4.${AWKSCALE-"5"}f\n\", $*)}"
}

# log10(100)=2
# Log 10 100
Log(){
    @Float "log(${2}) / log($1)"
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
