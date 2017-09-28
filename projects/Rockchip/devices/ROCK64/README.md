# PINE64 ROCK64

This is an experimental project for the PINE64 ROCK64

**Progress**

* [x] LEDs
* [x] IR
* [x] CEC
* [ ] Audio
  * [x] HDMI Stereo L-PCM
  * [x] HDMI Multi-channel L-PCM
  * [x] ACODEC A/V jack + I2S DAC
    * [x] Split into two devices (A/V jack and I2S DAC)
  * [x] SPDIF
  * [ ] HDMI NL-PCM (AC3/E-AC3/DTS)
  * [ ] HDMI HBR (TrueHD/DTS-HD)
* [x] Video
  * [x] Software decoding
  * [x] Hardware decoding
    * [x] h264 / hevc / vp8

**Known Issues/Limitations**

* Video aspect ratio / zoom is not working for all modes
* 4K resolution is limited to 30hz

**Build**

* `PROJECT=Rockchip DEVICE=ROCK64 ARCH=aarch64 make image`
* `PROJECT=Rockchip DEVICE=ROCK64 ARCH=arm make image`
