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
MaxVersion=""
declare -A DownloadFileList=(
    ["fasbashlib.tar.gz"]="upper.tar.gz"
    ["fasbashlib-lower.tar.gz"]="lower.tar.gz"
    ["fasbashlib-snake.tar.gz"]="snake.tar.gz"
    ["fasbashlib.sh"]="upper.sh"
    ["fasbashlib-lower.sh"]="lower.sh"
    ["fasbashlib-snake.sh"]="snake.sh"
    ["fasbashlib.json"]="info.json"
)
TagNameToBuild=()
GitCommitToBuild=()
DefaultBranchName=""
BuildTagFromSource=true # タグ付けされたバージョンをソースからビルドするかどうか
NoTagBuild=false

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

    if [[ -n "$(ls -A "${DESTDIR}/${INSTALLDIR}/")" ]]; then
        echo "WANINHG: Directory ${DESTDIR}/${INSTALLDIR} is not empty." >&2
        exit 1
    fi

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

_Make_GetInfoFromGit(){
    cd "$TmpDir/src" || exit 1
    MaxVersion="$(git describe --tags --abbrev=0)"
    if [[ "$NoTagBuild" = false ]]; then
        if [[ "${BuildTagFromSource}" = true ]]; then
            readarray -t GitCommitToBuild < <(git tag | sed -n "/${MinVersion}/,/${MaxVersion}/p")
        else
            readarray -t TagNameToBuild < <(git tag | sed -n "/${MinVersion}/,/${MaxVersion}/p")
        fi
    fi

    git config advice.detachedHead false
    DefaultBranchName="$(git symbolic-ref --short HEAD)"
}

_Make_GetFilesFromGitHub(){
    local Tag File SaveFile

    for Tag in "${TagNameToBuild[@]}"; do
        mkdir -p "$TmpDir/archive/$Tag"

        #while read -r Link; do
        #done < <($BinDir/Release-Link.sh "$Tag")

        for File in "${!DownloadFileList[@]}"; do
            SaveFile="$TmpDir/archive/$Tag/${DownloadFileList["${File}"]}"
            [[ -e "$SaveFile" ]] && continue
            echo "Downloading $File from $Tag" >&2
            curl -L -# -o "$SaveFile" "https://github.com/Hayao0819/FasBashLib/releases/download/${Tag}/${File}" || {
                echo "Failed to download: https://github.com/Hayao0819/FasBashLib/releases/download/${Tag}/${File}"
            }
        done
    done
}

_Make_GetFilesFromSourceCode(){
    local Commit
    cd "$TmpDir/src" || exit 1
    for Commit in "${GitCommitToBuild[@]}"; do

        for File in "${!DownloadFileList[@]}"; do
            SaveFile="$TmpDir/archive/$Commit/${DownloadFileList["${File}"]}"
            [[ -e "$SaveFile" ]]
        done && continue

        git checkout "$Commit" || {
            echo "Failed to checkout: $Commit" >&2
            exit 1
        }
        trap 'git checkout "${DefaultBranchName}"; rm -rf "$TmpDir/archive/$Commit"; exit 1' SIGHUP SIGINT SIGQUIT SIGTERM 
        make RELEASE_DIR="$TmpDir/build/$Commit" release
        trap SIGHUP SIGINT SIGQUIT SIGTERM 
        git checkout "${DefaultBranchName}" || {
            echo "Failed to checkout default branch: $DefaultBranchName"
            exit 1
        }

        for File in "${!DownloadFileList[@]}"; do
            SaveFile="$TmpDir/archive/$Commit/${DownloadFileList["${File}"]}"
            [[ -e "$SaveFile" ]] && continue
            echo "Copying $File from $Commit" >&2
            mkdir -p "$(dirname "$SaveFile")"
            cp "$TmpDir/build/$Commit/$File" "$SaveFile"
        done
    done
}

_Make_Unpack(){
    set -xv
    if [[ -z "$(PrintArray "${GitCommitToBuild[@]}" "${TagNameToBuild[@]}")" ]]; then
        echo "There is no tag or commit to install" >&2
        exit 1
    fi

    local Dir OrgFileName File UnpackDir
    rm -rf "$TmpDir/dest/"

    #for Dir in "$TmpDir/archive/"*; do
    while read -r Dir; do
        for OrgFileName in "${!DownloadFileList[@]}"; do
            File="${DownloadFileList["${OrgFileName}"]}"
            TargetDir="$TmpDir/dest/${INSTALLDIR}/$(basename "$Dir")/"
            UnpackDir="$TargetDir/$(cut -d "." -f 1 <<< "$File")"
            if [[ "$File" = *".tar.gz" ]]; then
                echo "Unpacking $Dir/$File to $UnpackDir" >&2        
                cd "$Dir" || {
                    echo "Cannot unpack archives for $(basename "$Dir")" >&2
                    continue
                }
                #unzip -o -d "$UnpackDir" "$Dir/$File"
                mkdir -p "$UnpackDir"
                tar -x -v -f "$Dir/$File" -C "$UnpackDir"
            else
                mkdir -p "$TargetDir"
                install -m 644 "$Dir/$File" "$TargetDir"
            fi
        done
    done < <(PrintArray "${GitCommitToBuild[@]}" "${TagNameToBuild[@]}" | sed "s|^|$TmpDir/archive/|")
}

_Make_MainCommand(){
    mkdir -p "$TmpDir/dest/usr/bin/"
    install -m 755 "${StaticDir}/fasbashlib" "$TmpDir/dest/usr/bin/"
}

_Make_FileList(){
    find "$TmpDir/dest/" -type f | sed "s|^$TmpDir/dest/||" > "$TmpDir/dest/${INSTALLDIR}/filelist"
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
_Make_GetInfoFromGit
_Make_GetFilesFromGitHub
_Make_GetFilesFromSourceCode
_Make_Unpack
_Make_MainCommand
_Make_FileList
_Make_Install
echo "$TmpDir"
