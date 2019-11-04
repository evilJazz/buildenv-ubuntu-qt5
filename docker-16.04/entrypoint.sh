#!/bin/bash
set -e

# Temporarily reset PATH
OLD_PATH=$PATH
PATH=/usr/sbin:/usr/bin:/sbin:/bin

# Map current user and group to user/group buildenv in container
CONTAINER_USERNAME="buildenv"
CONTAINER_GROUPNAME="buildenv"
HOMEDIR="/home/${CONTAINER_USERNAME}"

GROUP_ID=1000
USER_ID=1000
CONTAINER_WORK_DIR=/workdir
[ "$1" == "--uid" ] && USER_ID="$2" && shift 2
[ "$1" == "--gid" ] && GROUP_ID="$2" && shift 2
[ "$1" == "--workdir" ] && CONTAINER_WORK_DIR="$2" && shift 2

groupadd -f -g $GROUP_ID $CONTAINER_GROUPNAME
useradd -u $USER_ID -g $CONTAINER_GROUPNAME --shell /bin/bash $CONTAINER_USERNAME
mkdir -p $HOMEDIR
chown -R $CONTAINER_USERNAME.$CONTAINER_GROUPNAME $HOMEDIR

PATH=$OLD_PATH

touch /.buildenv
[ -f "/startup.sh" ] && source /startup.sh

echo "Starting in $CONTAINER_WORK_DIR where your working directory is attached..."
cd "$CONTAINER_WORK_DIR"

if [ -n "$1" ]; then
    sudo -E -u $CONTAINER_USERNAME HOME=$HOMEDIR "$@"
else
    sudo -E -u $CONTAINER_USERNAME HOME=$HOMEDIR bash
fi
