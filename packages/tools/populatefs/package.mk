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

PKG_NAME="populatefs"
PKG_VERSION="1.0"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/lipnitsk/populatefs"
PKG_URL="https://github.com/lipnitsk/$PKG_NAME/archive/v${PKG_VERSION}.tar.gz"
PKG_DEPENDS_HOST="e2fsprogs:host"
PKG_SECTION="tools"
PKG_SHORTDESC="populatefs: Tool for replacing genext2fs when creating ext4 images"
PKG_LONGDESC="populatefs: Tool for replacing genext2fs when creating ext4 images"
PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

make_host() {
  make EXTRA_LIBS="-lcom_err -lpthread" CFLAGS="$CFLAGS -fPIC"
}

makeinstall_host() {
  $STRIP src/populatefs

  mkdir -p $ROOT/$TOOLCHAIN/sbin
  cp src/populatefs $ROOT/$TOOLCHAIN/sbin
}
