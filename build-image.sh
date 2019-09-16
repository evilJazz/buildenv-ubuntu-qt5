#!/bin/bash -x
SCRIPT_FILENAME="`cd \`dirname \"$0\"\`; pwd`/`basename \"$0\"`"
SCRIPT_ROOT=$(dirname "$SCRIPT_FILENAME")

[ -z "$1" ] && IMAGE_NAME="buildenv-ubuntu-18.04-qt5" || IMAGE_NAME="$1"
[ -z "$2" ] && UBUNTU_VERSION="18.04" || UBUNTU_VERSION="$2"

docker build -t "$IMAGE_NAME" docker-${UBUNTU_VERSION}

