#!/bin/sh
# Code from Void Linux elogind.wrapper script
cgroup=/sys/fs/cgroup/elogind

mkdir -p "$cgroup"
if ! mountpoint "$cgroup" > /dev/null; then
	mount -t cgroup -o none,name=elogind cgroup $cgroup || exit 1
fi

[ ! -d /run/systemd ] && install -m755 -g 0 -o 0 -d /run/systemd
[ ! -d /run/user ] && install -m755 -g 0 -o 0 -d /run/user
for tmpfs in /run/systemd /run/user; do
	mountpoint "$tmpfs" > /dev/null && continue
	mkdir -p "$tmpfs"
	mount -t tmpfs -o nosuid,nodev,noexec,mode=0755 none "$tmpfs" || exit 1
done

exec /usr/libexec/elogind/elogind
