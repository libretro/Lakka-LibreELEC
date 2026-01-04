#!/bin/bash

# Check number of parameter.
if [ "$#" -ne 1 ]; then
  exit 1
fi

if [ "$1" = "enable" ]; then
  # To Enable from disabled or nothing.
  mount -o remount rw /flash/
  for file in /flash/distroconfig.txt /flash/distroconfig-composite.txt; do
    grep -i '^dtoverlay=gpio-poweroff.* #retroflag_picase_safeshutdown$' "${file}" >/dev/null
    if [ $? -ne 0 ]; then
    {
      sed -i '/^#dtoverlay=gpio-poweroff.* #retroflag_picase_safeshutdown$/d' "${file}"
      echo "dtoverlay=gpio-poweroff,gpiopin=4,active_low=1,input=1 #retroflag_picase_safeshutdown" >> "${file}"
    }
    fi
  done
  mount -o remount r /flash/
elif [ "$1" = "disable" ]; then
  # To Disable from enabled.
  mount -o remount rw /flash/
  for file in /flash/distroconfig.txt /flash/distroconfig-composite.txt; do
    grep -i '^#dtoverlay=gpio-poweroff.* #retroflag_picase_safeshutdown$' "${file}" >/dev/null
    if [ $? -ne 0 ]; then
    {
      sed -i '/^dtoverlay=gpio-poweroff.* #retroflag_picase_safeshutdown$/d' "${file}"
      echo "#dtoverlay=gpio-poweroff,gpiopin=4,active_low=1,input=1 #retroflag_picase_safeshutdown" >> "${file}"
    }
    fi
  done
  mount -o remount r /flash/
else
  # Bad parameter.
  exit 1
fi

exit 0
