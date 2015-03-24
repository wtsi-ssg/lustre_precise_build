#!/bin/bash -eux

# only proceed in a vagrant context
id vagrant >/dev/null 2>&1 || exit 0

mkdir /tmp/vbox
VER=$(cat /home/vagrant/.vbox_version)
wget -nc http://download.virtualbox.org/virtualbox/$VER/VBoxGuestAdditions_$VER.iso
mount -o loop VBoxGuestAdditions_$VER.iso /tmp/vbox
sh /tmp/vbox/VBoxLinuxAdditions.run
umount /tmp/vbox
rmdir /tmp/vbox
rm *.iso

mkdir /home/vagrant/.ssh
wget --no-check-certificate \
    'http://github.com/mitchellh/vagrant/raw/master/keys/vagrant.pub' \
    -O /home/vagrant/.ssh/authorized_keys
chown -R vagrant /home/vagrant/.ssh
chmod -R go-rwsx /home/vagrant/.ssh

# setup zsh - the best shell ever
VAGRANT_ZSHRC=/home/vagrant/.zshrc
EASYBIB_ZSHRC=https://gist.github.com/till/f683a2237571936c2df2/raw/201a181e0fe647d3922246758e7c07d96f59f6cc/.zshrc
wget $EASYBIB_ZSHRC -O $VAGRANT_ZSHRC
chown vagrant:vagrant $VAGRANT_ZSHRC
usermod -s /bin/zsh vagrant

