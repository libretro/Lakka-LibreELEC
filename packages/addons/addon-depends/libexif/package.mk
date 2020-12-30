# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2014 Stephan Raue (stephan@openelec.tv)

PKG_NAME="libexif"
PKG_VERSION="0.6.22"
PKG_SHA256="5048f1c8fc509cc636c2f97f4b40c293338b6041a5652082d5ee2cf54b530c56"
PKG_LICENSE="LGPL"
PKG_SITE="https://libexif.github.io"
PKG_URL="https://github.com/libexif/libexif/releases/download/libexif-${PKG_VERSION//./_}-release/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="A library to parse an EXIF file and read the data from those tags."
