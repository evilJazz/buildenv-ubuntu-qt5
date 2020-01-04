#!/bin/bash -x
SCRIPT_FILENAME="`cd \`dirname \"$0\"\`; pwd`/`basename \"$0\"`"
SCRIPT_ROOT=$(dirname "$SCRIPT_FILENAME")
set -e

DOCKER_ADDITIONAL_PARAMS=""
[ -t 1 ] && DOCKER_ADDITIONAL_PARAMS="-i"

if [ -f "$SCRIPT_ROOT/.env" ]; then
    source "$SCRIPT_ROOT/.env"
else
    IMAGE_NAME=$(basename "$SCRIPT_ROOT")
fi

if [ "$1" == "--help" ]; then
    echo "Usage: $0 [work directory] [command to run] [args..]"
    exit 1
fi

if [ -n "$1" ]; then
    [ ! -d "$1" ] && echo "Directory $1 does not exist. Exiting." && exit 1
    WORK_DIR="$1"
    shift 1
else
    WORK_DIR="$PWD"
fi

WORK_DIR=$(realpath "$WORK_DIR")
[ -z "$CONTAINER_WORK_DIR" ] && CONTAINER_WORK_DIR=/workdir

cd "$SCRIPT_ROOT"

if [ -n "$(declare -f -F buildImage)" ]; then
    buildImage
else
    docker build -t "$IMAGE_NAME" docker
fi

eval docker run --rm $DOCKER_ADDITIONAL_PARAMS -t \
    --volume "${IMAGE_NAME}-home-buildenv:/home/buildenv" \
    --volume "$WORK_DIR:$CONTAINER_WORK_DIR" \
    "$IMAGE_NAME" \
    --uid "$(id -u)" --gid "$(id -g)" --workdir "$CONTAINER_WORK_DIR" "$@"
