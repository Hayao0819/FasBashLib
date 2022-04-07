#!/usr/bin/env bash

UnsetAllFunc(){
    ForEach unset "{}" < <(declare -F | cut -d " " -f 3)
}
