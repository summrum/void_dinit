#!/bin/sh
# Detect LXC (and other) containers
[ -z "${container+x}" ] || export VIRTUALIZATION=1
[ -n "$VIRTUALIZATION" ] && return 0

echo "Remounting rootfs read-only"
mount -o remount,ro / || emergency_shell

if [ -x /sbin/dmraid -o -x /bin/dmraid ]; then
    echo "Activating dmraid devices"
    dmraid -i -ay
fi

if [ -x /bin/mdadm ]; then
    msg "Activating software RAID arrays..."
    mdadm -As
fi

if [ -x /bin/btrfs ]; then
    echo "Activating btrfs devices"
    btrfs device scan || emergency_shell
fi

if [ -x /sbin/vgchange -o -x /bin/vgchange ]; then
    echo "Activating LVM devices"
    vgchange --sysinit -a ay || emergency_shell
fi

if [ -e /etc/crypttab ]; then
    echo "Activating encrypted devices"
    awk -f /etc/runit/crypt.awk /etc/crypttab

    if [ -x /sbin/vgchange -o -x /bin/vgchange ]; then
        echo "Activating LVM devices for dm-crypt"
        vgchange --sysinit -a ay || emergency_shell
    fi
fi

if [ -x /usr/bin/zpool -a -x /usr/bin/zfs ]; then
    if [ -e /etc/zfs/zpool.cache ]; then
        echo "Importing cached ZFS pools"
        zpool import -N -a -c /etc/zfs/zpool.cache
    else
        echo "Scanning for and importing ZFS pools"
        zpool import -N -a -o cachefile=none
    fi

    echo "Mounting ZFS file systems"
    zfs mount -a -l

    echo "Sharing ZFS file systems"
    zfs share -a

    # NOTE(dh): ZFS has ZVOLs, block devices on top of storage pools.
    # In theory, it would be possible to use these as devices in
    # dmraid, btrfs, LVM and so on. In practice it's unlikely that
    # anybody is doing that, so we aren't supporting it for now.
fi
