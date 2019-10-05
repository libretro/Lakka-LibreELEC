# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="glu"
PKG_VERSION="9.0.1"
PKG_SHA256="f98dff2045e0c557da88553bf4cf9958f49cd5bd40d33d2f8b5e13c8f904d126"
PKG_LICENSE="OSS"
PKG_SITE="http://cgit.freedesktop.org/mesa/glu/"
PKG_URL="http://cgit.freedesktop.org/mesa/glu/snapshot/${PKG_NAME}-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain mesa"
PKG_NEED_UNPACK="$(get_pkg_directory mesa)"
PKG_LONGDESC="libglu is the The OpenGL utility library"
PKG_TOOLCHAIN="autotools"

PKG_CONFIGURE_OPTS_TARGET="--disable-silent-rules \
                           --disable-debug \
                           --disable-osmesa \
                           --with-gnu-ld"
