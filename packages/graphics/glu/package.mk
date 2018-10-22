# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)

PKG_NAME="glu"
PKG_VERSION="9.0.0"
PKG_SHA256="3d19cca9b26ec4048dd22e3d294acd43e080a3205a29ff47765bd514571ea8f9"
PKG_LICENSE="OSS"
PKG_SITE="http://cgit.freedesktop.org/mesa/glu/"
PKG_URL="http://cgit.freedesktop.org/mesa/glu/snapshot/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain mesa"
PKG_LONGDESC="libglu is the The OpenGL utility library"
PKG_TOOLCHAIN="autotools"

PKG_CONFIGURE_OPTS_TARGET="--disable-silent-rules \
            --disable-debug \
            --disable-osmesa \
            --with-gnu-ld"
