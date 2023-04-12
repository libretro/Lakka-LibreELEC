#!/bin/sh

#Allow all users to take advantage of changing Clock stuff, and setting R2P stuff.

#CPU
/usr/bin/busybox chmod 766 /sys/kernel/tegra_cpufreq/overclock
/usr/bin/busybox chmod 766 /sys/devices/system/cpu/cpufreq/policy0/scaling_governor
/usr/bin/busybox chmod 766 /sys/devices/system/cpu/cpufreq/policy0/scaling_max_freq
/usr/bin/busybox chmod 766 /sys/devices/system/cpu/cpufreq/policy0/scaling_min_freq

#GPU
/usr/bin/busybox chmod 766 /sys/devices/57000000.gpu/devfreq/57000000.gpu/governor
/usr/bin/busybox chmod 766 /sys/devices/57000000.gpu/devfreq/57000000.gpu/max_freq
/usr/bin/busybox chmod 766 /sys/devices/57000000.gpu/devfreq/57000000.gpu/min_freq

#Bluetooth ERTM disable toggle
/usr/bin/busybox chmod 766 /sys/module/bluetooth/parameters/disable_ertm

#R2P
/usr/bin/busybox chmod 766 /sys/module/pmc_r2p/parameters/enabled
/usr/bin/busybox chmod 766 /sys/module/pmc_r2p/parameters/action
/usr/bin/busybox chmod 766 /sys/module/pmc_r2p/parameters/entry_id
/usr/bin/busybox chmod 766 /sys/module/pmc_r2p/parameters/param1
/usr/bin/busybox chmod 766 /sys/module/pmc_r2p/parameters/param2

#Brightness
/usr/bin/busybox chmod 766 /sys/class/backlight/backlight/brightness
