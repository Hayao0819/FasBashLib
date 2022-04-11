#!/usr/bin/env bash

MainDir="$(cd "$(dirname "${0}")/../" || exit 1 ; pwd)"
LibDir="$MainDir/lib"
SrcDir="$MainDir/src"
BinDir="$MainDir/bin"
DocsDir="$MainDir/docs"
LibList=("${@}")

# sedコマンド
if sed -h 2>&1 | grep -q "GNU"; then
    GNUSed=true
else
    GNUSed=false
fi

# _GetFuncListFromStdin
_GetFuncListFromStdin(){
    (
        # すべての関数をリセット
        local Func
        while read -r Func; do
            unset "$Func"
        done < <(declare -F | cut -d " " -f 3)

        # ファイルをsource
        # shellcheck source=/dev/null
        source "/dev/stdin"

        # 関数のリストを出力
        declare -F | cut -d " " -f 3
    )
}

SedI(){
    local SedArgs=()

    # BSDかGNUか
    if "${GNUSed}"; then
        SedArgs=("-i" "${SedArgs[@]}")
    else
        SedArgs=("-i" "" "${SedArgs[@]}")
    fi

    sed "${SedArgs[@]}" "$@"
}


# Parse args
while [[ -n "${1-""}" ]]; do
    [[ "$1" == "-"* ]] || break
    case "${1}" in
        "-out")
            [[ -n "${2-""}" ]] || { echo "No file is specified"; exit 1; }
            DocsDir="${2}"
            shift 2 || break
            ;;
        "-debug")
            export SHDOC_DEBUG=1
            shift 1
            ;;
        "--")
            shift 1
            break
            ;;
        *)
            echo "Usage: $(basename "$0") [-out Dir]"
            [[ "${1}" = "-h" ]] && exit 0
            exit 1
            ;;
    esac
done

mkdir -p "${DocsDir}"

if [[ ! -e "$LibDir/shdoc/shdoc" ]]; then
    echo "Error: Update git submodule" >&2
    exit 1
fi

if [[ -z "${LibList[*]}" ]]; then
    readarray -t LibList < <("${BinDir}/GetLibList.sh" -q)
fi

for Lib in "${LibList[@]}"; do
    echo > "${DocsDir}/${Lib}.md"

    # Get info
    readarray -t FileList < <("$LibDir/GetMeta.sh" "$Lib" Files | tr "," "\n" | sed "s|^ *||g; s| *$||g; s|^	*||g; s|	*$||g; /^$/d" )
    #readarray -t FuncList < <(printf "${SrcDir}/$Lib/%s\n" "${FileList[@]}" | xargs cat | _GetFuncListFromStdin)
    #Prefix="$("$LibDir/GetMeta.sh" "$Lib" "Prefix")"

    # Create Document
    printf "${SrcDir}/$Lib/%s\n" "${FileList[@]}" | xargs -I{} echo "Load: {}"
    printf "${SrcDir}/$Lib/%s\n" "${FileList[@]}" | xargs cat | gawk -f "$LibDir/shdoc/shdoc" >> "${DocsDir}/${Lib}.md"

    #if [[ -n "${Prefix}" ]]; then
        #for Func in "${FuncList[@]}"; do
            #SedI "s|### ${Func}()|### ${Prefix}.${Func}()|g" "${DocsDir}/${Lib}.md"
            #SedI -E "s|\* \[${Func}\(\)]\(#${Func,,}\)|\* \[${Prefix}\.$Func\(\)\]\(\#${Prefix,,}\.${Func,,}\)|g" "${DocsDir}/${Lib}.md"
        #done
    #fi
done
