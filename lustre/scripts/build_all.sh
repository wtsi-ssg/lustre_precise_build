#!/bin/bash
echo Output redirected to  /vagrant/lustre/LOG 
rm -f  /vagrant/lustre/LOG
bash  /vagrant/lustre/scripts/download_source.sh  >> /vagrant/lustre/LOG  2>&1 || exit
bash  /vagrant/lustre/scripts/unpack_source.sh    >> /vagrant/lustre/LOG  2>&1 || exit 
bash  /vagrant/lustre/scripts/prepare_source.sh   >> /vagrant/lustre/LOG  2>&1 || exit
bash  /vagrant/lustre/scripts/compile_linux.sh    >> /vagrant/lustre/LOG  2>&1 || exit 
bash  /vagrant/lustre/scripts/compile_lustre.sh   >> /vagrant/lustre/LOG  2>&1 || exit
