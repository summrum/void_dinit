#!/bin/sh
export PATH=/usr/bin:/usr/sbin

set -e
echo "Mounting non-network filesystems...."
mount -a -t "nosysfs,nonfs,nonfs4,nosmbfs,nocifs,noceph,noglusterfs,nodavfs,nosshfs" -O no_netdev
