#!/bin/bash
push() {
fastboot oem config fsg-id "_ "
fastboot oem config fsg-id "c initrd=0x94000000,$1" #1010047" #1010926" #1010658"
fastboot flash aleph2 $2
fastboot continue
}

orig() {
    push 1010926 ./initroot-orig-harpia.cpio.gz
}

orig2() {
    push 1010052 ./initroot-orig2-harpia.cpio.gz
}

pure() {
    push 1011707 ./initroot-pure-harpia.cpio.gz
}

puresu() {
    push $1 ./initroot-pure-harpia.cpio.gz
}

$*
