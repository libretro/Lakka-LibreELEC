# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="waf"
PKG_VERSION="2.0.23"
PKG_SHA256="28a96115a5b5be47cf65e62c5416d988159d03f062f978e6462024ca93111503"
PKG_LICENSE="MIT"
PKG_SITE="https://waf.io"
PKG_URL="https://waf.io/${PKG_NAME}-${PKG_VERSION}.tar.bz2"
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
