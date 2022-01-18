#!/bin/sh
dbus-uuidgen --ensure
[ ! -d /run/dbus ] && install -m755 -g 22 -o 22 -d /run/dbus
