# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2014 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="faad2"
PKG_VERSION="2.10.0"
PKG_SHA256="0c6d9636c96f95c7d736f097d418829ced8ec6dbd899cc6cc82b728480a84bfb"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/knik0/faad2/"
PKG_URL="https://github.com/knik0/faad2/archive/${PKG_VERSION//./_}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="An MPEG-4 AAC decoder."
PKG_TOOLCHAIN="configure"

PKG_CONFIGURE_OPTS_TARGET="--enable-static \
                           --disable-shared \
                           --without-drm \
                           --with-gnu-ld \
                           --without-mpeg4ip \
                           --without-xmms"
pre_configure_target() {
  ./bootstrap
}

post_makeinstall_target() {
  rm -rf $INSTALL/usr/bin
}
