#!/bin/sh

for i in `ls xbmc-*.patch`; do
  mv $i `echo $i | sed "s,$1,$2,g"`
done
