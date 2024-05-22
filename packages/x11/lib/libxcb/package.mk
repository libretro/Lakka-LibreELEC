# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libxcb"
PKG_VERSION="1.17.0"
PKG_SHA256="599ebf9996710fea71622e6e184f3a8ad5b43d0e5fa8c4e407123c88a59a6d55"
PKG_LICENSE="OSS"
PKG_SITE="https://xcb.freedesktop.org"
PKG_URL="https://xorg.freedesktop.org/archive/individual/lib/${PKG_NAME}-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain util-macros Python3:host xcb-proto libpthread-stubs libXau"
PKG_LONGDESC="X C-language Bindings library."
PKG_BUILD_FLAGS="+pic"

PKG_CONFIGURE_OPTS_TARGET="--disable-screensaver \
                           --disable-xprint \
                           --disable-selinux \
                           --disable-xvmc"

if [ "${PROJECT}" = "L4T" -o "${DEVICE}" = "Odin" ]; then
  PKG_CONFIGURE_OPTS_TARGET="${PKG_CONFIGURE_OPTS_TARGET/--disable-shared/--enable-shared}"
fi

pre_configure_target() {
  PYTHON_LIBDIR=${SYSROOT_PREFIX}/usr/lib/${PKG_PYTHON_VERSION}
  PYTHON_TOOLCHAIN_PATH=${PYTHON_LIBDIR}/site-packages

  PKG_CONFIG+=" --define-variable=pythondir=${PYTHON_TOOLCHAIN_PATH}"
  PKG_CONFIG+=" --define-variable=xcbincludedir=${SYSROOT_PREFIX}/usr/share/xcb"
}
