# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="popt"
PKG_VERSION="1.18"
PKG_SHA256="5159bc03a20b28ce363aa96765f37df99ea4d8850b1ece17d1e6ad5c24fdc5d1"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/rpm-software-management/popt"
PKG_URL="http://ftp.rpm.org/popt/releases/popt-1.x/${PKG_NAME}-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="The popt library exists essentially for parsing command-line options."

pre_configure_target() {
 cd ${PKG_BUILD}
 rm -rf .${TARGET_NAME}
}

pre_configure_host() {
 cd ${PKG_BUILD}
 rm -rf .${HOST_NAME}
}
