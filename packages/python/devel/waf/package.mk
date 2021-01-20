# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="waf"
PKG_VERSION="2.0.21"
PKG_SHA256="7cebf2c5efe53cbb9a4b5bdc4b49ae90ecd64a8fce7a3222d58e591b58215306"
PKG_LICENSE="MIT"
PKG_SITE="https://waf.io"
PKG_URL="https://waf.io/${PKG_NAME}-${PKG_VERSION}"
PKG_LONGDESC="The Waf build system"
PKG_TOOLCHAIN="manual"

unpack() {
  mkdir -p ${PKG_BUILD}
    cp ${SOURCES}/${PKG_NAME}/${PKG_SOURCE_NAME} ${PKG_BUILD}/waf
    chmod a+x ${PKG_BUILD}/waf
}

makeinstall_host() {
  cp -pf waf ${TOOLCHAIN}/bin/
}
