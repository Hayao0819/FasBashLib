# shellcheck disable=SC2148,SC2034

_CheckUUID(){
    IsUUID "$1" || { echo "It is not UUID"; return 0;}
    echo "It is UUID" && return 0
}

_CheckUUID "$(uuidgen)"
_CheckUUID "Normal String"
