# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="slang"
PKG_VERSION="2.3.2"
PKG_SHA256="fc9e3b0fc4f67c3c1f6d43c90c16a5c42d117b8e28457c5b46831b8b5d3ae31a"
PKG_LICENSE="GPL"
PKG_SITE="http://www.jedsoft.org/slang/"
PKG_URL="https://www.jedsoft.org/releases/slang/${PKG_NAME}-${PKG_VERSION}.tar.bz2"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="A library designed to allow a developer to create robust multi-platform software."
PKG_BUILD_FLAGS="-parallel"

PKG_CONFIGURE_OPTS_TARGET="--without-onig"

pre_configure_target() {
 # slang fails to build in subdirs
 cd ${PKG_BUILD}
 rm -rf .${TARGET_NAME}
}

pre_configure_host() {
 # slang fails to build in subdirs
 cd ${PKG_BUILD}
 rm -rf .${HOST_NAME}
}
