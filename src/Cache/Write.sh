#!/usr/bin/env bash

# cmd | Cache.Create CacheName
# FSBLIB_CACHEID: スクリプト内のキャッシュを保存するディレクトリのパスのID
# TMPDIR: /tmpもしくはそれ相当のディレクトリ
Create(){
    @CreateDir > /dev/null
    cat > "$(@GetDir)/${1}"
    cat "$(@GetDir)/$1"
}

# @description キャッシュを保存するためのディレクトリを${TMPDIR}以下に作成します
#
# この関数はさまざまな関数からディレクトリを参照する際に呼び出されるので、通常はスクリプト内で明示的に呼び出す必要はありません。
#
# Cache.Create や Cache.GetID, Cache.GetDir などから呼び出されます。
#
# この関数を初めて実行したのがサブシェル内である場合、FSBLIB_CACHEID 変数が引き継がれないため、関数を呼び出せない可能性があります。
#
# 最初にサブシェル外でこのコマンドを実行することで、サブシェル内でもFSBLIB_CACHEID を引き継ぐことができます。
#
# @example
#    Cache.CreateDir > /dev/null
#
# @noargs
#
# @set FSBLIB_CACHEID
# @stdout 作成されたディレクトリのパスを出力します。  通常は不要なので、破棄してください。
#
# @exitcode 0 ディレクトリの作成に成功しました
# @exitcode 1 mkdirがなんらかの理由でディレクトリを作成できませんでした
#
CreateDir(){
    FSBLIB_CACHEID="${FSBLIB_CACHEID-"$(RandomString "10")"}"
    #[[ -n "${FSBLIB_CACHEID-""}" ]] || { echo "Set FSBLIB_CACHEID variable" >&2 ; return 1; }
    export FSBLIB_CACHEID="$FSBLIB_CACHEID"
    local TMPDIR="${TMPDIR-"/tmp"}"
    local _Dir="$TMPDIR/${FSBLIB_CACHEID}"
    mkdir -p "$_Dir"
    echo "$_Dir"
    return 0
}


