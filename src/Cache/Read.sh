#!/usr/bin/env bash
# @file Cache 
# @brief キャッシュの作成、呼び出し、管理を行います。
# @description
#     Cacheライブラリは、${TMPDIR}以下にデータを保存するテキストファイルを作成します。
#
#     これにより、コマンドの実行結果をキャッシュとして保存することが可能になります。
#
#     環境変数 `FSBLIB_CACHEID` をディレクトリ名として使用します。
#
#     `KEEPCACHESEC`で指定した秒数以上経過したキャッシュは削除されます。（デフォルトは86400秒）
#
#     環境変数は関数によって自動的に定義され、同じ値をスクリプトで直接定義することで変数が共有されない範囲でもデータを受け渡すことができます。
#


# @internal
GetID(){
    if [[ -z "${FSBLIB_CACHEID-""}" ]]; then
        @CreateDir > /dev/null
    fi
    echo "$FSBLIB_CACHEID"
}

# @internal
GetDir(){
    echo "${TMPDIR-"/tmp"}/$(@GetID)"
}


# @description 指定されたキャッシュが存在しているか確認します。
#              キャッシュが古すぎないかどうかも確認します。
#
# @example
#    Cache.Exist "FileList" || echo "Warning! You should update cache."
#
# @arg $1 Cache.Create で指定したキャッシュ名
#
# @set Cache.CreateDirを呼び出します
#
# @exitcode 0 最近作成されたキャッシュが存在しています
# @exitcode 1 キャッシュが存在しません
# @exitcode 2 キャッシュは存在しますが、作成されたのが86400秒以上前（1日以上前）のものです
Exist(){
    local _File
    _File="$(@CreateDir)/$1"
    [[ -e "$_File" ]] || return 1
    (( "$(@GetTimeDiffFromLastUpdate "$_File")" > "${KEEPCACHESEC-"86400"}" )) && return 2
    return 0
}

# @internal
GetTimeDiffFromLastUpdate(){
    local _Now _Last
    _Now="$(date "+%s")"
    _Last="$(@GetFileLastUpdate "$1")"
    echo "$(( _Now - _Last ))"
    return 0
}

# @internal
GetFileLastUpdate(){
    local _isGnu=false
    date --help 2> /dev/null | grep -q "GNU" && _isGnu=true

    if [[ "$_isGnu" = true ]]; then
        date +%s -r "$1"
    else
        {
            eval "$(stat -s "$1")"
            # shellcheck disable=SC2154
            echo "$st_mtime"
        }
    fi
}

# @description キャッシュの内容を取得します
# 指定された名前のキャッシュを取得し、標準出力に出力します
# 複数行の出力が行われる場合が多いです。
#
# @example
#    Cache.Get "FileList"
#
# @arg $1 Cache.Createで指定したキャッシュ名
#
# @stdout キャッシュの内容
#
# @exitcode 0 キャッシュの内容を表示しました
# @exitcode 1 キャッシュが存在しません
Get(){
    #@Exist "$1" || return 1
    cat "$(@GetDir)/$1" 2> /dev/null || return 1
}
