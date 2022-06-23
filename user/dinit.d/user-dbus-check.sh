#!/bin/sh
while ! pgrep -G $(id -g "$USER") -x "dbus-daemon" >/dev/null; do
echo "Waiting for user dbus daemon"
sleep 0.1
done
echo "user dbus daemon running"
exit 0