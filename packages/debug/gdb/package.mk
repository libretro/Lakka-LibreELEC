################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2014 Stephan Raue (stephan@openelec.tv)
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
PKG_VERSION="7.7"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://www.gnu.org/software/gdb/"
PKG_URL="http://ftp.gnu.org/gnu/gdb/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_TARGET="toolchain zlib ncurses expat"
PKG_PRIORITY="optional"
PKG_SECTION="debug"
PKG_SHORTDESC="gdb: The GNU Debugger"
PKG_LONGDESC="The purpose of a debugger such as GDB is to allow you to see what is going on ``inside'' another program while it executes--or what another program was doing at the moment it crashed."

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

CC_FOR_BUILD="$HOST_CC"
CFLAGS_FOR_BUILD="$HOST_CFLAGS"

pre_configure_target() {
  # gdb could fail on runtime if build with LTO support
    strip_lto
}

PKG_CONFIGURE_OPTS_TARGET="bash_cv_have_mbstate_t=set \
                           --disable-shared \
                           --enable-static \
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

post_makeinstall_target() {
  rm -rf $INSTALL/usr/share/gdb/python
}
