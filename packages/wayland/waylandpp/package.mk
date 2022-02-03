# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="waylandpp"
PKG_VERSION="0.2.9"
PKG_SHA256="9d34acd88149897d587b979fc454fd8e5be8021ba3d09ad24c77a4b7acff2ebd"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/NilsBrause/waylandpp"
PKG_URL="https://github.com/NilsBrause/waylandpp/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_HOST="toolchain:host pugixml:host"
PKG_DEPENDS_TARGET="toolchain pugixml:host waylandpp:host wayland"
PKG_LONGDESC="Wayland C++ bindings"

configure_package() {
  if [ "${OPENGL_SUPPORT}" = "yes" ]; then
    PKG_DEPENDS_TARGET+=" ${OPENGL}"
  elif [ "${OPENGLES_SUPPORT}" = "yes" ]; then
    PKG_DEPENDS_TARGET+=" ${OPENGLES}"
  fi
}

PKG_CMAKE_OPTS_HOST="-DBUILD_SCANNER=ON \
                     -DBUILD_LIBRARIES=OFF"

PKG_CMAKE_OPTS_TARGET="-DBUILD_SCANNER=OFF \
                       -DBUILD_LIBRARIES=ON \
                       -DCMAKE_CROSSCOMPILING=ON \
                       -DWAYLAND_SCANNERPP=${TOOLCHAIN}/bin/wayland-scanner++"
