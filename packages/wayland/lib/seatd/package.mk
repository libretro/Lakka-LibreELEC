# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2021-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="seatd"
PKG_VERSION="0.6.3"
PKG_SHA256="5226850c163b485aebe71da0d3f4941761637e146a5c9393cb40c52617ad84a8"
PKG_LICENSE="MIT"
PKG_SITE="https://git.sr.ht/~kennylevinsen/seatd"
PKG_URL="https://git.sr.ht/~kennylevinsen/seatd/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain systemd"
PKG_LONGDESC="A minimal seat management daemon, and a universal seat management library."

PKG_MESON_OPTS_TARGET="-Dlibseat-logind=systemd \
                       -Dlibseat-seatd=enabled \
                       -Dlibseat-builtin=disabled \
                       -Dserver=enabled \
                       -Dexamples=disabled \
                       -Dman-pages=disabled"

pre_configure_target() {
  # seatd does not build without -Wno flags as all warnings being treated as errors
  export TARGET_CFLAGS=$(echo "${TARGET_CFLAGS} -Wno-unused-parameter")
}

post_install() {
  enable_service seatd.service
}
