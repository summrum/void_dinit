#!/bin/sh
if [ "$1" != "start" ]; then
    . /etc/dinit.d/config/late-filesystems.conf
    if [ ! -z "$LATE_FILESYSTEMS" ]; then
        umount -aflt "$LATE_FILESYSTEMS"
    fi
else
exit 0
fi


