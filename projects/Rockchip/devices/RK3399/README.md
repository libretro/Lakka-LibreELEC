# Experimental project for RK3399 boards

**Supported boards**

* ROCKPro64
* Rock960
* Odroid N1

**Known issues**

* As the system currently only works in 64bit mode (32bit libmali crashes), some cores (N64, NDS) have their performance hindered due to the lack of ARM64 dynarecs. This will hopefully addressed in the future as more cores are ported to ARM64.
* On the other hand, some cores like PPSSPP or Dolphin work better in 64bit mode.
* The ethernet MAC address is currently random at each boot - this causes the IP address to be different too each time the board is rebooted.
  * While it should, the MAC address is not passed from u-boot (for network boot) to Linux, this causes the board to have one IP address when u-boot runs then another when Linux runs
* The HDMI display resolution is wrong when booting the board. A workaround for this is unplugging and plugging back the HDMI cord once booted.

**Build**

* `PROJECT=Rockchip DEVICE=RK3399 BOARD=ROCKPro64 ARCH=aarch64 make image`
* `PROJECT=Rockchip DEVICE=RK3399 BOARD=ROCK960 ARCH=arch64 make image`
* `PROJECT=Rockchip DEVICE=RK3399 BOARD=OdroidN1 ARCH=arch64 make image`
