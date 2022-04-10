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

# @internal
GetSearch(){
    local _Field="${1-"name-desc"}" _Keywords="$2" 
    curl -sL "https://aur.archlinux.org/rpc?v=5&type=search&by=$_Field&arg=${_Keywords}" | @CheckJson
}

# @internal
GetRawInfo(){
    curl -sL "https://aur.archlinux.org/rpc?v=5&type=info&arg=${1}"
}

# @internal
GetInfo(){
    GetRawAurInfo "$1" | @CheckJson
}

# @internal
CheckJson(){
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

IsPkgOutOfDated(){
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

InfoToBash(){
    local _Prefix="${AurPrefix-"{}"}" _Json
    local _ArrName _VarName

    _Json="$(cat)"

    # 配列
    for _JsonKey in "Depends" "Keywords" "License" "MakeDepends" "OptDepends"; do
        #shellcheck disable=SC2001
        _ArrName=$(sed "s|{}|$_JsonKey|g" <<< "$_Prefix")
        #echo "readarray -t '$_ArrName' < <(Get$_JsonKey <<< '$_Json')"
        echo "${_ArrName}=($(Aur.Get$_JsonKey <<< "$_Json" | sed "s|^|\"|g; s|$|\" |g" | tr -d "\n"))"
    done

    # 変数
    for _JsonKey in "Description" "FirstSubmitted" "ID" "LastModified" "Maintainer" "NumVotes" "PackageBase" "PackageBaseID" "Popularity" "URL" "URLPath" "Version"; do
        #shellcheck disable=SC2001
        _VarName=$(sed "s|{}|$_JsonKey|g" <<< "$_Prefix")
        echo "${_VarName}=\"$(Aur.Get$_JsonKey <<< "$_Json")\""
    done
}

GetAllDepends(){
    #local _Json
    #_Json="$(cat)"
    #GetAurMakeDepends <<< "$_Json"
    #GetAurDepends <<< "$_Json"
    jq -r ".Depends[], .MakeDepends[]"
}

GetRecursiveDepends(){
    local _Pkg 
    _Pkg="$(Pm.GetName <<< "$1")"
    _AurDependList=()

    # Installed package list
    # shellcheck disable=SC2034
    export FSBLIB_CACHEID="FasBashLib_Aur"
    ExistCache "InstalledPackage" || RunPacman -Qq | CreateCache "InstalledPackage" > /dev/null

    # Repository package list
    ExistCache "RepoPackage" || GetPacmanRepoPkgList | CreateCache "RepoPackage" > /dev/null

    # APIから情報を取得
    _Resolve(){
        # リポジトリパッケージかどうか確認
        GetCache "RepoPackage" | grep -qx "$1" && return 0

        #echo "Found AUR depend $1"
        while read -r _P; do
            ArrayIncludes _AurDependList "$_P" && continue
            GetCache "RepoPackage" | grep -qx "$_P" && continue
            #echo "Resolve $_P in $1"
            
            _AurDependList+=("$_P")    
            _Resolve "$_P"
        done < <(@GetInfo "$1" | @GetAllDepends | Pm.GetName)
    }
    _Resolve "$_Pkg"
    PrintEvalArray _AurDependList
}
