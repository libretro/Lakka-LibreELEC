# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2020-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="font-util"
PKG_VERSION="1.3.2"
PKG_SHA256="3ad880444123ac06a7238546fa38a2a6ad7f7e0cc3614de7e103863616522282"
PKG_LICENSE="OSS"
PKG_SITE="http://www.X.org"
PKG_URL="http://xorg.freedesktop.org/archive/individual/font/${PKG_NAME}-${PKG_VERSION}.tar.bz2"
PKG_DEPENDS_TARGET="toolchain util-macros"
PKG_DEPENDS_HOST="util-macros"
PKG_LONGDESC="X.org font utilities."

PKG_CONFIGURE_OPTS_TARGET="--with-fontrootdir=/usr/share/fonts \
                           --with-mapdir=/usr/share/fonts/util"

post_makeinstall_target() {
  rm -rf ${INSTALL}/usr/bin
}
