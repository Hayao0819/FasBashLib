#!/usr/bin/env bash
# shellcheck disable=SC2034

Puella_Magi_Holy_Quintet=("Madoka" "Sayaka" "Homura" "Mami" "Kyouko")

PrintArray "Iroha" "Kanagi" "Snaa" | ArrayAppend "Puella_Magi_Holy_Quintet" 
PrintEvalArray Puella_Magi_Holy_Quintet
