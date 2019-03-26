# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="inotify-tools"
PKG_VERSION="3.20.1"
PKG_SHA256="a433cc1dedba851078276db69b0e97f9fe41e4ba3336d2971adfca4b3a6242ac"
PKG_LICENSE="GPLv2"
PKG_SITE="http://wiki.github.com/rvoicilas/inotify-tools/"
PKG_URL="https://github.com/rvoicilas/inotify-tools/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="A C library and a set of command-line programs for Linux providing a simple interface to inotify."
PKG_TOOLCHAIN="autotools"

PKG_CONFIGURE_OPTS_TARGET="--enable-static --disable-shared --disable-doxygen"

pre_configure_target() {
  CFLAGS="$CFLAGS -Wno-error=misleading-indentation"
}

makeinstall_target() {
  :
}
