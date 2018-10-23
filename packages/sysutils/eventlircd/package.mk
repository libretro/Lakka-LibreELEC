# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)

PKG_NAME="eventlircd"
PKG_VERSION="3b753e9"
PKG_SHA256="4eca52d0570fa568b3296a2c9bc2af252423e25c1a67654bd79680fc5a93092a"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/LibreELEC/eventlircd"
PKG_URL="https://github.com/LibreELEC/eventlircd/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain systemd lirc"
PKG_LONGDESC="The eventlircd daemon provides four functions for LIRC devices"
PKG_TOOLCHAIN="autotools"

PKG_CONFIGURE_OPTS_TARGET="--with-udev-dir=/usr/lib/udev \
                           --with-lircd-socket=/run/lirc/lircd"

post_makeinstall_target() {
# install our own evmap files and udev rules
  rm -rf $INSTALL/etc/eventlircd.d
  rm -rf $INSTALL/usr/lib/udev/rules.d
  rm -rf $INSTALL/usr/lib/udev/lircd_helper

  mkdir -p $INSTALL/etc/eventlircd.d
    cp $PKG_DIR/evmap/*.evmap $INSTALL/etc/eventlircd.d
}

post_install() {
  enable_service eventlircd.service
}
