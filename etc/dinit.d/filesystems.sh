#!/bin/sh
export PATH=/usr/bin:/usr/sbin

set -e

if [ "$1" != "stop" ]; then

  echo "Mounting non-network filesystems...."
  mount -a -t "nosysfs,nonfs,nonfs4,nosmbfs,nocifs" -O no_netdev

fi
