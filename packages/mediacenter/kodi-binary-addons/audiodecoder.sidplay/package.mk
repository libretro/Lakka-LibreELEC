# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="audiodecoder.sidplay"
PKG_VERSION="1.2.2-Leia"
PKG_SHA256="271e513a3094b163f986eb5bb5cbc70c7a602f5764cef255cc161cc5094e5648"
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
