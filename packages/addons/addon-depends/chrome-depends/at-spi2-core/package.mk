# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2017 Escalade
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="at-spi2-core"
PKG_VERSION="2.36.0"
PKG_SHA256="88da57de0a7e3c60bc341a974a80fdba091612db3547c410d6deab039ca5c05a"
PKG_LICENSE="OSS"
PKG_SITE="http://www.gnome.org/"
PKG_URL="https://ftp.gnome.org/pub/gnome/sources/at-spi2-core/${PKG_VERSION:0:4}/at-spi2-core-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain atk dbus glib libXtst"
PKG_LONGDESC="Protocol definitions and daemon for D-Bus at-spi."

PKG_MESON_OPTS_TARGET="-Denable_docs=false \
                       -Denable-introspection=no \
                       -Ddbus_daemon=/usr/bin/dbus-daemon"

pre_configure_target() {
  TARGET_LDFLAGS="$LDFLAGS -lXext"
}
