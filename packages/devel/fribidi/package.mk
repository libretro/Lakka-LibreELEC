# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="fribidi"
PKG_VERSION="1.0.14"
PKG_SHA256="76ae204a7027652ac3981b9fa5817c083ba23114340284c58e756b259cd2259a"
PKG_LICENSE="LGPL"
PKG_SITE="http://fribidi.freedesktop.org/"
PKG_URL="https://github.com/fribidi/fribidi/releases/download/v${PKG_VERSION}/${PKG_NAME}-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="A bidirectional algorithm library."
PKG_BUILD_FLAGS="+pic"

PKG_MESON_OPTS_TARGET="-Ddeprecated=false \
                       -Ddocs=false \
                       -Ddefault_library=static"

post_makeinstall_target() {
  mkdir -p ${SYSROOT_PREFIX}/usr/bin
    cp -f ${PKG_DIR}/scripts/fribidi-config ${SYSROOT_PREFIX}/usr/bin
    chmod +x ${SYSROOT_PREFIX}/usr/bin/fribidi-config

  rm -rf ${INSTALL}/usr/bin
}
