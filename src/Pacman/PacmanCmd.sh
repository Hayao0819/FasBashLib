#!/usr/bin/env bash
# @file Pacman
# @brief Pacmanコマンドをシェルスクリプトから簡単に使えるようにしたラッパー関数
# @description
#    Pacman (Arch Linuxのためのパッケージマネージャ[Libalpm]のフロントエンド) をシェルスクリプトから容易に操作するためのラッパー関数
#
#    これらの関数はArch Linux上でのみ動作します。（動作環境の確認は現在実装されていません。）
#
#    一部の関数はLibalpmのファイルを直接参照します。
#
#    Pacmanの仕様変更などで動作しない場合は開発者に問題を報告してください。

# @internal
Run(){
    pacman --noconfirm --config "${PACMAN_CONF-"/etc/pacman.conf"}" "$@"
}

RunKey(){
    pacman-key --config "${PACMAN_CONF-"/etc/pacman.conf"}" "$@"
}

# @internal
GetConfig(){
    LANG=C pacman-conf --config="${PACMAN_CONF-"/etc/pacman.conf"}" "$@"
}

# @description パッケージがインストール済みかどうかを確認します。
#
# @example Pm.CheckPkg yay bash base
#
# @arg LONG  GNU getopt's long option
# @arg SHORT GNU getopt's short option
#
# @exitcode 0 指定された全てのパッケージがインストールされています
# @exitcode 1 指定されたどれかのパッケージがシステム上に見つかりませんでした
CheckPkg(){
    local p
    for p in "$@"; do
        @Run -Qq "$p" > /dev/null 2>&1 || return 1
    done
    return 0
}

# @description pacman.confからリポジトリの一覧を取得します。
#              pacman-confを使用してpacman.confを読みより、リポジトリの一覧を取得します。
#              pacman.confを使用しないでデータベースを読み取る場合は`GetPacmanRepoListFromLocalDb`を使用してください。
#
# @example Pm.GetRepoListFromConf
#
# @noargs
#
# @exitcode 0 この関数は常に0を返します
GetRepoListFromConf(){
    #@GetConfig | GetIniSectionList 2> /dev/null| grep -vx "options"
    @GetConfig --repo-list
}

GetRoot(){
    @GetConfig RootDir
}

PacmanGpg(){
    gpg --homedir "$(@GetConfig GPGDir)" "$@"
}

GetPacmanKeyringDir(){
    local _KeyringDir=""
    _KeyringDir="$(LANG=C pacman-key -h | RemoveBlank | grep -A 1 -- "^--populate" | tail -n 1 | cut -d "/" -f 2- | sed "s|'$||g")"
    : "${_KeyringDir="usr/share/pacman/keyrings"}"
    _KeyringDir="$(@GetRoot)/$_KeyringDir"
    _KeyringDir="$(sed -E "s|/+|/|g" <<< "$_KeyringDir")"
    if [[ -e "$_KeyringDir" ]]; then
        Readlinkf "$_KeyringDir"
    else
        echo "$_KeyringDir"
    fi
}

GetLatestPkgVer(){
    local _LANG="${LANG-""}"
    export LANG=C
    ForEach @Run -Si "{}" | grep "^Version" | cut -d ":" -f 2 | RemoveBlank
    [[ -n "$_LANG" ]] && export LANG="$_LANG"
    return 0
}

GetInstalledPkgVer(){
    ForEach pacman -Qq "{}" | cut -d " " -f 2
    PrintArray "${PIPESTATUS[@]}" | grep -qx "1" && return 1
    return 0
}

GetRepoConf(){
    ForEach eval 'echo [{}] && @GetConfig -r {}'
}

GetRepoServer(){
    #shellcheck disable=SC2016
    ForEach eval '@GetConfig -r {}' | grep "^Server" | ForEach eval 'Ini.ParseLine; printf "%s\n" ${VALUE}'
}

GetKeyringList(){
    find "$(@GetnKeyringDir)" -name "*.gpg" | GetBaseName | RemoveFileExt 
}

GetPacmanKernelPkg(){
    echo "there is nothing"
}

IsRepoPkg(){
    @Run -Slq | grep -qx "$(@GetName <<< "$1")"
}

GetRepoPkgList(){
    @Run -Slq "$@"
}

GetName(){
    cut -d "<" -f 1 | cut -d ">" -f 1 | cut -d "=" -f 1
}

GetRepoVer(){
    @Run -Sp --print-format '%v' "$1"
}
