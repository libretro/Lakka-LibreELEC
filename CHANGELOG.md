# v4.4
* Add new libretro core: `dirksimple`
* Add new libretro core: `jaxe`
* Add new libretro core: `numero`
* Add new libretro core: `thepowdertoy`
* Add new libretro core: `ep128emu`
* Update buildsystem to LibreELEC 10.0.4

# v4.3
* Update RetroArch to [1.14.0](https://www.libretro.com/index.php/retroarch-1-14-0-release/)
* Add new libretro core: `fake08`
* Add new libretro core: `mojozork`
* Add new libretro core: `puae2021`
* Update Mesa to [22.1.7](https://docs.mesa3d.org/relnotes/22.1.7.html)
* Add support for more Nintendo Switch variants
* Add Orange Pi 4 LTS (Rockchip RK3399)
* Update raspberry kernel to 5.10.110
* Update amlogic kernel to 5.11.22
* Update mainline kernel to 5.10.123

# v4.2
* Update RetroArch to [1.10.3](https://www.libretro.com/index.php/retroarch-1-10-3-release/)
* Add new libretro core: `a5200`
* `race`: fix savestates on arm platforms
* Update Mesa to [22.0.2](https://docs.mesa3d.org/relnotes/22.0.2.html)
* Amlogic: disable composite output by default
* Generic: add support for [Ventoy](https://www.ventoy.net) back

# v4.1
* Update RetroArch to [1.10.2](https://www.libretro.com/index.php/retroarch-1-10-2-release/)
* RetroArch standalone cores: add files needed to run these cores to the image (therefore disabled the system files downloader)
* Add new libretro core: `race`
* Add new libretro core: `bk`
* Add new libretro core: `same_cdi`
* Add new libretro core: `mame` (current)
* Fix `easyrpg` libretro core
* Drop `duckstation` core
* Update mainline kernel to 5.10.109 (PC, Allwinner, Amlogic, NXP)
* Update raspberry kernel to 5.10.103
* Fix Nvidia support (build driver as module)
* Fix ethernet and wifi on Intel NUC 11
* Add support for ASUS BT500 and TP-Link UB500 USB Wi-Fi adapters
* Update Mesa to [22.0.1](https://docs.mesa3d.org/relnotes/22.0.1.html)
* Fix custom shutdown scripts (add RPi.GPIO Python library)

# v4.0
* Update build system to LibreELEC 10.0.2
* Update Mesa to [22.0.0](https://docs.mesa3d.org/relnotes/22.0.0.html)
* Update RetroArch to [1.10.1](https://www.libretro.com/index.php/retroarch-1-10-1-release/)
* Add new libretro core: `sameduck`
* Add new libretro core: `superbroswar`
* L4T/Switch: complete new port with many fixes and enhancements
* Update mainline kernel to 5.10.103 (PC, Allwinner, Amlogic, NXP)
* Update Raspberry kernel/firmware to 5.10.95
* Rockchip devices: switch to mainline kernel (5.10.76)

# v3.7.3
* Maintenance release
* Update RetroArch to [1.10.3](https://www.libretro.com/index.php/retroarch-1-10-3-release/)
* Update libretro cores to the same version as on 4.x
* Add new libretro core: `a5200`

# v3.7.2
* Maintenance release
* Update RetroArch to [1.10.2](https://www.libretro.com/index.php/retroarch-1-10-2-release/)
* Update libretro cores to the same version as on 4.x
* Add new libretro core: `sameduck`
* Add new libretro core: `race`
* Add new libretro core: `bk`
* Drop `duckstation` core

# v3.7.1
* Maintenance release
* Update RetroArch to [1.10.1](https://www.libretro.com/index.php/retroarch-1-10-1-release/)
* Update libretro cores to the same version as on 4.x

# v3.7
* Update RetroArch to [1.10.0](https://www.libretro.com/index.php/retroarch-1-10-0-release/)
* Update libretro cores to the latest
* Add [small utility](https://github.com/spleen1981/xbox360-controllers-shutdown) to turn off Xbox360 controllers
* Fix AML aarch64 cores compilation
* Update Mesa to [21.3.6](https://docs.mesa3d.org/relnotes/21.3.6.html)
* Rollback Raspberry kernel/firmware files to 1.20210831 (fixes issue with 4K displays not initializing)
* Update mainline kernel to 5.10.101
* Add new libretro core: `wasm4`
* Add new libretro core: `jumpnbump`
* Add new libretro core: `blastem`
* Add new libretro core: `freechaf`
* Add new libretro core: `potator`
* Add new libretro core: `quasi88`
* Add new libretro core: `retro8`
* Add new libretro core: `xmil`
* Add new libretro core: `fmsx`
* Make the `.update` folder on the `STORAGE` partition writable without superuser privilege
* Add new device: Raspberry Pi Zero 2 with GPICase (Pi02GPi.arm)
* Fix recording / streaming in RetroArch
* Raspberry Pi: disable wifi powersaving to improve wifi stability

# v3.6
* Update RetroArch to [1.9.13.1](https://www.libretro.com/index.php/retroarch-1-9-13-release/)
* Update libretro cores to latest
* Add new libretro core: `ecwolf`
* Add new libretro core: `beetle-pce`
* Add highscore.dat for `fbneo` to RetroArch system folder
* Add artwork files, cheat.dat and history.dat for `mame2003-plus` to RetroArch system folder
* Add engine files, themes, soundfont and basic scummvm.ini for `scummvm` to RetroArch system folder
* Update Mesa to [21.2.5](https://docs.mesa3d.org/relnotes/21.2.5.html)
* Fix issue with older Intel GPUs (crocus driver is now preferred, `MESA_LOADER_DRIVER_OVERRIDE` is not required anymore)
* Update mainline kernel to 5.10.78
* Update Raspberry kernel/firmware files to 1.20211029

# v3.5.2
* Update RetroArch to [1.9.12](https://www.libretro.com/index.php/retroarch-1-9-12-release/)
* Update libretro cores to latest
* Add DAT/XML files for `fbneo` and `mame2003-plus` playlist scanning
* Add SAMBA share for database files on the image
* Fix mount units for Nintendo Switch
* Remove `disable_ertm=1` from `xpadneo` driver package

# v3.5.1
* Update RetroArch to [1.9.11](https://www.libretro.com/index.php/retroarch-1-9-11-release/)
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
