#!/bin/sh
mkdir -p /vagrant/lustre/downloads
cd  /vagrant/lustre/downloads
wget http://eu.ddn.com:8080/lustre/lustre-source-2.5.19-ddn1.0_2.6.32_431.17.1.el6_lustre.es118.x86_64_ES.x86_64.rpm
#wget ftp://ftp.redhat.com/pub/redhat/linux/enterprise/6Server/en/os/SRPMS/kernel-2.6.32-431.17.1.el6.src.rpm
wget ftp://ftp.sanger.ac.uk/pub/users/jb23/linux-2.6.32-431.17.1.el6.x86_64.tar.gz
wget http://www.mellanox.com/downloads/ofed/MLNX_OFED-2.1-1.0.6/MLNX_OFED_LINUX-2.1-1.0.6-ubuntu12.04-x86_64.tgz
	
