# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="RTL8192EU"
PKG_VERSION="dcd752459cc93ee89e52331b26c93eb8209dc00b"
PKG_SHA256="a8da10546ab7d1faabdc71fcd7793ab979a1b2a8d46854945b5956280aa7c698"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/Mange/rtl8192eu-linux-driver"
PKG_URL="https://github.com/Mange/rtl8192eu-linux-driver/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain linux"
PKG_NEED_UNPACK="$LINUX_DEPENDS"
PKG_LONGDESC="Realtek RTL8192EU Linux 3.x driver"
PKG_IS_KERNEL_PKG="yes"

pre_make_target() {
  unset LDFLAGS
}

make_target() {
  make V=1 \
       ARCH=$TARGET_KERNEL_ARCH \
       KSRC=$(kernel_path) \
       CROSS_COMPILE=$TARGET_KERNEL_PREFIX \
       CONFIG_POWER_SAVING=n \
       USER_EXTRA_CFLAGS="-Wno-error=date-time"
}

makeinstall_target() {
  mkdir -p $INSTALL/$(get_full_module_dir)/$PKG_NAME
    cp *.ko $INSTALL/$(get_full_module_dir)/$PKG_NAME
}
