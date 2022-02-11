#!/bin/sh
# Code from Void Runit
dbus-uuidgen --ensure
[ ! -d /run/dbus ] && install -m755 -g 22 -o 22 -d /run/dbus
exit 0
