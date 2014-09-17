lustre_precise_build
====================

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

