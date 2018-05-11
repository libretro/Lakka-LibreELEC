################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#      Copyright (C) 2016-present Team LibreELEC
#      Copyright (C) 2009-2012 Stephan Raue (stephan@openelec.tv)
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

PKG_NAME="mc"
PKG_VERSION="4.8.20"
PKG_SHA256="017ee7f4f8ae420a04f4d6fcebaabe5b494661075c75442c76e9c8b1923d501c"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://www.midnight-commander.org"
PKG_URL="http://ftp.midnight-commander.org/mc-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain gettext:host glib libssh2 libtool:host ncurses pcre"
PKG_SECTION="tools"
PKG_LONGDESC="Midnight Commander is a text based filemanager that emulates Norton Commander"

PKG_CONFIGURE_OPTS_TARGET=" \
  --datadir=/storage/.kodi/addons/virtual.system-tools/data \
  --libdir=/storage/.kodi/addons/virtual.system-tools/mclib \
  --sysconfdir=/storage/.kodi/addons/virtual.system-tools/etc \
  --with-screen=ncurses \
  --with-sysroot=$SYSROOT_PREFIX \
  --disable-aspell \
  --without-diff-viewer \
  --disable-doxygen-doc \
  --disable-doxygen-dot \
  --disable-doxygen-html \
  --with-gnu-ld \
  --without-libiconv-prefix \
  --without-libintl-prefix \
  --with-internal-edit \
  --disable-mclib \
  --with-subshell \
  --enable-vfs-extfs \
  --enable-vfs-ftp \
  --enable-vfs-sftp \
  --enable-vfs-tar \
  --without-x"

pre_configure_target() {
  LDFLAGS="$LDFLAGS -lcrypto -lssl"
}

post_makeinstall_target() {
  rm -rf $INSTALL/storage/.kodi/addons/virtual.system-tools/data/locale
  rm -rf $INSTALL/storage/.kodi/addons/virtual.system-tools/data/mc/help/mc.hlp.*
}
