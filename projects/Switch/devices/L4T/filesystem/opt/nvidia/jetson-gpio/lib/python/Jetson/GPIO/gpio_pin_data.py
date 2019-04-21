# Copyright (c) 2018, NVIDIA CORPORATION. All rights reserved.
# Permission is hereby granted, free of charge, to any person obtaining a
# copy of this software and associated documentation files (the "Software"),
# to deal in the Software without restriction, including without limitation
# the rights to use, copy, modify, merge, publish, distribute, sublicense,
# and/or sell copies of the Software, and to permit persons to whom the
# Software is furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
# DEALINGS IN THE SOFTWARE.

import os
import sys

JETSON_XAVIER = 'JETSON_XAVIER'
JETSON_TX2 = 'JETSON_TX2'
JETSON_TX1 = 'JETSON_TX1'
JETSON_NANO = 'JETSON_NANO'

# These arrays contain tuples of all the relevant GPIO data for each Jetson
# Platform. The format is represented as so - (Linux GPIO pin number,
# GPIO chip directory, board pin number, BCM pin number, CVM pin number,
# TEGRA_SOC pin number)
# The values are use to generate dictionaries that map the corresponding pin
# mode numbers to the Linux GPIO pin number and GPIO chip directory
JETSON_XAVIER_PIN_DEFS = [
    (134, "/sys/devices/2200000.gpio", 7, 4, 'MCLK05', 'SOC_GPIO42'),
    (140, "/sys/devices/2200000.gpio", 11, 17, 'UART1_RTS', 'UART1_RTS'),
    (63, "/sys/devices/2200000.gpio", 12, 18, 'I2S2_CLK', 'DAP2_SCLK'),
    (136, "/sys/devices/2200000.gpio", 13, 27, 'PWM01', 'SOC_GPIO44'),
    (105, "/sys/devices/2200000.gpio", 15, 22, 'GPIO27', 'SOC_GPIO54'),
    (8, "/sys/devices/c2f0000.gpio", 16, 23, 'GPIO8', 'CAN1_STB'),
    (56, "/sys/devices/2200000.gpio", 18, 24, 'GPIO35', 'SOC_GPIO12'),
    (205, "/sys/devices/2200000.gpio", 19, 10, 'SPI1_MOSI', 'SPI1_MOSI'),
    (204, "/sys/devices/2200000.gpio", 21, 9, 'SPI1_MISO', 'SPI1_MISO'),
    (129, "/sys/devices/2200000.gpio", 22, 25, 'GPIO17', 'SOC_GPIO21'),
    (22, "/sys/devices/2200000.gpio", 23, 11, 'SPI1_CLK', 'SPI1_SCK'),
    (206, "/sys/devices/2200000.gpio", 24, 8, 'SPI1_CS0_N', 'SPI1_CS0_N'),
    (207, "/sys/devices/2200000.gpio", 26, 7, 'SPI1_CS1_N', 'SPI1_CS1_N'),
    (3, "/sys/devices/c2f0000.gpio", 29, 5, 'CAN0_DIN', 'CAN0_DIN'),
    (2, "/sys/devices/c2f0000.gpio", 31, 6, 'CAN0_DOUT', 'CAN0_DOUT'),
    (9, "/sys/devices/c2f0000.gpio", 32, 12, 'GPIO9', 'CAN1_EN'),
    (0, "/sys/devices/c2f0000.gpio", 33, 13, 'CAN1_DOUT', 'CAN1_DOUT'),
    (66, "/sys/devices/2200000.gpio", 35, 19, 'I2S2_FS', 'DAP2_FS'),
    (141, "/sys/devices/2200000.gpio", 36, 16, 'UART1_CTS', 'UART1_CTS'),
    (1, "/sys/devices/c2f0000.gpio", 37, 26, 'CAN1_DIN', 'CAN1_DIN'),
    (65, "/sys/devices/2200000.gpio", 38, 20, 'I2S2_DIN', 'DAP2_DIN'),
    (64, "/sys/devices/2200000.gpio", 40, 21, 'I2S2_DOUT', 'DAP2_DOUT')
]

