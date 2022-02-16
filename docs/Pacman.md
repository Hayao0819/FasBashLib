# Pacman

Pacmanコマンドをシェルスクリプトから簡単に使えるようにしたラッパー関数

## Overview

Pacman (Arch Linuxのためのパッケージマネージャ[Libalpm]のフロントエンド) をシェルスクリプトから容易に操作するためのラッパー関数

これらの関数はArch Linux上でのみ動作します。（動作環境の確認は現在実装されていません。）

一部の関数はLibalpmのファイルを直接参照します。

Pacmanの仕様変更などで動作しない場合は開発者に問題を報告してください。

## Index

* [CheckPacmanPkg()](#checkpacmanpkg)

### CheckPacmanPkg()

パッケージがインストール済みかどうかを確認します。

#### Arguments

* LONG  GNU getopt's long option
* SHORT GNU getopt's short option

#### Exit codes

* **0**: 指定された全てのパッケージがインストールされています
* **1**: 指定されたどれかのパッケージがシステム上に見つかりませんでした

