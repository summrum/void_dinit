#!/bin/sh
# code from Artix Dinit and Void Runit
mountpoint -q /proc || mount -o nosuid,noexec,nodev -t proc proc /proc
mountpoint -q /sys || mount -o nosuid,noexec,nodev -t sysfs sys /sys
mountpoint -q /sys/kernel/security || mount -n -t securityfs securityfs /sys/kernel/security
[ -d /sys/firmware/efi ] && (mountpoint -q /sys/firmware/efi/efivars || mount -n -t efivarfs -o ro efivarfs /sys/firmware/efi/efivars)
mountpoint -q /dev || mount -o mode=0755,nosuid -t devtmpfs dev /dev

# seed /dev with some things that might be needed (for example,
# xudev doesn't do this compared to eudev), code from OpenRC

# creating /dev/console, /dev/tty and /dev/tty1 to be able to write
# to $CONSOLE with/without bootsplash before udevd creates it
[ -c /dev/console ] || mknod -m 600 /dev/console c 5 1
[ -c /dev/tty1 ]    || mknod -m 620 /dev/tty1 c 4 1
[ -c /dev/tty ]     || mknod -m 666 /dev/tty c 5 0

# udevd will dup its stdin/stdout/stderr to /dev/null
# and we do not want a file which gets buffered in ram
[ -c /dev/null ] || mknod -m 666 /dev/null c 1 3

# so udev can add its start-message to dmesg
[ -c /dev/kmsg ] || mknod -m 660 /dev/kmsg c 1 11

# extra symbolic links not provided by default
[ -e /dev/fd ]     || ln -snf /proc/self/fd /dev/fd
[ -e /dev/stdin ]  || ln -snf /proc/self/fd/0 /dev/stdin
[ -e /dev/stdout ] || ln -snf /proc/self/fd/1 /dev/stdout
[ -e /dev/stderr ] || ln -snf /proc/self/fd/2 /dev/stderr
[ -e /proc/kcore ] && ln -snf /proc/kcore /dev/core

mkdir -p /dev/pts /dev/shm
mountpoint -q /dev/pts || mount -o mode=0620,gid=5,nosuid,noexec -n -t devpts devpts /dev/pts
mountpoint -q /dev/shm || mount -o mode=1777,nosuid,nodev -n -t tmpfs shm /dev/shm
mountpoint -q /run || mount -o mode=0755,nosuid,nodev -t tmpfs run /run
mkdir -p /run/dinit

# Code from Void Runit
[ -r /etc/rc.conf ] && . /etc/rc.conf

# Detect LXC containers
[ ! -e /proc/self/environ ] && return
if grep -q lxc /proc/self/environ >/dev/null; then
    export VIRTUALIZATION=1
fi

if [ -z "$VIRTUALIZATION" ]; then
    _cgroupv1=""
    _cgroupv2=""

    case "${CGROUP_MODE:-hybrid}" in
        legacy)
            _cgroupv1="/sys/fs/cgroup"
            ;;
        hybrid)
            _cgroupv1="/sys/fs/cgroup"
            _cgroupv2="${_cgroupv1}/unified"
            ;;
        unified)
            _cgroupv2="/sys/fs/cgroup"
            ;;
    esac

    # cgroup v1
    if [ -n "$_cgroupv1" ]; then
        mountpoint -q "$_cgroupv1" || mount -o mode=0755 -t tmpfs cgroup "$_cgroupv1"
        while read -r _subsys_name _hierarchy _num_cgroups _enabled; do
            [ "$_enabled" = "1" ] || continue
            _controller="${_cgroupv1}/${_subsys_name}"
            mkdir -p "$_controller"
            mountpoint -q "$_controller" || mount -t cgroup -o "$_subsys_name" cgroup "$_controller"
        done < /proc/cgroups
    fi

    # cgroup v2
    if [ -n "$_cgroupv2" ]; then
        mkdir -p "$_cgroupv2"
        mountpoint -q "$_cgroupv2" || mount -t cgroup2 -o nsdelegate cgroup2 "$_cgroupv2"
    fi
fi
