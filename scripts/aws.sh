#!/bin/bash

# only proceed in AWS
id ubuntu >/dev/null 2>&1 || exit 0

# the naming is wrong, but it'll do for now
mkdir -p /vagrant/lustre
chmod a+w /vagrant/lustre

