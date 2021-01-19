# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2020-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="xrandr"
PKG_VERSION="1.5.1"
PKG_SHA256="7bc76daf9d72f8aff885efad04ce06b90488a1a169d118dea8a2b661832e8762"
PKG_LICENSE="OSS"
PKG_SITE="http://www.X.org"
PKG_URL="http://xorg.freedesktop.org/archive/individual/app/${PKG_NAME}-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain util-macros libXrandr"
PKG_LONGDESC="Xrandr is a primitive command line interface to the RandR extension and used to set the screen size, orientation and/or reflection."

post_makeinstall_target() {
  rm -rf ${INSTALL}/usr/bin/xkeystone
}
