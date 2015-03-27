#!/bin/bash

# only proceed in AWS
id ubuntu >/dev/null 2>&1 || exit 0

# the naming is wrong, but it'll do for now
# AWS puts data disks on /mnt
mkdir -p /stash
chmod a+w /stash

# this is the script that unpacks /stash as necessary
mv /home/ubuntu/rc.local /etc/rc.local
chmod a+rx /etc/rc.local
