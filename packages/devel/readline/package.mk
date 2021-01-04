# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="readline"
PKG_VERSION="8.1"
PKG_SHA256="f8ceb4ee131e3232226a17f51b164afc46cd0b9e6cef344be87c65962cb82b02"
PKG_LICENSE="MIT"
PKG_SITE="http://www.gnu.org/software/readline/"
PKG_URL="http://ftpmirror.gnu.org/readline/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain ncurses"
PKG_LONGDESC="The GNU Readline library provides a set of functions for use by applications that allow users to edit command lines as they are typed in."
PKG_BUILD_FLAGS="+pic"

PKG_CONFIGURE_OPTS_TARGET="bash_cv_wcwidth_broken=no \
                           --disable-shared \
                           --enable-static \
                           --with-curses"

post_makeinstall_target() {
  rm -rf $INSTALL/usr/share/readline
}
