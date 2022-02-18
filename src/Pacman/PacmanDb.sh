#!/usr/bin/env bash

# @description ローカルデータベースからリポジトリの一覧を取得します。
#              ローカルデータベース（/var/lib/pacman/sync)からリポジトリの一覧を取得します。
#              この関数が実行される前に同じpacman.confを使ってパッケージデータベースを更新する必要があります。
#              pacman.confを直接読み取る場合は`GetPacmanRepoListFromConf`を使用してください。
#
# @example GetPacmanRepoListFromLocalDb
#
# @noargs
#
# @exitcode 0 この関数は常に0を返します
GetPacmanRepoListFromLocalDb(){
    find "$(GetPacmanConf DBPath)/sync" -mindepth 1 -maxdepth 1 -type f | GetBaseName | sed "s|.db$||g"
    return 0
}
