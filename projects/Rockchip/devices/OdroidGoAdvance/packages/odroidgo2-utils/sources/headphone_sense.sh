#!/bin/bash

# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2020-present Shanti Gilbert (https://github.com/shantigilbert)

# Switch to headphones if we have them already connected at boot
GPIO=$(cat /sys/class/gpio/gpio86/value)
[[ "$GPIO" == "1" ]] && amixer cset name='Playback Path' HP  || amixer cset name='Playback Path' SPK

# Headphone sensing 
DEVICE='/dev/input/event1'

HP_ON='*(SW_HEADPHONE_INSERT), value 0*'
HP_OFF='*(SW_HEADPHONE_INSERT), value 1*'

/usr/bin/evtest "${DEVICE}" | while read line; do
    case $line in
	(${HP_ON})
	amixer cset name='Playback Path' HP 
	;;
	(${HP_OFF})
	amixer cset name='Playback Path' SPK
	;;
    esac
done
