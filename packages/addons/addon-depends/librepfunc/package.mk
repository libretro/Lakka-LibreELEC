# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2023-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="librepfunc"
PKG_VERSION="1.11.2"
PKG_SHA256="ef8349bd8ddd8bb44d4e8df1c6a0a17d202b293efd26f10c626156415c7a2972"
PKG_LICENSE="GPL-2.0"
PKG_SITE="https://github.com/wirbel-at-vdr-portal/librepfunc"
PKG_URL="https://github.com/wirbel-at-vdr-portal/librepfunc/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="librepfunc - a collection of functions, classes used by wirbel-at-vdr-portal"
PKG_BUILD_FLAGS="-sysroot"

pre_configure_target() {
  sed -i -e 's/^install:/install-shared:/' -e 's/^install-static:/install:/' Makefile
}
