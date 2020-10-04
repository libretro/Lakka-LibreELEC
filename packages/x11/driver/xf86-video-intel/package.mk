# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="xf86-video-intel"
PKG_VERSION="5ca3ac1a90af177eb111a965e9b4dd8a27cc58fc"
PKG_SHA256="1b1e27fa1fd8c8979fbb4aac78865e09b984b998f8330fa01b7e1cf789685507"
PKG_ARCH="x86_64"
PKG_LICENSE="OSS"
PKG_SITE="http://intellinuxgraphics.org/"
PKG_URL="https://gitlab.freedesktop.org/xorg/driver/$PKG_NAME/-/archive/$PKG_VERSION/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_TARGET="toolchain libXcomposite libXxf86vm libXdamage libdrm util-macros systemd xorg-server"
PKG_LONGDESC="The Xorg driver for Intel i810, i815, 830M, 845G, 852GM, 855GM, 865G, 915G, 915GM and 965G."
PKG_TOOLCHAIN="autotools"
# xf86-video-intel is broken enough. dont link with LTO

PKG_CONFIGURE_OPTS_TARGET="--disable-backlight \
                           --disable-backlight-helper \
                           --disable-gen4asm \
                           --enable-udev \
                           --disable-tools \
                           --enable-dri \
                           --disable-dri1 \
                           --enable-dri2 \
                           --enable-dri3 \
                           --enable-kms --enable-kms-only \
                           --disable-ums --disable-ums-only \
                           --enable-sna \
                           --enable-uxa \
                           --disable-xvmc \
                           --disable-xaa \
                           --disable-dga \
                           --disable-tear-free \
                           --disable-create2 \
                           --disable-async-swap \
                           --with-default-dri=2 \
                           --with-xorg-module-dir=$XORG_PATH_MODULES"

post_makeinstall_target() {
  rm -rf $INSTALL/usr/share/polkit-1
}
