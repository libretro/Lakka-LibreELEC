# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)

PKG_NAME="expat"
PKG_VERSION="2.2.5"
PKG_SHA256="b3781742738611eaa737543ee94264dd511c52a3ba7e53111f7d705f6bff65a8"
PKG_LICENSE="OSS"
PKG_SITE="http://expat.sourceforge.net/"
PKG_URL="https://github.com/libexpat/libexpat/archive/R_${PKG_VERSION//./_}.tar.gz"
PKG_SOURCE_DIR="libexpat-*/expat"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Expat is an XML parser library written in C."

PKG_CMAKE_OPTS_TARGET="-DBUILD_doc=OFF -DBUILD_tools=OFF -DBUILD_examples=OFF -DBUILD_tests=OFF -DBUILD_shared=ON"
PKG_CMAKE_OPTS_HOST="-DBUILD_doc=OFF -DBUILD_tools=OFF -DBUILD_examples=OFF -DBUILD_tests=OFF -DBUILD_shared=ON"

# cleanup
post_unpack() {
  rm -fr $BUILD/libexpat-R_${PKG_VERSION//./_}
}
