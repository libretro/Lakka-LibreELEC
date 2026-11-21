# Amlogic

This project is for Amlogic SoC devices

## S905L3-B boxes (GXLX2, 1 GiB RAM)

AMLGX `box` images ship device trees for common Amlogic S905L3-B
(GXLX2) set-top boxes:

* `meson-gxl-s905l3b-e900v22e.dtb` - Skyworth E900V22E (1 GiB RAM)
* `meson-gxl-s905l3b-m302a.dtb` - MBH M302A (2 GiB RAM)

Select the device tree by editing `uEnv.ini` on the boot partition, e.g.
for the E900V22E:

```
dtb_name=/amlogic/meson-gxl-s905l3b-e900v22e.dtb
```

### 1 GiB RAM and the CMA pool

The AMLGX kernel raises the Amlogic GX CMA pool to 896MB for video
decoding, which does not fit comfortably in a board with only 1 GiB RAM.
The boot scripts honour an optional `cma` variable from `uEnv.ini` and
shrink the pool before the kernel starts, e.g. 256MB:

```
cma=0x10000000
```

When `cma` is not set the pool size is unchanged, so boards with 2 GiB
or more behave exactly as before.

### Notes

* HDMI output on S905L3-B (GXLX2) needs the GXLX2 drm/meson support
  carried in `projects/Amlogic/devices/AMLGX/patches/linux/`.
* The SDIO WiFi of these boxes is a MediaTek MT7668 for which mainline
  kernels do not provide a driver yet; wired Ethernet works.
* SD/eMMC input clocks are assigned 24MHz and eMMC top speeds follow
  community-proven values for these boards.

## Links

* http://linux-meson.com

## Useful debug commands

* `cat /sys/kernel/debug/cec/cec0/status`
* `cat /sys/kernel/debug/clk/clk_summary`
* `cat /sys/class/drm/card0-HDMI-A-1/status`
* `hexdump -C /sys/class/drm/card0-HDMI-A-1/edid`
* `edid-decode /sys/class/drm/card0-HDMI-A-1/edid`
* `cat /sys/kernel/debug/dma_buf/bufinfo`
