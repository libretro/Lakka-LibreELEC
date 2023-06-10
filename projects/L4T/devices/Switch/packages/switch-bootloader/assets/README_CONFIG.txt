============================ @DISTRO@ .ini Configuration ============================
Never use # to comment out keys in the ini.
Either avoid them or use ; in front to invalidate a key.
Example: rootdev=mmcblk0p2 -> ;rootdev=mmcblk0p2

Below you can find all supported keys and their defaults.

========================= .ini Boot Entry Config Keys ==========================

[l4t=1]
 Enables and parses the .ini boot entry with L4T Loader.
 Mandatory!

[boot_prefixes=@DISTRO_PATH@/boot/]
 Sets the directory of the @DISTRO@/L4T bootloader files
 Mandatory!

[id=@DISTRO_ID@]
 Set FS Label name. @DISTRO_ID@ by default.
 Used to automatically find the correct linux partition.

================================================================================

[r2p_action=self]
 self:       Reboots to self. [Default]
 bootloader: Reboots to bootloader menu.
 
[usb3_enable=0]
 1: Enable  USB3 support.
 Enabling it can dramatically decrease WiFi 2.4GHz and Bluetooth signal quality.

[4k60_disable=0]
 1: Disable 4K@60 for Nintendo Switch (OLED).
 If [usb3_enable] is set, the driver will automatically choose between USB3
 and 4K@60. 4K@60 is preferred in that case.

[uart_port=0]
 0: Disable serial logging
 1: Enable serial logging on UART-A [Internal Port]
 2: Enable serial logging on UART-B [Right Joycon Rail]
 3: Enable serial logging on UART-C [Left Joycon Rail]
 4: Enable serial logging on USB

[fbconsole=1]
 0: Enable kernel logging on built-in display.
 1: Enable kernel logging on DP/HDMI/VGA.
 9: Or removed, disables kernel logging on any display.

[als_enable=1]
 1: Enable  Ambient Light Sensor.

[bootargs_extra=]
 Set extra kernel command line arguments.

[dvfsb=0]
 1: Enable DVFS B-Side.
 Reduces power draw in order to use less battery for the same performance.
 Can also allow higher CPU/GPU clocks. If OC is used, the reduced power draw
 is negated.

[ram_oc=0]
 Set RAM Overclock frequency in KHz.
 If you hang or get corruption or artifacts, try to reduce it.

 On T210 (Erista max 1996 MHz):
  Only frequencies in the following list are supported:
   1728000, 1795200, 1862400, 1894400, 1932800, 1996800
  Suggested:
   - 1862400

 On T210B01 (Mariko max 2133 MHz):
  Any multiple of 38400 KHz can be used.
  Suggested:
   - 1866000
   - 2133000


================================================================================
