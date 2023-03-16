#!/bin/sh
. /etc/dinit.d/config/late-filesystems.conf

case "$1" in
    start)
		if [ -n "$LATE_FILESYSTEMS" ]; then
		    mount -a -t "$LATE_FILESYSTEMS"
		fi
		;;
	stop)
		if [ -n "$LATE_FILESYSTEMS" ]; then
		    umount -a -f -t "$LATE_FILESYSTEMS"
		    sleep 1s
		    ret=$?
		    if [ "$ret" -ne "0" ]; then
		    	umount -a -f -l -t "$LATE_FILESYSTEMS"
		    	sleep 1s
		    	exit 0
		    else
		    	exit 0
		    fi
		fi
		;;
esac