# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="cairo"
PKG_VERSION="1.17.8"
PKG_SHA256="5b10c8892d1b58d70d3f0ba5b47863a061262fa56b9dc7944161f8c8b783bc64"
PKG_LICENSE="LGPL"
PKG_SITE="https://cairographics.org/"
PKG_URL="https://cairographics.org/snapshots/${PKG_NAME}-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain zlib freetype fontconfig glib libpng pixman"
PKG_LONGDESC="Cairo is a vector graphics library with cross-device output support."

configure_package() {
  if [ "${DISPLAYSERVER}" = "x11" ]; then
    PKG_DEPENDS_TARGET+=" libXrender libX11 mesa"
  fi
}

pre_configure_target() {
  PKG_MESON_OPTS_TARGET="-Ddwrite=disabled \
                         -Dfontconfig=enabled \
                         -Dfreetype=enabled \
                         -Dpng=enabled \
                         -Dquartz=disabled \
                         -Dtee=disabled \
                         -Dxcb=disabled \
                         -Dxlib-xcb=disabled \
                         -Dxml=disabled \
                         -Dzlib=enabled \
                         -Dtests=disabled \
                         -Dgtk2-utils=disabled \
                         -Dglib=enabled \
                         -Dspectre=disabled \
                         -Dsymbol-lookup=disabled \
                         -Dgtk_doc=false"

  if [ "${DISPLAYSERVER}" = "x11" ]; then
    PKG_MESON_OPTS_TARGET+=" -Dxlib=enabled"
  else
    PKG_MESON_OPTS_TARGET+=" -Dxlib=disabled"
  fi
}
