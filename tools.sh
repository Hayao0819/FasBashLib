#!/usr/bin/env bash
# shellcheck disable=SC2154

# shellcheck source=/dev/null
MainDir="$(cd "$(dirname "${0}")/" || exit 1 ; pwd)"
source "$MainDir/lib/Common.sh"

CATEGORY="${1-""}" COMMAND="${2-""}"

shift 2 || :

# スクリプトが実行されたかどうか
SCRIPT_RUN=false

RunScript(){
    local s _ShellArgs=()
    for s in "x" "v"; do
        echo "$-" | grep -o . | grep -qx "$s" && _ShellArgs+=("-$s")
    done
    bash "${_ShellArgs[@]}" "$@" || exit "$?"
    SCRIPT_RUN=true
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

case "${CATEGORY,,}" in
    build | b*)
        case "${COMMAND,,}" in
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
        esac
        ;;
    check | c*)
        case "${COMMAND,,}" in
            bin | b*)
                RunScript "$BinDir/Check-Bin.sh" "$@"
                ;;
            lib | l*)
                RunScript "$BinDir/Check-Lib" "$@"
                ;;
        esac
        ;;
    list | l*)
        case "${COMMAND,,}" in
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
        case "${COMMAND,,}" in
            link | l*)
                RunScript "${BinDir}/Release-Link.sh" "$@"
                ;;
            note | n*)
                RunScript "$BinDir/Release-Note.sh" "$@"
                ;;
        esac
        ;;
    test | t*)
        case "${COMMAND,,}" in
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
esac

if [[ "$SCRIPT_RUN" = false ]]; then
    echo "There is nothing to do." >&2
    exit 1
fi
exit 0
