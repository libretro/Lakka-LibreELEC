################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#      Copyright (C) 2016 Team LibreELEC
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

PKG_NAME="irssi"
PKG_VERSION="0.8.19"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://www.irssi.org/"
PKG_URL="https://github.com/irssi-import/irssi/releases/download/$PKG_VERSION/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain glib netbsd-curses openssl"
PKG_SECTION="tools"
PKG_SHORTDESC="IRC client"
PKG_LONGDESC="Irssi is a terminal based IRC client for UNIX systems"
PKG_AUTORECONF="no"

PKG_CONFIGURE_OPTS_TARGET="--with-sysroot=$SYSROOT_PREFIX \
        --enable-ssl \
        --disable-glibtest \
        --without-socks \
        --with-textui \
        --without-bot \
        --without-proxy \
        --with-gc \
        --without-perl \
        --without-sco"

pre_configure_target() {
  export CFLAGS="$CFLAGS -I$PKG_BUILD"
  export LIBS="-ltermcap"
}

makeinstall_target() {
  : # nop
}
