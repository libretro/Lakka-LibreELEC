#!/bin/bash

for pr in projects/*/linux/*.conf; do
  res=`grep CONFIG_SQUASHFS=y $pr`
  [[ "$res" = "" ]] && >&2 echo "CONFIG_SQUASHFS=y missing in $pr"
done

for pr in projects/*/linux/*.conf; do
  res=`grep CONFIG_DEFAULT_HOSTNAME=\"@DISTRONAME@\" $pr`
  [[ "$res" = "" ]] && >&2 echo "CONFIG_DEFAULT_HOSTNAME=\"@DISTRONAME@\" missing in $pr"
done

for pr in projects/*/linux/*.conf; do
  res=`grep CONFIG_JOYSTICK_XPAD= $pr`
  [[ "$res" = "" ]] && >&2 echo "CONFIG_JOYSTICK_XPAD= missing in $pr"
done

for pr in projects/*/linux/*.conf; do
  res=`grep 'CONFIG_INITRAMFS_SOURCE=" "' $pr`
  [[ "$res" = "" ]] && >&2 echo "CONFIG_INITRAMFS_SOURCE=\" \" missing in $pr"
done

for pr in projects/*; do
  res=${pr/projects/packages\/lakka}
  [[ "$res" = "" ]] && >&2 echo "OEM package missing for $pr"
done
