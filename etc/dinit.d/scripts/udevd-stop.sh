#!/bin/sh
# code from Void Runit
# Detect LXC containers
[ ! -e /proc/self/environ ] && return
if grep -q lxc /proc/self/environ >/dev/null; then
    export VIRTUALIZATION=1
fi
[ -n "$VIRTUALIZATION" ] && return 0
if [ -z "$VIRTUALIZATION" ]; then
    echo "Stopping udev..."
    udevadm control --exit
fi
