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

PKG_NAME="libdnet"
PKG_VERSION="1.12"
PKG_ARCH="any"
PKG_LICENSE="BSD"
PKG_SITE="http://code.google.com/p/libdnet/"
PKG_URL="http://libdnet.googlecode.com/files/$PKG_NAME-$PKG_VERSION.tgz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="network"
PKG_SHORTDESC="A simplified, portable interface to several low-level networking routines"
PKG_LONGDESC="A simplified, portable interface to several low-level networking routines"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

PKG_CONFIGURE_OPTS_TARGET="ac_cv_func_strlcat=no \
                           ac_cv_func_strlcpy=no \
                           --enable-static \
                           --disable-shared \
                           --without-python"

pre_configure_target() {
  sed "s|@prefix@|$SYSROOT_PREFIX/usr|g" -i $PKG_BUILD/dnet-config.in
}

post_makeinstall_target() {
  mkdir -p $TOOLCHAIN/bin
    cp dnet-config $TOOLCHAIN/bin/
}
