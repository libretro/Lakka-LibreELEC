# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2012 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="pango"
PKG_VERSION="1.43.0"
PKG_SHA256="d2c0c253a5328a0eccb00cdd66ce2c8713fabd2c9836000b6e22a8b06ba3ddd2"
PKG_LICENSE="GPL"
PKG_SITE="http://www.pango.org/"
PKG_URL="https://ftp.gnome.org/pub/gnome/sources/pango/${PKG_VERSION:0:4}/pango-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain cairo freetype fontconfig fribidi glib harfbuzz libX11 libXft"
PKG_LONGDESC="The Pango library for layout and rendering of internationalized text."
PKG_TOOLCHAIN="meson"

PKG_MESON_OPTS_TARGET="-Denable_docs=false \
                       -Dgir=false"

pre_configure_target() {
  export PKG_CONFIG_PATH="$(get_build_dir cairo)/.$TARGET_NAME/src":"$(get_build_dir libXft)/.$TARGET_NAME/src"
}

makeinstall_target() {
  :
}
