#!/usr/bin/env python

# This script has been created using the following as a reference:
# https://github.com/RetroFlag/retroflag-picase

from gpiozero import Button, LED
import os
import io
from signal import pause

powerPin = 26
powerPinPullUp = True
powerenPin = 27
hold = 1
power = LED(powerenPin)
power.on()

os_release_file = io.open("/etc/os-release")
device = list(filter(lambda x: x.find('LIBREELEC_DEVICE') == 0, os_release_file.readlines() ))[0][18:-2]
os_release_file.close()

if device == "RPi4-GPICase2":
    powerPinPullUp = False

#functions that handle button events
def when_pressed():
  os.system("shutdown -P now &")

btn = Button(powerPin, hold_time=hold, pull_up=powerPinPullUp)
btn.when_pressed = when_pressed
pause()
