#!/bin/sh

for i in `ls xorg-server-*.patch`; do
  cp $i `echo $i | sed "s,$1,$2,g"`
done
