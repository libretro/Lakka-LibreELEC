# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2020-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="alsa-topology-conf"
PKG_VERSION="1.2.4"
PKG_SHA256="55e0e6e42eca4cc7656c257af2440cdc65b83689dca49fc60ca0194db079ed07"
PKG_LICENSE="BSD-3c"
PKG_SITE="http://www.alsa-project.org/"
PKG_URL="ftp://ftp.alsa-project.org/pub/lib/alsa-topology-conf-$PKG_VERSION.tar.bz2"
PKG_LONGDESC="ALSA topology configuration files"
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/share/alsa/
  cp -PR ${PKG_BUILD}/topology ${INSTALL}/usr/share/alsa/
}
