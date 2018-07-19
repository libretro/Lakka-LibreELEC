# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)

PKG_NAME="freetype"
PKG_VERSION="2.6.5"
PKG_SHA256="e20a6e1400798fd5e3d831dd821b61c35b1f9a6465d6b18a53a9df4cf441acf0"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://www.freetype.org"
PKG_URL="http://download.savannah.gnu.org/releases/freetype/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_TARGET="toolchain zlib libpng"
PKG_SECTION="print"
PKG_SHORTDESC="freetype: TrueType font rendering library"
PKG_LONGDESC="The FreeType engine is a free and portable TrueType font rendering engine. It has been developed to provide TT support to a great variety of platforms and environments."
PKG_TOOLCHAIN="configure"

# package specific configure options
PKG_CONFIGURE_OPTS_TARGET="LIBPNG_CFLAGS=-I$SYSROOT_PREFIX/usr/include \
                           LIBPNG_LDFLAGS=-L$SYSROOT_PREFIX/usr/lib \
                           --with-zlib"

pre_configure_target() {
  # unset LIBTOOL because freetype uses its own
    ( cd ..
      unset LIBTOOL
      sh autogen.sh
    )
}

post_makeinstall_target() {
  $SED "s:\(['=\" ]\)/usr:\\1$SYSROOT_PREFIX/usr:g" $SYSROOT_PREFIX/usr/bin/freetype-config
  ln -v -sf $SYSROOT_PREFIX/usr/include/freetype2 $SYSROOT_PREFIX/usr/include/freetype

  rm -rf $INSTALL/usr/bin
}
