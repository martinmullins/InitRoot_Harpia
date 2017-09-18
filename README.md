# InitRoot XT1607
Motorolla G4 Play (Amazon) Harpia InitRoot
* Scratch Address is 0x90000000
* I used a Padding of 64MB.

A persistent root method was provided by Aleph Security: https://alephsecurity.com/2017/08/30/untethered-initroot/#persisting-the-payload. Following that guide I was able to produce a bootable root partition: initroot.ext4.
* I identified the best partition to attack was /dev/block/bootdevice/by-name/padC (ie. /dev/mmcblk0p34)
* I created the scripts findmissing.sh and fixperms.sh to assist in creating initroot.ext4 file

Then the following two steps are enough to obtain persitstent root on 6.0.1 Android Moto G4 Play devices.
1. Deploying initroot.ext4 to padC
```
$ dd if=/data/local/tmp/initroot.ext4 of=/dev/block/bootdevice/by-name/padC 
```
2. The modifiy the fsg-id UTAG.
```
$ fastboot oem config fsg-id "1 rdinit= root=/dev/mmcblk0p34"


For InitRoot (Phone in FastBoot Mode):
```
$ ./genimg.sh harpia
# note the init size reported <size>
# connect the phone in fast boot mode
$ ./fastboot.sh harpia <size>
```

SELinux Is Permissive:
```
$ adb shell getenforce
Permissive
```

Root shell default from adb:
```
$ adb shell
root@harpia:/ # id
uid=0(root) gid=0(root) groups=0(root),1004(input),1007(log),1011(adb),1015(sdcard_rw),1028(sdcard_r),3001(net_bt_admin),3002(net_bt),3003(inet),3006(net_bw_stats) context=u:r:shell:s0
```
