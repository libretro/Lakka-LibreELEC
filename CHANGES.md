# v3.6
* Update RetroArch to 1.9.13.1
* Update libretro cores to latest
* Add new libretro core: `ecwolf`
* Add new libretro core: `beetle-pce`
* Add highscore.dat for `fbneo` to RetroArch system folder
* Add artwork files, cheat.dat and history.dat for `mame2003-plus` to RetroArch system folder
* Add engine files, themes, soundfont and basic scummvm.ini for `scummvm` to RetroArch system folder
* Update Mesa to 21.2.5
* Fix issue with older Intel GPUs (crocus driver is now preferred, `MESA_LOADER_DRIVER_OVERRIDE` is not required anymore)
* Update mainline kernel to 5.10.78
* Update Raspberry kernel/firmware files to 1.20211029

# v3.5.2
* Update RetroArch to 1.9.12
* Update libretro cores to latest
* Add DAT/XML files for `fbneo` and `mame2003-plus` playlist scanning
* Add SAMBA share for database files on the image
* Fix mount units for Nintendo Switch
* Remove `disable_ertm=1` from `xpadneo` driver package

# v3.5.1
* Update RetroArch to 1.9.11
* Update libretro cores to latest
* Update Mesa to [21.2.4](https://docs.mesa3d.org/relnotes/21.2.4.html)
* Update Kernel to 5.10.72 (Generic, iMX6)
* Update Kernel/Firmware to 1.20210928 (RPi)
* Fix CRT / analog output on Raspberry Pi ([more](https://github.com/libretro/Lakka-LibreELEC/wiki/Raspberry-Pi#composite-output)
* Expose `/storage/.cache` as `Services` samba share
* Add vulkan-tools (Generic)

# v3.5
* Add support for [Anbernic RG351MP](https://anbernic.com/products/anbernic-new-rg351mp-retro-games-built)
* Update Mesa to [21.2.3](https://docs.mesa3d.org/relnotes/21.2.3.html)
* Update Linux kernel to 5.10.68 and kernel firmware to 20210919 (Generic, iMX6)
* Fix libraries for interfacing to Raspberry Pi GPU on aarch64
* Add WireGuard VPN support
* Add action to remove bluetooth pairing (**Settings** &rarr; **Bluetooth** &rarr; ***Bluetooth device*** &rarr; <kbd>Start</kbd> button or <kbd>Space</kbd> key)
* Add [xpadneo driver](https://atar-axis.github.io/xpadneo/) to support wireless Xbox gamepads (all, but L4T)
* Update 'default' kernel to 5.1.21 (Allwinner, Amlogic)
* Set HDMI output resolution to 720p, drop A20 devices (Allwinner)
* Add support for [Capcom Home Arcade](https://capcomhomearcade.com/uk)
* Replace i965 intel driver with the updated crocus one (Generic)
* Add support for [PiBoy DMG](https://www.experimentalpi.com/PiBoy-DMG--Kit_p_18.html) (RPi)
* Add support for non-standard modes in VEC - enhances CRT output (RPi)
* Update kernel/firmware to 1.20210831 (RPi)
* Enable additional PARPORT modules/features - fixes Gamecon module (Generic x64)
* Remove old mupen64plus core
* Enable RSP dynarec in parallel_n64 core (Generic)
* Enable RDP and RSP dynarec in mupen64plus_next (Generic)
