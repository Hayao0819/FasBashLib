#!/usr/bin/env bash
# shellcheck disable=SC2154

# shellcheck source=/dev/null
MainDir="$(cd "$(dirname "${0}")/" || exit 1 ; pwd)"
source "$MainDir/lib/Common.sh"

CATEGORY="${1-""}" COMMAND="${2-""}"

shift 2 || :

RunScript(){
    bash "$@"
}

case "${CATEGORY,,}" in
    build)
        case "${COMMAND,,}" in
            docs)
                RunScript "$BinDir/Build-Docs.sh" "$@"
                ;;
            multi)
                RunScript "$BinDir/Build-Multi.sh" "$@"
                ;;
            run)
                RunScript "$BinDir/Build-Run.sh" "$@"
                ;;
            single)
                RunScript "$BinDir/Build-Single.sh" "$@"
                ;;
        esac
        ;;
    check)
        case "${COMMAND,,}" in
            bin)
                RunScript "$BinDir/Check-Bin.sh" "$@"
                ;;
            lib)
                RunScript "$BinDir/Check-Lib" "$@"
                ;;
        esac
        ;;
    list)
        case "${COMMAND,,}" in
            lib)
                RunScript "${BinDir}/List.sh" -q "$@"
                ;;
            function | func)
                RunScript "${LibDir}/GetFuncList.sh" "$@"
                ;;
            file)
                RunScript "${LibDir}/GetFileList.sh" "$@"
                ;;
            full)
                RunScript "${BinDir}/List.sh" "$@"
                ;;
            test-todo)
                RunScript "${BinDir}/Test-NotFoundList.sh" "$@"
        esac
        ;;
    release)
        case "${COMMAND,,}" in
            link)
                RunScript "${BinDir}/Release-Link.sh" "$@"
                ;;
            note)
                RunScript "$BinDir/Release-Note.sh" "$@"
                ;;
        esac
        ;;
    test)
        case "${COMMAND,,}" in
            add)
                RunScript "${BinDir}/Test-Add.sh" "$@"
                ;;
            make | create)
                RunScript "$BinDir/Test-CreateResult.sh" "$@"
                ;;
            try | test-run)
                RunScript "$BinDir/Test-CreateResult.sh" -r "$@"
                ;;
            docker)
                RunScript "${BinDir}/Test-Docker.sh" "$@"
                ;;
            legacy)
                RunScript "${BinDir}/Test-LegacyList.sh" "$@"
                ;;
            todo | notfound)
                RunScript "${BinDir}/Test-NotFoundList.sh" "$@"
                ;;
            clean | removeempty)
                RunScript "${BinDir}/Test-RemoveEmpty.sh" "$@"
                ;;
            run)
                RunScript "${BinDir}/Test-Run.sh" "$@"
                ;;
        esac
        ;;
esac
