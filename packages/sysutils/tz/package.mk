# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="tz"
PKG_VERSION="2021e"
PKG_SHA256="11908a7f18530ca3013c8458d902a54cdd3382276bdd56891db074b1af4a26b8"
PKG_LICENSE="Public Domain"
PKG_SITE="http://www.iana.org/time-zones"
PKG_URL="https://github.com/eggert/tz/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Time zone and daylight-saving time data."

pre_configure_target() {
  PKG_MAKE_OPTS_TARGET="CC=${HOST_CC} LDFLAGS="
}

makeinstall_target() {
  make TZDIR="${INSTALL}/usr/share/zoneinfo" REDO=posix_only TOPDIR="${INSTALL}" install
}

post_makeinstall_target() {
  rm -rf ${INSTALL}/usr/bin ${INSTALL}/usr/sbin

  rm -rf ${INSTALL}/etc
  mkdir -p ${INSTALL}/etc
    ln -sf /var/run/localtime ${INSTALL}/etc/localtime
}

post_install() {
  enable_service tz-data.service
}
