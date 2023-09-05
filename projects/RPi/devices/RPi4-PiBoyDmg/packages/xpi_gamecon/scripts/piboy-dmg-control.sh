#!/bin/bash

stop_retroarch() {
	systemctl stop \
		retroarch.service \
		tmp-assets.mount \
		tmp-cheats.mount \
		tmp-cores.mount \
		tmp-database.mount \
		tmp-joypads.mount \
		tmp-overlays.mount \
		tmp-shaders.mount \
		tmp-system.mount
}

while [ 2 -gt 1 ]
do
	sleep 1
	VOL=`cat /sys/kernel/xpi_gamecon/volume`
	TEMP=`cat /sys/class/thermal/thermal_zone0/temp`
	POWERSW=`cat /sys/kernel/xpi_gamecon/status`
	BATTERY=`cat /sys/kernel/xpi_gamecon/percent`
	amixer -M set PCM $VOL%
	if [[ $TEMP -gt 70000 ]]  
	then
		echo 100 > /sys/kernel/xpi_gamecon/fan
	else
		echo 0 > /sys/kernel/xpi_gamecon/fan 
	fi
	if [[ $POWERSW -eq 6 ]]
	then
		stop_retroarch
		echo "0" > /sys/kernel/xpi_gamecon/flags
		/usr/sbin/rmmod xpi_gamecon
		/usr/sbin/shutdown -P
	fi
	if [[ $BATTERY -lt 5 ]]
	then
		stop_retroarch
		echo "0" > /sys/kernel/xpi_gamecon/flags
		/usr/sbin/rmmod xpi_gamecon
		/usr/sbin/shutdown -P
        fi
done

