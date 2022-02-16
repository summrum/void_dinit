#!/bin/sh
if [ "$1" != "stop" ]; then
  # code from Void Runit
  install -m0664 -o root -g utmp /dev/null /run/utmp
  halt -B  # for wtmp

  # Detect LXC containers
  [ ! -e /proc/self/environ ] && return
  if grep -q lxc /proc/self/environ >/dev/null; then
      export VIRTUALIZATION=1
  fi
  if [ -z "$VIRTUALIZATION" ]; then
  # Configure random seed
  cp /var/lib/random-seed /dev/urandom >/dev/null 2>&1 || true
  fi

  # Configure network
  ip link set up dev lo


  [ -r /etc/hostname ] && read -r HOSTNAME < /etc/hostname
  if [ -n "$HOSTNAME" ]; then
      echo "Setting up hostname to '${HOSTNAME}'..."
      printf "%s" "$HOSTNAME" > /proc/sys/kernel/hostname
  else
      echo "Didn't setup a hostname!"
  fi
  if [ -f /etc/localtime ]; then
	  loc_set=$(readlink -f /etc/localtime)
      set_zone=$(echo "$loc_set" | sed s%"/usr/share/zoneinfo/"%""%g)
      echo "Timezone set to '${set_zone}'"
  else
      [ -r /etc/rc.conf ] && . /etc/rc.conf
      echo "Setting timezone to '${TIMEZONE}'..."
      ln -sf "/usr/share/zoneinfo/$TIMEZONE" /etc/localtime
  fi

else
    # The system is being shut down
    echo "Saving random number seed"
    ( umask 077; bytes=$(cat /proc/sys/kernel/random/poolsize) || bytes=512; dd if=/dev/urandom of=/var/lib/random-seed count=1 bs=$bytes >/dev/null 2>&1 )

fi;
