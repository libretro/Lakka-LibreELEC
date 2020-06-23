# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="mumudvb"
PKG_VERSION="6fd60d6d0f2ea7340414a5e5b6eccfe7404e8c86"
PKG_SHA256="0a08f3598c73c8cc8ffc132c8dedcea944c9f10096deb0437f74ce2ecd0c8f27"
PKG_LICENSE="GPL"
PKG_SITE="http://mumudvb.net/"
PKG_URL="https://github.com/braice/MuMuDVB/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain libdvbcsa"
PKG_LONGDESC="MuMuDVB (Multi Multicast DVB) is a program that streams from DVB on a network using multicasting or unicast"
PKG_TOOLCHAIN="autotools"
PKG_BUILD_FLAGS="-sysroot"
