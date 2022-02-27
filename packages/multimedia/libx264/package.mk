# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)
PKG_NAME="libx264"
PKG_VERSION="6d10612ab0007f8f60dd2399182efd696da3ffe4"
PKG_LICENSE="Videolan(?)"
PKG_SITE="https://code.videolan.org/videolan/x264"
PKG_URL="${PKG_SITE}".git
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Software based x264 decoder/encoder"
PKG_TOOLCHAIN="configure"

PKG_CONFIGURE_OPTS_TARGET="--cross-prefix=${TARGET_PREFIX} \
                           --sysroot=${SYSROOT_PREFIX} \
                           --disable-asm"
