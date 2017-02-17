################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2012 Stephan Raue (stephan@openelec.tv)
#
#  This Program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2, or (at your option)
#  any later version.
#
#  This Program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with OpenELEC.tv; see the file COPYING.  If not, write to
#  the Free Software Foundation, 51 Franklin Street, Suite 500, Boston, MA 02110, USA.
#  http://www.gnu.org/copyleft/gpl.html
################################################################################

PKG_NAME="dvb-fe-tool"
PKG_VERSION="fa2f7d9"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://linuxtv.org/"
PKG_URL="https://git.linuxtv.org/cgit.cgi/v4l-utils.git/snapshot/$PKG_VERSION.tar.xz"
PKG_SOURCE_DIR="$PKG_VERSION*"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="tools"
PKG_SHORTDESC="dvb-fe-tool: Linux V4L2 and DVB API utilities and v4l libraries (libv4l)."
PKG_LONGDESC="Linux V4L2 and DVB API utilities and v4l libraries (libv4l)."
PKG_AUTORECONF="yes"

PKG_CONFIGURE_OPTS_TARGET="--disable-nls \
            --disable-rpath \
            --disable-libdvbv5 \
            --disable-libv4l \
            --disable-v4l-utils \
            --disable-qv4l2 \
            --without-jpeg \
            --without-libiconv-prefix \
            --without-libintl-prefix"

post_patch() {
  mkdir -p $PKG_BUILD/build-aux/
    touch $PKG_BUILD/build-aux/config.rpath
    touch $PKG_BUILD/libdvbv5-po/Makefile.in.in
    touch $PKG_BUILD/v4l-utils-po/Makefile.in.in
}

make_target() {
  cd $PKG_BUILD/.$TARGET_NAME/lib/libdvbv5
  make CFLAGS="$TARGET_CFLAGS"

  cd $PKG_BUILD/.$TARGET_NAME/utils/dvb
  make CFLAGS="$TARGET_CFLAGS"
}

makeinstall_target() {
  : # nop
}
