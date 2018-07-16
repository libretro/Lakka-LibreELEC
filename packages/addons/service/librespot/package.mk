# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2017 Shane Meagher (shanemeagher)
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="librespot"
PKG_VERSION="431be9e"
PKG_SHA256="2e336c5415b6ee6f669e673282daccdd770b15d35dd6d71b39b17dc2aa3424c0"
PKG_REV="111"
PKG_ARCH="any"
PKG_LICENSE="MIT"
PKG_SITE="https://github.com/librespot-org/librespot/"
PKG_URL="https://github.com/librespot-org/librespot/archive/$PKG_VERSION.zip"
PKG_DEPENDS_TARGET="toolchain avahi pulseaudio pyalsaaudio rust"
PKG_SECTION="service"
PKG_SHORTDESC="Librespot: play Spotify through LibreELEC using a Spotify app as a remote"
PKG_LONGDESC="Librespot ($PKG_VERSION) plays Spotify through LibreELEC using the open source librespot library using a Spotify app as a remote."
PKG_TOOLCHAIN="manual"

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
