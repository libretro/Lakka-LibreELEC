# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="game.libretro.melonds"
PKG_VERSION="0.8.3.7-Leia"
PKG_SHA256="9902693442b77e3ec9fc86b3d0a4a66f0b3e69f5fe65441e5848b7a26c387cb6"
PKG_REV="1"
# no openGL suport in retroplayer yet
PKG_ARCH="none"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/kodi-game/game.libretro.melonds"
PKG_URL="https://github.com/kodi-game/game.libretro.melonds/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform libretro-melonds"
PKG_SECTION=""
PKG_LONGDESC="game.libretro.melonds: melonDS emulator for Kodi"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="kodi.gameclient"
