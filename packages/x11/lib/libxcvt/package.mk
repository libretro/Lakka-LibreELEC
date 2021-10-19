# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2021-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libxcvt"
PKG_VERSION="0.1.0"
PKG_SHA256="90a4d4814935109890aa6c8101bf98ffbdc293000772f5db3d206f27d8a61976"
PKG_LICENSE="OSS"
PKG_SITE="https://gitlab.freedesktop.org/xorg/lib/libxcvt"
PKG_URL="https://gitlab.freedesktop.org/xorg/lib/${PKG_NAME}/-/archive/${PKG_NAME}-${PKG_VERSION}/${PKG_NAME}-${PKG_NAME}-${PKG_VERSION}.tar.bz2"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="libxcvt is a library providing a standalone version of the X server implementation of the VESA CVT standard timing modelines generator."
PKG_BUILD_FLAGS="+pic"
