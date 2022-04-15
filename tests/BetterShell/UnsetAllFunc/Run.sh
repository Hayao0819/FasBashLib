# shellcheck disable=SC2148,SC2034

echo "==実行前=="
ForEach unset {} < <(GetFuncList | grep -vx "GetFuncList" | grep -xv "UnsetAllFunc")
function MyNewVerySuperPerfectFunction(){
    echo "I can do nothing."
    return 0
}
GetFuncList


UnsetAllFunc
echo "==実行後=="
typeset -F | cut -d " " -f 3
