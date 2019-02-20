# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Lukas Rusak (lrusak@libreelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="screensaver.asterwave"
PKG_VERSION="6acee9c199049854bf511043c88da821e2b19459"
PKG_SHA256="554f348a7f120cf218e8f8922afd04f2e0814b1742e2bd27e2e9aadad238aebb"
PKG_REV="0"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/notspiff/screensaver.asterwave"
PKG_URL="https://github.com/notspiff/screensaver.asterwave/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform soil"
PKG_SECTION=""
PKG_SHORTDESC="screensaver.asterwave"
PKG_LONGDESC="screensaver.asterwave"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="xbmc.ui.screensaver"

if [ "$OPENGL" = "no" ] ; then
  exit 0
fi
