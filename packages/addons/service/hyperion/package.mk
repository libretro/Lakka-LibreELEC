# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Lukas Rusak (lrusak@libreelec.tv)
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="hyperion"
PKG_VERSION="22f7be8df010fe8f0a51e3677fe0c8e709042622"
PKG_SHA256="51cb6c5694d4bad67255ac4ae61a3c0aa481395c4868fb044a3ee19ca35bf19d"
PKG_VERSION_DATE="2018-12-20"
PKG_REV="109"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/hyperion-project/hyperion"
PKG_URL="https://github.com/hyperion-project/hyperion/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain Python2 libusb qtbase protobuf rpi_ws281x"
PKG_SECTION="service"
PKG_SHORTDESC="Hyperion: an AmbiLight controller"
PKG_LONGDESC="Hyperion($PKG_VERSION_DATE) is an modern opensource AmbiLight implementation."

PKG_IS_ADDON="yes"
PKG_ADDON_NAME="Hyperion"
PKG_ADDON_TYPE="xbmc.service"

PKG_AMLOGIC_SUPPORT="-DENABLE_AMLOGIC=0"
PKG_DISPMANX_SUPPORT="-DENABLE_DISPMANX=0"
PKG_FB_SUPPORT="-DENABLE_FB=1"
PKG_X11_SUPPORT="-DENABLE_X11=0"

if [ "$KODIPLAYER_DRIVER" = "bcm2835-driver" ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET bcm2835-driver"
  PKG_DISPMANX_SUPPORT="-DENABLE_DISPMANX=1"
  PKG_FB_SUPPORT="-DENABLE_FB=0"
elif [ "$DISPLAYSERVER" = "x11" ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET xorg-server xrandr"
  PKG_X11_SUPPORT="-DENABLE_X11=1"
fi

PKG_CMAKE_OPTS_TARGET="-DCMAKE_NO_SYSTEM_FROM_IMPORTED=ON \
                       -DHYPERION_VERSION_ID="$PKG_VERSION" \
                       $PKG_AMLOGIC_SUPPORT \
                       $PKG_DISPMANX_SUPPORT \
                       $PKG_FB_SUPPORT \
                       -DENABLE_OSX=0 \
                       -DUSE_SYSTEM_PROTO_LIBS=1 \
                       -DENABLE_SPIDEV=1 \
                       -DENABLE_TINKERFORGE=0 \
                       -DENABLE_V4L2=1 \
                       -DENABLE_WS2812BPWM=0 \
                       -DENABLE_WS281XPWM=1 \
                       $PKG_X11_SUPPORT \
                       -DENABLE_QT5=1 \
                       -DENABLE_TESTS=0 \
                       -Wno-dev"

pre_build_target() {
  cp -a $(get_build_dir rpi_ws281x)/* $PKG_BUILD/dependencies/external/rpi_ws281x
}

pre_configure_target() {
  echo "" > ../cmake/FindGitVersion.cmake
}

makeinstall_target() {
  : # nothing to do here
}

addon() {
  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/bin
    cp $PKG_BUILD/.$TARGET_NAME/bin/* $ADDON_BUILD/$PKG_ADDON_ID/bin

  cp -PR $PKG_BUILD/assets/webconfig $ADDON_BUILD/$PKG_ADDON_ID
  cp -PR $PKG_BUILD/effects $ADDON_BUILD/$PKG_ADDON_ID
}
