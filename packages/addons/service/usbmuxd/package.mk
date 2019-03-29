# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="usbmuxd"
PKG_VERSION="1.1.0"
PKG_SHA256="3e8948b4fe4250ee5c4bd41ccd1b83c09b8a6f5518a7d131a66fd38bd461b42d"
PKG_REV="101"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://www.libimobiledevice.org"
PKG_URL="http://www.libimobiledevice.org/downloads/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_TARGET="toolchain libusb libimobiledevice"
PKG_SECTION="service"
PKG_SHORTDESC="USB Multiplex Daemon"
PKG_LONGDESC="USB Multiplex Daemon"

PKG_IS_ADDON="yes"
PKG_ADDON_NAME="iPhone Tether"
PKG_ADDON_TYPE="xbmc.service"

PKG_DISCLAIMER="Additional data charges may occur. The LibreELEC team doesn't take any resposibility for extra data charges."

PKG_CONFIGURE_OPTS_TARGET="ac_cv_func_malloc_0_nonnull=yes \
                           ac_cv_func_realloc_0_nonnull=yes"

makeinstall_target() {
  :
}

addon() {
  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/bin
    cp -P $PKG_BUILD/.$TARGET_NAME/src/usbmuxd $ADDON_BUILD/$PKG_ADDON_ID/bin/
}
