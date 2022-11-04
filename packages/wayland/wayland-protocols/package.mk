# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="wayland-protocols"
PKG_VERSION="1.29"
PKG_SHA256="e25e9ab75ac736704ddefe92e8f9ac8730beab6f564db62f7ad695bba4ff9ed8"
PKG_LICENSE="OSS"
PKG_SITE="https://wayland.freedesktop.org/"
PKG_URL="https://gitlab.freedesktop.org/wayland/${PKG_NAME}/-/releases/${PKG_VERSION}/downloads/${PKG_NAME}-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain wayland:host"
PKG_LONGDESC="Specifications of extended Wayland protocols"

PKG_MESON_OPTS_TARGET="-Dtests=false"

post_makeinstall_target() {
  safe_remove ${INSTALL}
}
