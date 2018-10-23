# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)

PKG_NAME="libftdi1"
PKG_VERSION="1.3"
PKG_SHA256="9a8c95c94bfbcf36584a0a58a6e2003d9b133213d9202b76aec76302ffaa81f4"
PKG_LICENSE="LGPL"
PKG_SITE="http://www.intra2net.com/en/developer/libftdi/"
PKG_URL="http://www.intra2net.com/en/developer/libftdi/download/${PKG_NAME}-${PKG_VERSION}.tar.bz2"
PKG_DEPENDS_TARGET="toolchain libusb"
PKG_LONGDESC="libFTDI is an open source library to talk to FTDI chips"
PKG_BUILD_FLAGS="+pic"

PKG_CMAKE_OPTS_TARGET="-DSTATICLIBS=ON \
                       -DDOCUMENTATION=FALSE \
                       -DEXAMPLES=FALSE \
                       -DFTDIPP=FALSE \
                       -DPYTHON_BINDINGS=FALSE"

makeinstall_target() {
  mkdir -p $SYSROOT_PREFIX/usr/include/libftdi1
    cp ../src/ftdi.h $SYSROOT_PREFIX/usr/include/libftdi1

  mkdir -p $SYSROOT_PREFIX/usr/lib
    cp src/libftdi1.a $SYSROOT_PREFIX/usr/lib

  mkdir -p $SYSROOT_PREFIX/usr/lib/pkgconfig
    cp libftdi1.pc $SYSROOT_PREFIX/usr/lib/pkgconfig
}
