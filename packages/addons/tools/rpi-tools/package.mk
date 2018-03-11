################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#      Copyright (C) 2016-present Team LibreELEC
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

PKG_NAME="rpi-tools"
PKG_VERSION=""
PKG_REV="104"
PKG_ARCH="arm"
PKG_LICENSE="GPL"
PKG_SITE=""
PKG_URL=""
PKG_DEPENDS_TARGET="toolchain RPi.GPIO picamera gpiozero lan951x-led-ctl"
PKG_SECTION="virtual"
PKG_SHORTDESC="A bundle of tools and programs for use on the Raspberry Pi"
PKG_LONGDESC="This bundle currently includes RPi.GPIO, picamera, gpiozero lan951x-led-ctl"
PKG_DISCAIMER="Raspberry Pi is a trademark of the Raspberry Pi Foundation http://www.raspberrypi.org"

PKG_IS_ADDON="yes"
PKG_ADDON_NAME="Raspberry Pi Tools"
PKG_ADDON_TYPE="xbmc.python.module"
PKG_ADDON_PROVIDES=""
PKG_ADDON_PROJECTS="RPi"


addon() {
  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/lib/RPi/
    cp -PR $(get_build_dir RPi.GPIO)/build/lib.linux-*/RPi/* $ADDON_BUILD/$PKG_ADDON_ID/lib/RPi
    cp -PR $(get_build_dir picamera)/picamera $ADDON_BUILD/$PKG_ADDON_ID/lib/
    cp -PR $(get_build_dir gpiozero)/gpiozero $ADDON_BUILD/$PKG_ADDON_ID/lib/

  BCM2835_DIR="$(get_build_dir bcm2835-driver)"
  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/bin/
    cp -P $BCM2835_DIR/hardfp/opt/vc/bin/raspistill $ADDON_BUILD/$PKG_ADDON_ID/bin
    cp -P $BCM2835_DIR/hardfp/opt/vc/bin/raspiyuv $ADDON_BUILD/$PKG_ADDON_ID/bin
    cp -P $BCM2835_DIR/hardfp/opt/vc/bin/raspivid $ADDON_BUILD/$PKG_ADDON_ID/bin
    cp -P $BCM2835_DIR/hardfp/opt/vc/bin/raspividyuv $ADDON_BUILD/$PKG_ADDON_ID/bin

  # lan951x-led-ctl
    cp -P $(get_build_dir lan951x-led-ctl)/lan951x-led-ctl $ADDON_BUILD/$PKG_ADDON_ID/bin
}
