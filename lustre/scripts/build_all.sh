#!/bin/bash
echo Output redirected to  /vagrant/lustre/LOG 
rm -f  /vagrant/lustre/LOG
export LUSTREVER="lustre-2.7.0"
export KERNEL="linux-2.6.32-431.17.1.el6.x86_64"
case "${LUSTREVER}" in
  "lustre-2.7.0")
     export GIT_TAG="v2_7_0_0"
     export LUSTRE_VERSION="2.7.0"
     ;;
   "lustre-2.5.29-ddnpf5")
     export GIT_TAG=""
     export LUSTRE_VERSION="2.5.29-ddnpf5"
     ;;
   "lustre-2.5.29-ddnpf5-ddn-197")
     export GIT_TAG=""
     export LUSTRE_VERSION="2.5.29-ddnpf5-ddn-197"
     ;;
   "lustre-2.5.29-ddnpf5-ddn-197-sanger-fix")
     export GIT_TAG=""
     export LUSTRE_VERSION="2.5.29-ddnpf5-ddn-197-sanger-fix"
     ;;
   "lustre-2.5.29-ddnpf5-2")
     export GIT_TAG=""
     export LUSTRE_VERSION="2.5.29-ddnpf5-2"
     ;;
   "lustre-2.5.37-ddn")
     export GIT_TAG=""
     export LUSTRE_VERSION="2.5.37-ddn"
     ;;
   "lustre-2.5.37-ddn-2")
     export GIT_TAG=""
     export LUSTRE_VERSION="2.5.37-ddn-2"
     ;;
   "lustre-2.5.39-ddn-3")
     export GIT_TAG=""
     export LUSTRE_VERSION="2.5.39-ddn-3"
     export KERNEL="linux-2.6.32-573.3.1.el6.x86_64"
     export CC=gcc-4.4
     ;;
esac
# Fix the Kernel version
sed -i changes/debian/rules -e 's/KERNEL_PATH/'$KERNEL'/'

mkdir /vagrant/lustre/LOG
bash  /vagrant/lustre/scripts/download_source.sh | tee /vagrant/lustre/LOG/download.log  >> /vagrant/lustre/LOG/ALL  2>&1 || exit
bash  /vagrant/lustre/scripts/unpack_source.sh   | tee /vagrant/lustre/LOG/unpack.log    >> /vagrant/lustre/LOG/ALL  2>&1 || exit 
bash  /vagrant/lustre/scripts/prepare_source.sh  | tee /vagrant/lustre/LOG/prepare.log   >> /vagrant/lustre/LOG/ALL  2>&1 || exit
bash  /vagrant/lustre/scripts/compile_linux.sh   | tee /vagrant/lustre/LOG/linux.log     >> /vagrant/lustre/LOG/ALL  2>&1 || exit 
bash  /vagrant/lustre/scripts/compile_lustre.sh  | tee /vagrant/lustre/LOG/lustre.log    >> /vagrant/lustre/LOG/ALL  2>&1 || exit
