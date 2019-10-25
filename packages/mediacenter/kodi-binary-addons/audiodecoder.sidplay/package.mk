# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="audiodecoder.sidplay"
PKG_VERSION="2.1.0-Matrix"
PKG_SHA256="fa2183a21afe76c8500fb20291bbe9b7d62ea002a3c91ce685fcac86793cd8aa"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/xbmc/audiodecoder.sidplay"
PKG_URL="https://github.com/xbmc/audiodecoder.sidplay/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform sidplay-libs"
PKG_SECTION=""
PKG_SHORTDESC="audiodecoder.sidplay"
PKG_LONGDESC="audiodecoder.sidplay"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="kodi.audiodecoder"

PKG_CMAKE_OPTS_TARGET="-DSIDPLAY2_LIBRARIES=$SYSROOT_PREFIX/usr/lib"
