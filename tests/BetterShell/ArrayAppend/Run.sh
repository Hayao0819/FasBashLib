# shellcheck disable=SC2148,SC2034

Puella_Magi_Holy_Quintet=("Madoka" "Sayaka" "Homura" "Mami" "Kyouko")

ArrayAppend "Puella_Magi_Holy_Quintet"  < <(PrintArray "Iroha" "Kanagi" "Snaa")
PrintEvalArray Puella_Magi_Holy_Quintet
