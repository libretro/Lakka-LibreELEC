# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2020-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="alsa-topology-conf"
PKG_VERSION="1.2.2"
PKG_SHA256="b472d6b567c78173bd69543d9cffc9e379c80eb763c3afc8d5b24d5610d19425"
PKG_LICENSE="BSD-3c"
PKG_SITE="http://www.alsa-project.org/"
PKG_URL="ftp://ftp.alsa-project.org/pub/lib/alsa-topology-conf-$PKG_VERSION.tar.bz2"
PKG_LONGDESC="ALSA topology configuration files"
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/share/alsa/
  cp -PR ${PKG_BUILD}/topology ${INSTALL}/usr/share/alsa/
}
