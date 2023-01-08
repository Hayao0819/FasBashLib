#!/usr/bin/env bash
# shellcheck disable=SC2154

TmpFile="$(mktemp)"

# shellcheck source=/dev/null
source "$(cd "$(dirname "${0}")/../" || exit 1 ; pwd)/lib/Common.sh"

readarray -t LibList < <(GetLibList)

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
            #export SHDOC_DEBUG=1
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

LibList=("${@}")



PrepareBuild(){
    mkdir -p "${DocsDir}"
    if [[ -z "${LibList[*]}" ]]; then
        readarray -t LibList < <("${BinDir}/List.sh" -q)
    fi
}


# GetFullShellCode <Lib>
GetFullShellCode(){
    local FileList=()

    # Get info
    readarray -t FileList < <("$LibDir/GetMeta.sh" "$Lib" Files | tr "," "\n" | sed "s|^ *||g; s| *$||g; s|^	*||g; s|	*$||g; /^$/d" )

    # Create Document
    printf "${SrcDir}/$Lib/%s\n" "${FileList[@]}" | xargs -I{} echo "Load: {}"
    printf "${SrcDir}/$Lib/%s\n" "${FileList[@]}" | xargs cat
}


ReplaceTextInArray(){
    local ArrayName="$1" Text="$2" Replace="$3"
    readarray -t "$ArrayName" < <(eval "PrintArray \"\${${ArrayName}[@]}\"" | sed "s|$Text|$Replace|g")
}

isFuncDefLine(){
    grep -Eq ".*\(\) *{? *$" <<< "$1" && ! grep -Eq -- "=\(\)" <<< "$1"
}

getFuncName(){
    sed -E "s| *\(\) *\{? *$||g; s|^ *||g; s| *$||g; s|^	*||g; s|	*$||g; /^$/d" <<< "$1"
}

isDocLine(){
    grep -Eq "^ *# *@.*$" <<< "$1"
}

formatDocLine(){
    sed "s|^ *# *||g; s| *$||g; s|^	*||g; s|	*$||g; /^$/d; s|^@||g; s|@.*$||g" <<< "$1"
}

GenerateDoc(){
    local LibName="$1"
    local Section="" MultiLine=false Key="" Value="" Line=""
    local DocumentBody=() FunctionsBody=() IndexBody=()
    local DocCount=0 DocumentedFuncList=()

    local FUNC_ARG=() FUNC_STDOUT=() FUNC_EXITCODE=() FUNC_DESC=() FUNC_EXAMPLE=()

    if ! [[ -e "$SrcDir/$LibName/Description.txt" ]]; then
        echo "No description file: $SrcDir/$LibName/Description.txt"
        return 1
    fi

    # Get template
    readarray -t DocumentBody < <(cat "$StaticDir/document-body.md")

    # Get info
    ReplaceTextInArray DocumentBody "%LIBRARY_NAME%" "$LibName"
    ReplaceTextInArray DocumentBody "%LIBRARY_DESCRIPTIONTXT%" "$(cat "$SrcDir/$LibName/Description.txt")"
    ReplaceTextInArray DocumentBody "%LIBRARY_META_DESCRIPTION%" "$("$LibDir/GetMeta.sh" "$LibName" Description)"

    # Parse script code
    while read -r Line; do
        # get function
        if isFuncDefLine "$Line"; then
            # Get function name
            Section="$(getFuncName "$Line")"

            if (( ${#FUNC_DESC[@]} > 0)); then
                DocumentedFuncList+=("$Section")
            fi

            # Write document
            readarray -O "${#FunctionsBody[@]}" FunctionsBody < <(
                if (( ${#FUNC_DESC[@]} > 0)); then
                    DocumentedFuncList+=("$Section")
                    echo "### $Section"
                fi
                if (( ${#FUNC_DESC[@]} > 0)); then
                    echo "${FUNC_DESC[@]}"
                fi
                if (( ${#FUNC_ARG[@]} > 0)); then
                    echo "#### Arguments"
                    echo
                    echo "${FUNC_ARG[@]}"
                fi
                if (( ${#FUNC_STDOUT[@]} > 0)); then
                    echo "#### Stdout"
                    echo
                    echo "${FUNC_STDOUT[@]}"
                fi
                if (( ${#FUNC_EXITCODE[@]} > 0)); then
                    echo "#### Exitcode"
                    echo
                    echo "${FUNC_EXITCODE[@]}"
                fi
                if (( ${#FUNC_EXAMPLE[@]} > 0)); then
                    echo "#### Example"
                    echo
                    echo '```bash'
                    echo "${FUNC_EXAMPLE[@]}"
                    echo '```'
                fi
            )

            FUNC_DESC=() FUNC_ARG=() FUNC_STDOUT=() FUNC_EXITCODE=() FUNC_EXAMPLE=()
            DocCount=0

        elif isDocLine "$Line"; then
            Line="$(formatDocLine "$Line")"
            Key="$(cut -d " " -f 1 <<< "$Line")"
            Value="$(cut -d " " -f 2- <<< "$Line")"
            DocCount=$((DocCount+1))

            case "$Key" in
                "description")
                    [[ -n "$Value" ]] && FUNC_DESC+=("$Value")
                    MultiLine=true
                    ;;
                "example")
                    #FUNC_EXAMPLE+=("$Value")
                    MultiLine=true
                    ;;
                "arg")
                    FUNC_ARG+=("$Value")
                    MultiLine=false
                    ;;
                "noarg" | "noargs")
                    FUNC_ARG=("No arguments")
                    MultiLine=false
                    ;;
                "stdout")
                    FUNC_STDOUT+=("$Value")
                    MultiLine=false
                    ;;
                "exitcode")
                    FUNC_EXITCODE+=("$Value")
                    MultiLine=false
                    ;;
                *)
                    echo "Unknown key: $Key"
                    ;;
            esac
        
        elif [[ "$MultiLine" == true ]]; then
            Line="$(formatDocLine "$Line")"
            case "$Key" in
                "description")
                    FUNC_DESC+=("$Line")
                    ;;
                "example")
                    FUNC_EXAMPLE+=("$Line")
                    ;;
                *)
                    echo "Unknown key: $Key"
                    ;;
            esac

        fi 
    done < <(GetFullShellCode "$LibName")

    for Func in "${DocumentedFuncList[@]}"; do
        IndexBody+=("* [$Func](#${Func,,})")
    done

    # Write index
    printf "%s\n" "${IndexBody[@]}" > "$TmpFile"
    readarray DocumentBody < <(printf '%s\n' "${DocumentBody[@]}" | sed -e "/^%DOCUMENT_INDEX%$/r $TmpFile")

    # Write functions
    printf "%s\n" "${FunctionsBody[@]}" > "$TmpFile"
    readarray DocumentBody < <(printf '%s\n' "${DocumentBody[@]}" | sed -e "/^%DOCUMENT_FUNCTIONS%$/r $TmpFile" )


    #printf '%s\n' "${DocumentBody[@]}" > "${DocsDir}/${LibName}.md"
    if [[ -n "${DocumentBody[*]}" ]]; then
        printf '%s\n' "${FunctionsBody[@]}" > "${DocsDir}/${LibName}.md"
    fi
}

PrepareBuild


#LibList=("BetterShell")

for Lib in "${LibList[@]}"; do
    #echo > "${DocsDir}/${Lib}.md"

    echo "Generating doc for $Lib" >&2
    GenerateDoc "$Lib" || echo "Failed to generate doc for $Lib" >&2

    #| gawk -f "$LibDir/shdoc/shdoc" >> "${DocsDir}/${Lib}.md"
done
wait


