# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libXv"
PKG_VERSION="1.0.11"
PKG_SHA256="c4112532889b210e21cf05f46f0f2f8354ff7e1b58061e12d7a76c95c0d47bb1"
PKG_LICENSE="OSS"
PKG_SITE="http://www.x.org/"
PKG_URL="https://xorg.freedesktop.org/releases/individual/lib/${PKG_NAME}-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain util-macros libX11 libXfixes libXext"
PKG_LONGDESC="LibXv provides an X video extension to the X protocol."
PKG_BUILD_FLAGS="+pic"
PKG_TOOLCHAIN="autotools"

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


if [ "${PROJECT}" = "L4T" -o "${DEVICE}" = "Odin" ]; then
  PKG_CONFIGURE_OPTS_TARGET="${PKG_CONFIGURE_OPTS_TARGET/--disable-shared/--enable-shared}"
fi
