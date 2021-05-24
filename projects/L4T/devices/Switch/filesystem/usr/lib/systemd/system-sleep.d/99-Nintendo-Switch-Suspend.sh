#!/usr/bin/bash
case $1 in
    pre)
        ifconfig wlan0 down
    ;;
    post)
        ifconfig wlan0 up
        sleep .2
        dock-hotplug
    ;;
esac
