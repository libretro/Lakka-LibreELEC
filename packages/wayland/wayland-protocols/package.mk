# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="wayland-protocols"
PKG_VERSION="1.20"
PKG_SHA256="9782b7a1a863d82d7c92478497d13c758f52e7da4f197aa16443f73de77e4de7"
PKG_LICENSE="OSS"
PKG_SITE="https://wayland.freedesktop.org/"
PKG_URL="https://wayland.freedesktop.org/releases/${PKG_NAME}-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Specifications of extended Wayland protocols"

post_makeinstall_target() {
  rm -rf ${INSTALL}
}
