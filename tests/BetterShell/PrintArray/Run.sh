# shellcheck disable=SC2148,SC2034


Array=(hoge fugo piyo hage)

PrintArray "${Array[@]}"

echo

PrintArray "Stirng 1" "String 2" "String 3"
