#!/bin/sh

for i in `ls linux-$1-*.patch`; do
  mv $i `echo $i | sed "s,$1,$2,g"`
done
