#!/bin/sh
# LibreTranslate API wrapper for shell script
# Author : Yamada Hayao (@Hayao0819)
# License: WTFPL

# LIBRETRANSLATE_URL is the URL of the LibreTranslate instance to use
# LIBRETRANSLATE_API_KEY is the API key to use

Check(){
    export LIBRETRANSLATE_URL="${LIBRETRANSLATE_URL:-""}"
    export LIBRETRANSLATE_APIKEY="${LIBRETRANSLATE_APIKEY:-""}"

    if [ -z "$LIBRETRANSLATE_URL" ]; then
        echo "LIBRETRANSLATE_URL is not set"
        return 1
    fi
    if which jq >/dev/null; then
        return 0
    else
        echo "jq is not installed"
        return 1
    fi
    if which curl >/dev/null; then
        return 0
    else
        echo "curl is not installed"
        return 1
    fi
    return 0
}
Detect(){
    @Check || return 2
    __libre_translate_return="$(curl -s "${LIBRETRANSLATE_URL}/detect" -X POST -d "q=${1:-""}&api_key=${LIBRETRANSLATE_APIKEY:-""}")"
    if [ "$(echo "${__libre_translate_return}" | jq -r '.[].error')" = "null" ]; then
        echo "${__libre_translate_return}" | jq -r '.[].language'
        return 0
    else
        echo "${__libre_translate_return}" | jq -r '.error'
        return 1
    fi
}
Languages(){
    @Check || return 2
    curl -s "${LIBRETRANSLATE_URL}/languages" | jq -r '.[].code'
}

# libre_translate_translate <text> <source language> <target language>
Translate(){
    @Check || return 2
    __libre_translate_return="$(curl -s "$LIBRETRANSLATE_URL/translate" -X POST -d "q=${1:-""}&source=${2:-""}&target=${3:-""}&api_key=${LIBRETRANSLATE_APIKEY:-""}")"
    if [ "$(echo "${__libre_translate_return}" | jq -r '.error')" = "null" ]; then
        echo "${__libre_translate_return}" | jq -r '.translatedText'
        return 0
    else
        echo "${__libre_translate_return}" | jq -r '.error'
        return 1
    fi
}

# libre_translate_translate <text> <target language>
TranslateAuto(){
    @Check || return 2
    @Translate "${1:-""}" "$(@Detect "${1:-""}")" "${2:-""}"
}

