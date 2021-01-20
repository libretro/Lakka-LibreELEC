# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="gptfdisk"
PKG_VERSION="1.0.6"
PKG_SHA256="ddc551d643a53f0bd4440345d3ae32c49b04a797e9c01036ea460b6bb4168ca8"
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
