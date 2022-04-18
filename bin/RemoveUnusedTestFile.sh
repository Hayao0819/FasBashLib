#!/usr/bin/env bash
# shellcheck disable=SC1090,SC1091

set -Eeu

# Directory
MainDir="$(cd "$(dirname "${0}")/../" || exit 1 ; pwd)"
TestDir="$MainDir/tests"


Remove(){
    echo "Remove $1" >&2
    rm -rf "$1"
}

# Remove empty file
while read -r File; do
    [[ -e "$File" ]] || continue
    # shellcheck disable=SC2143
    if [[ -z "$(grep -v "^$" "$File" | grep -v "^#")" ]]; then
        Remove "$File"
    fi
done < <(find "${TestDir}" -type f)

# Remove empty directory
while read -r Dir; do
    [[ -e "$Dir" ]] || continue
    # shellcheck disable=SC2143
    #if [[ -z "$(find "${Dir}")" ]] || [[ -z "$(find "$Dir" -type f | grep -v "Exit.txt")" ]]; then
    if [[ -z "$(find "${Dir}")" ]]; then
        Remove "$Dir"
    fi
done < <(find "${TestDir}" -type d)
