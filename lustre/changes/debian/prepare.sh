#!/bin/sh
#
# Shell script to add correct version numbers to
# the lustre-modules control/postinst/postrm scripts

if [ -z "$1" ] ; then
echo "Usage: $0 name-of-kernel-deb we are building against:"
echo
echo "eg $0 linux-image-2.6.22.19-lustre-1.6.7_20090330_amd64.deb"
echo
exit 0
fi


if [ ! -f control.stub ] ; then
echo "script must be run from within the  debian/ directory"
exit 1
fi




cat <<EOT >  /tmp/changelog_$$
$LUSTREVER (1.0.0) precise; urgency=low

   DDN  upstream lustre release

 -- Auto Build <james.beal@sanger.ac.uk>  `date -R`

EOT
cat changelog >>  /tmp/changelog_$$
cp /tmp/changelog_$$ changelog





kernel=`echo $1 | awk -F/ '{print $NF}'`

# Split of the trailing path



KERNELMINOR=`echo $kernel | awk -F_ '{print $2}'`
KERNELMAJOR=`echo $kernel | awk -F_ '{print $1}' | sed s/linux-image-//g`
LUSTREVERSION=`parsechangelog changelog | grep Version | awk '{print $2}'`
PACKAGENAME=`parsechangelog changelog | grep Source | awk '{print $2}'`

PACKAGEVERSION=$KERNELMAJOR"_"$LUSTREVERSION



if [ "$2" = clean ] ; then
echo Cleaning
rm -f lustre-modules-$KERNELMAJOR.install
rm -f lustre-modules-$KERNELMAJOR.postinst
rm -f lustre-modules-$KERNELMAJOR.postrm
rm -f control
exit 0
fi



echo
echo "OK. I think I am building:" 
echo "lustre $LUSTREVERSION against kernel $KERNELMAJOR revision $KERNELMINOR"
echo 
echo "Package versions will be:"
echo lustre_$LUSTREVERSION
echo lustre-modules-$PACKAGEVERSION 
echo 
echo "And will install modules into /lib/modules/$KERNELMAJOR"
echo
echo "Is this sane (y/n)?"

read INPUT

case $INPUT in 
    Y|y)
	break;
	;;
    *)
	exit 0
	;;
esac



cp control.stub control

sed -i -e "s/#KERNELMAJOR#/$KERNELMAJOR/g" -e "s/#KERNELMINOR#/$KERNELMINOR/g" -e "s/#VERSION#/$PACKAGENAME/g"   control 

cp lustre-#VERSION#.init		$PACKAGENAME.init
cp lustre-#VERSION#.install  		$PACKAGENAME.install
cp lustre-#VERSION#.postinstall	  	$PACKAGENAME.postinst
cp lustre-#VERSION#.postrm  		$PACKAGENAME.postrm
cp lustre-#VERSION#.substvars		$PACKAGENAME.substvars

sed -i s/#VERSION#/$PACKAGENAME/g $PACKAGENAME.init
sed -i s/#VERSION#/$PACKAGENAME/g $PACKAGENAME.postinst
sed -i s/#VERSION#/$PACKAGENAME/g $PACKAGENAME.postrm

cp lustre-modules-#VERSION#.install lustre-modules-$KERNELMAJOR.install

cp lustre-modules-#VERSION#.postinst lustre-modules-$KERNELMAJOR.postinst
cp lustre-modules-#VERSION#.postrm lustre-modules-$KERNELMAJOR.postrm

sed -i s/#VERSION#/$KERNELMAJOR/g lustre-modules-$KERNELMAJOR.postinst
sed -i s/#VERSION#/$KERNELMAJOR/g lustre-modules-$KERNELMAJOR.postrm

echo "Files have been configured";

