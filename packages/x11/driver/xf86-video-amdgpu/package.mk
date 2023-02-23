# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="xf86-video-amdgpu"
PKG_VERSION="23.0.0"
PKG_SHA256="4f04f0ea66f3ced0dcc58f617409860163a19c4e8c285cfb5285f36ba09cc061"
PKG_ARCH="x86_64"
PKG_LICENSE="OSS"
PKG_SITE="https://www.x.org/wiki/RadeonFeature/"
PKG_URL="https://www.x.org/archive/individual/driver/${PKG_NAME}-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain libdrm xorg-server"
PKG_LONGDESC="Xorg driver for AMD Radeon GPUs using the amdgpu kernel driver."
PKG_TOOLCHAIN="autotools"

PKG_CONFIGURE_OPTS_TARGET="--enable-udev \
                           --enable-glamor \
                           --with-xorg-module-dir=${XORG_PATH_MODULES}"

post_makeinstall_target() {
  rm -r ${INSTALL}/usr/share
  mkdir -p ${INSTALL}/etc/X11
    cp ${PKG_BUILD}/conf/10-amdgpu.conf ${INSTALL}/etc/X11/xorg-amdgpu.conf
}
