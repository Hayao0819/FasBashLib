#!/usr/bin/env bash
# @file Aur
# @brief AurのAPIを使用します
# @description
#    AurwebのAPIをcurlを使って呼び出し、必要な情報を取得します
#

for _JsonKey in "Description" "FirstSubmitted" "ID" "LastModified" "Maintainer" "NumVotes" "PackageBase" "PackageBaseID" "Popularity" "URL" "URLPath" "Version"; do
    eval "Get$_JsonKey(){ jq -r \".${_JsonKey}\";}"
done

for _JsonKey in "Depends" "Keywords" "License" "MakeDepends" "OptDepends"; do
    eval "Get$_JsonKey(){ jq -r \".${_JsonKey}[]\";}"
done

GetAurSearch(){
    local _Field="${1-"name-desc"}" _Keywords="$2" 
    curl -sL "https://aur.archlinux.org/rpc?v=5&type=search&by=$_Field&arg=${_Keywords}" | CheckAurJson
}

GetAurInfo(){
    local _Pkg="$1" _Json
    curl -sL "https://aur.archlinux.org/rpc?v=5&type=info&arg=${_Pkg}" | CheckAurJson
}

CheckAurJson(){
    local _ResultCount _Json _Type
    _Json="$(cat)"
    _ResultCount=$(jq -r ".resultcount" <<< "$_Json")
    _Type=$(jq -r ".type" <<< "$_Json")
    (( _ResultCount > 0 )) && [[ "$_Type" != "error" ]] && {
        jq -r ".results[]" <<< "$_Json"
        return 0
    }
    return 1
}

IsOutOfDated(){
    local _Status
    _Status=$(jq -r ".OutOfDate")
    case "$_Status" in
        "null")
            return 1
            ;;
        *)
            echo "$_Status"
            return 0
            ;;
    esac
}

AurInfoToBash(){
    local _Prefix="${AurPrefix-"{}"}" _Json
    local _ArrName _VarName

    _Json="$(cat)"

    # 配列
    for _JsonKey in "Depends" "Keywords" "License" "MakeDepends" "OptDepends"; do
        #shellcheck disable=SC2001
        _ArrName=$(sed "s|{}|$_JsonKey|g" <<< "$_Prefix")
        #echo "readarray -t '$_ArrName' < <(Get$_JsonKey <<< '$_Json')"
        echo "${_ArrName}=($(Get$_JsonKey <<< "$_Json" | sed "s|^|\"|g; s|$|\" |g" | tr -d "\n"))"
    done

    # 変数
    for _JsonKey in "Description" "FirstSubmitted" "ID" "LastModified" "Maintainer" "NumVotes" "PackageBase" "PackageBaseID" "Popularity" "URL" "URLPath" "Version"; do
        #shellcheck disable=SC2001
        _VarName=$(sed "s|{}|$_JsonKey|g" <<< "$_Prefix")
        echo "${_VarName}=\"$(Get$_JsonKey <<< "$_Json")\""
    done
}
