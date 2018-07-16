# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)

PKG_NAME="libxkbcommon"
PKG_VERSION="0.7.1"
PKG_SHA256="ba59305d2e19e47c27ea065c2e0df96ebac6a3c6e97e28ae5620073b6084e68b"
PKG_ARCH="any"
PKG_LICENSE="OSS"
PKG_SITE="http://xkbcommon.org"
PKG_URL="http://xkbcommon.org/download/${PKG_NAME}-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain xkeyboard-config"
PKG_SECTION="wayland"
PKG_SHORTDESC="xkbcommon: a library to handle keyboard descriptions"
PKG_LONGDESC="xkbcommon is a library to handle keyboard descriptions, including loading them from disk, parsing them and handling their state. It's mainly meant for client toolkits, window systems, and other system applications; currently that includes Wayland, kmscon, GTK+, Qt, Clutter, and more. It is also used by some XCB applications for proper keyboard support."

if [ "$DISPLAYSERVER" = "x11" ]; then
  PKG_CONFIGURE_OPTS_TARGET="--enable-x11"
else
  PKG_CONFIGURE_OPTS_TARGET="--disable-x11"
fi
