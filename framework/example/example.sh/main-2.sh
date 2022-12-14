#!/usr/bin/env bash

main(){
    echo "Hello FasBashFramework"
    cat <<EOF
example.sh is an example project.
It retrieves a function from an external script, translates a remote text file, and outputs it.
EOF
    readme 
    return 0
}
