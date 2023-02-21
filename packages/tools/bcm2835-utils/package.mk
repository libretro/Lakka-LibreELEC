# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2023-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="bcm2835-utils"
PKG_VERSION="5db3e694d27431403bebb13404f5d85899b571e0"
PKG_SHA256="ab8a9f7632fe979533b801644f30211f916cd8280f476471b5d323d420d7a146"
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
