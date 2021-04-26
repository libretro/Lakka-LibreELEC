#!/usr/bin/bash
case $1 in
    pre)
        ifconfig wlan0 down
    ;;
    post)
        ifconfig set dev wlan0 up
    ;;
esac
