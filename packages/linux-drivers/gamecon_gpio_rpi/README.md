# Game controller driver for Raspberry Pi's GPIO
    
## 1. Intro

The driver is designed to be used with retro game controllers connected to Raspberry Pi's GPIO. Currently, up to 4 controllers of following types are supported:

- NES gamepads
- SNES gamepads
- PSX/PS2 gamepads
- N64 gamepads
- Gamecube gamepads
    
The driver is based on gamecon driver, but uses different pinout and parameters. No warranty - use at your own risk.

## 2. Required hardware

- Raspberry Pi and supported controllers
- Jumper wires between GPIO and pads
- Breadboard or splitter if multiple controllers are connected simultaneously


## 3. Connecting the controllers

GPIO pinout: http://elinux.org/Rpi_Low-level_peripherals

Pins P1-01 and P1-06 are used as common power and ground for all controllers. Note that 3.3V is used for all controllers, even if SNES&NES pads nominally are operated at 5V. They should work fine with 3.3V so no level shifters are needed for data pins. The maximum current spec (50mA) should be enough for 4 controllers. However, use a proper ac adapter with Pi to avoid any unwanted voltage drops.

Pins P1-03,05,07,26 (GPIO0, GPIO1, GPIO4 and GPIO7) are independent data pins, one per pad. NOTE: P1-03 & P1-05 correspond to GPIO2 G GPIO3 in rev.2 board, which must taken into account when loading the module. This is explained in section 4.

Pins P1-19 & P1-23 (GPIO10 & 11) are common signal pins for all NES/SNES pads. Pins P1-08, P1-10 & P1-12 (GPIO14, 15 & 18) are common signal pins for all PSX/PS2 pads.

### 3.1 NES & SNES gamepads

| Rpi pin      |        | SNES controller pin | NES controller pin |
| ------------ | ------ | ------------------- | ------------------ |
| P1-01 (3.3V) | `====` | 1 (power)           | 1 (power)          |
| GPIO10       | `--->` | 2 (clock)           | 5 (clock)          |
| GPIO11       | `--->` | 3 (latch)           | 6 (latch)          |
| GPIOXX       | `<---` | 4 (serial data)     | 7 (data)           |
| P1-06 (GND)  | `====` | 7 (ground)          | 4 (ground)         |

GPIOXX is the independent data pin. See section 4 on how to select the correct GPIO.

SNES&NES controller pinout: http://pinoutsguide.com/Game/snescontroller_pinout.shtml

### 3.2 N64 pads

| Rpi pin      |        | N64 controller pin |
| ------------ | ------ | ------------------ |
| P1-01 (3.3V) | `====` | power (leftmost)   |
| GPIOXX       | `<-->` | data (middle)      |
| P1-06 (GND)  | `====` | ground (rightmost) |

GPIOXX is the independent data pin. See section 4 on how to select the correct GPIO.

N64 controller pinout: http://www.larsivar.com/cp/images/n64_pinout.png


### 3.3 Gamecube pads

| Rpi pin      |        | Gamecube controller pin |
| ------------ | ------ | ----------------------- |
| P1-01 (3.3V) | `====` | 6 (power/3.43V)         |
| GPIOXX       | `<-->` | 3 (data)                |
| P1-06 (GND)  | `====` | 2&5 (gnd)               |

GPIOXX is the independent data pin. See section 4 on how to select the correct GPIO.

Gamecube controller pinout: https://cdn.hackaday.io/images/402451542330582063.png


### 3.4 PSX/PS2 pads

| Rpi pin      |        | PSX controller pin |
| ------------ | ------ | ------------------ |
| P1-01 (3.3V) | `====` | 5 (power/3.3V)     |
| GPIO14       | `--->` | 2 (command)        |
| GPIO15       | `--->` | 6 (select)         |
| GPIO18       | `--->` | 7 (clock)          |
| GPIOXX       | `<---` | 1 (data)           |
| P1-06 (GND)  | `====` | 4 (ground)         |

GPIOXX is the independent data pin. See section 4 on how to select the correct GPIO.

NOTE: P1-07 and P1-26 do not have on-board pullup resistors which are required for reliable operation with PSX/PS2 pads. Connect an external pullup resistor (1.8k-4.7k) between the pin and 3.3V (P1-01) if you use it with PSX/PS2 pad.

PSX/PS2 controller pinout: https://www.rhydolabz.com/wiki/wp-content/uploads/PS2_Controller-01.jpg


## 4. Enabling and configuring the driver

Perform the following operations as root (or with sudo):


### 4.1 Enable the module and configure pads
```
# modprobe gamecon_gpio_rpi map=<pad1/GPIO0>,<pad2/GPIO1>,<pad3/GPIO4>,<pad4/GPIO7>,<pad5/GPIO2>,<pad6/GPIO3>
```
where <pad...> is a number defining the pad type:
- 0 = no connection
- 1 = SNES pad
- 2 = NES pad
- 3 = Gamecube pad
- 4 = NES Fourscore
- 6 = N64 pad
- 7 = PSX/PS2 pad
- 8 = PSX DDR controller
- 9 = SNES mouse 

For example, if a snes pad is connected to GPIO0 and a N64 pad to GPIO7, the command would be `modprobe gamecon_gpio_rpi map=1,0,0,6`.

NOTE: pad1 & pad2 are only used with rev.1 board, and pad5 and pad6 with rev.2. So if you have rev.2 board, pad1 and pad2 must be set as 0.

The final pad index (used by the programs) is assigned sequentially for connected pads starting from 0. So in the previous example, snes pad would get index 0 and N64 pad index 1.

Use `tail /var/log/kern.log` to verify that module loading was successful.

### 4.2 Testing the pads
```
# jstest /dev/input/jsX
```
where X corresponds to the pad index (0-3)
    
### 4.3 Calibrating the axis of N64 analog pad
```
# jscal -s 4,1,0,0,0,6972137,6972137,1,0,0,0,6547006,6468127,1,0,0,0,536854528,536854528,1,0,0,0,536854528,536854528 /dev/input/jsX
```
for each N64 controller

### 4.4 Permanently enabling the module

```
# echo "options gamecon_gpio_rpi map=#,#,#,#,#,#" >> /storage/.config/modprobe.d/gamecon.conf
```
Replace hashes with your pad types.

## 5. More information
- http://www.raspberrypi.org/phpBB3/viewtopic.php?f=78&t=15787
- https://github.com/RetroPie/RetroPie-Setup/wiki/GPIO-Modules#gamecon_gpio_rpi