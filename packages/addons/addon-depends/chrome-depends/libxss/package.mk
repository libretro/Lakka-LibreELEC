# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libxss"
PKG_VERSION="1.2.5"
PKG_SHA256="5057365f847253e0e275871441e10ff7846c8322a5d88e1e187d326de1cd8d00"
PKG_LICENSE="OSS"
PKG_SITE="https://www.X.org"
PKG_URL="https://xorg.freedesktop.org/archive/individual/lib/libXScrnSaver-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain util-macros libXext scrnsaverproto"
PKG_LONGDESC="X11 Screen Saver extension library."
PKG_BUILD_FLAGS="+pic -sysroot"
