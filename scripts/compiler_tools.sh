#!/bin/bash

echo scripts/compiler_tools.sh
#sleep 999999
apt-get update
apt-get -y install alien quilt kernel-package fakeroot subversion autotools-dev   module-assistant cvs  automake libtool linux-headers-$(uname -r)  

# needed for AWS instance
apt-get -y install dkms

