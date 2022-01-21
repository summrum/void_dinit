#!/bin/sh
set -e
# sleep avoids unreliable dbus-send due to race condition
sleep 0.1s
if [ -x /usr/bin/elogind-inhibit ]; then
        dbus-send --system --print-reply --dest=org.freedesktop.DBus \
                /org/freedesktop/DBus                           \
                org.freedesktop.DBus.StartServiceByName         \
                string:org.freedesktop.login1 uint32:0
fi
[ -r /etc/locale.conf ] && . /etc/locale.conf && export LANG
if [ ! -d /run/dbus ]; then
mkdir -p /var/lib/sddm
chown -R sddm:sddm /var/lib/sddm
fi
exec sddm
