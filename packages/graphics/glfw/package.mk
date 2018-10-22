# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)

PKG_NAME="glfw"
PKG_VERSION="2.7.9"
PKG_SHA256="b7276dcadc85a07077834d1043f11ffd6a3a379647bb94361b4abc3ffca75e7d"
PKG_ARCH="x86_64"
PKG_LICENSE="BSD"
PKG_SITE="http://glfw.org"
PKG_URL="$SOURCEFORGE_SRC/glfw/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain mesa glu"
PKG_LONGDESC="provides a simple API for creating windows, contexts and surfaces, receiving input and events"

if [ "$OPENGL" = "no" ] ; then
  exit 0
fi

make_target() {
  make x11 PREFIX=$SYSROOT_PREFIX/usr
}

makeinstall_target() {
  make x11-install PREFIX=$SYSROOT_PREFIX/usr
}
