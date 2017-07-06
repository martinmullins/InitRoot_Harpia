#!/bin/bash
push() {
    fastboot oem config fsg-id "_ "
    fastboot oem config fsg-id "c initrd=0x94000000,$1"
    fastboot flash aleph2 $2
    fastboot continue
}

harpia() {
    push $1 ./initroot-harpia.cpio.gz
}

$*
