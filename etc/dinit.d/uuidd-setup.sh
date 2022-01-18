#!/bin/sh
[ ! -d /run/uuidd ] && mkdir -p /run/uuidd
chown _uuidd:_uuidd /run/uuidd
