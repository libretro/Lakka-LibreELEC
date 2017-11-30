################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#      Copyright (C) 2017-present Team LibreELEC
#      Copyright (C) 2009-2012 Stephan Raue (stephan@openelec.tv)
#      Copyright (C) 2011-2011 Gregor Fuis (gujs@openelec.tv)
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

PKG_NAME="pcscd"
PKG_VERSION="1.0"
PKG_REV="100"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://libreelec.tv"
PKG_URL=""
PKG_DEPENDS_TARGET="toolchain pcsc-lite libusb ccid"
PKG_SECTION="service"
PKG_SHORTDESC="Middleware to access a smart card using SCard API (PC/SC)"
PKG_LONGDESC="Middleware to access a smart card using SCard API (PC/SC)"
PKG_AUTORECONF="no"

PKG_IS_ADDON="yes"
PKG_ADDON_NAME="PC/SC Smart Card Daemon"
PKG_ADDON_TYPE="xbmc.service"

make_target() {
  :
}

makeinstall_target() {
  : 
}

addon() {
  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/bin/
    cp -Pa $(get_build_dir pcsc-lite)/.install_pkg/usr/sbin/pcscd $ADDON_BUILD/$PKG_ADDON_ID/bin/pcscd.bin

  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/drivers/serial
    cp -Pa $(get_build_dir ccid)/.$TARGET_NAME/src/.libs/libccidtwin.so $ADDON_BUILD/$PKG_ADDON_ID/drivers/serial

  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/drivers/ifd-ccid.bundle/Contents/Linux/
    cp -Pa $(get_build_dir ccid)/.$TARGET_NAME/src/.libs/libccid.so $ADDON_BUILD/$PKG_ADDON_ID/drivers/ifd-ccid.bundle/Contents/Linux/
    cp -Pa $(get_build_dir ccid)/.$TARGET_NAME/src/Info.plist $ADDON_BUILD/$PKG_ADDON_ID/drivers/ifd-ccid.bundle/Contents

  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/config
    cp -Pa $PKG_DIR/config/* $ADDON_BUILD/$PKG_ADDON_ID/config/
}
