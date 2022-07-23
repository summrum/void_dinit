#!/bin/sh
# code from Void Runit

# Detect LXC containers
[ ! -e /proc/self/environ ] && return
if grep -q lxc /proc/self/environ >/dev/null; then
    export VIRTUALIZATION=1
fi
[ -n "$VIRTUALIZATION" ] && return 0

if [ "$1" != "start" ]; then
    if [ -z "$VIRTUALIZATION" ]; then
        echo "Stopping udev..."
        udevadm control --exit
    fi
else
    if [ -x /usr/lib/systemd/systemd-udevd ]; then
        _udevd=/usr/lib/systemd/systemd-udevd
    elif [ -x /sbin/udevd -o -x /bin/udevd ]; then
        _udevd=udevd
    else
        echo "cannot find udevd!"
    fi

    if [ -n "${_udevd}" ]; then
        echo "Starting udev and waiting for devices to settle..."
        ${_udevd} --daemon
    fi
fi
