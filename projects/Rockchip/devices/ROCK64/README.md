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

**Known Issues/Limitations**

* Video output is RGB 4:4:4 8-bit limited range
* Video aspect ratio / zoom is not working for all modes
* 4K resolution is limited to 30hz

**Serial Console**

* UART2 on Pi-2 Bus pin 8/10 with baud rate 1500000

**Build**

* `PROJECT=Rockchip DEVICE=ROCK64 ARCH=aarch64 make image`
* `PROJECT=Rockchip DEVICE=ROCK64 ARCH=arm make image`

## Links

* Community Forum: https://forum.pine64.org/forumdisplay.php?fid=85
