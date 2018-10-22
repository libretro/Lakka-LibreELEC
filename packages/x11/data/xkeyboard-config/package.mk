# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)

PKG_NAME="xkeyboard-config"
PKG_VERSION="2.23.1"
PKG_SHA256="2a4bbc05fea22151b7a7c8ac2655d549aa9b0486bedc7f5a68c72716343b02f3"
PKG_LICENSE="OSS"
PKG_SITE="http://www.X.org"
PKG_URL="http://www.x.org/releases/individual/data/$PKG_NAME/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_LONGDESC="X keyboard extension data files."
PKG_TOOLCHAIN="autotools"

if [ "$DISPLAYSERVER" = "x11" ]; then
  PKG_DEPENDS_TARGET="toolchain util-macros xkbcomp"
  DISPLAYSERVER_XKEYBOARD="XKBCOMP=/usr/bin/xkbcomp \
                           --with-xkb-base=$XORG_PATH_XKB \
                           --with-xkb-rules-symlink=xorg"

else
  PKG_DEPENDS_TARGET="toolchain util-macros"
  DISPLAYSERVER_XKEYBOARD=""
fi

PKG_CONFIGURE_OPTS_TARGET="--without-xsltproc \
                           --enable-compat-rules \
                           --disable-runtime-deps \
                           --enable-nls \
                           --disable-rpath \
                           --with-gnu-ld \
                           $DISPLAYSERVER_XKEYBOARD"

pre_build_target() {
# broken autoreconf
  ( cd $PKG_BUILD
    intltoolize --force
  )
}
