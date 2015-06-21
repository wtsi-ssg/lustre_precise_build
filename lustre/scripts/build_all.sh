#!/bin/bash
echo Output redirected to  /vagrant/lustre/LOG 
rm -f  /vagrant/lustre/LOG
export LUSTREVER="lustre-2.5.29-ddnpf5"
case "${LUSTREVER}" in
  "lustre-2.7.0")
     export GIT_TAG="v2_7_0_0"
     export LUSTRE_VERSION="2.7.0"
     ;;
   "lustre-2.5.29-ddnpf5")
     export GIT_TAG=""
     export LUSTRE_VERSION="2.5.29-ddnpf5"
     ;;
esac


bash  /vagrant/lustre/scripts/download_source.sh  >> /vagrant/lustre/LOG  2>&1 || exit
bash  /vagrant/lustre/scripts/unpack_source.sh    >> /vagrant/lustre/LOG  2>&1 || exit 
bash  /vagrant/lustre/scripts/prepare_source.sh   >> /vagrant/lustre/LOG  2>&1 || exit
bash  /vagrant/lustre/scripts/compile_linux.sh    >> /vagrant/lustre/LOG  2>&1 || exit 
bash  /vagrant/lustre/scripts/compile_lustre.sh   >> /vagrant/lustre/LOG  2>&1 || exit
