#!/bin/bash
patched() {
cd initrd/
cp ../pad64 ../initroot-harpia.cpio.gz
find . | grep -v [.]$ | cpio -v -R root:root -o -H newc | gzip > ../tmp 
ls -la ../tmp 
cat ../tmp >> ../initroot-harpia.cpio.gz 
#rm -fr ../tmp
cd -
}

pure() {
cd purerd/
cp ../pad64 ../initroot-pure-harpia.cpio.gz
find . | grep -v [.]$ | cpio -v -R root:root -o -H newc | gzip > ../tmp 
ls -la ../tmp 
cat ../tmp >> ../initroot-pure-harpia.cpio.gz 
#rm -fr ../tmp
cd -
}

orig() {
cp ./pad64 ./initroot-orig-harpia.cpio.gz
cat ~/harpiabin/initrd.img >>  initroot-orig-harpia.cpio.gz
ls -al ~/harpiabin/initrd.img
}

orig2() {
cp ./pad64 ./initroot-orig2-harpia.cpio.gz
cat ./init.gz  >>  initroot-orig2-harpia.cpio.gz
ls -al ./init.gz
}


$*
