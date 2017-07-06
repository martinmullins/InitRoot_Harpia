#!/bin/bash
harpia() {
    if [[ ! -e pad64 ]]; then
        dd if=/dev/zero of=pad64  bs=1M  count=64
    fi
    cd initrdimg-harpia/ 
    cp ../pad64 ../initroot-harpia.cpio.gz
    find . | grep -v [.]$ | cpio -v -R root:root -o -H newc | gzip > ../tmp 
    SZ=$(awk '{ print $5; }' <(ls -al ../tmp))
    cat ../tmp >> ../initroot-harpia.cpio.gz 
    rm -v ../tmp
    cd -
    echo "initrd size is $SZ"
}

$*
