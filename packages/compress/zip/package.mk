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

PKG_NAME="zip"
PKG_VERSION="30"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="Info-ZIP"
PKG_SITE="http://www.info-zip.org/pub/infozip/"
PKG_URL="$SOURCEFORGE_SRC/infozip/Zip%203.x%20%28latest%29/3.0/${PKG_NAME}${PKG_VERSION}.tar.gz"
PKG_SOURCE_DIR="${PKG_NAME}${PKG_VERSION}"
PKG_DEPENDS="bzip2"
PKG_BUILD_DEPENDS_TARGET="toolchain bzip2"
PKG_PRIORITY="optional"
PKG_SECTION="compress"
PKG_SHORTDESC="zip: PKUNZIP compatible compression utility"
PKG_LONGDESC="zip is a compression and file packaging utility for Unix, VMS, MSDOS, OS/2, Windows 9x/NT/XP, Minix, Atari, Macintosh, MVS, z/OS, Amiga, Acorn RISC, and other OS. It is analogous to a combination of the Unix commands tar(1) and compress(1) (or tar(1) and gzip(1)) and is compatible with PKZIP (Phil Katz's ZIP for MSDOS systems) and other major zip utilities."

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

make_target() {
  make CC=$TARGET_CC \
       CPP=${TARGET_PREFIX}cpp \
       RANLIB=$TARGET_RANLIB \
       AR=$TARGET_AR \
       STRIP=$TARGET_STRIP \
       LOCAL_ZIP="$TARGET_CFLAGS" \
       -f unix/Makefile generic
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/bin
    cp zip $INSTALL/usr/bin
    $STRIP $INSTALL/usr/bin/zip
}
