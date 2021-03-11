# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="gptfdisk"
PKG_VERSION="1.0.8"
PKG_SHA256="95d19856f004dabc4b8c342b2612e8d0a9eebdd52004297188369f152e9dc6df"
PKG_LICENSE="GPL"
PKG_SITE="http://www.rodsbooks.com/gdisk/"
PKG_URL="https://downloads.sourceforge.net/project/${PKG_NAME}/${PKG_NAME}/${PKG_VERSION}/${PKG_NAME}-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain popt crossguid"
PKG_LONGDESC="GPT text-mode partitioning tools"

make_target() {
  make sgdisk "CC=${CC}" "CXX=${CXX}"
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/sbin/
    cp -p sgdisk ${INSTALL}/usr/sbin/
}
