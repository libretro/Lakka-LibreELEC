# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="game.libretro.snes9x2002"
PKG_VERSION="7.2.0.15-Matrix"
PKG_SHA256="5a5c714d39114e99e035047389e3c48ffe6d0b58087c4b3191c26227cae3363b"
PKG_REV="3"
# neon optimizations make it only useful for arm
PKG_ARCH="arm"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/kodi-game/game.libretro.snes9x2002"
PKG_URL="https://github.com/kodi-game/game.libretro.snes9x2002/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform libretro-snes9x2002"
PKG_SECTION=""
PKG_LONGDESC="game.libretro.snes9x2002: snes9x2002 for Kodi"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="kodi.gameclient"
