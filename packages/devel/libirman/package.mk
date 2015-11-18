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

PKG_NAME="libirman"
PKG_VERSION="0.5.0"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://sourceforge.net/projects/lirc"
PKG_URL="http://downloads.sourceforge.net/project/lirc/libirman/$PKG_VERSION/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain systemd"
PKG_PRIORITY="optional"
PKG_SECTION="system"
PKG_SHORTDESC="libirman library for lircd"
PKG_LONGDESC="libirman library for lircd"

PKG_IS_ADDON="no"
PKG_AUTORECONF="yes"

PKG_CONFIGURE_OPTS_TARGET="--disable-shared \
                           --enable-static \
                           --disable-swtest"

pre_configure_target() {
  CFLAGS="$CFLAGS -fPIC -DPIC"
}

post_makeinstall_target() {
  rm -rf $INSTALL/usr/bin
}
