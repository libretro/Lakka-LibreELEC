#!/bin/bash

rm -rf target/

>&2 echo "Generic.x86_64"
DISTRO=Lakka PROJECT=Generic ARCH=x86_64 make image -j9
>&2 echo "Generic.i386"
DISTRO=Lakka PROJECT=Generic ARCH=i386 make image -j9
>&2 echo "RPi.arm + noobs"
DISTRO=Lakka PROJECT=RPi ARCH=arm make noobs -j9
>&2 echo "RPi2.arm + noobs"
DISTRO=Lakka PROJECT=RPi2 ARCH=arm make noobs -j9
>&2 echo "imx6.cuboxi.arm"
DISTRO=Lakka PROJECT=imx6 SYSTEM=cuboxi ARCH=arm make image -j9
>&2 echo "imx6.udoo.arm"
DISTRO=Lakka PROJECT=imx6 SYSTEM=udoo ARCH=arm make image -j9
>&2 echo "OdroidC1.arm"
DISTRO=Lakka PROJECT=OdroidC1 ARCH=arm make image -j9
>&2 echo "Odroid_C2.arm"
DISTRO=Lakka PROJECT=Odroid_C2 ARCH=arm make image -j9
>&2 echo "OdroidXU3.arm"
DISTRO=Lakka PROJECT=OdroidXU3 ARCH=arm make image -j9
>&2 echo "WeTek_Core.arm"
DISTRO=Lakka PROJECT=WeTek_Core ARCH=arm make image -j9
>&2 echo "WeTek_Hub.arm"
DISTRO=Lakka PROJECT=WeTek_Hub ARCH=arm make image -j9
>&2 echo "WeTek_Play.arm"
DISTRO=Lakka PROJECT=WeTek_Play ARCH=arm make image -j9
>&2 echo "WeTek_Play_2.arm"
DISTRO=Lakka PROJECT=WeTek_Play_2 ARCH=arm make image -j9
>&2 echo "Gamegirl.arm"
DISTRO=Lakka PROJECT=Gamegirl ARCH=arm make image -j9
>&2 echo "Virtual.x86_64"
DISTRO=Lakka PROJECT=Virtual ARCH=x86_64 make image -j9

rm target/*.kernel
rm target/*.system

for f in target/*; do
  md5sum $f > $f.md5
  sha256sum $f > $f.sha256
done

for f in target/*; do
  dir=`echo $f | sed -e 's/target\/Lakka-\(.*\)-\(.*\)-devel-\(.*\)/\1/'`
  mkdir -p target/$dir
  mv $f target/$dir/
done

#scp -r target/* lakka@sources.lakka.tv:sources/nightly/
