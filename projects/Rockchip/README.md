# Rockchip

This project is for Rockchip SoC devices

## Devices

**RK3288**
* [ASUS Tinker Board](devices/TinkerBoard)
* [mqmaker MiQi](devices/MiQi)

**RK3328**
* [PINE64 ROCK64](devices/RK3328)
* [Popcorn Hour RockBox](devices/RK3328)
* [Popcorn Hour Transformer](devices/RK3328)
* [Firefly ROC-RK3328-CC](devices/RK3328)

**RK3399**
* [96rocks ROCK960](devices/RK3399)
* [PINE64 RockPro64](devices/RK3399)
* [Rockchip Sapphire Board](devices/RK3399)

**My single-board computer is not listed, will it be added in the future?**<br />
If your single-board computer uses a current generation SoC listed on http://opensource.rock-chips.com/wiki_Main_Page the odds are in your favor.

**My Android device is not listed, will it be added in the future?**<br />
You may have luck if your device vendor is open source friendly, otherwise keep using Android for best support.

## Links

* https://github.com/rockchip-linux
* http://opensource.rock-chips.com

## Useful debug commands

* `cat /sys/kernel/debug/dri/0/summary`
* `cat /sys/kernel/debug/dw-hdmi/status`
* `cat /sys/kernel/debug/clk/clk_summary`
* `hexdump -C /sys/class/drm/card0-HDMI-A-1/edid`
* `edid-decode /sys/class/drm/card0-HDMI-A-1/edid`
* `cat /sys/kernel/debug/dma_buf/bufinfo`
