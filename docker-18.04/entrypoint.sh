#!/bin/bash
set -e

# Map current user and group to user/group buildenv in container
CONTAINER_USERNAME="buildenv"
CONTAINER_GROUPNAME="buildenv"
HOMEDIR="/home/${CONTAINER_USERNAME}"

GROUP_ID=1000
USER_ID=1000
[ "$1" == "--uid" ] && USER_ID="$2" && shift 2
[ "$1" == "--gid" ] && GROUP_ID="$2" && shift 2

groupadd -f -g $GROUP_ID $CONTAINER_GROUPNAME
useradd -u $USER_ID -g $CONTAINER_GROUPNAME --shell /bin/bash $CONTAINER_USERNAME
mkdir --parent $HOMEDIR
chown -R $CONTAINER_USERNAME:$CONTAINER_GROUPNAME $HOMEDIR

[ -f "/startup.sh" ] && source /startup.sh

echo "Starting in /workdir where your working directory is attached..."
cd /workdir

if [ -n "$1" ]; then
    sudo -u $CONTAINER_USERNAME HOME=$HOMEDIR "$@"
else
    sudo -u $CONTAINER_USERNAME HOME=$HOMEDIR bash
fi
