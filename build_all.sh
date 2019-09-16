#!/bin/bash

rm -rf target/

export IGNORE_VERSION=1

>&2 echo "Generic.x86_64"
PROJECT=Generic ARCH=x86_64 make image
>&2 echo "Generic_VK_nvidia.x86_64"
PROJECT=Generic_VK_nvidia ARCH=x86_64 make image
>&2 echo "Generic.i386"
PROJECT=Generic ARCH=i386 make image
>&2 echo "RPi.arm + noobs"
PROJECT=RPi ARCH=arm make noobs
>&2 echo "RPi.gpicase.arm + noobs"
PROJECT=RPi BOARD=GPICase ARCH=arm make noobs
>&2 echo "RPi2.arm + noobs"
PROJECT=RPi2 ARCH=arm make noobs
>&2 echo "RPi4.arm + noobs"
PROJECT=RPi2 BOARD=RPi4 ARCH=arm make noobs
>&2 echo "Allwinner.arm"
PROJECT=Allwinner SYSTEM=Bananapi ARCH=arm make image
PROJECT=Allwinner SYSTEM=Cubieboard2 ARCH=arm make image
PROJECT=Allwinner SYSTEM=Cubietruck ARCH=arm make image
PROJECT=Allwinner SYSTEM=orangepi_2 ARCH=arm make image
PROJECT=Allwinner SYSTEM=orangepi_lite ARCH=arm make image
PROJECT=Allwinner SYSTEM=orangepi_one ARCH=arm make image
PROJECT=Allwinner SYSTEM=orangepi_pc ARCH=arm make image
PROJECT=Allwinner SYSTEM=orangepi_plus ARCH=arm make image
PROJECT=Allwinner SYSTEM=orangepi_plus2e ARCH=arm make image
PROJECT=Allwinner SYSTEM=nanopi_m1_plus ARCH=arm make image
>&2 echo "imx6.cuboxi.arm"
PROJECT=imx6 SYSTEM=cuboxi ARCH=arm make image
>&2 echo "imx6.udoo.arm"
PROJECT=imx6 SYSTEM=udoo ARCH=arm make image
>&2 echo "OdroidC1.arm"
PROJECT=OdroidC1 ARCH=arm make image
>&2 echo "Odroid_C2.arm"
PROJECT=Odroid_C2 ARCH=arm make image
>&2 echo "OdroidXU3.arm"
PROJECT=OdroidXU3 ARCH=arm make image
>&2 echo "WeTek_Core.arm"
PROJECT=WeTek_Core ARCH=arm make image
>&2 echo "WeTek_Hub.arm"
PROJECT=WeTek_Hub ARCH=arm make image
>&2 echo "WeTek_Play.arm"
PROJECT=WeTek_Play ARCH=arm make image
>&2 echo "WeTek_Play_2.arm"
PROJECT=WeTek_Play_2 ARCH=arm make image
>&2 echo "Gamegirl.arm"
PROJECT=Gamegirl ARCH=arm make image
>&2 echo "S8X2.arm"
PROJECT=S8X2 SYSTEM=S82 ARCH=arm make image
PROJECT=S8X2 SYSTEM=M8 ARCH=arm make image
PROJECT=S8X2 SYSTEM=T8 ARCH=arm make image
PROJECT=S8X2 SYSTEM=MXIII-1G ARCH=arm make image
PROJECT=S8X2 SYSTEM=MXIII-PLUS ARCH=arm make image
PROJECT=S8X2 SYSTEM=X8H-PLUS ARCH=arm make image
>&2 echo "S805.arm"
PROJECT=S805 SYSTEM=MXQ ARCH=arm make image
PROJECT=S805 SYSTEM=HD18Q ARCH=arm make image
PROJECT=S805 SYSTEM=M201C ARCH=arm make image
PROJECT=S805 SYSTEM=M201D ARCH=arm make image
PROJECT=S805 SYSTEM=MK808B-Plus ARCH=arm make image
>&2 echo "S905.arm"
PROJECT=S905 ARCH=arm make image
>&2 echo "S912.arm"
PROJECT=S912 ARCH=arm make image
>&2 echo "TinkerBoard.arm"
PROJECT=Rockchip DEVICE=TinkerBoard ARCH=arm make image
>&2 echo "RK3328.arm"
PROJECT=Rockchip DEVICE=RK3328 BOARD=ROCK64 ARCH=arm make image
PROJECT=Rockchip DEVICE=RK3328 BOARD=ROC-RK3328-CC ARCH=arm make image
>&2 echo "MiQi.arm"
PROJECT=Rockchip DEVICE=MiQi ARCH=arm make image
>&2 echo "RK3399.arm"
PROJECT=Rockchip DEVICE=RK3399 BOARD=ROCKPro64 ARCH=arm make image
PROJECT=Rockchip DEVICE=RK3399 BOARD=ROCK960 ARCH=arm make image
# PROJECT=Rockchip DEVICE=RK3399 BOARD=OdroidN1 ARCH=arm make image

rm target/*.kernel
rm target/*.system

for f in target/*; do
  md5sum $f > $f.md5
  sha256sum $f > $f.sha256
done

for f in target/*; do
  dir=`echo $f | sed -e 's/target\/Lakka-\(.*\)-\(.*\)-devel-\(.*\)/\1/'`
  #dir=`echo $f | sed -e 's/target\/Lakka-\(.*\)-2.3\(.*\)/\1/'`
  mkdir -p target/$dir
  mv $f target/$dir/
done

#scp -r target/* lakka@sources.lakka.tv:sources/nightly/
