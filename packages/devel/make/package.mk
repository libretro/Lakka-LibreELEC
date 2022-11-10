# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="make"
PKG_VERSION="4.4"
PKG_SHA256="581f4d4e872da74b3941c874215898a7d35802f03732bdccee1d4a7979105d18"
PKG_LICENSE="GPLv3"
PKG_SITE="https://www.gnu.org/software/make/"
PKG_URL="http://ftpmirror.gnu.org/make/${PKG_NAME}-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_HOST=""
PKG_LONGDESC="Utility to maintain groups of programs."

pre_configure_host() {
  export CC=${LOCAL_CC}
}

post_makeinstall_host() {
  ln -sf make ${TOOLCHAIN}/bin/gmake
}
