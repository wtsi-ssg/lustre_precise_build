#!/bin/bash
cd /vagrant/lustre/source/linux-2.6.32-431.17.1.el6.x86_64
make oldconfig
make kpkg-clean
DATE="`date -u +%F%H%M |sed -e 's/-//g'`"
if [ -z "${BUILDER}" ] ; then
 export BUILDER="jb23"
fi
if [ -z "${LUSTRE_VERSION}" ] ; then
 export LUSTRE_VERSION="exascaler-2-1"
fi
if [ -z "${KERNEL_VERSION}" ] ; then
KERNEL_VERSION="`pwd | sed -e 's#^/vagrant/lustre/source/linux-2.6.32-##' -e 's/.x86_64$//'`"
fi
CONCURRENCY_LEVEL=5  make-kpkg kernel-image kernel-headers kernel-source --append-to-version="-$BUILDER-$KERNEL_VERSION-$LUSTRE_VERSION" --revision=$DATE --rootcmd fakeroot --initrd
mv /vagrant/lustre/source/*.deb /vagrant/lustre/debs/

