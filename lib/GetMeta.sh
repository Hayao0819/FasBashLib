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
    readarray -t SectionList < <(
        grep -E '^ *\[.*\] *$' "$MetaFile" | sed -e 's|^ *\[||g; s|\] *$||g'
    )
    
    NextToFsbLib="$(printf "%s\n" "${SectionList[@]}" | grep -x "FsbLib" -A 1 | tail -n 1)"

    sed -ne "/^ *\[FsbLib\] *$/,/^ *\[${NextToFsbLib}\] *$/p" "$MetaFile" | sed "1d; s|^ *\[${NextToFsbLib}\] *$||g" | grep -Ex -- "^ *${2} *=.*" | cut -d "=" -f 2- | sed "s|^ *||g; s| *$||g"  | sed "s|^\"||g; s|\"$||g"| grep -v "^$" || true
}
