#!/bin/sh

for i in `ls xbmc-dharma-*.patch`; do
  mv $i `echo $i | sed "s,$1,$2,g"`
done
