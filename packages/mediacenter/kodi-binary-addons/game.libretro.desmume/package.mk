# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="game.libretro.desmume"
PKG_VERSION="a2e9101e18babc475df1a162a6664aa47a6fb5ad"
PKG_SHA256="1d8d73e39cac09021c3fb2f3222a9e8695f2ab8b5c0dae2027256022e7c969b8"
PKG_REV="108"
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
