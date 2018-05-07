# Lakka for Switch (WIP)

It's a WIP of porting Lakka for the Switch. A standalone Lakka project is on its way to have a nice IMG file to use with Painless Linux - for now it's nothing but a dirty mess. In the meantime you'll have to do it yourself.

## How to boot

1. `DISTRO=Lakka PROJECT=Switch ARCH=aarch64 make image`
    * The `make` command will fail when packing the final image but we only need the `SYSTEM` image so it's alright
2. On your SD card, create two partitions :
    1. `mmcblk0p1` : a FAT32 partition of ~300mb (flash partition)
    2. `mmcblk0p2` : an ext4 partition filling the remaining space (it doesn't expand yet) (storage partition)
3. Mount the FAT32 partition and
    1. Copy the boot folder from the [Painless Linux](https://github.com/natinusala/painless-linux) repository
    2. Copy the `Lakka-xxxx.system` file from the `target` folder and rename it `SYSTEM`
    3. Delete the `boot/boot.scr` file and put the one from this folder instead
    4. Get `initramfs.cpio` from the `build.Lakka-xxx/image` folder and convert it to a `uImage` using `mkimage` (no compression)
    5. Call it `initramfs.uImage` and put it in the `boot` folder of the SD card
4. Use Painless Linux to boot !

## What works / what doesn't

See the Painless Linux README for that.
