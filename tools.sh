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
    echo " tools.sh TYPE COMMAND [Arguments]"
    echo
    echo " Types:"
    echo "    build, check, list, release, test, help"
    echo
    echo " build Commands:"
    echo "    docs            Build document"
    echo "    multi           Build multi-files library"
    echo "    run             Run funtion"
    echo "    single          Build single-file library"
    echo "    all             Build all files"
    echo "    zip | archive   Build multi file and compress"
    echo "    info | json     Build a JSON that has information about library"
    echo
    echo " check Commands:"
    echo "    bin             Run shellcheck for management scripts"
    echo "    lib             Run static tests with shellcheck and  FasBashLib's own"
    echo
    echo " list Commands:"
    echo "    lib             Library list"
    echo "    function | fn   Function list in library"
    echo "    file            File list in library"
    echo "    full | all      Full library list with description and other meta info"
    echo "    test-todo       List of functions missing test file"
    echo
    echo " release Commands:"
    echo "    link | ln       Get script URL from GitHub with API"
    echo "    list            List of past releases"
    echo "    note            Make release note markdown"
    echo 
    echo " test Commands:"
    echo "    add             Add new files for test"
    echo "    create | make   Create \"Result.txt\" by running \"Run.sh\""
    echo "    try             Execute \"Run.sh\" without any updating"
    echo "    docker          Run tests in Docker (Alpha unstable)"
    echo "    legacy          Get library list that has old test file"
    echo "    todo            List of functions missing test file"
    echo "    clean           Remove empty test file"
    echo "    rm              Remove junk file that is not used from any scripts"
    echo "    run             Run test"
    echo "    junk            List of junk file"
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
                info | json | j* | i*)
                    RunScript "${BinDir}/Build-Info.sh" "$@"
                    ;;
                all)
                    SCRIPT_RUN=true
                    (
                        cd "$MainDir"
                        make
                    )
                    ;;
                zip | z* | archive)
                    RunScript "$BinDir/Build-Zip.sh" "$@"
                    ;;
            esac
            ;;
        check | c*)
            case "${_CMD,,}" in
                bin | b*)
                    RunScript "$BinDir/Check-Bin.sh" "$@"
                    ;;
                lib | l*)
                    RunScript "$BinDir/Check-Lib.sh" "$@"
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
                link | ln)
                    RunScript "${BinDir}/Release-Link.sh" "$@"
                    ;;
                list)
                    RunScript "$BinDir/Release-List.sh" "$@"
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
                clean | removeempty | c*)
                    RunScript "${BinDir}/Test-RemoveEmpty.sh" "$@"
                    ;;
                rm)
                    RunScript "$BinDir/Test-RemoveJunk.sh" "$@"
                    ;;
                run | r*)
                    RunScript "${BinDir}/Test-Run.sh" "$@"
                    ;;
                junk | j*)
                    RunScript "${BinDir}/Test-Junk.sh" "$@"
                    ;;
            esac
            ;;
        "help")
            HelpDoc
            SCRIPT_RUN=true
            ;;
    esac || return 1

    if [[ "$SCRIPT_RUN" = false ]]; then
        echo "There is nothing to do." >&2
        return 1
    fi
    SCRIPT_RUN=false
    return 0
}

if (( $# < 1 )); then
    Prompt="$(echo -e "\e[1mFsbLib > \e[m")"
    echo "インタラクティブモード(Beta)"
    while true; do
        IFS=" " read -p "$Prompt" -r -e -a  Args
        case "${Args[0]-""}" in
            "clear")
                clear
                continue
                ;;
            "shell" | "sh")
                "${Args[@]:1}"
                continue
                ;;
            "help")
                HelpDoc
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
