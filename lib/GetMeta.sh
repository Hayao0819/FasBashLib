#!/usr/bin/env bash
MainDir="$(cd "$(dirname "${0}")/../" || exit 1 ; pwd)"
SrcDir="$MainDir/src"
SectionName="FsbLib"
CsvMode=false

# shellcheck source=/dev/null
source "$MainDir/lib/Common.sh"

if (( $# < 2 )); then
    echo "Usage: $(basename "$0") [-c] DirName Param [Section]"
    exit 1
fi

if [[ "$1" = "-c" ]]; then
    CsvMode=true
    shift 1
fi

if ((  $# >= 3)); then
    SectionName="$3"
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
    
    NextSection="$(printf "%s\n" "${SectionList[@]}" | grep -x "${SectionName}" -A 1 | tail -n 1)"

    sed -ne "/^ *\[${SectionName}\] *$/,/^ *\[${NextSection}\] *$/p" "$MetaFile" | sed "1d; s|^ *\[${NextSection}\] *$||g" | grep -v "^ *#" | grep -Ex -- "^ *${2} *=.*" | cut -d "=" -f 2- | sed "s|^ *||g; s| *$||g"  | sed "s|^\"||g; s|\"$||g"| grep -v "^$" || true
} | if [[ "$CsvMode" = true ]]; then
    tr "," "\n" | RemoveBlank | grep -v "^$"
else
    cat
fi
