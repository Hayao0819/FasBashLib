#!/usr/bin/env bash

# @internal
GetRepoConf(){
   cat /etc/portage/repos.conf /etc/portage/repos.conf/* 2> /dev/null 
}

GetDefaultRepoName(){
    @GetRepoConf | Ini.GetParam DEFAULT main-repo
}

# GetRepoLocation <Repo name>
GetRepoLocation(){
    @GetRepoConf | Ini.GetParam "$1" location
}

GetRepoPkgList(){
    local _RepoPath
    _RepoPath="$(@GetRepoLocation "$1")"
    find "$_RepoPath" -mindepth 3 -maxdepth 3 -type f -name '*.ebuild' | sed -e "s|${_RepoPath%/}/||g" -e 's|.ebuild$||g' | awk -F "/" '{print $1"/"$3}'
}


GetAllPkgList(){
    @GetRepoConf | sed -e 's/^ *//' -e 's/ *$//' | grep "^ *location *=" | sed -e 's/^location *= *//' | xargs -L1 realpath | xargs -I{} bash -c "find '{}' -mindepth 3 -maxdepth 3 -type f -name '*.ebuild' | sed -e 's|{}/||g' -e 's|.ebuild$||g'" | awk -F "/" '{print $1"/"$3}'
}

GetInstalledPkgList(){
    find /var/db/pkg/ -mindepth 2 -maxdepth 2 -type d | sed 's|/var/db/pkg/||g'
}

GetWorldPkgList(){
    sed -E 's|:.+$||g' /var/lib/portage/world | xargs -I{} bash -c 'ls -d /var/db/pkg/{}-* | sed "s|/var/db/pkg/||g" | grep -E "{}-[0-9]"'
}


