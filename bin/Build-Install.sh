#!/usr/bin/env bash
# shellcheck disable=SC2154
# shellcheck source=/dev/null

set -Eeu -o pipefail

source <(curl -sL "https://github.com/Hayao0819/FasBashLib/releases/download/v0.2.4/fasbashlib.sh")
source "$(cd "$(dirname "${0}")/../" || exit 1 ; pwd)/lib/Common.sh"

DESTDIR="${DESTDIR-""}"
INSTALLDIR="/usr/lib/fasbashlib/"

#TmpDir="$(mktemp -d -t "fasbashlib.XXXXX")"
TmpDir="$MainDir/work"
MinVersion="v0.2.5.1"
DownloadFileList=(
    "fasbashlib.zip" "fasbashlib-lower.zip" "fasbashlib-snake.zip"
    "fasbashlib.sh"  "fasbashlib-lower.sh"  "fasbashlib-snake.sh"  
)
TagNameToBuild=()
GitCommitToBuild=()
DefaultBranchName=""

#_Run(){
#    local _LockDir="$TmpDir/Lockfile/"
#    [[ -e "$_LockDir/$1" ]] && return 0
#    mkdir -p "$_LockDir"
#    if "$@"; then
#        echo > "${_LockDir}/$1"
#    else
#        echo "Failed to run: $*" >&2
#        exit 1
#    fi
#}

_Make_Prepare(){
    # Create directories
    mkdir -p "$TmpDir" "${DESTDIR}/${INSTALLDIR}"

    echo "Working directory: $TmpDir" >&2

    # Get source codes
    if [[ -e "$TmpDir/src/.git" ]]; then
        cd "$TmpDir/src/" || return 1
        git pull
        return 0
    fi

    rm -rf "${TmpDir}/src"
    git clone --recursive "https://github.com/Hayao0819/FasBashLib.git" "$TmpDir/src"
}

_Make_Builable_Version(){
    cd "$TmpDir/src" || exit 1
    readarray -t TagNameToBuild < <(git tag | sed -n "/${MinVersion}/,\$p")
    DefaultBranchName="$(git symbolic-ref --short HEAD)"
}

_Make_GetFilesFromGitHub(){
    local Tag File

    for Tag in "${TagNameToBuild[@]}"; do
        mkdir -p "$TmpDir/archive/$Tag"

        #while read -r Link; do
        #done < <($BinDir/Release-Link.sh "$Tag")

        for File in "${DownloadFileList[@]}"; do
            [[ -e "$TmpDir/archive/$Tag/$File" ]] && continue
            echo "Downloading $File from $Tag" >&2
            curl -L -# -o "$TmpDir/archive/$Tag/$File" "https://github.com/Hayao0819/FasBashLib/releases/download/${Tag}/${File}" || {
                echo "Failed to download: https://github.com/Hayao0819/FasBashLib/releases/download/${Tag}/${File}"
            }
        done
    done
}

_Make_GetFilesFromSourceCode(){
    local Commit
    cd "$TmpDir/src" || exit 1
    for Commit in "${GitCommitToBuild[@]}"; do
        git checkout "$Commit" || {
            echo "Failed to checkout: $Commit" >&2
            exit 1
        }
        make RELEASE_DIR="$TmpDir/archive/$Commit" release
        git checkout "${DefaultBranchName}" || {
            echo "Failed to checkout default branch: $DefaultBranchName"
            exit 1
        }
    done
}

_Make_Unpack(){
    set -xv
    if [[ -z "$(PrintArray "${GitCommitToBuild[@]}" "${TagNameToBuild[@]}")" ]]; then
        echo "There is no tag or commit to install" >&2
        exit 1
    fi

    local Dir File UnpackDir
    for Dir in "$TmpDir/archive/"*; do
        for File in "${DownloadFileList[@]}"; do
            UnpackDir="$TmpDir/dest/${INSTALLDIR}/$(basename "$Dir")/$(cut -d "-" -f 2 <<< "$(RemoveFileExt <<< "$File")")/single"
            mkdir -p "$UnpackDir"
            if [[ "$File" = *".zip" ]]; then
                echo "Unpacking $Dir/$File to $UnpackDir" >&2        
                cd "$Dir" || {
                    echo "Cannot unpack archives for $(basename "$Dir")" >&2
                    continue
                }
                unzip -o -d "$UnpackDir" "$Dir/$File"
            else
                install -m 644 "$Dir/$File" "$UnpackDir"
            fi
        done
    done
}

_Make_Install(){
    local Dir
    for Dir in "$TmpDir/dest/"*; do
        echo "Installing $Dir to $DESTDIR" >&2
        cp -r "$Dir" "$DESTDIR"
    done
}

# Parse args
NoArg=()
while [[ -n "${1-""}" ]]; do
    case "${1}" in
        "-dir")
            DESTDIR="$(Readlinkf "$2")"
            shift 2
            ;;
        "--")
            shift 1
            break
            ;;
        "-"*)
            echo "Usage: $(basename "$0") [-dir DESTDIR]" >&2
            [[ "${1}" = "-h" ]] && exit 0
            exit 1
            ;;
        *)
            NoArg+=("$1")
            shift 1
            ;;
    esac
done
set -- "${NoArg[@]}"


_Make_Prepare
_Make_Builable_Version
_Make_GetFilesFromGitHub
_Make_GetFilesFromSourceCode
_Make_Unpack
_Make_Install
echo "$TmpDir"
