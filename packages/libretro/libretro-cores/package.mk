# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 208-present Team LibreELEC (https://libreelec.tv)
# Copyright (C) 2020 Team Lakka

PKG_NAME="libretro-cores"
PKG_VERSION=""
PKG_ARCH="any"
PKG_SECTION="libretro"
PKG_SHORTDESC="libretro cores metapackage"
PKG_SITE="https://www.libretro.com/"
PKG_STAMP="$DISABLE_LIBRETRO"

PKG_TOOLCHAIN="manual"

# $LIBRETRO_CORES defined in distribution options
if [ "$DISABLE_LIBRETRO" != "yes" ]; then
  PKG_DEPENDS_TARGET="$LIBRETRO_CORES"
fi

