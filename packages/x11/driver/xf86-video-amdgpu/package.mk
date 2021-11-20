# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="xf86-video-amdgpu"
PKG_VERSION="21.0.0"
PKG_SHA256="607823034defba6152050e5eb1c4df94b38819ef764291abadd81b620bc2ad88"
PKG_ARCH="x86_64"
PKG_LICENSE="OSS"
PKG_SITE="https://www.x.org/wiki/RadeonFeature/"
PKG_URL="http://xorg.freedesktop.org/archive/individual/driver/${PKG_NAME}-${PKG_VERSION}.tar.bz2"
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
