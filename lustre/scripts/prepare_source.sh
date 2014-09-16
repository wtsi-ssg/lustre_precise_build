#!/bin/bash
cd /vagrant/lustre/source/lustre-2.5.19
echo "Apply patches to get lustre to build on ubuntu and gcc 4.6"
echo "These patches turn off -Wformat-security in the minimal amount of code in" 
echo "each file so they compile with gcc 4.6.x"
cat /vagrant/lustre/patches/ext4-mmp.patch.patch  | patch ./ldiskfs/kernel_patches/patches/rhel6.4/ext4-mmp.patch
cat /vagrant/lustre/patches/ldlm_lockd.c.patch    | patch ./lustre/ldlm/ldlm_lockd.c
cat /vagrant/lustre/patches/o2iblnd_cb.c.patch    | patch ./lnet/klnds/o2iblnd/o2iblnd_cb.c
cat /vagrant/lustre/patches/ptlrpcd.c.patch       | patch ./lustre/ptlrpc/ptlrpcd.c
cat /vagrant/lustre/patches/qsd_reint.c.patch     | patch ./lustre/quota/qsd_reint.c
cat /vagrant/lustre/patches/service.c.patch       | patch ./lustre/ptlrpc/service.c
cat /vagrant/lustre/patches/socklnd_cb.c.patch    | patch ./lnet/klnds/socklnd/socklnd_cb.c
cat /vagrant/lustre/patches/workitem.c.patch      | patch ./libcfs/libcfs/workitem.c
cd /vagrant/lustre/source/linux-2.6.32-431.17.1.el6.x86_64/
ln -s -f /vagrant/lustre/source/lustre-2.5.19/lustre/kernel_patches/series/2.6-rhel6.series series
ln -s -f /vagrant/lustre/source/lustre-2.5.19/lustre/kernel_patches/patches patches
echo Patching Linux kernel source
echo "Fixing issue with gcc  -dumpversion not returning a triple"
cat /vagrant/lustre/patches/Makefile.patch | patch Makefile 
echo "Fixing issue with http://stackoverflow.com/questions/10425761/kernel-compile-error-gcc-error-elf-i386-no-such-file-or-directory"
cat /vagrant/lustre/patches/arch_x86_vdso_Makefile.patch | patch arch/x86/vdso/Makefile
echo "Copy the config from lustre to linux kernel"
cp /vagrant/lustre/source/lustre-2.5.19/lustre/kernel_patches/kernel_configs/kernel-2.6.32-2.6-rhel6-x86_64.config ./.config
echo "Remove the storage related module that does not build"
cat /vagrant/lustre/patches/config.patch | patch -R  .config
echo "Apply lustre patches"
quilt push -av
