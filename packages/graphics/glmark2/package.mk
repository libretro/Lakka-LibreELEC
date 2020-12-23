# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="glmark2"
PKG_VERSION="784aca755a469b144acf3cae180b6e613b7b057a"
PKG_SHA256="787dd7de05c795c7c42694e648b5c6418e4b395fc460ea349d1d35d493469356"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/glmark2/glmark2"
PKG_URL="https://github.com/glmark2/glmark2/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="glmark2 is an OpenGL 2.0 and ES 2.0 benchmark"

if [ "$OPENGLES_SUPPORT" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" $OPENGLES"
  PKG_MESON_OPTS_TARGET="-Dflavors=drm-glesv2"
elif [ "$OPENGL_SUPPORT" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" $OPENGL"
  PKG_MESON_OPTS_TARGET="-Dflavors=drm-gl"
fi
