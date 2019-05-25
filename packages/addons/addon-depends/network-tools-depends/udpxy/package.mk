# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="udpxy"
PKG_VERSION="1.0.23-12"
PKG_SHA256="16bdc8fb22f7659e0427e53567dc3e56900339da261199b3d00104d699f7e94c"
PKG_LICENSE="GPLv3"
PKG_SITE="http://www.udpxy.com"
PKG_URL="http://www.udpxy.com/download/1_23/${PKG_NAME}.${PKG_VERSION}-prod.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="A UDP-to-HTTP multicast traffic relay daemon."

configure_target() {
  export CFLAGS+=" -Wno-stringop-truncation"
}

makeinstall_target() {
  :
}
