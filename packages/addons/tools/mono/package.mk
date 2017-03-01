################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#      Copyright (C) 2016 Team LibreELEC
#
#  LibreELEC is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 2 of the License, or
#  (at your option) any later version.
#
#  LibreELEC is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with LibreELEC.  If not, see <http://www.gnu.org/licenses/>.
################################################################################

PKG_NAME="mono"
PKG_VERSION="4.8.0.495"
PKG_REV="102"
PKG_ARCH="any"
PKG_LICENSE="MIT"
PKG_SITE="http://www.mono-project.com"
PKG_URL="http://download.mono-project.com/sources/mono/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_SOURCE_DIR="$PKG_NAME-${PKG_VERSION%.*}"
PKG_DEPENDS_TARGET="toolchain mono:host libgdiplus sqlite mono_sqlite zlib"
PKG_SECTION="tools"
PKG_SHORTDESC="Mono: a cross platform, open source .NET framework"
PKG_LONGDESC="Mono ($PKG_VERSION) is a software platform designed to allow developers to easily create cross platform applications part of the .NET Foundation"
PKG_AUTORECONF="yes"

PKG_IS_ADDON="yes"
PKG_ADDON_NAME="Mono"
PKG_ADDON_TYPE="xbmc.python.script"
PKG_MAINTAINER="Anton Voyl (awiouy)"

prefix="/storage/.kodi/addons/$PKG_SECTION.$PKG_NAME"
options="--build=$HOST_NAME \
         --prefix=$prefix \
         --bindir=$prefix/bin \
         --sbindir=$prefix/sbin \
         --sysconfdir=$prefix/etc \
         --libexecdir=$prefix/lib \
         --localstatedir=/var \
         --disable-boehm \
         --disable-libraries \
         --without-mcs-docs"

configure_host() {
  cp -PR ../* .
  ./configure $options --host=$HOST_NAME
}

makeinstall_host() {
  : # nop
}

configure_target() {
  cp -PR ../* .
  strip_lto
  ./configure $options --host=$TARGET_NAME \
                       --disable-mcs-build
}

makeinstall_target() {
  make -C "$ROOT/$PKG_BUILD/.$HOST_NAME" install DESTDIR="$INSTALL"
  make -C "$ROOT/$PKG_BUILD/.$TARGET_NAME" install DESTDIR="$INSTALL"
  $STRIP "$INSTALL/storage/.kodi/addons/$PKG_SECTION.$PKG_NAME/bin/mono"
}

addon() {
  mkdir -p "$ADDON_BUILD/$PKG_ADDON_ID"
  
  cp -PR "$PKG_BUILD/.install_pkg/storage/.kodi/addons/$PKG_SECTION.$PKG_NAME"/* \
         "$ADDON_BUILD/$PKG_ADDON_ID/"

  rm -fr "$ADDON_BUILD/$PKG_ADDON_ID/include" \
         "$ADDON_BUILD/$PKG_ADDON_ID/share/man"

  mv "$ADDON_BUILD/$PKG_ADDON_ID/bin/mono-sgen" \
     "$ADDON_BUILD/$PKG_ADDON_ID/bin/mono"

  cp -L "$(get_build_dir cairo)/.install_pkg/usr/lib/libcairo.so.2" \
        "$(get_build_dir libX11)/.install_pkg/usr/lib/libX11.so.6" \
        "$(get_build_dir libXext)/.install_pkg/usr/lib/libXext.so.6" \
        "$(get_build_dir libexif)/.install_pkg/usr/lib/libexif.so.12" \
        "$(get_build_dir libgdiplus)/.install_pkg/usr/lib/libgdiplus.so" \
        "$(get_build_dir mono_sqlite)/.install_pkg/usr/lib/libsqlite3.so.0" \
        "$(get_build_dir pixman)/.install_pkg/usr/lib/libpixman-1.so.0" \
        "$ADDON_BUILD/$PKG_ADDON_ID/lib"
}
