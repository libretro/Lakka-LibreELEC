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
PKG_VERSION="4.8.19"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://www.midnight-commander.org"
PKG_URL="http://ftp.midnight-commander.org/${PKG_NAME}-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain libtool:host gettext:host glib pcre netbsd-curses"
PKG_SECTION="tools"
PKG_SHORTDESC="mc: visual file manager"
PKG_LONGDESC="mc is a visual file manager, licensed under GNU General Public License and therefore qualifies as Free Software. It's a feature rich full-screen text mode application that allows you to copy, move and delete files and whole directory trees, search for files and run commands in the subshell. Internal viewer and editor are included"
PKG_AUTORECONF="no"

PKG_CONFIGURE_OPTS_TARGET="--sysconfdir=/storage/.kodi/addons/virtual.system-tools/etc \
            --datadir=/storage/.kodi/addons/virtual.system-tools/data \
            --libdir=/storage/.kodi/addons/virtual.system-tools/mclib \
            --disable-mclib \
            --disable-aspell \
            --disable-vfs \
            --disable-doxygen-doc \
            --disable-doxygen-dot \
            --disable-doxygen-html \
            --with-sysroot=$SYSROOT_PREFIX \
            --with-screen=ncurses \
            --without-x \
            --with-gnu-ld \
            --without-libiconv-prefix \
            --without-libintl-prefix \
            --with-internal-edit \
            --without-diff-viewer \
            --with-subshell"

pre_configure_target() {
  export CFLAGS="$CFLAGS -I$SYSROOT_PREFIX/usr/include/ncurses"
  export LDFLAGS="$(echo $LDFLAGS | sed -e "s|-Wl,--as-needed||") -ltermcap"
}

post_makeinstall_target() {
  rm -rf $INSTALL/storage/.kodi/addons/virtual.system-tools/data/locale
  rm -rf $INSTALL/storage/.kodi/addons/virtual.system-tools/data/mc/help/mc.hlp.*
}
