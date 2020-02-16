# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libheif"
PKG_VERSION="1.6.2"
PKG_SHA256="bb229e855621deb374f61bee95c4642f60c2a2496bded35df3d3c42cc6d8eefc"
PKG_LICENSE="LGPLv3"
PKG_SITE="http://www.libde265.org"
PKG_URL="https://github.com/strukturag/libheif/releases/download/v$PKG_VERSION/libheif-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain libde265 libjpeg-turbo libpng"
PKG_LONGDESC="A HEIF file format decoder and encoder."
PKG_BUILD_FLAGS="+pic"
PKG_TOOLCHAIN="configure"

PKG_CONFIGURE_OPTS_TARGET="--enable-static \
                           --disable-shared \
                           --disable-go \
                           --disable-examples \
                           --disable-tests"
