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


# @description パッケージがインストール済みかどうかを確認します。
#
# @example CheckPacmanPkg yay bash base
#
# @arg LONG  GNU getopt's long option
# @arg SHORT GNU getopt's short option
#
# @exitcode 0 指定された全てのパッケージがインストールされています
# @exitcode 1 指定されたどれかのパッケージがシステム上に見つかりませんでした
CheckPacmanPkg(){
    local p
    for p in "$@"; do
        pacman -Qq "$p" || return 1
    done
    return 0
}

