# shellcheck disable=SC2148,SC2034

Sum 20 40 49 448 248 284 34 3278674 3774

value=28973

Sum value 200


value=0
while read -r Num; do
    value=$(Sum value Num)
    echo "$value"
done < <(seq 1 100)
