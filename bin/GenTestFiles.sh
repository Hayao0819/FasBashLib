#!/usr/bin/env bash
# shellcheck disable=SC1090,SC1091

MainDir="$(cd "$(dirname "${0}")/../" || exit 1 ; pwd)"
LibDir="$MainDir/lib"
SrcDir="$MainDir/src"
BinDir="$MainDir/bin"
TestsDir="$MainDir/tests"

# Parse args
while [[ -n "${1-""}" ]]; do
    [[ "$1" == "-"* ]] || break
    case "${1}" in
        "--")
            shift 1
            break
            ;;
        *)
            echo "Usage: $(basename "$0") -- [Lib1] [Lib2] ..."
            [[ "${1}" = "-h" ]] && exit 0
            exit 1
            ;;
    esac
done

# Get library list
if (( "${#}" > 0 )); then
    LibList=("$@")
else
    readarray -t LibList < <("$BinDir/GetLibList.sh" -q)
fi

# Create lib dirs
printf "%s\n" "${LibList[@]}" | xargs -I{} mkdir -p "$TestsDir/{}"

# Create function dirs
while read -r Dir; do
    LibName="$(basename "$Dir")"
    while read -r File; do
        

        (
            source "${Dir}/${File}" || {
                echo "Failed to load shell file" >&2
                exit 1
            }

            while read -r Func; do
                FuncTestDir="$TestsDir/$LibName/${Func}/"
                mkdir -p "$FuncTestDir"
                #TestFiles=("Run.sh" "Result.txt")
                #for _File in "${TestFiles[@]}"; do
                #    touch "$FuncTestDir/$_File"
                #done
                [[ -e "$FuncTestDir/Run.sh"    ]] || echo "# shellcheck disable=SC2148,SC2034" >  "$FuncTestDir/Run.sh"
                [[ -e "$FuncTestDir/Result.sh" ]] || echo > "$FuncTestDir/Result.sh"
            done < <(typeset -F | cut -d " " -f 3)
        )
    done < <("$LibDir/GetMeta.sh" "${LibName}" "Files" | tr "," "\n")

done < <(printf "${SrcDir}/%s\n" "${LibList[@]}")

