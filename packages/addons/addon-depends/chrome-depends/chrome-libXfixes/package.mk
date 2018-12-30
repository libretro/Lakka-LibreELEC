# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

. $(get_pkg_directory libXfixes)/package.mk

PKG_NAME="chrome-libXfixes"
PKG_LONGDESC="libXfixes for chrome"
PKG_URL=""

PKG_CONFIGURE_OPTS_TARGET="--disable-static \
                           --enable-shared"

unpack() {
  mkdir -p $PKG_BUILD
  tar --strip-components=1 -xf $SOURCES/${PKG_NAME:7}/${PKG_NAME:7}-$PKG_VERSION.tar.bz2 -C $PKG_BUILD
}

makeinstall_target() {
  :
}
