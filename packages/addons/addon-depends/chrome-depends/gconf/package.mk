# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="gconf"
PKG_VERSION="3.2.6"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://projects-old.gnome.org/gconf/"
PKG_URL="https://download.gnome.org/sources/GConf/3.2/GConf-$PKG_VERSION.tar.xz"
PKG_SOURCE_DIR="GConf-$PKG_VERSION"
PKG_DEPENDS_TARGET="toolchain zlib glib dbus-glib glfw"
PKG_LONGDESC="GConf is a system for storing application preferences."

PKG_CONFIGURE_OPTS_TARGET="--disable-shared \
                           --enable-static \
                           --disable-gtk-doc \
                           --disable-orbit"
