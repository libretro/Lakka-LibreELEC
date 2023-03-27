# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2017 Shane Meagher (shanemeagher)
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="librespot"
PKG_VERSION="03b547d3b3b434811225ebc153c651e5f1917b95"
PKG_VERSION_DATE="2023-04-16"
PKG_SHA256="fd6ffed75f5d9a0941c4ca2a86192c17217b60d1d301e47ff0d8aeec3b3e0e97"
PKG_REV="1"
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
  unset CFLAGS
  unset CXXFLAGS
  unset CPPFLAGS
  unset LDFLAGS
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
