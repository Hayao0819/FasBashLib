# shellcheck disable=SC2148,SC2034

Variable=true

if Bool Variable; then
    echo "Variable = true"
else
    echo "Variable = false"
fi

Variable=false

if Bool Variable; then
    echo "Variable = true"
else
    echo "Variable = false"
fi
