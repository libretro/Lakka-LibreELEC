# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Lukas Rusak (lrusak@libreelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="screensaver.cpblobs"
PKG_VERSION="8f9b8bcc54816b3ba6dc5aa24f11c35ffd128bf4"
PKG_SHA256="0cb103ddf4876c35e7f1a2e8ddf4871fa56b9d0d367f30324cd2f58b0b268959"
PKG_REV="0"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/notspiff/screensaver.cpblobs"
PKG_URL="https://github.com/notspiff/screensaver.cpblobs/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform soil"
PKG_SECTION=""
PKG_SHORTDESC="screensaver.cpblobs"
PKG_LONGDESC="screensaver.cpblobs"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="xbmc.ui.screensaver"

if [ "$OPENGL" = "no" ] ; then
  exit 0
fi
