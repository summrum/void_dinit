#!/bin/sh
# code from Void Runit

if [ -d /usr/sbin -a ! -L /usr/sbin ]; then
	for f in /usr/sbin/*; do
		if [ -f $f -a ! -L $f ]; then
			echo "Detected $f file, can't create /usr/sbin symlink."
			return 0
		fi
	done
	echo "Creating /usr/sbin -> /usr/bin symlink, moving existing to /usr/sbin.old"
	mv /usr/sbin /usr/sbin.old
	ln -sf bin /usr/sbin
fi

if [ ! -e /var/log/wtmp ]; then
	install -m0664 -o root -g utmp /dev/null /var/log/wtmp
fi
if [ ! -e /var/log/btmp ]; then
	install -m0600 -o root -g utmp /dev/null /var/log/btmp
fi
install -dm1777 /tmp/.X11-unix /tmp/.ICE-unix
rm -f /etc/nologin /forcefsck /forcequotacheck /fastboot
