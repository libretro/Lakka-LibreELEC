# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="usbmuxd"
PKG_VERSION="360619c5f721f93f0b9d8af1a2df0b926fbcf281"
PKG_SHA256="3f36b9f427f388c701798904ed2655867e0113ef3ac68e73f1a69a6e5e2940b2"
PKG_REV="0"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://www.libimobiledevice.org"
PKG_URL="https://github.com/libimobiledevice/usbmuxd/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain libusb libimobiledevice libimobiledevice-glue libusbmuxd libplist"
PKG_TOOLCHAIN="autotools"
PKG_SECTION="service"
PKG_SHORTDESC="USB Multiplex Daemon"
PKG_LONGDESC="USB Multiplex Daemon"

PKG_IS_ADDON="yes"
PKG_ADDON_NAME="iPhone Tether"
PKG_ADDON_TYPE="xbmc.service"

PKG_DISCLAIMER="Additional data charges may occur. The LibreELEC team doesn't take any resposibility for extra data charges."

PKG_CONFIGURE_OPTS_TARGET="ac_cv_func_malloc_0_nonnull=yes \
                           ac_cv_func_realloc_0_nonnull=yes"

configure_package() {
  # if using a git hash as a package version - set RELEASE_VERSION
  if [ -f ${PKG_BUILD}/NEWS ]; then
    export RELEASE_VERSION="$(sed -n '1,/RE/s/Version \(.*\)/\1/p' ${PKG_BUILD}/NEWS)-git-${PKG_VERSION:0:7}"
  fi
}

post_configure_target() {
  libtool_remove_rpath libtool
}

makeinstall_target() {
  :
}

addon() {
  mkdir -p ${ADDON_BUILD}/${PKG_ADDON_ID}/bin
    cp -P ${PKG_BUILD}/.${TARGET_NAME}/src/usbmuxd ${ADDON_BUILD}/${PKG_ADDON_ID}/bin/
}
