#!/bin/bash
echo "Making destination directories"
mkdir -p /vagrant/lustre/downloads/tmp
mkdir -p /vagrant/lustre/debs
rm -rf   /vagrant/lustre/source
mkdir -p /vagrant/lustre/source
cd /vagrant/lustre/downloads/tmp
echo "Unpacking linux kernel"
tar xf /vagrant/lustre/downloads/linux-2.6.32-431.17.1.el6.x86_64.tar.gz 
echo "Unpacking lustre source"
tar xf /vagrant/lustre/downloads/sanger-lustre-2.5.29.ddnpf3.tar.gz 
echo "Unpacking Mellanox file"
tar xf /vagrant/lustre/downloads/MLNX_OFED_LINUX-2.1-1.0.6-ubuntu12.04-x86_64.tgz 
echo "Moving files to destination"
mv /vagrant/lustre/downloads/tmp/$LUSTREVER /vagrant/lustre/source/
mv /vagrant/lustre/downloads/tmp/linux-2.6.32-431.17.1.el6.x86_64  /vagrant/lustre/source/
mv /vagrant/lustre/downloads/tmp/MLNX_OFED_LINUX-2.1-1.0.6-ubuntu12.04-x86_64/DEBS/mlnx-ofed-kernel-dkms_2.1-OFED.2.1.1.0.6.1.g75b4801_all.deb /vagrant/lustre/debs/
rm -rf  /vagrant/lustre/downloads/tmp
echo "Installing ofed mellanox dpms package"
apt-get -y install  linux-headers-generic
apt-get -y -f install
dpkg -i /vagrant/lustre/debs/mlnx-ofed-kernel-dkms_2.1-OFED.2.1.1.0.6.1.g75b4801_all.deb 

