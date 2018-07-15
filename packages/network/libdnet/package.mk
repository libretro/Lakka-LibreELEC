################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#      Copyright (C) 2018-present Team LibreELEC
#      Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
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

PKG_NAME="libdnet"
PKG_VERSION="8029bf9"
PKG_SHA256="1e41cbe5e4884108b08fa92964305354f1662b7e889f62736b3749845d7a8c56"
PKG_ARCH="any"
PKG_LICENSE="BSD"
PKG_SITE="https://github.com/sgeto/libdnet"
PKG_URL="https://github.com/sgeto/libdnet/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="network"
PKG_LONGDESC="A simplified, portable interface to several low-level networking routines"
PKG_TOOLCHAIN="autotools"
PKG_BUILD_FLAGS="+pic"

PKG_CONFIGURE_OPTS_TARGET="ac_cv_func_strlcat=no \
                           ac_cv_func_strlcpy=no \
                           --enable-static \
                           --disable-shared \
                           --disable-python"

pre_configure_target() {
  export CFLAGS+=" -I$PKG_BUILD/include"
}

post_makeinstall_target() {
  cp $SYSROOT_PREFIX/usr/bin/dnet-config \
     $TOOLCHAIN/bin/dnet-config
}
