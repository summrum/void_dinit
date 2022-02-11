#!/bin/sh
# code from Void Runit
udevadm trigger --action=add --type=subsystems
udevadm trigger --action=add --type=devices
