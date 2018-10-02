# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="game.libretro.desmume"
PKG_VERSION="8aedfec"
PKG_SHA256="684daac7d15c7ab96ab52a62ba9c55c316a8737ced7314c76ac317529d5dd428"
PKG_REV="106"
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
