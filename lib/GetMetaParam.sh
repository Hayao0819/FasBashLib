#!/usr/bin/env bash
MainDir="$(cd "$(dirname "${0}")/../" || exit 1 ; pwd)"
SrcDir="$MainDir/src"
SectionName="FsbLib"

# shellcheck source=/dev/null
source "$MainDir/lib/Common.sh"

if (( $# < 1 )); then
    echo "Usage: $(basename "$0") DirName [Section]"
    exit 1
fi

if ((  $# >= 2)); then
    SectionName="$2"
fi

MetaFile="$SrcDir/$1/Meta.ini"

[[ -f "$MetaFile" ]] || {
    echo "$MetaFile does not exist" >&2
    exit 1
}

readarray -t SectionList < <(
    grep -E '^ *\[.*\] *$' "$MetaFile" | sed -e 's|^ *\[||g; s|\] *$||g'
)

NextSection="$(printf "%s\n" "${SectionList[@]}" | grep -x "${SectionName}" -A 1 | tail -n 1)"

sed -ne "/^ *\[${SectionName}\] *$/,/^ *\[${NextSection}\] *$/p" "$MetaFile" | \
    sed "1d; s|^ *\[${NextSection}\] *$||g" | grep -v "^ *#" | grep -E -- "^ *[^=]*=.+" | \
    while read -r line; do
        value="$(cut -d "=" -f 2- <<< "$line")"
        if [[ -n "$(RemoveBlank <<< "$value" | sed "s|^\"||g; s|\"||g")"  ]]; then
            echo "$line"
        fi
    done | cut -d "=" -f 1
