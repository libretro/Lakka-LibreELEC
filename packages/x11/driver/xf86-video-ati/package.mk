# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)

PKG_NAME="xf86-video-ati"
PKG_VERSION="18.1.0"
PKG_SHA256="6c335f423c1dc3d904550d41cb871ca4130ba7037dda67d82e3f1555e1bfb9ac"
PKG_ARCH="x86_64"
PKG_LICENSE="OSS"
PKG_SITE="http://www.x.org/"
PKG_URL="http://xorg.freedesktop.org/archive/individual/driver/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_TARGET="toolchain xorg-server"
PKG_LONGDESC="The ati driver supports various ATi, know AMD, video chips."
PKG_TOOLCHAIN="autotools"

PKG_CONFIGURE_OPTS_TARGET="--enable-glamor --with-xorg-module-dir=$XORG_PATH_MODULES"

post_makeinstall_target() {
  mkdir -p $INSTALL/etc/X11
    cp $PKG_DIR/config/*.conf $INSTALL/etc/X11
}
