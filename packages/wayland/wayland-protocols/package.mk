# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="wayland-protocols"
PKG_VERSION="1.34"
PKG_SHA256="c59b27cacd85f60baf4ee5f80df5c0d15760ead6a2432b00ab7e2e0574dcafeb"
PKG_LICENSE="OSS"
PKG_SITE="https://wayland.freedesktop.org/"
PKG_URL="https://gitlab.freedesktop.org/wayland/${PKG_NAME}/-/releases/${PKG_VERSION}/downloads/${PKG_NAME}-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain wayland:host"
PKG_LONGDESC="Specifications of extended Wayland protocols"

PKG_MESON_OPTS_TARGET="-Dtests=false"

post_makeinstall_target() {
  safe_remove ${INSTALL}
}
