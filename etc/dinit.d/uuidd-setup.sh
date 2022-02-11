#!/bin/sh
# Code from Void Runit
[ ! -d /run/uuidd ] && mkdir -p /run/uuidd
chown _uuidd:_uuidd /run/uuidd