JETSON_TX2_PIN_DEFS = [
    (76, "/sys/devices/2200000.gpio", 7, 4, 'AUDIO_MCLK', 'AUD_MCLK'),
    (146, "/sys/devices/2200000.gpio", 11, 17, 'UART0_RTS', 'UART1_RTS'),
    (72, "/sys/devices/2200000.gpio", 12, 18, 'I2S0_CLK', 'DAP1_SCLK'),
    (77, "/sys/devices/2200000.gpio", 13, 27, 'GPIO20_AUD_INT', 'GPIO_AUD0'),
    (15, "/sys/devices/3160000.i2c/i2c-0/0-0074", 15, 22, 'GPIO_EXP_P17', 'GPIO_EXP_P17'),
    (40, "/sys/devices/c2f0000.gpio", 16, 23, 'AO_DMIC_IN_DAT', 'CAN0_GPIO0'),
    (161, "/sys/devices/2200000.gpio", 18, 24, 'GPIO16_MDM_WAKE_AP', 'GPIO_MDM2'),
    (109, "/sys/devices/2200000.gpio", 19, 10, 'SPI1_MOSI', 'GPIO_CAM6'),
    (108, "/sys/devices/2200000.gpio", 21, 9, 'SPI1_MISO', 'GPIO_CAM5'),
    (14, "/sys/devices/3160000.i2c/i2c-0/0-0074", 22, 25, 'GPIO_EXP_P16', 'GPIO_EXP_P16'),
    (107, "/sys/devices/2200000.gpio", 23, 11, 'SPI1_CLK', 'GPIO_CAM4'),
    (110, "/sys/devices/2200000.gpio", 24, 8, 'SPI1_CS0', 'GPIO_CAM7'),
    (None, None, 26, 7, 'SPI1_CS1', None),
    (78, "/sys/devices/2200000.gpio", 29, 5, 'GPIO19_AUD_RST', 'GPIO_AUD1'),
    (42, "/sys/devices/c2f0000.gpio", 31, 6, 'GPIO9_MOTION_INT', 'CAN_GPIO2'),
    (41, "/sys/devices/2200000.gpio", 32, 12, 'AO_DMIC_IN_CLK', 'CAN_GPIO1'),
    (69, "/sys/devices/2200000.gpio", 33, 13, 'GPIO11_AP_WAKE_BT', 'GPIO_PQ5'),
    (75, "/sys/devices/2200000.gpio", 35, 19, 'I2S0_LRCLK', 'DAP1_FS'),
    (147, "/sys/devices/2200000.gpio", 36, 16, 'UART0_CTS', 'UART1_CTS'),
    (68, "/sys/devices/2200000.gpio", 37, 26, 'GPIO8_ALS_PROX_INT', 'GPIO_PQ4'),
    (74, "/sys/devices/2200000.gpio", 38, 20, 'I2S0_SDIN', 'DAP1_DIN'),
    (73, "/sys/devices/2200000.gpio", 40, 21, 'I2S0_SDOUT', 'DAP1_DOUT')
]

