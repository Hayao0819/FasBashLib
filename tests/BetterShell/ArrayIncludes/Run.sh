# shellcheck disable=SC2148,SC2034

Puella_Magi_Holy_Quintet=("Madoka" "Sayaka" "Homura" "Mami" "Kyouko")

ArrayIncludes Puella_Magi_Holy_Quintet "Nagisa" || echo "$?"
ArrayIncludes Puella_Magi_Holy_Quintet "Sayaka" ;  echo "$?"
