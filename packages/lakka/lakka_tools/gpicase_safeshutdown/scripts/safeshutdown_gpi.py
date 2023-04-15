#!/usr/bin/env python

# This script has been created using the following as a reference:
# https://github.com/RetroFlag/retroflag-picase

from gpiozero import Button, LED
import os
from signal import pause

powerPin = 26
powerenPin = 27
hold = 1
power = LED(powerenPin)
power.on()

with open('/etc/os-release', 'r') as data:
    content = data.read()
device = list(filter(lambda x: x.find('LIBREELEC_DEVICE') == 0, content.splitlines()))[0][18:-1]

powerPinPullUp = False if device == 'RPi4-GPICase2' else True

#functions that handle button events
def when_pressed():
  os.system("shutdown -P now &")

btn = Button(powerPin, hold_time=hold, pull_up=powerPinPullUp)
btn.when_pressed = when_pressed
pause()
