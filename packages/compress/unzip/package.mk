# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)

PKG_NAME="unzip"
PKG_VERSION="60"
PKG_SHA256="036d96991646d0449ed0aa952e4fbe21b476ce994abc276e49d30e686708bd37"
PKG_ARCH="any"
PKG_LICENSE="OSS"
PKG_SITE="http://www.info-zip.org/pub/infozip/"
PKG_URL="http://ftp.uk.i-scream.org/sites/www.ibiblio.org/gentoo/distfiles/$PKG_NAME$PKG_VERSION.tar.gz"
PKG_SOURCE_DIR="${PKG_NAME}${PKG_VERSION}"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="compress"
PKG_SHORTDESC="unzip: PKUNZIP compatible compression utility"
PKG_LONGDESC="UnZip is an extraction utility for archives compressed in .zip format (also called "zipfiles"). Although highly compatible both with PKWARE's PKZIP and PKUNZIP utilities for MS-DOS and with Info-ZIP's own Zip program, the primary objectives have been portability and non-MSDOS functionality."
PKG_TOOLCHAIN="manual"

make_target() {
    make CC=$CC RANLIB=$RANLIB AR=$AR STRIP=$STRIP \
         -f unix/Makefile generic LOCAL_UNZIP="$CFLAGS"
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/bin
    cp unzip $INSTALL/usr/bin
    $STRIP $INSTALL/usr/bin/unzip
}
