# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="inotify-tools"
PKG_VERSION="3.20.11.0"
PKG_SHA256="58a3cde89e4a5111a87ac16b56b06a8f885460fca0aea51b69c856ce30a37a14"
PKG_LICENSE="GPLv2"
PKG_SITE="http://wiki.github.com/inotify-tools/inotify-tools/"
PKG_URL="https://github.com/inotify-tools/inotify-tools/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="A C library and a set of command-line programs for Linux providing a simple interface to inotify."
PKG_TOOLCHAIN="autotools"
PKG_BUILD_FLAGS="-sysroot"

PKG_CONFIGURE_OPTS_TARGET="--enable-static --disable-shared --disable-doxygen"

pre_configure_target() {
  CFLAGS="$CFLAGS -Wno-error=misleading-indentation"
}
