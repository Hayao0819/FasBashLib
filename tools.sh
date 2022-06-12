#!/usr/bin/env bash
# shellcheck disable=SC2154

# shellcheck source=/dev/null
MainDir="$(cd "$(dirname "${0}")/" || exit 1 ; pwd)"
source "$MainDir/lib/Common.sh"

# スクリプトが実行されたかどうか
SCRIPT_RUN=false

RunScript(){
    local s _ShellArgs=()
    for s in "x" "v"; do
        echo "$-" | grep -o . | grep -qx "$s" && _ShellArgs+=("-$s")
    done
    SCRIPT_RUN=true
    bash "${_ShellArgs[@]}" "$@" || return "$?"
}

HelpDoc(){
    echo "FasBashLib Management Tools"
    echo
    echo " Build Commands:"
    echo "    docs       Build document"
    echo "    multi      Build multi-files library"
    echo "    run        Run funtion"
    echo "    single     Build single-file library"
    echo
}

Main(){
    local _CAT="${1-""}" _CMD="${2-""}"
    shift 2 || true
    case "${_CAT,,}" in
        build | b*)
            case "${_CMD,,}" in
                docs | d*)
                    RunScript "$BinDir/Build-Docs.sh" "$@"
                    ;;
                multi | m*)
                    RunScript "$BinDir/Build-Multi.sh" "$@"
                    ;;
                run | r*)
                    RunScript "$BinDir/Build-Run.sh" "$@"
                    ;;
                single | s*)
                    RunScript "$BinDir/Build-Single.sh" "$@"
                    ;;
                all | a*)
                    (
                        cd "$MainDir"
                        make
                    )
                    ;;
            esac
            ;;
        check | c*)
            case "${_CMD,,}" in
                bin | b*)
                    RunScript "$BinDir/Check-Bin.sh" "$@"
                    ;;
                lib | l*)
                    RunScript "$BinDir/Check-Lib" "$@"
                    ;;
            esac
            ;;
        list | l*)
            case "${_CMD,,}" in
                lib | l*)
                    RunScript "${BinDir}/List.sh" -q "$@"
                    ;;
                function | func | fn)
                    RunScript "${LibDir}/GetFuncList.sh" "$@"
                    ;;
                file)
                    RunScript "${LibDir}/GetFileList.sh" "$@"
                    ;;
                full | all)
                    RunScript "${BinDir}/List.sh" "$@"
                    ;;
                test-todo | todo | t*)
                    RunScript "${BinDir}/Test-NotFoundList.sh" "$@"
                    ;;
            esac
            ;;
        release | r*)
            case "${_CMD,,}" in
                link | l*)
                    RunScript "${BinDir}/Release-Link.sh" "$@"
                    ;;
                note | n*)
                    RunScript "$BinDir/Release-Note.sh" "$@"
                    ;;
            esac
            ;;
        test | t*)
            case "${_CMD,,}" in
                add | a*)
                    RunScript "${BinDir}/Test-Add.sh" "$@"
                    ;;
                make | create | m*)
                    RunScript "$BinDir/Test-CreateResult.sh" "$@"
                    ;;
                try | test-run)
                    RunScript "$BinDir/Test-CreateResult.sh" -r "$@"
                    ;;
                docker | d*)
                    RunScript "${BinDir}/Test-Docker.sh" "$@"
                    ;;
                legacy | l*)
                    RunScript "${BinDir}/Test-LegacyList.sh" "$@"
                    ;;
                todo | notfound | n*)
                    RunScript "${BinDir}/Test-NotFoundList.sh" "$@"
                    ;;
                clean | removeempty | c* | rm)
                    RunScript "${BinDir}/Test-RemoveEmpty.sh" "$@"
                    ;;
                run | r*)
                    RunScript "${BinDir}/Test-Run.sh" "$@"
                    ;;
            esac
            ;;
    esac || return 1

    if [[ "$SCRIPT_RUN" = false ]]; then
        echo "There is nothing to do." >&2
        return 1
    fi
    SCRIPT_RUN=false
    return 0
}

if (( $# < 2 )); then
    Prompt="$(echo -e "\e[1mFsbLib > \e[m")"
    echo "インタラクティブモード(Beta)"
    while true; do
        IFS=" " read -p "$Prompt" -r -e -a  Args
        case "${Args[0]}" in
            "clear")
                clear
                continue
                ;;
            "shell" | "sh")
                "${Args[@]:1}"
                continue
                ;;
            "" | exit)
                exit
                ;;
        esac
        Main "${Args[@]}" || true
    done
else
    Main "$@" || exit "$?"
    exit 0
fi
