# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2020-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="vadumpcaps"
PKG_VERSION="fb4dfef76c0fa08f853af377d5d4945d5fb3001c"
PKG_SHA256="4362084e366ef66dc6bd9336baa570a5b459dade57783b24001b2847818a8b69"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/fhvwy/vadumpcaps"
PKG_URL="https://github.com/fhvwy/vadumpcaps/archive/$PKG_VERSION.tar.gz"
PKG_LONGDESC="This is a utility to show all capabilities of a VAAPI device/driver."
PKG_DEPENDS_TARGET="toolchain libva"
PKG_TOOLCHAIN="make"

makeinstall_target() {
  mkdir -p $INSTALL/usr/bin
  cp vadumpcaps $INSTALL/usr/bin
}
