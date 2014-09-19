#!/bin/bash
cd /vagrant/lustre/source/lustre-2.5.19/debian
echo Y | ./prepare.sh /vagrant/lustre/debs/linux-image-*
cd /vagrant/lustre/source/lustre-2.5.19
dpkg-buildpackage -rfakeroot -uc -us
rm -rf  /var/lib/dkms/lustre-exascaler-2-1-client-modules
dh_clean
make clean
echo building dkms packages
rsync -a /vagrant/lustre/source/lustre-2.5.19/  /usr/src/lustre-exascaler-2-1-client-modules-1.0.0
dkms add -m lustre-exascaler-2-1-client-modules -v 1.0.0
dkms -m lustre-exascaler-2-1-client-modules -v 1.0.0 --all
dkms mkdeb -m lustre-exascaler-2-1-client-modules -v 1.0.0 --all
mv  /var/lib/dkms/lustre-exascaler-2-1-client-modules/1.0.0/deb/*.deb /vagrant/lustre/debs
rm  /var/lib/dkms/lustre-exascaler-2-1-client-modules/1.0.0/tarball/*
dkms mkdsc -m lustre-exascaler-2-1-client-modules -v 1.0.0 --all
mv  /var/lib/dkms/lustre-exascaler-2-1-client-modules/1.0.0/dsc/*.dsc /vagrant/lustre/debs



