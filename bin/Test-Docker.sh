#!/usr/bin/env bash
# shellcheck disable=SC1090,SC1091,SC2154

# shellcheck source=/dev/null
source "$(cd "$(dirname "${0}")/../" || exit 1 ; pwd)/lib/Common.sh"

RunCmd(){
    echo "Run: $*"
    "$@"
}

# Args
Image="$1"
shift 1 || exit 1

# Initilize
DockerName="fasbashlib-test"
DOCKER_BUILD_OPT=(-t "$DockerName:latest" -f "${DockerDir}/${Image}/Dockerfile" ".")
DOCKER_RUN_OPT=(--platform linux/amd64 --env "GROUP_ID=$(id -g)" --env "USER_ID=$(id -u)" -it "$DockerName:latest")

# Run
(
    cd "$MainDir" || exit 1
    pwd
    RunCmd docker build "${DOCKER_BUILD_OPT[@]}" 
    RunCmd exec docker run "${DOCKER_RUN_OPT[@]}" "$@"
)
