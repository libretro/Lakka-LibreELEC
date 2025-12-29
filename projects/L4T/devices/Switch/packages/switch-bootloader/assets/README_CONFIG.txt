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
 normal:     Reboots with no config. Allows default auto boot to be used. 

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

[fbconsole=9]
 0: Enable kernel logging on built-in display, and disable splash screen
 1: Enable kernel logging on DP/HDMI/VGA.
 9: Or removed, disables kernel logging on any display.

[als_enable=1]
 1: Enable  Ambient Light Sensor.

[jc_rail_disable=0]
 1: Disable railed Joycon support.

[touch_skip_tuning=0]
 1: Disables touch panel tuning on boot.
 Some panels with broken flex cable might need it.

[wifi_disable_vht80=0]
 1: Disable Wi-Fi VHT80 and VHT160 bonding (5GHz band).
 In case wifi card firmware hangs when fully used at such speeds and kernel
 panics, that might help to mitigate that issue.

[bootargs_extra=]
 Set extra kernel command line arguments.

[dvfsb=0]
 1: Enable DVFS B-Side.
 Reduces power draw in order to use less battery for the same performance.
 Can also allow higher CPU/GPU clocks. If OC is used, the reduced power draw
 is negated.

[gpu_dvfsc=0]
1: Enable DVFS C-Side for GPU. T210B01 only.
 Reduces power draw drastically on GPU frequencies of 768/844 MHz and up.
 Allows up to 1228 MHz clocks on select speedo binnings.

[limit_gpu_clk=0]
 1: Set GPU clock hard limit to 1075 MHz. T210B01 only.
 Helps when `gpu_dvfsc` is enabled and GPU can't handle the higher frequencies
 in such low voltages.

[enable_ipv6=0]
 0: IPv6 Disabled (default)
 1: IPv6 Enabled

[enable_upfs = 0]
 0: upfs storage is disabled
 1: upfs storage is enabled(experimental): Keep FS permissions in ext4 partition image(Easier to clean)
 2: upfsps storage is enabled(experimental) Keep FS permission in storage dir in hidden files
================================================================================


============================== RAM Overclocking ================================

