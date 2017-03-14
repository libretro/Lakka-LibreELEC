#!/bin/bash

if [ -f /storage/.kodi/media/ledpatterns/shutdown.png ]; then
    LEDDIR=/storage/.kodi
else
    LEDDIR=/usr/share/kodi
fi

case "$1" in
  halt)
    hdparm -y /dev/sda
    led_png $LEDDIR/media/ledpatterns/shutdown.png
    ;;
  poweroff)
    hdparm -y /dev/sda
    led_png $LEDDIR/media/ledpatterns/shutdown.png
    ;;
  reboot)
    led_png $LEDDIR/media/ledpatterns/shutdown.png
    ;;
  *)
    ;;
esac
