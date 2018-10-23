# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)

PKG_NAME="libshairplay"
PKG_VERSION="ce80e00"
PKG_SHA256="49ac0e0470ec6367f720c7b79a09165138f57b60f5949a2d9c38be5823d13294"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/juhovh/shairplay"
PKG_URL="https://github.com/juhovh/shairplay/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Emulates an AirPort Express to streaming music from iTunes and compatible iPods."
PKG_TOOLCHAIN="autotools"

post_makeinstall_target() {
  mkdir -p $INSTALL/etc/shairplay
    cp -P ../airport.key $INSTALL/etc/shairplay
}
