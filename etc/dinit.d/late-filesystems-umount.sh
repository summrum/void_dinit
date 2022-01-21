#!/bin/sh
. /etc/dinit.d/config/late-filesystems.conf
if [ ! -z "$LATE_FILESYSTEMS" ]; then
    umount -a -f -t "$LATE_FILESYSTEMS"
    ret=$?
    [ $ret -ne 0 ] && umount -a -f -l -t "$LATE_FILESYSTEMS"
fi
