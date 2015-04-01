#!/bin/bash
cd /vagrant/lustre/source/lustre-$LUSTRE_VERSION/debian
echo Y | ./prepare.sh /vagrant/lustre/debs/linux-image-*
cd /vagrant/lustre/source/lustre-$LUSTRE_VERSION
dpkg-buildpackage -rfakeroot -uc -us
mv /vagrant/lustre/source/*.deb /vagrant/lustre/debs/
rm -rf  /var/lib/dkms/$LUSTREVER-client-modules
dh_clean
make clean
echo building dkms packages
rsync -a /vagrant/lustre/source/$LUSTREVER/*  /usr/src/lustre-client-modules-$LUSTRE_VERSION-1.0.0
dkms add -m lustre-client-modules-$LUSTRE_VERSION  -v 1.0.0 --all
dkms build -m lustre-client-modules-$LUSTRE_VERSION  -v 1.0.0  -k 3.8.0-44-generic  -k 3.2.0-75-generic
dkms -m lustre-client-modules-$LUSTRE_VERSION  -v 1.0.0 --all
rm /var/lib/dkms/lustre-client-modules-${LUSTRE_VERSION}/1.0.0/tarball/lustre-client-modules-${LUSTRE_VERSION}-1.0.0.dkms.tar.gz
yes | dkms mkdeb  -m lustre-client-modules-$LUSTRE_VERSION  -v 1.0.0 --all
mv  /var/lib/dkms/lustre-client-modules-$LUSTRE_VERSION/1.0.0/deb/*.deb /vagrant/lustre/debs
rm  /var/lib/dkms/$LUSTREVER-client-modules/1.0.0/tarball/*
dkms mkdsc -m lustre-client-modules-$LUSTRE_VERSION  -v 1.0.0 --all
mv  /var/lib/dkms//lustre-client-modules-$LUSTRE_VERSION/1.0.0/dsc/*.dsc /vagrant/lustre/debs

