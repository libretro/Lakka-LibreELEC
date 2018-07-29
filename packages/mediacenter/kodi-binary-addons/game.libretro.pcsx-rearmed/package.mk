# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="game.libretro.pcsx-rearmed"
PKG_VERSION="5c4f796"
PKG_SHA256="d012a50421b27070112b2b57343f3297bd1b1a4935e6d1d7b9667bab6783a9d4"
PKG_REV="107"
# neon optimizations make it only useful for arm
PKG_ARCH="arm"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/kodi-game/game.libretro.pcsx-rearmed"
PKG_URL="https://github.com/kodi-game/game.libretro.pcsx-rearmed/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform libretro-pcsx-rearmed"
PKG_SECTION=""
PKG_LONGDESC="game.libretro.pcsx-rearmed: PCSX Rearmed for Kodi"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="kodi.gameclient"

if ! target_has_feature neon; then
  echo "${DEVICE:-${PROJECT}} doesn't support neon"
  exit 0
fi
