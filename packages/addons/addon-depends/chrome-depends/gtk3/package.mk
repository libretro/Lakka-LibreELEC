# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2017 Escalade
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="gtk3"
PKG_VERSION="3.24.4"
PKG_SHA256="d84f59ff02a87cc90c9df4a572a13eca4e3506e2bf511e2b9cbdb4526fa0cb9c"
PKG_LICENSE="LGPL"
PKG_SITE="http://www.gtk.org/"
PKG_URL="https://ftp.gnome.org/pub/gnome/sources/gtk+/${PKG_VERSION:0:4}/gtk+-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain at-spi2-atk atk cairo gdk-pixbuf glib libX11 libXi libXrandr libepoxy pango"
PKG_LONGDESC="A library for creating graphical user interfaces for the X Window System."

PKG_CONFIGURE_OPTS_TARGET="--disable-cups \
                           --disable-debug \
                           --enable-explicit-deps=no \
                           --disable-glibtest \
                           --disable-gtk-doc \
                           --disable-gtk-doc-html \
                           --disable-man \
                           --enable-modules \
                           --disable-papi \
                           --disable-xinerama \
                           --enable-xkb"

pre_configure_target() {
  LIBS="$LIBS -lXcursor"
  export PKG_CONFIG_PATH="$(get_build_dir pango)/.$TARGET_NAME/meson-private:$(get_build_dir gdk-pixbuf)/.$TARGET_NAME/meson-private:$(get_build_dir shared-mime-info)/.$TARGET_NAME"
  export CFLAGS="$CFLAGS -I$(get_build_dir pango) -I$(get_build_dir pango)/.$TARGET_NAME -L$(get_build_dir pango)/.$TARGET_NAME/pango"
  export GLIB_COMPILE_RESOURCES=glib-compile-resources GLIB_MKENUMS=glib-mkenums GLIB_GENMARSHAL=glib-genmarshal
}

makeinstall_target() {
  :
}
