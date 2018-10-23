# RK3328

This is an experimental project for the RK3328-based boards

**Supported boards**

* PINE64 ROCK64
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
    * Video aspect ratio / zoom is not working for all modes
    * 4K resolution is limited to 30hz
* ROC-RK3328-CC

**Build**

* `PROJECT=Rockchip DEVICE=RK3328 BOARD=ROCK64 ARCH=arm make image`
* `PROJECT=Rockchip DEVICE=RK3328 BOARD=ROC-RK3328-CC ARCH=arm make image`
