# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="waf"
PKG_VERSION="2.0.22"
PKG_SHA256="0a09ad26a2cfc69fa26ab871cb558165b60374b5a653ff556a0c6aca63a00df1"
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
