# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="screensaver.shadertoy"
PKG_VERSION="81b2758c8037ccc4e85f13b3a48e0622e9316c94"
PKG_SHA256="6d07eb8155a73786860b1d7e90b1c8b82bdd6e0cde970ce00a4d5ca5189b0e30"
PKG_REV="3"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/popcornmix/screensaver.shadertoy"
PKG_URL="https://github.com/popcornmix/screensaver.shadertoy/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform"
PKG_SECTION=""
PKG_SHORTDESC="screensaver.shadertoy"
PKG_LONGDESC="screensaver.shadertoy"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="xbmc.ui.screensaver"

if [ ! "$OPENGL" = "no" ]; then
# for OpenGL (GLX) support
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET $OPENGL glew"
fi

if [ "$OPENGLES_SUPPORT" = yes ]; then
# for OpenGL-ES support
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET $OPENGLES"
fi
