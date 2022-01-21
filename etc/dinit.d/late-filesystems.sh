#!/bin/sh
. /etc/dinit.d/config/late-filesystems.conf
if [ ! -z "$LATE_FILESYSTEMS" ]; then
    mount -a -t "$LATE_FILESYSTEMS"
fi
