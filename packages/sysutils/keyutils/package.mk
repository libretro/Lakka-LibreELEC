# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="keyutils"
PKG_VERSION="1.6"
PKG_SHA256="d3aef20cec0005c0fa6b4be40079885567473185b1a57b629b030e67942c7115"
PKG_LICENSE="GPL"
PKG_SITE="http://people.redhat.com/~dhowells/keyutils/"
PKG_URL="http://people.redhat.com/~dhowells/keyutils/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Keyutils is a set of utilities for managing the key retention facility in the kernel."
PKG_BUILD_FLAGS="+pic"

PKG_MAKE_OPTS_TARGET="NO_ARLIB=0 NO_SOLIB=1 BINDIR=/usr/bin SBINDIR=/usr/sbin LIBDIR=/usr/lib USRLIBDIR=/usr/lib"
PKG_MAKEINSTALL_OPTS_TARGET="$PKG_MAKE_OPTS_TARGET"

post_makeinstall_target() {
  rm -rf $INSTALL/usr/share
  rmdir $INSTALL/etc/request-key.d
  ln -sf /storage/.config/request-key.d $INSTALL/etc/request-key.d
}
