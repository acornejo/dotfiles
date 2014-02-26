#!/bin/bash
VERSION=2.6.15-20-amd64-k8
FILE=/tmp/initrd-$RANDOM
cat /boot/initrd.img-$VERSION | gunzip > $FILE
OLD_CWD=`pwd`
cd /
find lib/modules/$VERSION/kernel/fs/fat lib/modules/$VERSION/kernel/fs/vfat lib/modules/$VERSION/kernel/fs/nls | cpio -H newc -oAF $FILE
echo bin/dmess | cpio -H newc -oAF $FILE
cat $FILE | gzip -n9 > /boot/initrd.cgz
rm $FILE
cd "$OLD_CWD"
