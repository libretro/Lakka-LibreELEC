# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2014 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libXScrnSaver"
PKG_VERSION="1.2.5"
PKG_SHA256="5057365f847253e0e275871441e10ff7846c8322a5d88e1e187d326de1cd8d00"
PKG_LICENSE="GPL"
PKG_SITE="https://xorg.freedesktop.org/"
PKG_URL="https://xorg.freedesktop.org/releases/individual/lib/libXScrnSaver-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain libXext scrnsaverproto"
PKG_LONGDESC="X11 Screen Saver extension client library."
PKG_BUILD_FLAGS="-sysroot"

PKG_MESON_OPTS_TARGET="-Ddefault_library=shared"
