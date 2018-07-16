# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)

PKG_NAME="xf86-video-ati"
PKG_VERSION="18.0.1"
PKG_SHA256="72ea3b8127d4550b64f797457f5a7851a541fa4ee2cc3f345b6c1886b81714a0"
PKG_ARCH="x86_64"
PKG_LICENSE="OSS"
PKG_SITE="http://www.x.org/"
PKG_URL="http://xorg.freedesktop.org/archive/individual/driver/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_TARGET="toolchain xorg-server"
PKG_SECTION="x11/driver"
PKG_SHORTDESC="xf86-video-ati: The Xorg driver for ATI video chips"
PKG_LONGDESC="The ati driver supports various ATi, know AMD, video chips."
PKG_TOOLCHAIN="autotools"

PKG_CONFIGURE_OPTS_TARGET="--enable-glamor --with-xorg-module-dir=$XORG_PATH_MODULES"

post_makeinstall_target() {
  mkdir -p $INSTALL/etc/X11
    cp $PKG_DIR/config/*.conf $INSTALL/etc/X11
}
