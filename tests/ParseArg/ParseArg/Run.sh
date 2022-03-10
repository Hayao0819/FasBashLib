# shellcheck disable=SC2148,SC2034

ParseArg LONG="help,debug,version,option:" SHORT="h,d,v,o:" -- "--help" "-do" "String" "Hello World" 
printf "%s\n" "${OPTRET[@]}"
