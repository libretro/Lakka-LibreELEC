# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libXi"
PKG_VERSION="1.7.10"
PKG_SHA256="36a30d8f6383a72e7ce060298b4b181fd298bc3a135c8e201b7ca847f5f81061"
PKG_LICENSE="OSS"
PKG_SITE="http://www.x.org/"
PKG_URL="http://xorg.freedesktop.org/archive/individual/lib/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_TARGET="toolchain util-macros libX11 libXfixes libXext"
PKG_LONGDESC="LibXi provides an X Window System client interface to the XINPUT extension to the X protocol."
PKG_BUILD_FLAGS="+pic"

PKG_CONFIGURE_OPTS_TARGET="--enable-static --disable-shared \
                           --enable-malloc0returnsnull \
                           --disable-silent-rules \
                           --disable-docs \
                           --disable-specs \
                           --without-xmlto \
                           --without-fop \
                           --without-xsltproc \
                           --without-asciidoc \
                           --with-gnu-ld"
