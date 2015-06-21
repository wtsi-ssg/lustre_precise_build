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
if [ "${LUSTREVER}" = "lustre-2.5.29.ddnpf3" ] ; then
  alien -t  /vagrant/lustre/downloads/lustre-2.5.29.ddnpf3-2.6.32_431.29.2.el6_lustre.2.5.29.ddnpf3.x86_64_g6a6b29c.src.rpm 
  tar xvf lustre-2.5.29.ddnpf3.tgz 
  tar xvf lustre-2.5.29.ddnpf3.tar.gz 
fi
if [ "${LUSTREVER}" = "lustre-2.5.29-ddnpf5" ] ; then
 tar xvf  /vagrant/lustre/downloads/lustre-2.5.29.ddnpf5.tar
 mv lustre-2.5.29.ddnpf5 lustre-2.5.29-ddnpf5
fi
if [ "${GIT_TAG}" != "" ] ; then
  tar xvf /vagrant/lustre/downloads/${LUSTREVER}.tar.gz 
  DATE="`date -u +%F%H%M |sed -e 's/-//g'`"
  echo "TAG = ${GIT_TAG}" > ${LUSTREVER}/META
  echo "VERSION = ${GIT_TAG}" >> ${LUSTREVER}/META
  echo "BUILDID = sanger${DATE}"  >> ${LUSTREVER}/META
  echo "PRISTINE = 0" >> ${LUSTREVER}/META
  echo "LOCAL_VERSION = " >> ${LUSTREVER}/META
fi
echo "Unpacking Mellanox file"
tar xf /vagrant/lustre/downloads/MLNX_OFED_LINUX-2.1-1.0.6-ubuntu12.04-x86_64.tgz 
echo "Moving files to destination"
mv /vagrant/lustre/downloads/tmp/$LUSTREVER /vagrant/lustre/source/
mv /vagrant/lustre/downloads/tmp/linux-2.6.32-431.17.1.el6.x86_64  /vagrant/lustre/source/
mv /vagrant/lustre/downloads/tmp/MLNX_OFED_LINUX-2.1-1.0.6-ubuntu12.04-x86_64/DEBS/mlnx-ofed-kernel-dkms_2.1-OFED.2.1.1.0.6.1.g75b4801_all.deb /vagrant/lustre/debs/
cd /
rm -rf  /vagrant/lustre/downloads/tmp
echo "Installing ofed mellanox dpms package"
apt-get -y install  linux-headers-generic
apt-get -y -f install
dpkg -i /vagrant/lustre/debs/mlnx-ofed-kernel-dkms_2.1-OFED.2.1.1.0.6.1.g75b4801_all.deb 

