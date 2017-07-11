#!/bin/bash

# to allow empty folders in the github, recreate them before pushing
recreateIgnores() {
    cd initrdimg-harpia/ 
    touch {sys,system,proc,dev,data,customize,dsp}/.gitignore
    cd -
}

harpia() {
    #remove .gitignores
    for i in add sys system proc dev data customize dsp; do
        gitig="initrdimg-harpia/$i/.gitignore"
        if [[ -e $gitig ]]; then
            echo -n "Git doesn't allow empty directores, removing temporary file: "
            rm -v $gitig
        fi
    done

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
