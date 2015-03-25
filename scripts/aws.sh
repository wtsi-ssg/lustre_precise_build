#!/bin/bash

# only proceed in AWS
id ubuntu >/dev/null 2>&1 || exit 0

# the naming is wrong, but it'll do for now
# AWS puts data disks on /mnt
mkdir -p /mnt/vagrant/lustre
chmod a+w /mnt/vagrant/lustre
ln -s /mnt/vagrant /vagrant
