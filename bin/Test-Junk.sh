#!/usr/bin/env bash
# shellcheck disable=SC1090,SC1091,SC2154

# shellcheck source=/dev/null
source "$(cd "$(dirname "${0}")/../" || exit 1 ; pwd)/lib/Common.sh"

TestFiles=(
    Run.sh
    Result.txt
    Exit.txt
)

FoundJunkFineCount=0

while read -r Lib; do
    readarray -t LibFuncList < <(GetLibFuncList -noprefix "$Lib")
    [[ -e "$TestsDir/$Lib" ]] || continue
    readarray -t TestedFuncList < <(find "$TestsDir/$Lib" -type d -mindepth 1 -maxdepth 1 | GetBaseName)

    #echo "${TestedFuncList[@]}"

    # 存在しない関数
    for Func in "${TestedFuncList[@]}";do
        if ! PrintArray "${LibFuncList[@]}" | grep -qx "$Func"; then
            find "${TestsDir}/$Lib/$Func/" -type f -mindepth 1 -maxdepth 1
        fi
    done

    # 関数内の不要なファイル
    for Func in "${TestedFuncList[@]}"; do
        # Lib/Func直下のファイルを調査
        readarray -t FileList < <(find "$TestsDir/$Lib/$Func" -type f -mindepth 1 -maxdepth 1 | GetBaseName)
        readarray -t DirList < <(find "$TestsDir/$Lib/$Func" -type d -mindepth 1 -maxdepth 1 | GetBaseName)
        Result=("${FileList[@]}")
        for File in "${TestFiles[@]}"; do
            readarray -t Result < <( PrintArray "${Result[@]}" | grep -xv "${File}")
        done
        PrintArray "${Result[@]}" | sed "s|^|$TestsDir/$Lib/$Func/|g"
        FoundJunkFineCount=$(( FoundJunkFineCount + ${#Result[@]} ))
        Result=()

        # Lib/Func以下のサブディレクトリを調査
        for Dir in "${DirList[@]}"; do
            readarray -t FileList < <(find "$TestsDir/$Lib/$Func/$Dir" -type f -mindepth 1 -maxdepth 1 | GetBaseName)
            Result=("${FileList[@]}")
            for File in "${TestFiles[@]}"; do
                readarray -t Result < <( PrintArray "${Result[@]}" | grep -xv "${File}")
            done
            PrintArray "${Result[@]}" | sed "s|^|$TestsDir/$Lib/$Func/$Dir/|g"
            FoundJunkFineCount=$(( FoundJunkFineCount + ${#Result[@]} ))
            Result=()
        done
        FileList=() DirList=()
    done

    TestedFuncList=() LibFuncList=()
done < <(GetLibList)


if (( FoundJunkFineCount != 0 ));then
    echo "Found ${FoundJunkFineCount} junk files" >&2
    exit 1
fi
exit 0

