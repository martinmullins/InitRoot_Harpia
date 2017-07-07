# InitRoot XT1607
Motorolla G4 Play (Amazon) Harpia InitRoot
* Scratch Address is 0x90000000
* I used a Padding of 64MB.

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
