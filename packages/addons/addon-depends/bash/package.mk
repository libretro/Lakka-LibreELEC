# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="bash"
PKG_VERSION="5.0.18"
PKG_SHA256="83adb589317d3295e73e86f6816f6670d7f089344538f9f516ce25bfb5fd3a0b"
PKG_LICENSE="GPL"
PKG_SITE="http://www.gnu.org/software/bash/bash.html"
PKG_URL="ftp://ftp.cwru.edu/pub/$PKG_NAME/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain ncurses"
PKG_LONGDESC="The GNU Bourne Again shell."

PKG_CONFIGURE_OPTS_TARGET="--with-curses \
                           --enable-readline \
                           --without-bash-malloc \
                           --with-installed-readline"

pre_make_target() {
  # precreate this generated header because it may be created too late
  make pathnames.h
}
