# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="tz"
PKG_VERSION="2020f"
PKG_SHA256="e53b70c3ed8597a081e2c12ec049802433b5e022d3d20db4e8bda80d760d7cee"
PKG_LICENSE="Public Domain"
PKG_SITE="http://www.iana.org/time-zones"
PKG_URL="https://github.com/eggert/tz/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Time zone and daylight-saving time data."

pre_configure_target() {
  PKG_MAKE_OPTS_TARGET="CC=$HOST_CC LDFLAGS="
}

makeinstall_target() {
  make TZDIR="$INSTALL/usr/share/zoneinfo" REDO=posix_only TOPDIR="$INSTALL" install
}

post_makeinstall_target() {
  rm -rf $INSTALL/usr/bin $INSTALL/usr/sbin

  rm -rf $INSTALL/etc
  mkdir -p $INSTALL/etc
    ln -sf /var/run/localtime $INSTALL/etc/localtime
}

post_install() {
  enable_service tz-data.service
}
