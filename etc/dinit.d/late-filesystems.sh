#!/bin/sh
. /etc/dinit.d/config/late-filesystems.conf
if [ "$1" != "stop" ]; then
    if [ ! -z "$LATE_FILESYSTEMS" ]; then
        mount -at "$LATE_FILESYSTEMS"
    fi
else
    if [ ! -z "$LATE_FILESYSTEMS" ]; then
        umount -aft "$LATE_FILESYSTEMS"
        ret=$?
        [ $ret -ne 0 ] && umount -aflt "$LATE_FILESYSTEMS"
        umount -aflt "$LATE_FILESYSTEMS"
    fi
fi
