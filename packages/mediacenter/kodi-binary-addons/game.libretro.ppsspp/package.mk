# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="game.libretro.ppsspp"
PKG_VERSION="0.0.1.2-Leia"
PKG_SHA256="27bfeda9a91b1eef60552c5b7055b2fa246b3d5b0d09a9986ab69e858d10c69a"
PKG_REV="1"
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
