#!/usr/bin/env bash
MainDir="$(cd "$(dirname "${0}")/../" || exit 1 ; pwd)"
LibDir="$MainDir/lib"
if (( $# < 1 )); then
    echo "Usage: $(basename "$0") LibName"
    exit 1
fi

LibName="$1"
FuncList=()


while read -r File; do
    #echo "Load: $File" >&2
    readarray -O "${#FuncList[@]}" -t FuncList < <(

        # shellcheck source=/dev/null
        source "${File}"

        declare -F | cut -d " " -f 3
    )
done < <("${LibDir}/GetFileList.sh" "$LibName")

Prefix="$("$LibDir/GetMeta.sh" "$LibName" Prefix)"

if [[ -n "${Prefix-""}" ]]; then
    readarray -t FuncList < <(printf "${Prefix}.%s\n" "${FuncList[@]}")
fi

printf "%s\n" "${FuncList[@]}"
