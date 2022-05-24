#!/usr/bin/env bash





Includes(){
    PrintEvalArray "$1" | grep -qx "$2"
}
