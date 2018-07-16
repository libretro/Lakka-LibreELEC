# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)

PKG_NAME="zip"
PKG_VERSION="30"
PKG_SHA256="f0e8bb1f9b7eb0b01285495a2699df3a4b766784c1765a8f1aeedf63c0806369"
PKG_ARCH="any"
PKG_LICENSE="Info-ZIP"
PKG_SITE="http://www.info-zip.org/pub/infozip/"
PKG_URL="$SOURCEFORGE_SRC/infozip/Zip%203.x%20%28latest%29/3.0/${PKG_NAME}${PKG_VERSION}.tar.gz"
PKG_SOURCE_DIR="${PKG_NAME}${PKG_VERSION}"
PKG_DEPENDS_TARGET="toolchain bzip2"
PKG_SECTION="compress"
PKG_SHORTDESC="zip: PKUNZIP compatible compression utility"
PKG_LONGDESC="zip is a compression and file packaging utility for Unix, VMS, MSDOS, OS/2, Windows 9x/NT/XP, Minix, Atari, Macintosh, MVS, z/OS, Amiga, Acorn RISC, and other OS. It is analogous to a combination of the Unix commands tar(1) and compress(1) (or tar(1) and gzip(1)) and is compatible with PKZIP (Phil Katz's ZIP for MSDOS systems) and other major zip utilities."
PKG_TOOLCHAIN="manual"

make_target() {
  make CC=$CC CPP=$CPP RANLIB=$RANLIB AR=$AR STRIP=$STRIP LOCAL_ZIP="$CFLAGS" \
       -f unix/Makefile generic
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/bin
    cp zip $INSTALL/usr/bin
    $STRIP $INSTALL/usr/bin/zip
}
