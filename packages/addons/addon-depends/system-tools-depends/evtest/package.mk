# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="evtest"
PKG_VERSION="1.36"
PKG_SHA256="3b9a66c92e48b0cd13b689530b5729c031bc1bcbfe9d19c258f9245e2f8d2a0f"
PKG_LICENSE="GPL"
PKG_SITE="https://gitlab.freedesktop.org/libevdev/evtest/"
PKG_URL="https://gitlab.freedesktop.org/libevdev/evtest/-/archive/${PKG_NAME}-${PKG_VERSION}/${PKG_NAME}-${PKG_NAME}-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain libxml2"
PKG_LONGDESC="A simple tool for input event debugging."
PKG_TOOLCHAIN="autotools"
PKG_BUILD_FLAGS="-sysroot"
