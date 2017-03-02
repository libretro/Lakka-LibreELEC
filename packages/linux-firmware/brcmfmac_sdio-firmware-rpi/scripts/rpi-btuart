#!/bin/bash

if [ "$(cat /proc/device-tree/aliases/uart0)" = "$(cat /proc/device-tree/aliases/serial1)" ] ; then
  if [ "$(wc -c /proc/device-tree/soc/gpio@7e200000/uart0_pins/brcm\,pins | cut -f 1 -d ' ')" = "16" ] ; then
    /usr/bin/hciattach /dev/serial1 bcm43xx 3000000 flow -
  else
    /usr/bin/hciattach /dev/serial1 bcm43xx 921600 noflow -
  fi
else
  /usr/bin/hciattach /dev/serial1 bcm43xx 460800 noflow -
fi
