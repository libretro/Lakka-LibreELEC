#!/bin/bash

LEDDIR="/usr/share/kodi/addons/service.slice/resources/media/ledpatterns"

case "$1" in
  halt)
    hdparm -y /dev/sda
    led_png $LEDDIR/shutdown.png
    ;;
  poweroff)
    hdparm -y /dev/sda
    led_png $LEDDIR/shutdown.png
    ;;
  reboot)
    led_png $LEDDIR/shutdown.png
    ;;
  *)
    ;;
esac
