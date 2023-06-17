# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2017 Shane Meagher (shanemeagher)
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="librespot"
PKG_VERSION="c964102a349589d644baef5f43a566d6d1e151f1"
PKG_VERSION_DATE="2023-05-14"
PKG_SHA256="3bc6782d8796253040d995043fba4e6f6c71ff902da110b50398071e082b1930"
PKG_REV="2"
PKG_ARCH="any"
PKG_LICENSE="MIT"
PKG_SITE="https://github.com/librespot-org/librespot/"
PKG_URL="https://github.com/librespot-org/librespot/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain alsa-lib avahi pulseaudio cargo:host"
PKG_SECTION="service"
PKG_SHORTDESC="Librespot: play Spotify through Kodi using a Spotify app as a remote"
PKG_LONGDESC="Librespot (${PKG_VERSION_DATE}) lets you play Spotify through Kodi using a Spotify app as a remote."
PKG_TOOLCHAIN="manual"

PKG_IS_ADDON="yes"
PKG_ADDON_NAME="Librespot"
PKG_ADDON_TYPE="xbmc.service"
PKG_MAINTAINER="Anton Voyl (awiouy)"

make_target() {
  export RUSTC_LINKER=${CC}
  cargo build \
    --target ${TARGET_NAME} \
    --release \
    --no-default-features \
    --features "alsa-backend pulseaudio-backend with-dns-sd"

  ${STRIP} ${PKG_BUILD}/.${TARGET_NAME}/target/${TARGET_NAME}/release/librespot
}

addon() {
  mkdir -p ${ADDON_BUILD}/${PKG_ADDON_ID}/bin
    cp ${PKG_BUILD}/.${TARGET_NAME}/target/${TARGET_NAME}/release/librespot \
       ${ADDON_BUILD}/${PKG_ADDON_ID}/bin

  mkdir -p ${ADDON_BUILD}/${PKG_ADDON_ID}/lib
    cp $(get_build_dir avahi)/avahi-compat-libdns_sd/.libs/libdns_sd.so.1 \
       ${ADDON_BUILD}/${PKG_ADDON_ID}/lib
}
