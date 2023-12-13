#!/usr/bin/env python

# This script has been created using the following as a reference:
# https://github.com/RetroFlag/GPiCase2-Script
# And, Pull Request #4 "lakka patch & safe shutdown script & audio fix"
# https://github.com/RetroFlag/GPiCase2-Script/pull/4
#
# Currently, lcdrun() and audiofix() are disabled.

import RPi.GPIO as GPIO
import os
import time
from multiprocessing import Process

#initialize pins
#powerPin = 26 #pin 5
#ledPin = 14 #TXD
#resetPin = 2 #pin 13
#powerenPin = 27 #pin 5

powerPin = 26
powerenPin = 27

#initialize GPIO settings
def init():
	GPIO.setmode(GPIO.BCM)
	GPIO.setup(powerPin, GPIO.IN, pull_up_down=GPIO.PUD_UP)
	GPIO.setup(powerenPin, GPIO.OUT, initial=GPIO.HIGH)
	GPIO.output(powerenPin, GPIO.HIGH)
	GPIO.setwarnings(False)

#waits for user to hold button up to 1 second before issuing poweroff command
def poweroff():
	while True:
		#self.assertEqual(GPIO.input(powerPin), GPIO.LOW)
		GPIO.wait_for_edge(powerPin, GPIO.FALLING)
		#start = time.time()
		#while GPIO.input(powerPin) == GPIO.HIGH:
		#	time.sleep(0.5)
		os.system("systemctl stop retroarch")
		time.sleep(1)
		os.system("systemctl poweroff")

#def lcdrun():
#	while True:
#		os.system("sh /opt/RetroFlag/lcdnext.sh")
#		time.sleep(1)

#def audiofix():
#	while True:
#		time.sleep(0.5)
#		os.system("systemctl restart retroarch")
#		break

if __name__ == "__main__":
	#initialize GPIO settings
	init()
	#create a multiprocessing.Process instance for each function to enable parallelism 
	powerProcess = Process(target = poweroff)
	powerProcess.start()
#	lcdrunProcess = Process(target = lcdrun)
#	lcdrunProcess.start()
#	audiofixProcess = Process(target = audiofix)
#	audiofixProcess.start()

	powerProcess.join()
#	lcdrunProcess.join()
#	audiofixProcess.join()

	GPIO.cleanup()

