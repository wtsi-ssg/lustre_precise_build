#!/bin/bash
# For AWS: unpack /stash into {/mnt}/vagrant/lustre.
# This is lustre/scripts/unpack_stash.sh which Packer should place in
# /etc/rc.local

if [ ! -d /mnt/vagrant ]; then
    mkdir -p /mnt/vagrant/lustre
    chmod a+w /mnt/vagrant/lustre
    ln -sf /mnt/vagrant /vagrant
    cp -ar /stash/* /vagrant/lustre
fi
