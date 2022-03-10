# shellcheck disable=SC2148,SC2034

Array=("Welcome" "to" "Bash" "World!")

PrintArray "${Array[@]}" | ForEach echo " | {}" 
