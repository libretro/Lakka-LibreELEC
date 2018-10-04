# Experimental project for RK3399 boards

**Supported boards**

* ROCKPro64
* Rock960
* Odroid N1

**Known issues**

* The ethernet MAC address is currently random at each boot - this causes the IP address to be different too each time the board is rebooted.
  * While it should, the MAC address is not passed from u-boot (for network boot) to Linux, this causes the board to have one IP address when u-boot runs then another when Linux runs

**Build**

* `PROJECT=Rockchip DEVICE=RK3399 BOARD=ROCKPro64 ARCH=arm make image`
* `PROJECT=Rockchip DEVICE=RK3399 BOARD=ROCK960 ARCH=arm make image`
* `PROJECT=Rockchip DEVICE=RK3399 BOARD=OdroidN1 ARCH=arm make image`
