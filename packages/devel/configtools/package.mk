# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="configtools"
PKG_VERSION="c8ddc8472f8efcadafc1ef53ca1d863415fddd5f" # 2020-12-22
PKG_SHA256="6389d62e4e55554c764c2c0deb5b42767f34d7f274728c28355fedbaa337165b"
PKG_LICENSE="GPL"
PKG_SITE="http://git.savannah.gnu.org/cgit/config.git"
PKG_URL="http://git.savannah.gnu.org/cgit/config.git/snapshot/config-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_HOST=""
PKG_LONGDESC="configtools"
PKG_TOOLCHAIN="manual"

makeinstall_host() {
  mkdir -p ${TOOLCHAIN}/configtools
  cp config.* ${TOOLCHAIN}/configtools
}
