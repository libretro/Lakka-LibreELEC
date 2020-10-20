# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2020-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="alsa-ucm-conf"
PKG_VERSION="1.2.4"
PKG_SHA256="2c3b535c77dcb9aaf62a61f4f8324f1ab184162f105f7ec9ed1e37c742fcd340"
PKG_LICENSE="BSD-3c"
PKG_SITE="http://www.alsa-project.org/"
PKG_URL="ftp://ftp.alsa-project.org/pub/lib/alsa-ucm-conf-$PKG_VERSION.tar.bz2"
PKG_LONGDESC="ALSA Use Case Manager configuration (and topologies)"
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/share/alsa/
  cp -PR ${PKG_BUILD}/ucm2 ${INSTALL}/usr/share/alsa/
  safe_remove ${INSTALL}/usr/share/alsa/ucm2/README.md
}
