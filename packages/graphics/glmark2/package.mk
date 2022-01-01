# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="glmark2"
PKG_VERSION="2021.12"
PKG_SHA256="9f111284b2ef1d3fce91928e249e6ca00796a036831b063a549a0f3b03557a95"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/glmark2/glmark2"
PKG_URL="https://github.com/glmark2/glmark2/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="glmark2 is an OpenGL 2.0 and ES 2.0 benchmark"

if [ "${OPENGLES_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGLES}"
  PKG_MESON_OPTS_TARGET="-Dflavors=drm-glesv2"
elif [ "${OPENGL_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGL}"
  PKG_MESON_OPTS_TARGET="-Dflavors=drm-gl"
fi

