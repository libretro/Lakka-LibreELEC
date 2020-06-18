# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2017 Shane Meagher (shanemeagher)
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="librespot"
PKG_VERSION="66f8a98ad2f5bf35be4daecd788dad6f0d87fb7c"
PKG_SHA256="b027c983341aa53d940412d5624cfe91392958ea9836ba597289680a4430b253"
PKG_VERSION_DATE="2020-02-27"
PKG_REV="123"
PKG_ARCH="any"
PKG_LICENSE="MIT"
PKG_SITE="https://github.com/librespot-org/librespot/"
PKG_URL="https://github.com/librespot-org/librespot/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain alsa-lib libvorbis pulseaudio rust"
PKG_SECTION="service"
PKG_SHORTDESC="Librespot: play Spotify through Kodi using a Spotify app as a remote"
PKG_LONGDESC="Librespot ($PKG_VERSION_DATE) lets you play Spotify through Kodi using a Spotify app as a remote."
PKG_TOOLCHAIN="manual"

PKG_IS_ADDON="yes"
PKG_ADDON_NAME="Librespot"
PKG_ADDON_TYPE="xbmc.service"
PKG_ADDON_REQUIRES="script.module.requests:0.0.0"
PKG_MAINTAINER="Anton Voyl (awiouy)"

make_target() {
  . $(get_build_dir rust)/cargo/env
  cargo build \
    --release \
    --no-default-features \
    --features "alsa-backend pulseaudio-backend with-vorbis"
  $STRIP $PKG_BUILD/.$TARGET_NAME/*/release/librespot
}

addon() {
  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/bin
    cp $PKG_BUILD/.$TARGET_NAME/*/release/librespot \
       $ADDON_BUILD/$PKG_ADDON_ID/bin
}
