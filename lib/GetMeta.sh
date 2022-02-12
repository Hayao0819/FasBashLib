#!/usr/bin/env bash
MainDir="$(cd "$(dirname "${0}")/../" || exit 1 ; pwd)"
SrcDir="$MainDir/src"
if (( $# < 2 )); then
    echo "Usage: $(basename "$0") DirName Param"
    exit 1
fi

MetaFile="$SrcDir/$1/Meta.ini"

[[ -f "$MetaFile" ]] || {
    echo "$MetaFile does not exist" >&2
    exit 1
}

{
    InSection=false Output=()
    while read -r Line; do
        Line=$(sed "s|^ *||g; s| *$||g" <<< "$Line")
        case "$Line" in
            "[FsbLib]")
                InSection=true
                ;;
            "["*"]")
                InSection=false
                ;;
            "")
                continue
                ;;
            *"="*)
                [[ "$InSection" = true ]] || continue
                if [[ "$Line" = "${2}"* ]]; then
                    Output+=("$(cut -d "=" -f 2 <<< "${Line}" | sed "s|^ *||g; s| *$||g; s|^\"||g; s|\"$||g" )")
                fi
                ;;
        esac
    done < <(cat "$MetaFile")
    [[ -n "${Output[*]}" ]] || exit 0
    printf "%s\n" "${Output[@]}"
}
