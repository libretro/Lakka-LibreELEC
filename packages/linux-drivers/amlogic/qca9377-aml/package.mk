# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="qca9377-aml"
PKG_VERSION="0cc65f9"
PKG_SHA256="336f6e95fc16874a81daf5289c656688a90c5df566ffeaea708f7ac2f5198b9e"
PKG_ARCH="arm aarch64"
PKG_LICENSE="GPL"
PKG_SITE="https://boundarydevices.com/new-silex-wifi-802-11ac-bt4-1-module/"
PKG_URL="https://github.com/boundarydevices/qcacld-2.0/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain linux"
PKG_NEED_UNPACK="$LINUX_DEPENDS"
PKG_LONGDESC="qca9377 Linux Driver"
PKG_IS_KERNEL_PKG="yes"
PKG_TOOLCHAIN="manual"

post_unpack() {
  sed -i 's,-Wall,,g; s,-Werror,,g' $PKG_BUILD/Kbuild
  sed -i 's,CDEFINES :=,CDEFINES := -Wno-misleading-indentation -Wno-unused-variable -Wno-unused-function,g' $PKG_BUILD/Kbuild
}

pre_make_target() {
  unset LDFLAGS
  unset CFLAGS
}

make_target() {
  make KERNEL_SRC="$(kernel_path)" \
    ARCH=$TARGET_KERNEL_ARCH \
    CROSS_COMPILE=$TARGET_KERNEL_PREFIX \
    CONFIG_CLD_HL_SDIO_CORE=y
}

makeinstall_target() {
  mkdir -p $INSTALL/$(get_full_module_dir)/$PKG_NAME
    find $PKG_BUILD/ -name \*.ko -not -path '*/\.*' -exec cp {} $INSTALL/$(get_full_module_dir)/$PKG_NAME \;
}
