#!/usr/bin/env bash
# Do not use FasBashLib in this file
# shellcheck disable=SC1090,SC1091,SC2154

set -Eeu

# shellcheck source=/dev/null
source "$(cd "$(dirname "${0}")/../" || exit 1 ; pwd)/lib/Common.sh"

# Init


Quiet=false
LibList=()

# functions
GetMeta(){
    "$LibDir/GetMeta.sh" "$@"
}

# Parse args
while [[ -n "${1-""}" ]]; do
    [[ "$1" == "-"* ]] || break
    case "${1}" in
        "-q")
            Quiet=true
            shift 1
            ;;
        "--")
            shift 1
            break
            ;;
        *)
            echo "Usage: $(basename "$0") [-q]"
            [[ "${1}" = "-h" ]] && exit 0
            exit 1
            ;;
    esac
done
LibList=("$@")
shift "$#"

if (("${#LibList[@]}" < 1 )); then
    readarray -t LibList < <(find "${SrcDir}" -mindepth 1 -maxdepth 1 -type d  -print0 | xargs -0 -L 1 basename | sort)
fi

for Lib in "${LibList[@]}"; do
    echo "$Lib"
    [[ "$Quiet" = false ]] || continue
    for C in "Description" "Depends" "Require" "Shell" "Conflicts" "Files"; do
        echo "    $C: $(GetMeta "$Lib" "$C")"
    done
done
