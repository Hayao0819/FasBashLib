#!/usr/bin/env bash

ParsePkgFileName(){
    local _Pkg="$1"
    local _PkgName _PkgVer _PkgRel _Arch _FileExt  
    local _PkgWithOutExt

    # File name
    if grep "/" <<< "$_Pkg"; then
        _Pkg="$(basename "$_Pkg")"
    fi

    # Parse
    _FileExt="$(GetLastSplitString "-" "$_Pkg" | cut -d "." -f 2-)" #pkg.tar.zst
    _PkgWithOutExt="${_Pkg%%".${_FileExt}"}" 
    _Arch=$(GetLastSplitString "-" "${_PkgWithOutExt}")
    _PkgRel=$(GetLastSplitString "-" "${_PkgWithOutExt%%"-${_Arch}"}")
    _PkgVer=$(GetLastSplitString "-" "${_PkgWithOutExt%%"-${_PkgRel}-${_Arch}"}")
    _PkgName="${_PkgWithOutExt%%"-${_PkgVer}-${_PkgRel}-${_Arch}"}"

    _ParsedPkg=("${_PkgName}" "-" "$_PkgVer" "-" "$_PkgRel" "-" "$_Arch" ".$_FileExt")

    if [[ ! "$(PrintArray "${_ParsedPkg[@]}" | tr -d "\n")" = "${_Pkg}" ]]; then
        return 1
    fi
    PrintArray "${_ParsedPkg[@]}"
}

# @description ローカルデータベースからリポジトリの一覧を取得します。
#              ローカルデータベース（/var/lib/pacman/sync)からリポジトリの一覧を取得します。
#              この関数が実行される前に同じpacman.confを使ってパッケージデータベースを更新する必要があります。
#              pacman.confを直接読み取る場合は`GetRepoListFromConf`を使用してください。
#
# @example GetRepoListFromLocalDb
#
# @noargs
#
# @exitcode 0 この関数は常に0を返します
GetRepoListFromLocalDb(){
    find "$(@GetConfig DBPath)/sync" -mindepth 1 -maxdepth 1 -type f | GetBaseName | sed "s|.db$||g"
    return 0
}

# OpenSyncDb <repo> 
OpenSyncDb(){
    local _Dir _RepoDb
    @CreateDbTmpDir
    _Dir="$(@GetDbTmpDir)/sync/$1"
    mkdir -p "$_Dir"
    _RepoDb="$(@GetConfig DBPath)/sync/$1.db"
    [[ -e "$_RepoDb" ]] || return 1
    tar -xzf "${_RepoDb}" -C "$_Dir" || return 1
}

GetDbTmpDir(){
    echo "${TMPDIR-"/tmp"}/fasbashlib-pacman-db"
}

CreateDbTmpDir(){
    mkdir -p "$(@GetDbTmpDir)"
}

DeleteDbTmpDir(){
    rm -rf "$(@GetDbTmpDir)"
}

IsOpendSyncDb(){
    readarray -t _PkgDbList < <(find "$(@GetDbTmpDir)/sync/$1" -mindepth 1 -maxdepth 1 -type d )
    (( "${#_PkgDbList[@]}" > 0 )) && return 0
    return 1
}

OpenedSyncDbList(){
    find "$(@GetDbTmpDir)/sync/" -mindepth 1 -maxdepth 1 -type d 
}

# GetSyncDbDescPath <pkgname>
GetSyncDbDescPath(){
    local _repo
    _repo="$(pacman -Sp --print-format '%r' "$1")"
    { IsPacmanSyncDbOpend "$_repo" || OpenPacmanSyncDb "$_repo"; } || return 1
    echo "$(@GetDbTmpDir)/sync/$(pacman -Sp --print-format '%r/%n-%v' "$1")"
}

# GetSyncDbDesc <pkgname>
GetSyncDbDesc(){
    local _path
    _path="$(@GetSyncDbDescPath "$1")"
    [[ -e "$_path" ]] || return 1
    cat "$_path/desc"
}

GetSyncAllDesc(){
    find "$(@GetDbTmpDir)" -mindepth 3 -maxdepth 3 -name "desc" -type f
}

GetVirtualPkgList(){
    @GetRepoListFromLocalDb | ForEach @OpenSyncDb {}
    @GetSyncAllDesc | ForEach eval "@GetDbSection PROVIDES < {}" | RemoveBlank
}

GetPkgArch(){
    @GetSyncDbDesc "$1" | @GetDbSection ARCH | RemoveBlank
}
