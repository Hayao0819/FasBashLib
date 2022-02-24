#!/usr/bin/env bash

GetPacmanDbSectionList(){
    grep -E "^%.*%$"
}

GetPacmanDbNextSection(){
    GetPacmanDbSectionList | grep -x -A 1 "^%$1%$" | GetLine 2 | sed "s|^%||g; s|%$||g"
}

GetPacmanDbSection(){
    readarray -t _Stdin
    PrintEvalArray _Stdin | sed -ne "/^%$1%$/,/^%$(PrintEvalArray _Stdin | GetPacmanDbNextSection "$1")%$/p" | sed "1d; \$d" | RemoveBlank
}
