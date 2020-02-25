# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libevdev"
PKG_VERSION="1.8.0"
PKG_SHA256="20d3cae4efd277f485abdf8f2a7c46588e539998b5a08c2c4d368218379d4211"
PKG_LICENSE="GPL"
PKG_SITE="http://www.freedesktop.org/wiki/Software/libevdev/"
PKG_URL="http://www.freedesktop.org/software/libevdev/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="libevdev is a wrapper library for evdev devices."
PKG_BUILD_FLAGS="+pic"

PKG_CONFIGURE_OPTS_TARGET="--enable-shared --disable-static"

post_makeinstall_target() {
  rm -rf $INSTALL/usr/bin
}
