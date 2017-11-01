# ASUS Tinker Board

This is an experimental project for the ASUS Tinker Board

**Progress**

* [x] LEDs
* [ ] ~~CEC~~
* [ ] Audio
  * [x] HDMI Stereo L-PCM
  * [x] HDMI Multi-channel L-PCM
  * [x] HDA 3.5 mm jack
  * [ ] HDMI NL-PCM (AC3/E-AC3/DTS)
  * [ ] HDMI HBR (TrueHD/DTS-HD)
* [ ] Video
  * [x] Software decoding
  * [ ] Hardware decoding
    * [x] h264 / hevc / vp8
    * [ ] mpeg4 / mpeg2
* [ ] HDMI Video Format
  * [x] RGB 4:4:4 Limited Range
  * [ ] RGB 4:4:4 Full Range
  * [ ] YCbCr 4:4:4
  * [ ] YCbCr 4:2:0
* [x] WiFi
* [x] Bluetooth

**Known Issues/Limitations**

* Video output is RGB 4:4:4 8-bit limited range
* Video aspect ratio / zoom is not working for all modes
* Generic USB-Audio do not work due to a custom alsa config
* 4K resolution is limited to 30hz due to failed compliance test
* CEC is not connected to SoC

**Serial Console**

* UART2 on GPIO pin 32/33 with baud rate 115200

**Build**

* `PROJECT=Rockchip DEVICE=TinkerBoard ARCH=arm make image`

## Links

* Community Forum: https://tinkerboarding.co.uk/forum/
