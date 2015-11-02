#!/bin/bash
cd $SOURCE_DIR/$KERNEL
cat /dev/null | make oldconfig
make kpkg-clean
export CC=gcc-4.4 
export DATE="`date -u +%F%H%M |sed -e 's/-//g'`"
export CONCURRENCY_LEVEL=`awk 'BEGIN{i=0}/processor/{i++;}END{print i*2}' /proc/cpuinfo`
if [ -z "${BUILDER}" ] ; then
 export BUILDER="jb23"
fi
if [ -z "${LUSTRE_VERSION}" ] ; then
 export LUSTRE_VERSION="exascaler-2-1"
fi
if [ -z "${KERNEL_VERSION}" ] ; then
KERNEL_VERSION="`pwd | sed -e 's#^'$SOURCE_DIR'/linux-2.6.32-##' -e 's/.x86_64$//'`"
fi
make-kpkg kernel-image kernel-headers kernel-source --append-to-version="-$BUILDER-$KERNEL_VERSION-$LUSTRE_VERSION" --revision=$DATE --rootcmd fakeroot --initrd
mv $SOURCE_DIR/*.deb /vagrant/lustre/debs/

