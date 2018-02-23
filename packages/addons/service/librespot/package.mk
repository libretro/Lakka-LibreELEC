################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#      Copyright (C) 2017-present Team LibreELEC
#      Copyright (C) 2017 Shane Meagher (shanemeagher)
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

PKG_NAME="librespot"
PKG_VERSION="685fb4e"
PKG_SHA256="10ff0e5520e576e72b259f69d37e25ec3e520a4be13cbe9707c68614f24526fc"
PKG_REV="110"
PKG_ARCH="any"
PKG_LICENSE="MIT"
PKG_SITE="https://github.com/librespot-org/$PKG_NAME/"
PKG_URL="https://github.com/librespot-org/$PKG_NAME/archive/$PKG_VERSION.zip"
PKG_DEPENDS_TARGET="toolchain avahi pulseaudio pyalsaaudio rust"
PKG_SECTION="service"
PKG_SHORTDESC="Librespot: play Spotify through LibreELEC using a Spotify app as a remote"
PKG_LONGDESC="Librespot ($PKG_VERSION) plays Spotify through LibreELEC using the open source librespot library using a Spotify app as a remote."
PKG_TOOLCHAIN="manual"
PKG_BUILD_FLAGS="-lto"

PKG_IS_ADDON="yes"
PKG_ADDON_NAME="Librespot"
PKG_ADDON_TYPE="xbmc.service.library"
PKG_MAINTAINER="Anton Voyl (awiouy)"

configure_target() {
  . "$TOOLCHAIN/.cargo/env"
  export PKG_CONFIG_ALLOW_CROSS=0
}

make_target() {
  cd src
  $CARGO_BUILD --no-default-features --features "alsa-backend pulseaudio-backend with-dns-sd"
  cd "$PKG_BUILD/.$TARGET_NAME"/*/release
  $STRIP librespot
}

addon() {
  mkdir -p "$ADDON_BUILD/$PKG_ADDON_ID"
  cp "$(get_build_dir pyalsaaudio)/.install_pkg/usr/lib/$PKG_PYTHON_VERSION/site-packages/alsaaudio.so" \
     "$ADDON_BUILD/$PKG_ADDON_ID"

  mkdir -p "$ADDON_BUILD/$PKG_ADDON_ID/bin"
  cp "$PKG_BUILD/.$TARGET_NAME"/*/release/librespot  \
     "$ADDON_BUILD/$PKG_ADDON_ID/bin"

  mkdir -p "$ADDON_BUILD/$PKG_ADDON_ID/lib"
  cp "$(get_build_dir avahi)/avahi-compat-libdns_sd/.libs/libdns_sd.so.1" \
     "$ADDON_BUILD/$PKG_ADDON_ID/lib"
}
