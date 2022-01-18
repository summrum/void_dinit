#!/bin/sh
# code from Runit
udevadm trigger --action=add --type=subsystems
udevadm trigger --action=add --type=devices
