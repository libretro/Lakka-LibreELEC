# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2023-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="bcm2835-utils"
PKG_VERSION="4e3333c62c202b0b12c3b881d3d9729efa66ca08"
PKG_SHA256="78f02f13304ccd14276c5b658087cc1805a690d41478df98e7ed0ba210f11352"
PKG_ARCH="arm aarch64"
PKG_LICENSE="BSD-3-Clause"
PKG_SITE="https://github.com/raspberrypi/utils"
PKG_URL="https://github.com/raspberrypi/utils/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="gcc:host"
PKG_LONGDESC="Raspberry Pi related collection of scripts and simple applications"
PKG_TOOLCHAIN="cmake"

# only going to use vclog so don't build everything else
make_target() {
  mkdir -p ${PKG_BUILD}/.${TARGET_NAME}/vclog/build
  cd ${PKG_BUILD}/.${TARGET_NAME}/vclog/build
  cmake -DCMAKE_TOOLCHAIN_FILE=${CMAKE_CONF} -DCMAKE_C_FLAGS="${TARGET_CFLAGS}" -S ${PKG_BUILD}/vclog
  make
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/bin
  cp -PRv ${PKG_BUILD}/.${TARGET_NAME}/vclog/build/vclog ${INSTALL}/usr/bin
}