JETSON_TX1_PIN_DEFS = [
    (216, "/sys/devices/6000d000.gpio", 7, 4, 'AUDIO_MCLK', 'AUD_MCLK'),
    (162, "/sys/devices/6000d000.gpio", 11, 17, 'UART0_RTS', 'UART1_RTS'),
    (11, "/sys/devices/6000d000.gpio", 12, 18, 'I2S0_CLK', 'DAP1_SCLK'),
    (38, "/sys/devices/6000d000.gpio", 13, 27, 'GPIO20_AUD_INT', 'GPIO_PE6'),
    (15, "/sys/devices/7000c400.i2c/i2c-1/1-0074", 15, 22, 'GPIO_EXP_P17', 'GPIO_EXP_P17'),
    (37, "/sys/devices/6000d000.gpio", 16, 23, 'AO_DMIC_IN_DAT', 'DMIC3_DAT'),
    (184, "/sys/devices/6000d000.gpio", 18, 24, 'GPIO16_MDM_WAKE_AP', 'MODEM_WAKE_AP'),
    (16, "/sys/devices/6000d000.gpio", 19, 10, 'SPI1_MOSI', 'SPI1_MOSI'),
    (17, "/sys/devices/6000d000.gpio", 21, 9, 'SPI1_MISO', 'SPI1_MISO'),
    (14, "/sys/devices/7000c400.i2c/i2c-1/1-0074", 22, 25, 'GPIO_EXP_P16', 'GPIO_EXP_P16'),
    (18, "/sys/devices/6000d000.gpio", 23, 11, 'SPI1_CLK', 'SPI1_SCK'),
    (19, "/sys/devices/6000d000.gpio", 24, 8, 'SPI1_CS0', 'SPI1_CS0'),
    (20, "/sys/devices/6000d000.gpio", 26, 7, 'SPI1_CS1', 'SPI1_CS1'),
    (219, "/sys/devices/6000d000.gpio", 29, 5, 'GPIO19_AUD_RST', 'GPIO_X1_AUD'),
    (186, "/sys/devices/6000d000.gpio", 31, 6, 'GPIO9_MOTION_INT', 'MOTION_INT'),
    (36, "/sys/devices/6000d000.gpio", 32, 12, 'AO_DMIC_IN_CLK', 'DMIC3_CLK'),
    (63, "/sys/devices/6000d000.gpio", 33, 13, 'GPIO11_AP_WAKE_BT', 'AP_WAKE_NFC'),
    (8, "/sys/devices/6000d000.gpio", 35, 19, 'I2S0_LRCLK', 'DAP1_FS'),
    (163, "/sys/devices/6000d000.gpio", 36, 16, 'UART0_CTS', 'UART1_CTS'),
    (187, "/sys/devices/6000d000.gpio", 37, 26, 'GPIO8_ALS_PROX_INT', 'ALS_PROX_INT'),
    (9, "/sys/devices/6000d000.gpio", 38, 20, 'I2S0_SDIN', 'DAP1_DIN'),
    (10, "/sys/devices/6000d000.gpio", 40, 21, 'I2S0_SDOUT', 'DAP1_DOUT')
]

JETSON_NANO_PIN_DEFS = [
    (216, "/sys/devices/6000d000.gpio", 7, 4, 'AUDIO_MCLK', 'AUD_MCLK'),
    (50, "/sys/devices/6000d000.gpio", 11, 17, 'UART2_RTS', 'UART2_RTS'),
    (79, "/sys/devices/6000d000.gpio", 12, 18, 'DAP4_SCLK', 'DAP4_SCLK'),
    (14, "/sys/devices/6000d000.gpio", 13, 27, 'SPI2_SCK', 'SPI2_SCK'),
    (194, "/sys/devices/6000d000.gpio", 15, 22, 'LCD_TE', 'LCD_TE'),
    (232, "/sys/devices/6000d000.gpio", 16, 23, 'SPI2_CS1', 'SPI2_CS1'),
    (15, "/sys/devices/6000d000.gpio", 18, 24, 'SPI2_CS0', 'SPI2_CS0'),
    (16, "/sys/devices/6000d000.gpio", 19, 10, 'SPI1_MOSI', 'SPI1_MOSI'),
    (17, "/sys/devices/6000d000.gpio", 21, 9, 'SPI1_MISO', 'SPI1_MISO'),
    (13, "/sys/devices/6000d000.gpio", 22, 25, 'SPI2_MISO', 'SPI2_MISO'),
    (18, "/sys/devices/6000d000.gpio", 23, 11, 'SPI1_SCK', 'SPI1_SCK'),
    (19, "/sys/devices/6000d000.gpio", 24, 8, 'SPI1_CS0', 'SPI1_CS0'),
    (20, "/sys/devices/6000d000.gpio", 26, 7, 'SPI1_CS1', 'SPI1_CS1'),
    (149, "/sys/devices/6000d000.gpio", 29, 5, 'CAM_AF_EN', 'CAM_AF_EN'),
    (200, "/sys/devices/6000d000.gpio", 31, 6, 'GPIO_PZ0', 'GPIO_PZ0'),
    (168, "/sys/devices/6000d000.gpio", 32, 12, 'LCD_BL_PWM', 'LCD_BL_PW'),
    (38, "/sys/devices/6000d000.gpio", 33, 13, 'GPIO_PE6', 'GPIO_PE6'),
    (76, "/sys/devices/6000d000.gpio", 35, 19, 'DAP4_FS', 'DAP4_FS'),
    (51, "/sys/devices/6000d000.gpio", 36, 16, 'UART2_CTS', 'UART2_CTS'),
    (12, "/sys/devices/6000d000.gpio", 37, 26, 'SPI2_MOSI', 'SPI2_MOSI'),
    (77, "/sys/devices/6000d000.gpio", 38, 20, 'DAP4_DIN', 'DAP4_DIN'),
    (78, "/sys/devices/6000d000.gpio", 40, 21, 'DAP4_DOUT', 'DAP4_DOUT')
]

