# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="wayland-protocols"
PKG_VERSION="1.12"
PKG_SHA256="3b19e8a9e1e19474756a7069db23b90ca9b8ebb438448c6063b4a7fc89b7c8b2"
PKG_LICENSE="OSS"
PKG_SITE="https://wayland.freedesktop.org/"
PKG_URL="https://wayland.freedesktop.org/releases/${PKG_NAME}-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Specifications of extended Wayland protocols"

post_makeinstall_target() {
  rm -rf $INSTALL
}
