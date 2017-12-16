# Rockchip

This project is for Rockchip SoC devices

## Devices

* [ASUS Tinker Board](devices/TinkerBoard)
* [PINE64 ROCK64](devices/ROCK64)
* [mqmaker MiQi](devices/MiQi)
* [Popcorn Hour RockBox](devices/RockBox)

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
