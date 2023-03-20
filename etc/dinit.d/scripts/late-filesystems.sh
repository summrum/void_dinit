#!/bin/sh
. /etc/dinit.d/config/late-filesystems.conf

case "$1" in
    start)
		if [ -n "$LATE_FILESYSTEMS" ]; then
		    mount -a -v -t "$LATE_FILESYSTEMS"
		fi
		;;
	stop)
		if [ -n "$LATE_FILESYSTEMS" ]; then
		    umount -a -fv -t "$LATE_FILESYSTEMS"
		    ret=$?
		    sleep 1s	    
		    if [ "$ret" -ne "0" ]; then
		    	umount -a -flv -t "$LATE_FILESYSTEMS" && sleep 1s
		    	exit 0
		    else
		    	exit 0
		    fi
		fi
		;;
esac