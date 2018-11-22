# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="alsa-lib"
PKG_VERSION="1.1.7"
PKG_SHA256="9d6000b882a3b2df56300521225d69717be6741b71269e488bb20a20783bdc09"
PKG_LICENSE="GPL"
PKG_SITE="http://www.alsa-project.org/"
PKG_URL="ftp://ftp.alsa-project.org/pub/lib/alsa-lib-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="ALSA (Advanced Linux Sound Architecture) is the next generation Linux Sound API."
PKG_TOOLCHAIN="autotools"
PKG_BUILD_FLAGS="+pic"

if build_with_debug; then
  PKG_ALSA_DEBUG=--with-debug
else
  PKG_ALSA_DEBUG=--without-debug
fi

PKG_CONFIGURE_OPTS_TARGET="$PKG_ALSA_DEBUG \
                           --disable-dependency-tracking \
                           --with-plugindir=/usr/lib/alsa \
                           --disable-python"

post_configure_target() {
  sed -i 's/.*PKGLIBDIR.*/#define PKGLIBDIR ""/' include/config.h
}

post_makeinstall_target() {
  rm -rf $INSTALL/usr/bin

  mkdir -p $INSTALL/usr/config
    cp -PR $PKG_DIR/config/modprobe.d $INSTALL/usr/config
}

post_install() {
  add_group audio 63
}
