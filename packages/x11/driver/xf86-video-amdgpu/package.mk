# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="xf86-video-amdgpu"
PKG_VERSION="19.0.1"
PKG_SHA256="aaa197196aadcb12e93e10a2aa03c9aedc9ba7b27c2643a8ef620d41e2d1c6d5"
PKG_ARCH="x86_64"
PKG_LICENSE="OSS"
PKG_SITE="http://www.x.org/"
PKG_URL="http://xorg.freedesktop.org/archive/individual/driver/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_TARGET="toolchain xorg-server"
PKG_LONGDESC="AMD Radeon video driver for the Xorg X server."
PKG_TOOLCHAIN="autotools"

PKG_CONFIGURE_OPTS_TARGET="--enable-udev \
                           --enable-glamor \
                           --with-xorg-module-dir=$XORG_PATH_MODULES"

post_makeinstall_target() {
  rm -r $INSTALL/usr/share
  mkdir -p $INSTALL/etc/X11
    cp $PKG_BUILD/conf/10-amdgpu.conf $INSTALL/etc/X11/xorg-amdgpu.conf
}
