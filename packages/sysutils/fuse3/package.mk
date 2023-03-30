# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2022-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="fuse3"
PKG_VERSION="3.14.1"
PKG_SHA256="126919d72b46b3e0eb58a9c6933a2a50c36f2ea69f61fe9e78bdba9f463ffa20"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/libfuse/libfuse/"
PKG_URL="https://github.com/libfuse/libfuse/releases/download/fuse-${PKG_VERSION}/fuse-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain systemd"
PKG_LONGDESC="FUSE is an interface for userspace programs to export a filesystem to the Linux kernel."

PKG_MESON_OPTS_TARGET="-Ddisable-mtab=false \
                       -Dutils=true \
                       -Dexamples=false \
                       -Duseroot=false \
                       -Dtests=false"

post_makeinstall_target() {
  rm -rf ${INSTALL}/etc
  rm -rf ${INSTALL}/usr/lib/udev
}
