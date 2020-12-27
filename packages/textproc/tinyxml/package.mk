# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)

PKG_NAME="tinyxml"
PKG_VERSION="2.6.2"
PKG_SHA256="15bdfdcec58a7da30adc87ac2b078e4417dbe5392f3afb719f9ba6d062645593"
PKG_LICENSE="OSS"
PKG_SITE="http://www.grinninglizard.com/tinyxml/"
PKG_URL="https://downloads.sourceforge.net/tinyxml/tinyxml_${PKG_VERSION//./_}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="TinyXML is a simple, small, C++ XML parser."
PKG_TOOLCHAIN="autotools"
PKG_BUILD_FLAGS="+pic"

PKG_CONFIGURE_OPTS_TARGET="--enable-static --disable-shared --with-pic"

post_makeinstall_target() {
  rm -rf $INSTALL/usr
}
