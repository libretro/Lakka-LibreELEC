# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="RTL8192CU"
PKG_VERSION="7a15cb42e568b0f9c3c872bd6a06cdcab9f0ffd0"
PKG_SHA256="93cd979956ab3f60618707cd11395549ecff17135fa969e25f031a1f06453a7d"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/pvaret/rtl8192cu-fixes"
PKG_URL="${PKG_SITE}/archive/${PKG_VERSION}.tar.gz"
PKG_LONGDESC="Realtek RTL81xxCU Linux 3.x driver"
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
