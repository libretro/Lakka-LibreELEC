# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="glmark2"
PKG_VERSION="2021.12"
PKG_SHA256="9f111284b2ef1d3fce91928e249e6ca00796a036831b063a549a0f3b03557a95"
PKG_LICENSE="GPL-3.0-or-later"
PKG_SITE="https://github.com/glmark2/glmark2"
PKG_URL="https://github.com/glmark2/glmark2/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain libjpeg-turbo libpng"
PKG_LONGDESC="glmark2 is an OpenGL 2.0 and ES 2.0 benchmark"

if [ "${OPENGL_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGL}"
elif [ "${OPENGLES_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGLES}"
fi

case ${DISPLAYSERVER} in
  wl)
    PKG_DEPENDS_TARGET+=" wayland wayland-protocols"
    PKG_MESON_OPTS_TARGET="-Dflavors=wayland-glesv2"
    ;;
  x11)
    PKG_DEPENDS_TARGET+=" libX11"
    PKG_MESON_OPTS_TARGET="-Dflavors=x11-gl"
    ;;
  *)
    PKG_DEPENDS_TARGET+=" systemd libdrm"
    PKG_MESON_OPTS_TARGET="-Dflavors=drm-glesv2"
    ;;
esac
