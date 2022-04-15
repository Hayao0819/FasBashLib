# shellcheck disable=SC2148,SC2034

DefinedFunc(){
    true
}

if CheckFuncDefined DefinedFunc; then
    echo "Function is defined"
else
    echo "Function is not defined"
fi

if CheckFuncDefined NoExistFunc; then
    echo "Function is defined"
else
    echo "Function is not defined"
fi
