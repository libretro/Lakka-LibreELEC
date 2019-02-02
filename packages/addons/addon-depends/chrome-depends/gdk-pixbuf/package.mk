# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2012 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="gdk-pixbuf"
PKG_VERSION="2.38.0"
PKG_SHA256="dd50973c7757bcde15de6bcd3a6d462a445efd552604ae6435a0532fbbadae47"
PKG_LICENSE="OSS"
PKG_SITE="http://www.gtk.org/"
PKG_URL="https://ftp.gnome.org/pub/gnome/sources/gdk-pixbuf/${PKG_VERSION:0:4}/gdk-pixbuf-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain glib libjpeg-turbo libpng jasper shared-mime-info tiff"
PKG_LONGDESC="GdkPixbuf is a a GNOME library for image loading and manipulation."

PKG_MESON_OPTS_TARGET="-Ddocs=false \
                       -Dgir=false \
                       -Dman=false \
                       -Drelocatable=false"
pre_configure_target() {
  export PKG_CONFIG_PATH="$(get_build_dir shared-mime-info)/.$TARGET_NAME"
}
