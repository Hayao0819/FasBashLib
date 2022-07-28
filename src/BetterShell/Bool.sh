#!/usr/bin/env bash

Bool(){
    case "$(RemoveBlank <<< "$(ToLower "$1")")" in
        "true")
            return 0
            ;;
        "false")
            return 1
            ;;
    esac
    case "$(ToLower "$(PrintEval "${1}")")" in
        "true")
            return 0
            ;;
        "" | "false")
            return 1
            ;;
        *)
            return 2
            ;;
    esac
}
