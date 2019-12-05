# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2017 Shane Meagher (shanemeagher)
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="librespot"
PKG_VERSION="0.1.0"
PKG_SHA256="4e03c69d1893ed14414d5a76ecdb5ea139ddfcce47fd57cc4e77b696001badb7"
PKG_REV="118"
PKG_ARCH="any"
PKG_LICENSE="MIT"
PKG_SITE="https://github.com/librespot-org/librespot/"
PKG_URL="https://github.com/librespot-org/librespot/archive/v$PKG_VERSION.zip"
PKG_DEPENDS_TARGET="toolchain pulseaudio rust"
PKG_SECTION="service"
PKG_SHORTDESC="Librespot: play Spotify through Kodi using a Spotify app as a remote"
PKG_LONGDESC="Librespot ($PKG_VERSION_DATE) lets you play Spotify through Kodi using a Spotify app as a remote."
PKG_TOOLCHAIN="manual"

PKG_IS_ADDON="yes"
PKG_ADDON_NAME="Librespot"
PKG_ADDON_TYPE="xbmc.service"
PKG_MAINTAINER="Anton Voyl (awiouy)"

make_target() {
  cd src
  . "$(get_build_dir rust)/cargo/env"
  $CARGO_BUILD --no-default-features --features "pulseaudio-backend with-dns-sd"
  "$STRIP" $PKG_BUILD/.$TARGET_NAME/*/release/librespot
}

addon() {
  mkdir -p "$ADDON_BUILD/$PKG_ADDON_ID/bin"
    cp $PKG_BUILD/.$TARGET_NAME/*/release/librespot \
       "$ADDON_BUILD/$PKG_ADDON_ID/bin"

  mkdir -p "$ADDON_BUILD/$PKG_ADDON_ID/lib"
    cp "$(get_build_dir avahi)/avahi-compat-libdns_sd/.libs/libdns_sd.so.1" \
       "$ADDON_BUILD/$PKG_ADDON_ID/lib"
}
