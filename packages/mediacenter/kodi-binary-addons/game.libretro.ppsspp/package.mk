# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="game.libretro.ppsspp"
PKG_VERSION="d24a963"
PKG_SHA256="2634b9c6f47bd32afcc2beb3f53b03b3ca3fb8d1391b502396ff24862aafca27"
PKG_REV="106"
# no openGL suport in retroplayer yet
PKG_ARCH="none"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/kodi-game/game.libretro.ppsspp"
PKG_URL="https://github.com/kodi-game/game.libretro.ppsspp/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform libretro-ppsspp"
PKG_SECTION=""
PKG_LONGDESC="game.libretro.ppsspp: ppsspp for Kodi"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="kodi.gameclient"
