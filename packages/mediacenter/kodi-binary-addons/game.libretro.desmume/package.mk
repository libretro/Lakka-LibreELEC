# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="game.libretro.desmume"
PKG_VERSION="0.0.1.2-Leia"
PKG_SHA256="0e4a482699e0fdcfde9e45f33bba686d3e8372c28ad351df701fd67a35147307"
PKG_REV="111"
# no openGL suport in retroplayer yet
PKG_ARCH="none"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/kodi-game/game.libretro.desmume"
PKG_URL="https://github.com/kodi-game/game.libretro.desmume/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform libretro-desmume"
PKG_SECTION=""
PKG_LONGDESC="game.libretro.desmume: DESMuME GameClient for Kodi"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="kodi.gameclient"
