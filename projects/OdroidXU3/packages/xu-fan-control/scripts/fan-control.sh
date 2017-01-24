#!/bin/sh
# Credits: https://github.com/nthx/odroid-xu3-fan-control
# this must be placed in /storage/.config folder
# for following /storage/.config/autostart.sh startup
# script to work
#
# contents of /storage/.config/autostart.sh :
# (
# /storage/.config/fancontrol.sh
# ) &

CPUTempReadFrom="/sys/devices/10060000.tmu/temp"
FanSpeedSet="/sys/devices/odroid_fan.14/pwm_duty" 
#change to "/sys/devices/odroid_fan.13/pwm_duty" for Xu3

# Assume Fan is running at full Speed
FanSpeedActual=254

# Disable Fan Auto Control Mode
echo 0 > /sys/devices/odroid_fan.14/fan_mode

while [ true ];
do
  # read current CPU Temperature
  CPUTemperature=`cat ${CPUTempReadFrom} | cut -c11- | sort -nr | head -1`

  FanSpeedAdopted=0
  if [ ${CPUTemperature} -ge 78000 ]; then
    FanSpeedAdopted=254
  elif [ ${CPUTemperature} -ge 75000 ]; then
    FanSpeedAdopted=200
  elif [ ${CPUTemperature} -ge 70000 ]; then
    FanSpeedAdopted=130
  elif [ ${CPUTemperature} -ge 68000 ]; then
    FanSpeedAdopted=100
  elif [ ${CPUTemperature} -ge 66000 ]; then
    FanSpeedAdopted=80
  elif [ ${CPUTemperature} -ge 63000 ]; then
    FanSpeedAdopted=75
  elif [ ${CPUTemperature} -ge 60000 ]; then
    FanSpeedAdopted=70
  elif [ ${CPUTemperature} -ge 58000 ]; then
    FanSpeedAdopted=65
  else
    FanSpeedAdopted=60 
  fi
  if [ ${FanSpeedActual} -ne  ${FanSpeedAdopted} ]; then
    echo ${FanSpeedAdopted} > ${FanSpeedSet}
    FanSpeedActual=${FanSpeedAdopted}
  fi
  sleep 3 #check every 3 seconds
done
#eof
