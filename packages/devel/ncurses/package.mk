################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#      Copyright (C) 2017-present Team LibreELEC
#
#  LibreELEC is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 2 of the License, or
#  (at your option) any later version.
#
#  LibreELEC is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with LibreELEC.  If not, see <http://www.gnu.org/licenses/>.
################################################################################

PKG_NAME="ncurses"
PKG_VERSION="6.1-20180203"
PKG_SHA256="fac9db9460f271ee632af386a5b502d43a25d7cf14138e3d3166d4bedc4f6cb0"
PKG_ARCH="any"
PKG_LICENSE="MIT"
PKG_SITE="http://www.gnu.org/software/ncurses/"
PKG_URL="http://invisible-mirror.net/archives/ncurses/current/ncurses-$PKG_VERSION.tgz"
PKG_DEPENDS_TARGET="toolchain zlib"
PKG_SECTION="devel"
PKG_SHORTDESC="ncurses: The ncurses (new curses) library"
PKG_LONGDESC="The ncurses (new curses) library is a free software emulation of curses in System V Release 4.0, and more. It uses terminfo format, supports pads and color and multiple highlights and forms characters and function-key mapping, and has all the other SYSV-curses enhancements over BSD curses."
# causes some segmentation fault's (dialog) when compiled with gcc's link time optimization.
PKG_BUILD_FLAGS="-lto +pic"

PKG_CONFIGURE_OPTS_TARGET="--without-ada \
                           --without-cxx \
                           --without-cxx-binding \
                           --disable-db-install \
                           --without-manpages \
                           --without-progs \
                           --without-tests \
                           --without-shared \
                           --with-normal \
                           --without-debug \
                           --without-profile \
                           --without-termlib \
                           --without-ticlib \
                           --without-gpm \
                           --without-dbmalloc \
                           --without-dmalloc \
                           --disable-rpath \
                           --disable-database \
                           --with-fallbacks=linux,screen,xterm,xterm-color \
                           --disable-big-core \
                           --enable-termcap \
                           --enable-getcap \
                           --enable-getcap-cache \
                           --enable-symlinks \
                           --disable-bsdpad \
                           --without-rcs-ids \
                           --enable-ext-funcs \
                           --disable-const \
                           --enable-no-padding \
                           --disable-sigwinch \
                           --enable-pc-files \
                           --with-pkg-config-libdir=/usr/lib/pkgconfig \
                           --disable-tcap-names \
                           --without-develop \
                           --disable-hard-tabs \
                           --disable-xmc-glitch \
                           --disable-hashmap \
                           --disable-safe-sprintf \
                           --disable-scroll-hints \
                           --disable-widec \
                           --disable-echo \
                           --disable-warnings \
                           --disable-home-terminfo \
                           --disable-assertions"

post_makeinstall_target() {
  cp misc/ncurses-config $TOOLCHAIN/bin
  chmod +x $TOOLCHAIN/bin/ncurses-config
  $SED "s:\(['=\" ]\)/usr:\\1$SYSROOT_PREFIX/usr:g" $TOOLCHAIN/bin/ncurses-config
  rm -rf $INSTALL/usr/bin
}
