#Introduction

This is a system which can be used to produce deb files for a ubuntu system which provide the lustre file system, both server and client side.

To use it you must have both http://www.packer.io/ and http://www.vagrantup.com/ installed.

Taking the most automated route the process would be:

```
  git clone https://github.com/james-beal/lustre_precise_build.git
  cd lustre_precise_build
  ./create_box # Wait while your new vm is installed
  vagrant up
  vagrant ssh
      sudo bash /vagrant/lustre/scripts/build_all.sh
```

The log should appear in lustre/LOG and the output deb files should appear in lustre/debs

#Scripts

build_all.sh is a wrapper script that calls other scripts and logs the output to a logfile

##download_source.sh

This script downloads the source code from the various locations after checking that it has not been downloaded already. The only thing of note is that the kernel source has been converted from an source rpm to a tarfile using the following process on a centos box ( not provided ). The resulting source code has been republished on the sanger's ftp site.
```

```
##unpack_source.sh

This unpacks the downloaded source code, makes a number of directories and moves the unpacked source code in to the correct location to be built. From the Mellanox download the DKMS support for mlnx-ofed kernel modules are installed on the build machine so that the lustre can find the correct headers to build with o2ib support. When testing is complete I will ensure that other packages required on the server side are moved to the output deb directory.

##prepare_source.sh

This is one of the more complex scripts, it's task is to prepare the source to be built under precise. The first step is to apply the standard lustre patches to the linux kernel source by creating the standard symbolic links and using quilt to apply the patches. After that we apply local patches to get the kernel and lustre to compile under ubuntu/gcc-4.x . These patches were developed by repeatedly trying to compile the kernel and lustre and when there was an issue stopping fixing the issue by hand and then writing a patch which automates the fix.

###Kernel/Makefile

The Makefile defines three varibles CPP_MAJOR,CPP_MINOR,CPP_PATCH which are devived from the gcc version ( which is found using  -dumpversion ), gcc versions passed version 4.6? do not report a PATCH version eg they report (gcc-4.6 rather than gcc-4.6.3) This patch adds a default value of 0 to CPP_MINOR and CPP_PATCH

###Kernal/arch/x86/vdso/Makefile

This makefile is for VDSO ( http://en.wikipedia.org/wiki/VDSO ), this fix was found reading http://stackoverflow.com/questions/10425761/kernel-compile-error-gcc-error-elf-i386-no-such-file-or-directory which basically says that we have to use -m64 and -m32 instead of -m elf_x86_64  or -m elf_x86

###Kernel/.config

The  PMC SIERRA MaxRAID appears not to compile under ubuntu so this patch disables it.

###Lustre/ldiskfs/kernel_patches/patches/rhel6.4/ext4-mmp.patch

All the patches in the lustre source are basically using the following pattern to disable an warning for a single statement.

```
        #pragma GCC diagnostic push
        #pragma GCC diagnostic ignored "-Wformat-security"

 	struct task_struct *task = kthread_run(fn, arg, name);
        #pragma GCC diagnostic pop
```
Here #pragma GCC diagnostic push saves the state of the diagnositcs, we then ignore a warning, have the single problematic statement and return the state of the diagnostics to its earlier state.

This patch is the most interesting of the set as it is a patch to a patch, I took the approach of creating the patch by hand as it seemed simplest. It is worth noting that a patch has two bits the bits that change and the size of the patch. In the first instance I only added the extra lines and was confused when the file finished early, by manually increasing the size of the patch all was made well.

###Lustre/lustre/ldlm/ldlm_lockd.c
Simple patch to disable -Wformat-security
###Lustre/lnet/klnds/o2iblnd/o2iblnd_cb.c
Simple patch to disable -Wformat-security
###Lustre/lustre/ptlrpc/ptlrpcd.c
Simple patch to disable -Wformat-security
###Lustre/lustre/quota/qsd_reint.c
Simple patch to disable -Wformat-security
###Lustre/lustre/ptlrpc/service.c
Simple patch to disable -Wformat-security
###Lustre/lnet/klnds/socklnd/socklnd_cb.c
Simple patch to disable -Wformat-security
###Lustre/libcfs/libcfs/workitem.c
Simple patch to disable -Wformat-security

##compile_linux.sh
##compile_lustre.sh

