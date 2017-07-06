# harpiaBootloaderUnlock
Motorolla G4 Play (Amazon) Bootloader Unlock

The idea for the unlock comes from here: https://forum.xda-developers.com/g4-play/help/unlocking-amazon-g4-play-bootloader-t3629834

```
For InitRoot:
./genimg.sh harpia
# note the init size reported <size>
# connect the phone in fast boot mode
./fastboot.sh harpia <size>
```
