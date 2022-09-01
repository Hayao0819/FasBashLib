#!/usr/bin/env bash
# shellcheck disable=SC2154

# shellcheck source=/dev/null
source "$(cd "$(dirname "${0}")/../" || exit 1 ; pwd)/lib/Common.sh"

DESTDIR="${DESTDIR-""}/usr/" INSTALLDIR="/lib/fasbashlib/"

OutputDir="${DESTDIR}/${INSTALLDIR}"

TmpDir="$(mktemp -d -t "fasbashlib.XXXXX")"
MinVersion="v0.2.5.1"
DownloadFileList=(
    "fasbashlib.zip" "fasbashlib-lower.zip" "fasbashlib-snake.zip"
    "fasbashlib.sh"  "fasbashlib-lower.sh"  "fasbashlib-snake.sh"  
)
TagNameToBuild=()
GitCommitToBuild=(a28c26576b1c2b36120611d84c33ddf8956bf53f)


_Make_Prepare(){
    # Create directories
    mkdir -p "$TmpDir" "$DESTDIR"

    echo "Working directory: $TmpDir" >&2

    # Get source codes
    git clone --recursive "https://github.com/Hayao0819/FasBashLib.git" "$TmpDir/src"
}

_Make_Builable_Version(){
    cd "$TmpDir/src" || exit 1
    readarray -t TagNameToBuild < <(git tag | sed -n "/${MinVersion}/,\$p")
}

_Make_GetFilesFromGitHub(){
    local Tag File

    for Tag in "${TagNameToBuild[@]}"; do
        mkdir -p "$TmpDir/archive/$Tag"

        #while read -r Link; do
        #done < <($BinDir/Release-Link.sh "$Tag")

        for File in "${DownloadFileList[@]}"; do
            echo "Downloading $File from $Tag" >&2
            curl -L -# -o "$TmpDir/archive/$Tag/$File" "https://github.com/Hayao0819/FasBashLib/releases/download/${Tag}/${File}"
        done
    done
}

_Make_GetFilesFromSourceCode(){
    local Commit
    cd "$TmpDir/src" || exit 1
    for Commit in "${GitCommitToBuild[@]}"; do
        git checkout "$Commit" || {
            echo "Failed to checkout $Commit"
            exit 1
        }
        make RELEASE_DIR="$TmpDir/archive/$Commit" release
    done
}

_Make_Unpack(){
    set -xv
    local Dir File UnpackDir
    for Dir in "$TmpDir/archive/"*; do
        for File in "${DownloadFileList[@]}"; do 
            UnpackDir="$TmpDir/dest/${INSTALLDIR}/$(basename "$Dir")"
            echo "Unpacking $Dir/$File to $UnpackDir" >&2
            mkdir -p "$UnpackDir"
            #unzip -d "$UnpackDir" "$Dir/$File"
            tar -C "$UnpackDir" -xf "$Dir/$File"
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
            DESTDIR="$2"
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
#_Make_GetFilesFromSourceCode
_Make_Unpack
_Make_Install
echo "$TmpDir"
