#!/bin/sh
set -e
[ -r /etc/locale.conf ] && . /etc/locale.conf && export LANG
if [ ! -d /run/dbus ]; then
mkdir -p /var/lib/sddm
chown -R sddm:sddm /var/lib/sddm
fi
exec sddm
