#!/usr/bin/env python2

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

#functions that handle button events
def when_pressed():
  os.system("shutdown -P now &")
  
btn = Button(powerPin, hold_time=hold)
btn.when_pressed = when_pressed
pause()