[ram_oc=0]
 Set RAM Overclock frequency in KHz.

 If you hang or get corruption or artifacts, try to reduce it.
 `mem-bench` command can use almost all of the available bandwidth so it can be
 used for a quick testing.
 Actual stability can only be confirmed by `memtester` command on as high as
 possible temperature for several hours and with a big test size.
 Running a secondary GPU benchmark can help raise temperature.

 Any clock increase will also increase RAM power consumption like a CPU/GPU OC.
 For example on T210B01, with 1z-nm ram, going from 1866 to 2133 causes a
 146 mW increase on active reads/writes which is 19.8%.
 Any other state is affected only with a voltage change.

 Warning: On T210B01, GPU minimum voltage might be raised if very high RAM
 frequency is used and GPU binning is low.

 T210 (Erista max 2133 MHz):
  List of supported frequencies:
  1733000, 1800000, 1866000, 1900000, 1933000, 1966000, 2000000, 2033000,
  2066000, 2100000, 2133000, 2166000, 2200000, 2233000, 2266000, 2300000,
  2333000, 2366000.

  Input frequency is generally normalized to one of the above.
  Actual frequency will differ a bit.

  Suggested Jedec Frequencies:
   - 1866000
   - 2133000

  Suggested Custom:
   - Any, if it works.


 T210B01 (Mariko max 3000 MHz):
  List of supported frequencies:
  1866000, 2133000, 2166000, 2200000, 2233000, 2266000, 2300000, 2333000,
  2366000, 2400000, 2433000, 2466000, 2500000, 2533000, 2566000, 2600000,
  2633000, 2666000, 2700000, 2733000, 2766000, 2800000, 2833000, 2866000,
  2900000, 2933000, 2966000, 3000000, 3033000, 3066000, 3100000, 3133000,
  3166000, 3200000.

  Input frequency is generally normalized to one of the above.
  Actual frequency will be exactly one of these.

  Suggested Jedec Frequencies:
   - 1866000
   - 2133000
   - 2400000
   - 2666000

  Suggested Custom Frequencies:
   - Any, if it works.
   Very high ram frequencies might raise GPU power draw on some GPU frequencies
   if GPU binning is low.

 Timing based overclocking:
  To enable that, edit the last [2 (T210) or 3 (T210B01) digits] of the frequency.

  It's generally better to find a good base frequency before touching these.

  Do not touch them at all for guaranteed stability on max possible frequency,
  since without these, the whole configuration is exactly per Nvidia's and
  RAM vendor's specifications.

 Syntax:
  T210:    Freq MHz +  BA. FFFFF[BA]. (18624[00] -> 18624[52])
  T210B01: Freq MHz + CBA. FFFF[CBA]. (2133[000] -> 2133[252])

 Description of F, A, B and C timing overclocking options:
  [F]: Actual clock frequency. Exceeding chip's real max is actual OC.

  [A]: Base Latency reduction.
  Base latency decreases based on selected frequency bracket.
  Brackets: 1333/1600/1866/2133.
   - Range: 0 - 3. 0 to -3 bracket change.
   Example 1: 1866 with 2 is 1333 base latency. Originally 1866 bracket.
   Example 1: 1866 with 3 is 1333 base latency. Originally 1866 bracket.
   Example 2: 1996 with 3 is 1333 base latency. Originally 2133 bracket.
   Example 3: 2133 with 2 is 1600 base latency. Originally 2133 bracket.
   Example 4: 2400 with 0 is 2133 base latency. Originally 2133 bracket.

  [B]: Core Timings reduction.
  Timings that massively get affected by temperatures are not touched.
   - Range: 0 - 9. 0% to 45% reduction.

  [C]: BW Increase. T210B01/LPDDR4x only. RAM Temperature limited timings.
  Can cause significant ram data corruption if ram temperature exceeds max.
  Reason is not allowed on T210 and LPDDR4.
   - 0/1/2/3/4: for max 85/75/65/55/45 oC

 RAM Temperature is only related to MEM/PLL sensors and not to Tdiode or Tboard.
 45oC is 50/51 oC MEM/PLL (around 43 oC Tdiode, depends on temp equilibrium).
 65oC is 68/69 oC MEM/PLL (around 60 oC Tdiode, depends on temp equilibrium).

 Full Examples:
  Old (no timing adjustments) OC equivalents:
   - 1862 Old OC: 15% -> [A1,B3,C0] - 1866031
   - 1996 Old OC: 25% -> [A2,B5,C0] - 2000052

  T210 Examples:
   - 19968[00] -> 1996800: 1996 MHz with read/write base latency of 2133 MHz
                           and proper 1996 MHz core timings.
   - 19968[00] -> 1996852: 1996 MHz with read/write base latency of 1600 MHz
                           and reduced core timings by 25%.
  T210B01 Examples:
   - 2666[000] -> 2666000: 2666 MHz with read/write base latency of 2133 MHz
                           and proper 2666 MHz core timings.
   - 2666[000] -> 2666252: 2666 MHz with read/write base latency of 1600 MHz,
                           reduced core timings by 25% and up to 65C operation.

Again, do not use them if you want the ram running like Nvidia and RAM vendor
made the tables, and write the frequency `as is` in that case.


[ram_oc_vdd2=0]
 Changes VDDIO/VDDQ voltage for T210. VDDIO only for T210B01.
 Can stabilize timing reduction or if at frequency limit.
 Do not use for zero reason. Limits are fully safe (official Jedec).
 Range: 1100 - 1175. (Unit in mV).

[ram_oc_vddq=0]
 Changes VDDQ voltage for T210B01.
 Can stabilize timing reduction or if at frequency limit.
 Do not use for zero reason. Limits are fully safe (official Jedec).
 Range: 600 - 650. (Unit in mV).

================================================================================
