# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)

PKG_NAME="keyutils"
PKG_VERSION="1.5.10"
PKG_SHA256="115c3deae7f181778fd0e0ffaa2dad1bf1fe2f5677cf2e0e348cdb7a1c93afb6"
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
