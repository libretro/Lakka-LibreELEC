!/bin/sh

#Allow all users to change cpu/gpu freq/scalers, and auto enable overclock

#CPU
/usr/bin/busybox chmod 766 /sys/kernel/tegra_cpufreq/overclock
/usr/bin/busybox chmod 766 /sys/devices/system/cpu/cpufreq/policy0/scaling_governor
/usr/bin/busybox chmod 766 /sys/devices/system/cpu/cpufreq/policy0/scaling_max_freq
/usr/bin/busybox chmod 766 /sys/devices/system/cpu/cpufreq/policy0/scaling_min_freq

#GPU
/usr/bin/busybox chmod 766 /sys/devices/57000000.gpu/devfreq/57000000.gpu/governor
/usr/bin/busybox chmod 766 /sys/devices/57000000.gpu/devfreq/57000000.gpu/max_freq
/usr/bin/busybox chmod 766 /sys/devices/57000000.gpu/devfreq/57000000.gpu/min_freq
