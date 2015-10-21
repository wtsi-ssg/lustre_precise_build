#!/bin/sh
mkdir -p /vagrant/lustre/downloads
cd  /vagrant/lustre/downloads
if [ "${GIT_TAG}" = "" ] ; then
  if [ -x  /vagrant/lustre/scripts/download_secret ]; then
    bash -x  /vagrant/lustre/scripts/download_secret
  fi
else
  git clone http://git.whamcloud.com/fs/lustre-release.git
  cd lustre-release
  git checkout ${GIT_TAG}
  sh autogen.sh 
  ./configure --disable-modules
  make dist
  mv *.tar.gz /vagrant/lustre/downloads
fi
cd  /vagrant/lustre/downloads
  
if [ "${KERNEL}" = "linux-2.6.32-431.17.1.el6.x86_64" ] ; then
  #wget ftp://ftp.redhat.com/pub/redhat/linux/enterprise/6Server/en/os/SRPMS/kernel-2.6.32-431.17.1.el6.src.rpm
  if [  "`md5sum linux-2.6.32-431.17.1.el6.x86_64.tar.gz |  awk '{print $1}' `" != "8ec9076424ef8a390f22d3532537755c" ] ; then
    rm -f linux-2.6.32-431.17.1.el6.x86_64.tar.gz
    wget ftp://ftp.sanger.ac.uk/pub/users/jb23/linux-2.6.32-431.17.1.el6.x86_64.tar.gz
  fi
fi

if [ "${KERNEL}" = "linux-2.6.32-573.3.1.el6.x86_64" ] ; then
  if [  "`md5sum linux-2.6.32-573.3.1.el6.x86_64.tar.gz |  awk '{print $1}' `" != "3674a9a25c31cefbca68af568269bf30" ] ; then
    rm -f  linux-2.6.32-573.3.1.el6.x86_64.tar.gz
    wget ftp://ftp.sanger.ac.uk/pub/users/jb23/linux-2.6.32-573.3.1.el6.x86_64.tar.gz
  fi
fi


if [  "`md5sum MLNX_OFED_LINUX-2.1-1.0.6-ubuntu12.04-x86_64.tgz |  awk '{print $1}'`" != "f590709dd4e9a31dd05251bcb66241cc"  ] ; then
  rm -f  MLNX_OFED_LINUX-2.1-1.0.6-ubuntu12.04-x86_64.tgz
  #wget http://www.mellanox.com/downloads/ofed/MLNX_OFED-2.1-1.0.6/MLNX_OFED_LINUX-2.1-1.0.6-ubuntu12.04-x86_64.tgz
  wget ftp://ftp.sanger.ac.uk/pub/jb23/MLNX_OFED_LINUX-2.1-1.0.6-ubuntu12.04-x86_64.tgz
fi
