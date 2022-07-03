# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libdvdread"
PKG_VERSION="6.1.3-Next-Nexus-Alpha2"
PKG_SHA256="1f7b3c377c86abdd566be64de0b9c8145980c0b249c07b341bb6093233e72148"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/xbmc/libdvdread"
PKG_URL="https://github.com/xbmc/libdvdread/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="libdvdread is a library which provides a simple foundation for reading DVDs."
PKG_TOOLCHAIN="manual"

if [ "${KODI_DVDCSS_SUPPORT}" = yes ]; then
  PKG_DEPENDS_TARGET+=" libdvdcss"
fi
