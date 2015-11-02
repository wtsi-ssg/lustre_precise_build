#!/bin/bash
echo Output redirected to  /vagrant/lustre/LOG 
cd /vagrant/lustre
rm -f  /vagrant/lustre/LOG
export LUSTREVER="lustre-2.7.0"
export KERNEL="linux-2.6.32-431.17.1.el6.x86_64"
export SOURCE_DIR=/tmp/compile
. scripts/enviroment
# Fix the Kernel version
sed -i changes/debian/rules -e 's#KERNEL_SOURCE#'$KERNEL_SOURCE'#'
mkdir /vagrant/lustre/LOG
export | tee /vagrant/lustre/LOG/enviroment.log  >> /vagrant/lustre/LOG/ALL  2>&1
bash  /vagrant/lustre/scripts/download_source.sh | tee /vagrant/lustre/LOG/download.log  >> /vagrant/lustre/LOG/ALL  2>&1 || exit
bash  /vagrant/lustre/scripts/unpack_source.sh   | tee /vagrant/lustre/LOG/unpack.log    >> /vagrant/lustre/LOG/ALL  2>&1 || exit 
bash  /vagrant/lustre/scripts/prepare_source.sh  | tee /vagrant/lustre/LOG/prepare.log   >> /vagrant/lustre/LOG/ALL  2>&1 || exit
bash  /vagrant/lustre/scripts/compile_linux.sh   | tee /vagrant/lustre/LOG/linux.log     >> /vagrant/lustre/LOG/ALL  2>&1 || exit 
bash  /vagrant/lustre/scripts/compile_lustre.sh  | tee /vagrant/lustre/LOG/lustre.log    >> /vagrant/lustre/LOG/ALL  2>&1 || exit
