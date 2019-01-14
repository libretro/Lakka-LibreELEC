# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="game.libretro.mupen64plus"
PKG_VERSION="ccb64c136f9c26f43694ffc610f97ae52b6daae6"
PKG_SHA256="aeab6ba90cbaac0b4bd2971f41e31a3b9cf1ada87ca176a6cdff342fd833b844"
PKG_REV="112"
# no openGL suport in retroplayer yet
PKG_ARCH="none"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/kodi-game/game.libretro.mupen64plus"
PKG_URL="https://github.com/kodi-game/game.libretro.mupen64plus/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform libretro-mupen64plus"
PKG_SECTION=""
PKG_LONGDESC="game.libretro.mupen64plus: Mupen 64 Plus emulator for Kodi"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="kodi.gameclient"
