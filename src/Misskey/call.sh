#!/usr/bin/env bash
# @file Misskey
# @brief MisskeyのAPIをシェルスクリプトで扱うためのバインディング
# @description
#    curlとjqを利用してMisskeyのAPIを操作するための関数です。
#
#    Stream APIは現在非対応です。
#
#    実装済みのAPIは非常に少ないですがBindingBase関数で簡単に実装可能です。

# MakeJson KEY=VALUE KEY=VALUE ...
MakeJson(){
    local i _Key _Value
    for i in "i=$MISSKEY_TOKEN" "$@"; do
        _Key=$(cut -d "=" -f 1 <<< "$i")
        _Value=$(cut -d "=" -f 2- <<< "$i")
        if [[ "$_Value" =~ ^[0-9]+$ ]] || [[ "$_Value" = true ]] || [[ "$_Value" = false ]] || [[ "$_Value" = "{"*"}" ]] || [[ "$_Value" = "["*"]" ]]; then
            echo -n "{\"$_Key\": $_Value}"
        else
            echo -n "{\"$_Key\": \"$_Value\"}"
        fi 
    done | sed "s|}{|,|g" | jq -c -M 
}

# SendReq URL KEY=VALUE KEY=VALUE ...
SendReq(){
    local _Url="$1" _CurlArgs=()
    shift 1
    _CurlArgs+=(-s -L) # curlのよくある設定
    #_CurlArgs+=(--fail-with-body) # 失敗時の処理
    _CurlArgs+=(-X POST) # MisskeyのAPIは全てPOST
    _CurlArgs+=(-H "Content-Type: application/json") # JSONで送信
    _CurlArgs+=(-d "$(@MakeJson "$@")") # JSONを送信
    _CurlArgs+=("$_Url") # URL指定

    Msg.Debug "Run: ${_CurlArgs[*]//"${MISSKEY_TOKEN}"/"TOKEN"}"
    curl "${_CurlArgs[@]}"
}

# BindingBase <APIPath> <Args1> <Args2> -- "$@"
# Argsは必ずAPIのクエリと同じ文字列にしてください
# 例: BindingBase /notes/search query limit
BindingBase(){
    local _API="$1"
    shift 1

    # Parse args
    local i _APIArgs=("") _Args
    for i in "$@"; do
        shift 1 2> /dev/null || true
        if [[ "$i" = "--" ]]; then
            break
        else
            _APIArgs+=("$i")
        fi
    done

    # Msg.Debug "$_API has ${#_APIArgs[@]} args (${_APIArgs[*]})"

    #local i=0 _JsonKey _JsonValue
    #while true; do
    #    i="$(( i + 1 ))"
    #    _JsonKey="${_APIArgs[$((i-1))]-""}"
    #    _JsonValue=$(eval echo "\${${i}-""}" )
    #    if [[ -n "${_JsonKey-""}" ]]; then
    #        _Args+=("${_JsonKey}=$_JsonValue")
    #    fi
    #    shift 1 2> /dev/null || true
    #    if (( "$#" <= "$i" )) || [[ -z "${_APIArgs[$i]-""}" ]]; then
    #        break
    #    fi
    #done

    #echo "Run Args: $*"
    #echo "API Args: ${_APIArgs[*]}"

    local _Cnt _Shifted=false
    for ((_Cnt=1;_Cnt<="${#_APIArgs[@]} - 1" ;_Cnt++)); do
        _Args+=("${_APIArgs[$_Cnt]}=$(eval echo "\${${_Cnt}:-""}")")
        
        if [[ -z "$(eval echo "\${$((_Cnt+1)):-""}")" ]]; then
            shift "$_Cnt"
            _Shifted=true
            break
        fi
    done
    if ! Bool _Shifted; then
        _Shifted=true
        shift "$(( ${#_APIArgs[@]} - 1 ))"
    fi

    # MISSKEY_ENTRYが設定されていない場合
    if [[ -z "${MISSKEY_ENTRY-""}" ]]; then
        @Setup "${MISSKEY_DOMAIN}" "$MISSKEY_TOKEN"
    fi

    # ${_API#/} "#/"は前方最短一致で/を削除
    # ${MISSKEY_ENTRY%/} "%/"は後方最短一致で/を削除
    @SendReq "${MISSKEY_ENTRY%/}/${_API#/}" "${_Args[@]}" "$@"
}
