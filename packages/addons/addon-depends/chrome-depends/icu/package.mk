################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#      Copyright (C) 2016-present Team LibreELEC
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

PKG_NAME="icu"
PKG_VERSION="61.1"
PKG_SHA256="d007f89ae8a2543a53525c74359b65b36412fa84b3349f1400be6dcf409fafef"
PKG_ARCH="any"
PKG_LICENSE="Custom"
PKG_SITE="http://www.icu-project.org"
PKG_URL="http://download.icu-project.org/files/icu4c/${PKG_VERSION}/icu4c-${PKG_VERSION//./_}-src.tgz"
PKG_SOURCE_DIR="icu"
PKG_DEPENDS_TARGET="toolchain icu:host"
PKG_LONGDESC="International Components for Unicode library"

PKG_ICU_OPTS="--disable-extras \
              --disable-icuio \
              --disable-layout \
              --disable-renaming \
              --disable-samples \
              --disable-tests \
              --disable-tools"


PKG_CONFIGURE_OPTS_HOST="--enable-static \
                         --disable-shared \
                         $PKG_ICU_OPTS"

PKG_CONFIGURE_OPTS_TARGET="--with-cross-build=$PKG_BUILD/.$HOST_NAME \
                         $PKG_ICU_OPTS"

PKG_CONFIGURE_SCRIPT="source/configure"

post_makeinstall_target() {
  rm -rf $INSTALL
}
