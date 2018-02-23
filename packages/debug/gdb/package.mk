################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
#
#  OpenELEC is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 2 of the License, or
#  (at your option) any later version.
#
#  OpenELEC is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with OpenELEC.  If not, see <http://www.gnu.org/licenses/>.
################################################################################

PKG_NAME="gdb"
PKG_VERSION="8.1"
PKG_SHA256="af61a0263858e69c5dce51eab26662ff3d2ad9aa68da9583e8143b5426be4b34"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://www.gnu.org/software/gdb/"
PKG_URL="http://ftpmirror.gnu.org/gdb/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain zlib ncurses expat"
PKG_SECTION="debug"
PKG_SHORTDESC="gdb: The GNU Debugger"
PKG_LONGDESC="The purpose of a debugger such as GDB is to allow you to see what is going on ``inside'' another program while it executes--or what another program was doing at the moment it crashed."
# gdb could fail on runtime if build with LTO support
PKG_BUILD_FLAGS="-lto"

CC_FOR_BUILD="$HOST_CC"
CFLAGS_FOR_BUILD="$HOST_CFLAGS"

PKG_CONFIGURE_OPTS_TARGET="bash_cv_have_mbstate_t=set \
                           --disable-shared \
                           --enable-static \
                           --with-auto-load-safe-path=/ \
                           --disable-nls \
                           --disable-sim \
                           --without-x \
                           --disable-tui \
                           --disable-libada \
                           --without-lzma \
                           --disable-libquadmath \
                           --disable-libquadmath-support \
                           --enable-libada \
                           --enable-libssp \
                           --disable-werror"

makeinstall_target() {
  make DESTDIR=$INSTALL install
}

post_makeinstall_target() {
  rm -rf $INSTALL/usr/share/gdb/python
}
