#!/bin/bash
cd $SOURCE_DIR/$KERNEL
ln -s -f $SOURCE_DIR/$LUSTREVER/lustre/kernel_patches/series/2.6-rhel6.series series
ln -s -f $SOURCE_DIR/$LUSTREVER/lustre/kernel_patches/patches patches
echo "Apply lustre patches"
quilt push -av || exit 1
echo Patching Linux kernel source
echo "Fixing issue with gcc  -dumpversion not returning a triple"
cat /vagrant/lustre/changes/patches/Makefile.patch | patch Makefile || exit 2
if [ "$KERNEL" = "linux-2.6.32-431.17.1.el6.x86_64" ] ; then 
  echo "Fixing issue with http://stackoverflow.com/questions/10425761/kernel-compile-error-gcc-error-elf-i386-no-such-file-or-directory"
  cat /vagrant/lustre/changes/patches/arch_x86_vdso_Makefile.patch | patch arch/x86/vdso/Makefile || exit 3
fi 
echo "Copy the config from lustre to linux kernel"
cp $SOURCE_DIR/$LUSTREVER/lustre/kernel_patches/kernel_configs/kernel-2.6.32-2.6-rhel6-x86_64.config ./.config
echo "Remove the storage related module that does not build"
cat /vagrant/lustre/changes/patches/config.patch | patch -R  .config || exit 4
cd $SOURCE_DIR/$LUSTREVER
echo "Copying debian rules in to place"
if [ "${LUSTRE_VERSION}" = "2.5.37-ddn" -o "${LUSTRE_VERSION}" = "2.5.37-ddn-2" ]; then
 echo "Changing dkms.conf"
 cp /vagrant/lustre/changes/lustre-2.5.37-ddn/dkms.conf /vagrant/lustre/changes/debian/
fi
rsync -av /vagrant/lustre/changes/debian .
mv $SOURCE_DIR/$LUSTREVER/debian/dkms.conf $SOURCE_DIR/$LUSTREVER/
if [ "${LUSTRE_VERSION}" = "2.7.0" ]; then
 echo "Applying lustre patch"
 cat /vagrant/lustre/changes/2.7.0/lustre/utils/liblustreapi_util.c.patch | patch lustre/utils/liblustreapi_util.c
fi
if [ "${LUSTRE_VERSION}" = "2.5.29-ddnpf5-ddn-197-sanger-fix" ]; then
 echo "Applying lustre patch"
 cat /vagrant/lustre/changes/lustre-2.5.29-ddnpf5-ddn-197-sanger-fix/lustre/utils/liblustreapi.c.patch | patch lustre/utils/liblustreapi.c
fi
