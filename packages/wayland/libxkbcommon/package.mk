# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libxkbcommon"
PKG_VERSION="1.3.1"
PKG_SHA256="b3c710d27a2630054e1e1399c85b7f330ef03359b460f0c1b3b587fd01fe9234"
PKG_LICENSE="MIT"
PKG_SITE="http://xkbcommon.org"
PKG_URL="http://xkbcommon.org/download/${PKG_NAME}-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain xkeyboard-config libxml2"
PKG_LONGDESC="xkbcommon is a library to handle keyboard descriptions."

PKG_MESON_OPTS_TARGET="-Denable-docs=false"
#if ! [ "${PROJECT}" = "L4T" ]; then
  if [ "${DISPLAYSERVER}" = "x11" ]; then
    PKG_MESON_OPTS_TARGET+=" -Denable-x11=true \
                             -Denable-wayland=false"
  elif [ "${DISPLAYSERVER}" = "wl" ]; then
    PKG_MESON_OPTS_TARGET+=" -Denable-x11=false \
                             -Denable-wayland=true"
  else
    PKG_MESON_OPTS_TARGET+=" -Denable-x11=false \
                             -Denable-wayland=false"
  fi
#fi

pre_configure_target() {
#  if ! [ "${PROJECT}" = "L4T" ]; then
    if [ "${DISPLAYSERVER}" = "x11" ]; then
      TARGET_LDFLAGS="${LDFLAGS} -lXau -lxcb"
    fi
#  fi
}
