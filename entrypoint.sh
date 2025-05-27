#!/bin/ash
cd /home/container

MODIFIED_STARTUP=$(eval echo "$STARTUP")
echo ":/home/container$ $MODIFIED_STARTUP"

exec $MODIFIED_STARTUP
