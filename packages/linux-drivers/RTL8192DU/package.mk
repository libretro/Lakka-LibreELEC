# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="RTL8192DU"
PKG_VERSION="eb09a4e6e96a5a033afe60c71022bfa42eea148a"
PKG_SHA256="e78c4fc28a66c1f15154a26c93bee9696965fe81a3246a751c2b4d1fa10e3454"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/lwfinger/rtl8192du"
PKG_URL="https://github.com/lwfinger/rtl8192du/archive/${PKG_VERSION}.tar.gz"
PKG_LONGDESC="Realtek RTL8192DU Linux driver"
PKG_IS_KERNEL_PKG="yes"

pre_make_target() {
  unset LDFLAGS
}

make_target() {
  make V=1 \
       ARCH=${TARGET_KERNEL_ARCH} \
       KSRC=$(kernel_path) \
       CROSS_COMPILE=${TARGET_KERNEL_PREFIX} \
       CONFIG_POWER_SAVING=n
}

makeinstall_target() {
  mkdir -p ${INSTALL}/$(get_full_module_dir)/${PKG_NAME}
    cp *.ko ${INSTALL}/$(get_full_module_dir)/${PKG_NAME}
}
