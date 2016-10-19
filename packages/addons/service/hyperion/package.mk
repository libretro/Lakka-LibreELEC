################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#      Copyright (C) 2009-2016 Lukas Rusak (lrusak@libreelec.tv)
#
#  LibreELEC is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 2 of the License, or
#  (at your option) any later version.
#
#  LibreELEC is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with LibreELEC.  If not, see <http://www.gnu.org/licenses/>.
################################################################################

PKG_NAME="hyperion"
PKG_VERSION="355a324"
PKG_REV="103"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/hyperion-project/hyperion"
PKG_URL="https://github.com/hyperion-project/hyperion/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain Python libusb qtbase protobuf rpi_ws281x"
PKG_SECTION="service"
PKG_SHORTDESC="Hyperion: an AmbiLight controller"
PKG_LONGDESC="Hyperion($PKG_VERSION) is an modern opensource AmbiLight implementation."

PKG_IS_ADDON="yes"
PKG_ADDON_NAME="Hyperion"
PKG_ADDON_TYPE="xbmc.service"

AMLOGIC_SUPPORT="-DENABLE_AMLOGIC=0"
DISPMANX_SUPPORT="-DENABLE_DISPMANX=0"
FB_SUPPORT="-DENABLE_FB=1"
X11_SUPPORT="-DENABLE_X11=0"

if [ "$KODIPLAYER_DRIVER" = "libamcodec" ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET libamcodec"
  AMLOGIC_SUPPORT="-DENABLE_AMLOGIC=1"
elif [ "$KODIPLAYER_DRIVER" = "bcm2835-driver" ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET bcm2835-driver"
  DISPMANX_SUPPORT="-DENABLE_DISPMANX=1"
  FB_SUPPORT="-DENABLE_FB=0"
elif [ "$DISPLAYSERVER" = "x11" ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET xorg-server xrandr"
  X11_SUPPORT="-DENABLE_X11=1"
fi

pre_build_target() {
  cp -a $(get_build_dir rpi_ws281x)/* $ROOT/$PKG_BUILD/dependencies/external/rpi_ws281x
}

pre_configure_target() {
  echo "" > ../cmake/FindGitVersion.cmake
}

PKG_CMAKE_OPTS_TARGET="-DQT_QMAKE_EXECUTABLE=$ROOT/$TOOLCHAIN/bin/qmake \
                       -DHYPERION_VERSION_ID="$PKG_VERSION" \
                       $AMLOGIC_SUPPORT \
                       $DISPMANX_SUPPORT \
                       $FB_SUPPORT \
                       -DENABLE_OSX=0 \
                       -DUSE_SYSTEM_PROTO_LIBS=1 \
                       -DENABLE_SPIDEV=1 \
                       -DENABLE_TINKERFORGE=0 \
                       -DENABLE_V4L2=1 \
                       -DENABLE_WS2812BPWM=0 \
                       -DENABLE_WS281XPWM=1 \
                       $X11_SUPPORT \
                       -DENABLE_QT5=1 \
                       -DENABLE_TESTS=0 \
                       -Wno-dev"

makeinstall_target() {
  : # nothing to do here
}

addon() {
  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/bin
    cp $PKG_BUILD/.$TARGET_NAME/bin/* $ADDON_BUILD/$PKG_ADDON_ID/bin

  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/config
    cp -P $PKG_BUILD/config/hyperion.config.json.example $ADDON_BUILD/$PKG_ADDON_ID/config/hyperion.config.json.sample
    sed -e "s,/usr/share/hyperion/effects,/storage/.kodi/addons/service.hyperion/effects,g" \
        -e "s,/usr/share/hyperion/webconfig,/storage/.kodi/addons/service.hyperion/webconfig,g" \
        -i $ADDON_BUILD/$PKG_ADDON_ID/config/hyperion.config.json.sample

  cp -PR $PKG_BUILD/assets/webconfig $ADDON_BUILD/$PKG_ADDON_ID
  cp -PR $PKG_BUILD/effects $ADDON_BUILD/$PKG_ADDON_ID

  debug_strip $ADDON_BUILD/$PKG_ADDON_ID/bin
}
