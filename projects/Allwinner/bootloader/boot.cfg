setenv bootargs console=ttyS0,115200 boot=/dev/mmcblk0p1 disk=/dev/mmcblk0p2 consoleblank=0
load mmc 0:1 0x43000000 sun8i-h3-orangepi-pc.dtb
load mmc 0:1 0x42000000 KERNEL
bootm 0x42000000 - 0x43000000
