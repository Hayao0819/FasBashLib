#!/usr/bin/env bash
# shellcheck disable=SC1090

CurrentDir="$(cd "$(dirname "${0}")" || exit 1 ; pwd)"
SrcDir="$CurrentDir/src"
OutFile="${1-"${CurrentDir}/fasbashlib.sh"}"

for file in "${SrcDir}/"*".sh"; do
    echo "Load: $file"
    source "$file"
done

echo -e "#!/usr/bin/env bash\n# shellcheck disable=all" > "$OutFile"
typeset -f >> "$OutFile"
