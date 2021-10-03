# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="audiodecoder.sidplay"
PKG_VERSION="20.0.0-Nexus"
PKG_SHA256="89c41d4ac5b5ef7eceb1c17eeadbce6a6fd14c27cfb91a53653f89eee041bf0d"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/xbmc/audiodecoder.sidplay"
PKG_URL="https://github.com/xbmc/audiodecoder.sidplay/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform sidplay-libs"
PKG_SECTION=""
PKG_SHORTDESC="audiodecoder.sidplay"
PKG_LONGDESC="audiodecoder.sidplay"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="kodi.audiodecoder"

PKG_CMAKE_OPTS_TARGET="-DSIDPLAY2_LIBRARIES=${SYSROOT_PREFIX}/usr/lib"
