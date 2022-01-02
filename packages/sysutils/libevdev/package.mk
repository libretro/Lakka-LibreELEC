# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libevdev"
PKG_VERSION="1.12.0"
PKG_SHA256="2f729e3480695791f9482e8388bd723402b89f0eaf118057bbdea3cecee9b237"
PKG_LICENSE="MIT"
PKG_SITE="http://www.freedesktop.org/wiki/Software/libevdev/"
PKG_URL="http://www.freedesktop.org/software/libevdev/${PKG_NAME}-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="libevdev is a wrapper library for evdev devices."
PKG_BUILD_FLAGS="+pic"
PKG_TOOLCHAIN="meson"

PKG_MESON_OPTS_TARGET=" \
  -Ddefault_library=shared \
  -Ddocumentation=disabled \
  -Dtests=disabled"

post_makeinstall_target() {
  rm -rf ${INSTALL}/usr/bin
}
