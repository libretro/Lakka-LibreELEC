# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="weston"
PKG_VERSION="6.0.0"
PKG_SHA256="546323a90607b3bd7f48809ea9d76e64cd09718102f2deca6d95aa59a882e612"
PKG_LICENSE="OSS"
PKG_SITE="https://wayland.freedesktop.org/"
PKG_URL="https://wayland.freedesktop.org/releases/${PKG_NAME}-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain wayland-protocols libdrm libxkbcommon libinput cairo libjpeg-turbo dbus"
PKG_LONGDESC="Reference implementation of a Wayland compositor"

PKG_MESON_OPTS_TARGET="-Dbackend-drm-screencast-vaapi=false \
                       -Dbackend-headless=false \
                       -Dbackend-rdp=false \
                       -Dscreenshare=false \
                       -Dbackend-x11=false \
                       -Dbackend-fbdev=false \
                       -Dweston-launch=false \
                       -Dxwayland=false \
                       -Dremoting=false \
                       -Dshell-fullscreen=false \
                       -Dshell-ivi=false \
                       -Dcolor-management-lcms=false \
                       -Dcolor-management-colord=false \
                       -Dimage-webp=false \
                       -Dsimple-dmabuf-drm=intel \
                       -Ddemo-clients=false \
                       -Dsimple-clients=egl \
                       -Dresize-pool=false \
                       -Dwcap-decode=false \
                       -Dtest-junit-xml=false"

post_makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/weston
    cp ${PKG_DIR}/scripts/weston-config ${INSTALL}/usr/lib/weston

  mkdir -p ${INSTALL}/usr/share/weston
    cp ${PKG_DIR}/config/weston.ini ${INSTALL}/usr/share/weston

  safe_remove ${INSTALL}/usr/share/wayland-sessions
  safe_remove ${INSTALL}/usr/bin/weston-calibrator 
  safe_remove ${INSTALL}/usr/bin/weston-simple-*
  safe_remove ${INSTALL}/usr/bin/weston-touch-calibrator
}

post_install() {
  enable_service weston.service
}
