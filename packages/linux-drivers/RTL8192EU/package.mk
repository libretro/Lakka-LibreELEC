# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="RTL8192EU"
PKG_VERSION="744bbe52976e51895fce2c1d4075f97a98dca2b2"
PKG_SHA256="2197871514bd246f934bb36beb398b26af122e797b322f8f59f52ce085fec136"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/Mange/rtl8192eu-linux-driver"
PKG_URL="https://github.com/Mange/rtl8192eu-linux-driver/archive/${PKG_VERSION}.tar.gz"
PKG_LONGDESC="Realtek RTL8192EU Linux 3.x driver"
PKG_IS_KERNEL_PKG="yes"

pre_make_target() {
  unset LDFLAGS
}

make_target() {
  make V=1 \
       ARCH=${TARGET_KERNEL_ARCH} \
       KSRC=$(kernel_path) \
       CROSS_COMPILE=${TARGET_KERNEL_PREFIX} \
       CONFIG_POWER_SAVING=n \
       USER_EXTRA_CFLAGS="-Wno-error=date-time"
}

makeinstall_target() {
  mkdir -p ${INSTALL}/$(get_full_module_dir)/${PKG_NAME}
    cp *.ko ${INSTALL}/$(get_full_module_dir)/${PKG_NAME}
}
