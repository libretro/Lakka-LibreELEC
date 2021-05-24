# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="file"
PKG_VERSION="5.40"
PKG_SHA256="35488116b068042320374f60e505e37c2c61b899402f9968e070b63dc39286d4"
PKG_LICENSE="BSD"
PKG_SITE="http://www.darwinsys.com/file/"
PKG_URL="https://github.com/file/file/archive/FILE${PKG_VERSION/./_}.tar.gz"
PKG_DEPENDS_HOST="toolchain:host"
PKG_DEPENDS_TARGET="toolchain file:host zlib"
PKG_LONGDESC="The file utility is used to determine the types of various files."
PKG_TOOLCHAIN="autotools"
PKG_BUILD_FLAGS="-sysroot"

PKG_CONFIGURE_OPTS_HOST="--enable-fsect-man5 \
                         --enable-static \
                         --disable-shared"

PKG_CONFIGURE_OPTS_TARGET="${PKG_CONFIGURE_OPTS_HOST}"
