# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="game.libretro.desmume"
PKG_VERSION="0.0.1.7-Leia"
PKG_SHA256="de9c02a94e23927a5394518d10965e6da06f4661ccdba54ac4982fe7ce843f73"
PKG_REV="1"
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
