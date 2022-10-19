
# Pacman

Pacmanコマンドをシェルスクリプトから簡単に使えるようにしたラッパー関数

## Overview

Pacman (Arch Linuxのためのパッケージマネージャ[Libalpm]のフロントエンド) をシェルスクリプトから容易に操作するためのラッパー関数

これらの関数はArch Linux上でのみ動作します。（動作環境の確認は現在実装されていません。）

一部の関数はLibalpmのファイルを直接参照します。

Pacmanの仕様変更などで動作しない場合は開発者に問題を報告してください。

## Index

* [GetRepoListFromConf](#getrepolistfromconf)
* [GetRepoListFromLocalDb](#getrepolistfromlocaldb)

### GetRepoListFromConf

pacman.confからリポジトリの一覧を取得します。
pacman-confを使用してpacman.confを読みより、リポジトリの一覧を取得します。
pacman.confを使用しないでデータベースを読み取る場合は`GetPacmanRepoListFromLocalDb`を使用してください。

_Function has no arguments._

#### Exit codes

* **0**: この関数は常に0を返します

### GetRepoListFromLocalDb

ローカルデータベースからリポジトリの一覧を取得します。
ローカルデータベース（/var/lib/pacman/sync)からリポジトリの一覧を取得します。
この関数が実行される前に同じpacman.confを使ってパッケージデータベースを更新する必要があります。
pacman.confを直接読み取る場合は`GetRepoListFromConf`を使用してください。

_Function has no arguments._

#### Exit codes

* **0**: この関数は常に0を返します