jetson_gpio_data = {
    'JETSON_XAVIER': {
        'gpio_numbers': {
            'BOARD': {x[2]: (x[0], x[1]) for x in JETSON_XAVIER_PIN_DEFS},
            'BCM': {x[3]: (x[0], x[1]) for x in JETSON_XAVIER_PIN_DEFS},
            'CVM': {x[4]: (x[0], x[1]) for x in JETSON_XAVIER_PIN_DEFS},
            'TEGRA_SOC': {x[5]: (x[0], x[1]) for x in JETSON_XAVIER_PIN_DEFS},
        },
        'JETSON_INFO': {
            'P1_REVISION': 1,
            'RAM': '16384M',
            'REVISION': 'Unknown',
            'TYPE': 'Jetson Xavier',
            'MANUFACTURER': 'NVIDIA',
            'PROCESSOR': 'ARM Carmel'
        }
    },
    'JETSON_TX2': {
        'gpio_numbers': {
            'BOARD': {x[2]: (x[0], x[1]) for x in JETSON_TX2_PIN_DEFS},
            'BCM': {x[3]: (x[0], x[1]) for x in JETSON_TX2_PIN_DEFS},
            'CVM': {x[4]: (x[0], x[1]) for x in JETSON_TX2_PIN_DEFS},
            'TEGRA_SOC': {x[5]: (x[0], x[1]) for x in JETSON_TX2_PIN_DEFS},
        },
        'JETSON_INFO': {
            'P1_REVISION': 1,
            'RAM': '8192M',
            'REVISION': 'Unknown',
            'TYPE': 'Jetson TX2',
            'MANUFACTURER': 'NVIDIA',
            'PROCESSOR': 'ARM A57 + Denver'
        }
    },
    'JETSON_TX1': {
        'gpio_numbers': {
            'BOARD': {x[2]: (x[0], x[1]) for x in JETSON_TX1_PIN_DEFS},
            'BCM': {x[3]: (x[0], x[1]) for x in JETSON_TX1_PIN_DEFS},
            'CVM': {x[4]: (x[0], x[1]) for x in JETSON_TX1_PIN_DEFS},
            'TEGRA_SOC': {x[5]: (x[0], x[1]) for x in JETSON_TX1_PIN_DEFS},
        },
        'JETSON_INFO': {
            'P1_REVISION': 1,
            'RAM': '4096M',
            'REVISION': 'Unknown',
            'TYPE': 'Jetson TX1',
            'MANUFACTURER': 'NVIDIA',
            'PROCESSOR': 'ARM A57'
        }
    },
    'JETSON_NANO': {
        'gpio_numbers': {
            'BOARD': {x[2]: (x[0], x[1]) for x in JETSON_NANO_PIN_DEFS},
            'BCM': {x[3]: (x[0], x[1]) for x in JETSON_NANO_PIN_DEFS},
            'CVM': {x[4]: (x[0], x[1]) for x in JETSON_NANO_PIN_DEFS},
            'TEGRA_SOC': {x[5]: (x[0], x[1]) for x in JETSON_NANO_PIN_DEFS},
        },
        'JETSON_INFO': {
            'P1_REVISION': 1,
            'RAM': '4096M',
            'REVISION': 'Unknown',
            'TYPE': 'Jetson Nano',
            'MANUFACTURER': 'NVIDIA',
            'PROCESSOR': 'ARM A57'
        }
    }
}

def get_gpio_data(model):
    gpio_chip_base = {}
    jetson_model_pin_def = model+"_PIN_DEFS"
    if model not in jetson_gpio_data or model not in jetson_model_pin_def:
        raise Exception("Unknown hardware model " + model)
    gpio_pin_data = jetson_gpio_data[model]
    gpio_chip_dirs = set(filter(None, [x[1] for x in eval(jetson_model_pin_def)]))
    # Get the gpiochip offsets
    for chip in gpio_chip_dirs:
        for filename in os.listdir(chip + '/gpio'):
            if 'gpiochip' in filename:
                with open(chip + '/gpio/' + filename
                          + '/base', 'r') as f:
                    gpio_chip_base[chip] = int(f.read().strip())
                    break
    return gpio_pin_data, gpio_chip_base