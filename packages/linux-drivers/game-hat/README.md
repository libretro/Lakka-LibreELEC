# Game HAT driver for Lakka

## Status

- Video: working, resolution is 640x480
- Audio: working, with volume hotkeys
- Inputs: working, with analog mapped to DPAD
- Touch screen: cannot work without xorg, which Lakka doesn't have

The Raspberry Pi 1 is currently not supported but can be if requested.

## Input mapping

- Menu toggle: SELECT + START
- Volume up: SELECT + L
- Volume down: SELECT + R
- Analog mapped to DPAD if the current core doesn't use analog
- All other buttons are mapped as usual

If you would like to change this mapping, edit `/joypads/udev/Game-HAT.cfg` (see below).

## How to use

1. Install and boot Lakka on your Raspberry Pi at least once before installing the HAT to create and populate the storage partition, then install the HAT
2. Plug your RPi SD Card in your PC
3. Add the following lines to the end of `config.txt` (`LAKKA` partition)

```txt
# Enable audio (loads snd_bcm2835)
dtparam=audio=on
dtoverlay=waveshare32b:rotate=270
hdmi_force_hotplug=1

hdmi_group=2

hdmi_mode=87

hdmi_cvt=640 480 60 1 0 0 0

disable_overscan=1

dtparam=spi=on
avoid_warnings=1
```

4. Create a file called `joystick.conf` in `/.config/modprobe.d/` (`LAKKA_DISK` partition)
5. Inside that file, write the following line: `options mk_arcade_joystick_rpi map=1` and save
6. Create a file called `game-hat.conf` in `/.config/modules-load.d/` (`LAKKA_DISK` partition)
7. Inside that file, write the following line: `mk_arcade_joystick_rpi` and save
8. Create a `udev` folder in the `/joypads/` folder (`LAKKA_DISK` partition)
9. Inside this folder, create a new file called `Game-HAT.cfg`
10. Write the following content to this file:

```
# Game HAT Input Mapping and Configuration
input_driver = "udev"
input_device_display_name = "Game HAT"
input_vendor_id = "1"
input_product_id = "1"

# Buttons mapping
input_a_btn = "0"
input_b_btn = "1"
input_y_btn = "4"
input_x_btn = "3"

input_select_btn = "10"
input_start_btn = "11"

input_l_btn = "7"
input_r_btn = "6"

# Analog mapping
input_up_axis = "-1"
input_down_axis = "+1"
input_left_axis = "-0"
input_right_axis = "+0"

# Map DPAD to left analog
input_analog_dpad_mode = "1"

# Hotkeys: enabled with SELECT
input_enable_hotkey_btn = "10"

# Menu toggle: SELECT + START
input_menu_toggle_btn = "11"

# Volume: SELECT + L / R
input_volume_down_btn = "7"
input_volume_up_btn = "6"
```

11. Edit `/.config/retroarch/retroarch.cfg` (`LAKKA_DISK` partition):
    - Set `xmb_layout` to `"2"` to increase the menu legibility
    - Set `video_font_size` to `"24.000000"` to increase the OSD legibility
12. Unmount the SD Card and put it back into the RPi - your copy of Lakka is now ready to be used with the Game HAT!
