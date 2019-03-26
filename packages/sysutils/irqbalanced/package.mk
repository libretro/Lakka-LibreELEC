# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="irqbalanced"
PKG_VERSION="7f31046"
PKG_SHA256="e9f533bc2186fcef8456b78fb404ac981836d19f4b6ff10fede830b1df421717"
PKG_ARCH="arm"
PKG_LICENSE="other"
PKG_SITE="http://www.freescale.com"
PKG_URL="https://github.com/dv1/irqbalanced/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain systemd glib"
PKG_LONGDESC="irqbalanced: distribute hardware interrupts across processors on a multiprocessor system."
PKG_TOOLCHAIN="configure"

pre_configure_target() {
  sh -c ./autogen.sh
}

post_install() {
  enable_service irqbalance.service
}
