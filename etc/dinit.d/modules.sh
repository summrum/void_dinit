#!/bin/sh
# code from Void Runit
export PATH=/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin

for f in $(kmod static-nodes 2>/dev/null|awk '/Module/ {print $2}'); do
	modprobe -bq $f 2>/dev/null
done

# Detect LXC containers
[ ! -e /proc/self/environ ] && return
if grep -q lxc /proc/self/environ >/dev/null; then
    export VIRTUALIZATION=1
fi

[ -n "$VIRTUALIZATION" ] && return 0
# Do not try to load modules if kernel does not support them.
[ ! -e /proc/modules ] && return 0

echo "Loading kernel modules..."
/etc/dinit.d/modules-load.sh -v | tr '\n' ' ' | sed 's:insmod [^ ]*/::g; s:\.ko\(\.gz\)\? ::g'
echo
