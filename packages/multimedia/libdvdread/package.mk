# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libdvdread"
PKG_VERSION="6.0.0-Leia-Alpha-3"
PKG_SHA256="a30b6aa0aad0f2c505bc77948af2d5531a80b6e68112addb4c123fca24d5d3bf"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/xbmc/libdvdread"
PKG_URL="https://github.com/xbmc/libdvdread/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="libdvdread is a library which provides a simple foundation for reading DVDs."
PKG_TOOLCHAIN="manual"

if [ "${KODI_DVDCSS_SUPPORT}" = yes ]; then
  PKG_DEPENDS_TARGET+=" libdvdcss"
fi
