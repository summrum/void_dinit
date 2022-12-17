#!/bin/sh
. /etc/dinit.d/config/late-filesystems.conf

case "$1" in
    start)
		if [ ! -z "$LATE_FILESYSTEMS" ]; then
		    mount -a -t "$LATE_FILESYSTEMS"
		fi
		;;
	stop)
		if [ ! -z "$LATE_FILESYSTEMS" ]; then
		    umount -a -f -t "$LATE_FILESYSTEMS"
		    ret=$?
		    [ $ret -ne 0 ] && umount -a -f -l -t "$LATE_FILESYSTEMS"
		    sleep 1s
		    exit 0
		fi
		;;
esac