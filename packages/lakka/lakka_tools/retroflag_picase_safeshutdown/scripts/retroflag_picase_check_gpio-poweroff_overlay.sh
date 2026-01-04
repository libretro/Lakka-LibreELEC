#!/bin/bash

# Check number of parameter.
if [ "$#" -ne 0 ]; then
  exit 1
fi

is_GpioPoweroffDtbo_Installed=true

if [ -f "/storage/.cache/services/safeshutdown.conf" ]; then
  # To Enable from disabled or nothing.
  for file in /flash/distroconfig.txt /flash/distroconfig-composite.txt; do
    grep -i '^dtoverlay=gpio-poweroff.* #retroflag_picase_safeshutdown$' "${file}" >/dev/null
    if [ $? -ne 0 ]; then
    {
      mount -o remount rw /flash/
      sed -i '/^#dtoverlay=gpio-poweroff.* #retroflag_picase_safeshutdown$/d' "${file}"
      echo "dtoverlay=gpio-poweroff,gpiopin=4,active_low=1,input=1 #retroflag_picase_safeshutdown" >> "${file}"
      mount -o remount r /flash/
      is_GpioPoweroffDtbo_Installed=false
    }
    fi
  done
fi

if ! "${is_GpioPoweroffDtbo_Installed}" ; then
  systemctl reboot
fi

exit 0
