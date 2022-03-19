# shellcheck disable=SC2148,SC2034

function my_func(){
    echo "Hello World"
    return 0
}

for f in "my_func" "undefined_func"; do
    if CheckFuncDefined "$f"; then
        echo "$f is defined."
    else
        echo "$f is undefined."
    fi
done
