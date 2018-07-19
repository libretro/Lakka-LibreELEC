# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)

PKG_NAME="libprojectM"
PKG_VERSION="2.0.0"
PKG_SHA256="77ed43508ae2913261714b85364198f250af9e53d36d637320ddbcc2578148ee"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://projectm.sourceforge.net/"
PKG_URL="$DISTRO_SRC/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain ftgl freetype $OPENGL"
PKG_SECTION="multimedia"
PKG_SHORTDESC="a MilkDrop compatible opensource music visualizer"
PKG_LONGDESC="a MilkDrop compatible opensource music visualizer"

PKG_CMAKE_OPTS_TARGET="-DBUILD_PROJECTM_STATIC=1"
