# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libXrender"
PKG_VERSION="0.9.10"
PKG_SHA256="c06d5979f86e64cabbde57c223938db0b939dff49fdb5a793a1d3d0396650949"
PKG_ARCH="any"
PKG_LICENSE="OSS"
PKG_SITE="http://www.X.org"
PKG_URL="http://xorg.freedesktop.org/archive/individual/lib/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_TARGET="toolchain util-macros libX11"
PKG_SECTION="x11/lib"
PKG_SHORTDESC="libxrender: X Rendering Extension client library"
PKG_LONGDESC="The X Rendering Extension (Render) introduces digital image composition as the foundation of a new rendering model within the X Window System. Rendering geometric figures is accomplished by client-side tesselation into either triangles or trapezoids."
PKG_BUILD_FLAGS="+pic"

PKG_CONFIGURE_OPTS_TARGET="--enable-static --disable-shared --enable-malloc0returnsnull"
