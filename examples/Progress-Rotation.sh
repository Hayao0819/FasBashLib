#!/usr/bin/env bash

# shellcheck source=/dev/null
current_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")/../" && pwd)
source <("$current_dir/tools.sh" build single Progress -out /dev/stdout 2> /dev/null)

count=0
while true; do
    Prog.Rotation "$count" "Hello! FasBashLib Progress.Rotation  "
    sleep 0.05
    ((count++))
    if ((count > 50)); then
        Esc.ClearLineAndReturn
        break
    fi
done
exit 0
