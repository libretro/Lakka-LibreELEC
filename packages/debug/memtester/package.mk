# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="memtester"
PKG_VERSION="4.3.0"
PKG_SHA256="f9dfe2fd737c38fad6535bbab327da9a21f7ce4ea6f18c7b3339adef6bf5fd88"
PKG_LICENSE="GPL"
PKG_SITE="http://pyropus.ca/software/memtester/"
PKG_URL="http://pyropus.ca/software/memtester/old-versions/memtester-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="A userspace utility for testing the memory subsystem for faults."
PKG_TOOLCHAIN="manual"

make_target() {
  make memtester
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/bin
  cp memtester $INSTALL/usr/bin
}
