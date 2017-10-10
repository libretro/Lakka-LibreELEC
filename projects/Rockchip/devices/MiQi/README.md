# ASUS Tinker Board

This is an experimental project for the ASUS Tinker Board

**Progress**

* [x] LEDs (power, sd-card activity and heartbeat)
* [x] Persistent ethernet MAC-address set in u-boot (upstreamed)
* [x] ~~Kodi fbdev (for performance testing, no vsync, no double buffering)~~ (dropped)
* [ ] Kodi DRM/KMS
  * [x] Basic rendering
  * [x] Resolution / refresh rate change
  * [ ] Scale GUI using DRM
  * [ ] Atomic DRM
* [ ] Audio
  * [x] I2S Stereo L-PCM
  * [x] I2S Multi-channel L-PCM
  * [x] I2S NL-PCM (AC3/E-AC3/DTS)
  * [ ] I2S/SPDIF HBR (TrueHD/DTS-HD)
  * [x] HDA 3.5 mm jack
* [ ] Video
  * [x] Software decoding
  * [x] Hardware decoding (works with mpv)
    * [x] h264 / hevc / vp8
    * [x] mpegts container
    * [x] scale video correctly
    * [x] fix memory leak
* [x] WiFi
* [x] Bluetooth
* [ ] ~~CEC~~

**Known Issues/Limitations**

* Video aspect ratio / zoom is not working for all modes
* Generic USB-Audio do not work due to a custom alsa config
* 4K resolution is limited to 30hz due to failed compliance test
* CEC is not connected to SoC

**Build**

* `PROJECT=Rockchip DEVICE=TinkerBoard ARCH=arm MEDIACENTER=no make image`
* `PROJECT=Rockchip DEVICE=TinkerBoard ARCH=arm MEDIACENTER=mpv-rockchip make image`
* `PROJECT=Rockchip DEVICE=TinkerBoard ARCH=arm MEDIACENTER=kodi make image`
