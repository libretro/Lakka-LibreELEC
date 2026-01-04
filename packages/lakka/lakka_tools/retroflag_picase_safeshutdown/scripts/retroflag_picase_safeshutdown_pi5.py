#!/usr/bin/env python

#
# For RPi5
# The safe shutdown script for RETROFLAG Pi CASE series for Lakka-v6 (lg-gpio version)
# https://abyz.me.uk/lg/
# https://abyz.me.uk/lg/py_lgpio.html
#


import os
os.environ["LG_WD"] = "/tmp"
import lgpio as sbc
import time
import signal


handle=-1
powerPin = 3 #pin 5
ledPin = 14 #TXD
resetPin = 2 #pin 13
powerenPin = 4 #pin 5
LED_status = 0 #LED ON=1 OFF=0


def init():

	global handle
	global LED_status

	# Open GPIO handle.
	handle = sbc.gpiochip_open(0)

	# Activate PowerEn Pin for enable PowerSwitch.
	# Updates for RETROFLAG Pi case completely power off:
	# PowerEn Pin is better activated by "gpio-poweroff" overlay in distroconfig.txt.
	# sbc.gpio_claim_output(handle, powerenPin, level=1)

	# Enable Power LED.
	LED_status = 1
	sbc.gpio_claim_output(handle, ledPin, level=LED_status)

	# RPi5 safeshutdown is supported by OS
	# Add poweroff() callback.
	# sbc.gpio_claim_alert(handle, powerPin, sbc.FALLING_EDGE, lFlags=sbc.SET_PULL_UP)
	# sbc.callback(handle, powerPin, sbc.FALLING_EDGE, poweroff)

        # Add reset() callback.
	sbc.gpio_claim_alert(handle, resetPin, sbc.FALLING_EDGE, lFlags=sbc.SET_PULL_UP)
	sbc.callback(handle, resetPin, sbc.FALLING_EDGE, reset)


# RPi5 safeshutdown is supported by OS
# def poweroff(chip, gpio, level, timestamp):
#
#	# Start LED blink.
#	signal.setitimer(signal.ITIMER_REAL, 0.2, 0.2)
#
#	# Stop retroarch.service.
#	os.system("systemctl stop retroarch")
#
#	# Wait 1 sec.
#	time.sleep(1)
#
#	# Shutdown system.
#	os.system("systemctl poweroff")


def reset(chip, gpio, level, timestamp):

	# Start LED blink.
	signal.setitimer(signal.ITIMER_REAL, 0.2, 0.2)

	# Stop retroarch.service.
	os.system("systemctl stop retroarch")

	# Wait 1 sec.
	time.sleep(1)

	# Shutdown system.
	os.system("systemctl reboot")


def ledBlink(arg1, arg2):

	global LED_status

	if LED_status == 1:
		# LED ON -> OFF
		LED_status = 0
	else:
		# LED OFF -> ON
		LED_status = 1

	sbc.gpio_write(handle, ledPin, LED_status)


def main():

	# Initialize
	init()

	# Register signal handler for LED blink
	signal.signal(signal.SIGALRM, ledBlink)

	# Loop & sleep
	while True:
		time.sleep(1)


if __name__ == "__main__":
    main()

