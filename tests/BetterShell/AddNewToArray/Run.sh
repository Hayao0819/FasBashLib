#!/usr/bin/env bash
# shellcheck disable=SC2034

Puella_Magi_Holy_Quintet=("Madoka" "Sayaka" "Homura" "Mami" "Kyouko")

# 重複して追加しない
AddNewToArray "Puella_Magi_Holy_Quintet" "Madoka" 
PrintEvalArray Puella_Magi_Holy_Quintet

# 区切り
echo "====="

# 新しい項目を追加
AddNewToArray "Puella_Magi_Holy_Quintet" "Nagisa"
PrintEvalArray Puella_Magi_Holy_Quintet
