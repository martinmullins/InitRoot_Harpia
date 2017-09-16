#!/bin/bash

IMAGE_FOLDERS="oem sys system proc dev data customize dsp"

# to allow empty folders in the github, recreate them before pushing
recreate_gitignore() 
{
    cd initrdimg-harpia/ 
    for i in $IMAGE_FOLDERS; do
        touch $i/.gitignore
    done
    cd -
}

remove_gitignore() 
{
    for i in $IMAGE_FOLDERS; do
        gitig="initrdimg-harpia/$i/.gitignore"
        if [[ -e $gitig ]]; then
            echo -n "Git doesn't allow empty directores, removing temporary file: "
            rm -v $gitig
        fi
    done
}

harpia() 
{
    remove_gitignore

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


    recreate_gitignore
}

harpia_nopad()
{
    remove_gitignore

    cd initrdimg-harpia/ 
    find . | grep -v [.]$ | cpio -v -R root:root -o -H newc | gzip > ../initroot-harpia-nopad.cpio.gz 
    cd -

    recreate_gitignore
}

$*
