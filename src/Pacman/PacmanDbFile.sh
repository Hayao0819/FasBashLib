#!/usr/bin/env bash

GetPacmanDbSectionList(){
    grep -E "^%.*%$"
}

GetPacmanDbNextSection(){
    GetPacmanDbSectionList | grep -x -A 1 "^%$1%$" | GetLine 2 | sed "s|^%||g; s|%$||g"
}

GetPacmanDbSection(){
    readarray -t _Stdin
    PrintEvalArray _Stdin | sed -ne "/^%$1%$/,/^%$(PrintEvalArray _Stdin | GetPacmanDbNextSection "$1")%$/p" | sed "1d; \$d" # | RemoveBlank
}


# なし
# 6.55s user 3.90s system 179% cpu 5.816 total
# あり
# 7.15s user 4.22s system 195% cpu 5.821 total
