# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="memtester"
PKG_VERSION="4.5.0"
PKG_SHA256="8ed52b0d06d4aeb61954994146e2a5b2d20448a8f3ce3ee995120e6dbde2ae37"
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
  mkdir -p ${INSTALL}/usr/bin
  cp memtester ${INSTALL}/usr/bin
}
