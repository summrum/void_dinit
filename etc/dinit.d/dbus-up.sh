#!/bin/sh
while ! pidof dbus-daemon >/dev/null; do
echo "Waiting for dbus-daemon"
sleep 0.1
done
echo "dbus-daemon running"
exit 0