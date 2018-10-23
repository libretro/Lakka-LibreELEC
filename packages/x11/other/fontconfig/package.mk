# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)

PKG_NAME="fontconfig"
PKG_VERSION="2.12.6"
PKG_SHA256="064b9ebf060c9e77011733ac9dc0e2ce92870b574cca2405e11f5353a683c334"
PKG_LICENSE="OSS"
PKG_SITE="http://www.fontconfig.org"
PKG_URL="http://www.freedesktop.org/software/fontconfig/release/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain util-macros freetype libxml2 zlib expat"
PKG_LONGDESC="Fontconfig is a library for font customization and configuration."

PKG_CONFIGURE_OPTS_TARGET="--with-arch=$TARGET_ARCH \
                           --with-cache-dir=/storage/.cache/fontconfig \
                           --with-default-fonts=/usr/share/fonts \
                           --without-add-fonts \
                           --disable-dependency-tracking \
                           --disable-docs"

pre_configure_target() {
# ensure we dont use '-O3' optimization.
  CFLAGS=`echo $CFLAGS | sed -e "s|-O3|-O2|"`
  CXXFLAGS=`echo $CXXFLAGS | sed -e "s|-O3|-O2|"`
  CFLAGS="$CFLAGS -I$PKG_BUILD"
  CXXFLAGS="$CXXFLAGS -I$PKG_BUILD"

  # Delete this as a workaround https://bugs.freedesktop.org/show_bug.cgi?id=101280
  rm -f $PKG_BUILD/src/fcobjshash.h
}

post_makeinstall_target() {
  rm -rf $INSTALL/usr/bin

  mkdir -p $INSTALL/etc/fonts/conf.d
    cp $PKG_DIR/conf.d/*.conf $INSTALL/etc/fonts/conf.d
}
