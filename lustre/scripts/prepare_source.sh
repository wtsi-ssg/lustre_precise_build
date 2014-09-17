#!/bin/bash
cd /vagrant/lustre/source/linux-2.6.32-431.17.1.el6.x86_64/
ln -s -f /vagrant/lustre/source/lustre-2.5.19/lustre/kernel_patches/series/2.6-rhel6.series series
ln -s -f /vagrant/lustre/source/lustre-2.5.19/lustre/kernel_patches/patches patches
echo "Apply lustre patches"
quilt push -av || exit 1
echo Patching Linux kernel source
echo "Fixing issue with gcc  -dumpversion not returning a triple"
cat /vagrant/lustre/changes/patches/Makefile.patch | patch Makefile || exit 2
echo "Fixing issue with http://stackoverflow.com/questions/10425761/kernel-compile-error-gcc-error-elf-i386-no-such-file-or-directory"
cat /vagrant/lustre/changes/patches/arch_x86_vdso_Makefile.patch | patch arch/x86/vdso/Makefile || exit 3
echo "Copy the config from lustre to linux kernel"
cp /vagrant/lustre/source/lustre-2.5.19/lustre/kernel_patches/kernel_configs/kernel-2.6.32-2.6-rhel6-x86_64.config ./.config
echo "Remove the storage related module that does not build"
cat /vagrant/lustre/changes/patches/config.patch | patch -R  .config || exit 4
cd /vagrant/lustre/source/lustre-2.5.19
echo "Copying debian rules in to place"
rsync -av /vagrant/lustre/changes/debian .
mv debian/dmks.conf .
echo "Apply patches to get lustre to build on ubuntu and gcc 4.6"
echo "These patches turn off -Wformat-security in the minimal amount of code in" 
echo "each file so they compile with gcc 4.6.x"
cat /vagrant/lustre/changes/patches/ext4-mmp.patch.patch  | patch /vagrant/lustre/source/lustre-2.5.19/ldiskfs/kernel_patches/patches/rhel6.4/ext4-mmp.patch  || exit 5
cat /vagrant/lustre/changes/patches/pinger.c.patch        | patch -R  /vagrant/lustre/source/lustre-2.5.19/lustre/ptlrpc/pinger.c || exit 6
cat /vagrant/lustre/changes/patches/ldlm_lockd.c.patch    | patch ./lustre/ldlm/ldlm_lockd.c || exit 7
cat /vagrant/lustre/changes/patches/o2iblnd_cb.c.patch    | patch ./lnet/klnds/o2iblnd/o2iblnd_cb.c || exit 8
cat /vagrant/lustre/changes/patches/ptlrpcd.c.patch       | patch ./lustre/ptlrpc/ptlrpcd.c || exit 9
cat /vagrant/lustre/changes/patches/qsd_reint.c.patch     | patch ./lustre/quota/qsd_reint.c || exit 10
cat /vagrant/lustre/changes/patches/service.c.patch       | patch ./lustre/ptlrpc/service.c || exit 11
cat /vagrant/lustre/changes/patches/socklnd_cb.c.patch    | patch ./lnet/klnds/socklnd/socklnd_cb.c || exit 12
cat /vagrant/lustre/changes/patches/workitem.c.patch      | patch ./libcfs/libcfs/workitem.c || exit 13

