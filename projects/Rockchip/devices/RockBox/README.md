# Popcorn Hour RockBox

This is an experimental project for the Popcorn Hour RockBox Basic

**Progress**

* [x] LEDs
* [x] IR
* [x] CEC
* [ ] Audio
  * [x] HDMI Stereo L-PCM
  * [x] HDMI Multi-channel L-PCM
  * [x] SPDIF
  * [ ] HDMI NL-PCM (AC3/E-AC3/DTS)
  * [ ] HDMI HBR (TrueHD/DTS-HD)
* [ ] Video
  * [x] Software decoding
  * [ ] Hardware decoding
    * [x] h264 / hevc / vp8 / vp9
    * [ ] mpeg4 / mpeg2
* [ ] HDMI Video Format
  * [x] RGB 4:4:4 Limited Range
  * [ ] RGB 4:4:4 Full Range
  * [ ] YCbCr 4:4:4
  * [ ] YCbCr 4:2:0
  * [ ] HDR10 / HLG
* [x] WiFi

**Known Issues/Limitations**

* Video output is RGB 4:4:4 8-bit limited range
* Video aspect ratio / zoom is not working for all modes
* 4K resolution is limited to 30hz

**Build**

* `PROJECT=Rockchip DEVICE=RockBox ARCH=aarch64 make image`
* `PROJECT=Rockchip DEVICE=RockBox ARCH=arm make image`

**How to use**
- Flash image to a sd-card
- Insert sd-card into the device
- Plug in power and LibreELEC should boot instead of Android
- Remove sd-card from device to boot into Android
