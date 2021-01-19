# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="dstat"
PKG_VERSION="e428c7dc7137f81f8ca6bef8854b37a4ddd4f337" # 19 Jun 2020
PKG_SHA256="3315f5cefc7cd4e968430baa19247fc32af36dd42c9ad3edf5962ae4f597013f"
PKG_LICENSE="GPL"
PKG_SITE="http://dag.wiee.rs/home-made/dstat"
PKG_URL="https://github.com/dstat-real/dstat/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain Python3"
PKG_LONGDESC="Versatile resource statistics tool."
PKG_TOOLCHAIN="manual"
PKG_BUILD_FLAGS="-sysroot"

post_unpack() {
  rm ${PKG_BUILD}/Makefile
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/bin
  cp -p dstat ${INSTALL}/usr/bin
}
