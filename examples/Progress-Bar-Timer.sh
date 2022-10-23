#!/usr/bin/env bash
# shellcheck source=/dev/null
current_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")/../" && pwd)
source <("$current_dir/tools.sh" build single Progress -out /dev/stdout 2> /dev/null)


# 30 sec timer

echo "Timer start!!"

time {
    count=0
    sec=30
    while true; do
        Prog.WideBar "$sec" "$count" # Change this line to Prog.Bar to see the difference
        ((count++))
        if ((count > sec)); then
            echo
            break
        fi
        sleep 1
        
    done
}
