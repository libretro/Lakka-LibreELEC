#!/usr/bin/env python

#
# The safe shutdown script for Retroflag GPiCase2 (lg-gpio version)
# https://abyz.me.uk/lg/
# https://abyz.me.uk/lg/py_lgpio.html
#

import os
os.environ["LG_WD"] = "/tmp"
import lgpio as sbc
import time

handle=-1
powerPin = 26
powerenPin = 27

def poweroff(chip, gpio, level, timestamp):

	# Stop retroarch.service.
	os.system("systemctl stop retroarch")

	# Wait 1 sec.
	time.sleep(1)

	# Close GPIO handle.
	sbc.gpiochip_close(handle)

	# Shutdown system.
	os.system("systemctl poweroff")


# Open GPIO handle.
handle = sbc.gpiochip_open(0)

# Activate PowerEn Pin for enable PowerSwitch.
sbc.gpio_claim_output(handle, powerenPin, level=1)
sbc.gpio_write(handle, powerenPin, 1)

# Add poweroff() callback.
sbc.gpio_claim_alert(handle, powerPin, sbc.FALLING_EDGE, lFlags=sbc.SET_PULL_UP)
sbc.callback(handle, powerPin, sbc.FALLING_EDGE, poweroff)

# Loop & sleep
while True:
	time.sleep(1)

