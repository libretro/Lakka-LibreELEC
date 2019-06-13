# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="sbc"
PKG_VERSION="1.4"
PKG_SHA256="050058cfc5a2709d324868ddbb82f9b796ba6c4f5e00cb6a715b3841ee13dfe9"
PKG_LICENSE="GPL"
PKG_SITE="http://www.bluez.org/"
PKG_URL="http://www.kernel.org/pub/linux/bluetooth/sbc-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="standalone SBC library"
PKG_BUILD_FLAGS="+pic"

PKG_CONFIGURE_OPTS_TARGET="--enable-static \
                           --disable-shared \
                           --disable-tools \
                           --disable-tester"
