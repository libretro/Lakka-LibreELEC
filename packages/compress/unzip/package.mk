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

PKG_NAME="unzip"
PKG_VERSION="60"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="OSS"
PKG_SITE="http://www.info-zip.org/pub/infozip/"
PKG_URL="http://ftp.uk.i-scream.org/sites/www.ibiblio.org/gentoo/distfiles/$PKG_NAME$PKG_VERSION.tar.gz"
PKG_SOURCE_DIR="${PKG_NAME}${PKG_VERSION}"
PKG_DEPENDS_TARGET="toolchain"
PKG_PRIORITY="optional"
PKG_SECTION="compress"
PKG_SHORTDESC="unzip: PKUNZIP compatible compression utility"
PKG_LONGDESC="UnZip is an extraction utility for archives compressed in .zip format (also called "zipfiles"). Although highly compatible both with PKWARE's PKZIP and PKUNZIP utilities for MS-DOS and with Info-ZIP's own Zip program, the primary objectives have been portability and non-MSDOS functionality."
PKG_IS_ADDON="no"

PKG_AUTORECONF="no"

make_target() {
    make CC=$TARGET_CC \
      RANLIB=$TARGET_RANLIB \
      AR=$TARGET_AR \
      STRIP=$TARGET_STRIP \
      -f unix/Makefile generic LOCAL_UNZIP="$CFLAGS"
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/bin
    cp unzip $INSTALL/usr/bin
    $STRIP $INSTALL/usr/bin/unzip
}

