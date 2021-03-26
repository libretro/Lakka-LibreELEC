# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2020-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="crust"
PKG_VERSION="219383cd48924179bdd6c5e125c0dd9ab0d78c16"
PKG_SHA256="f16e362e20c4c59da4f4a6e692f5d1c3b442a7e398ae9f45932791711f6aa1f6"
PKG_ARCH="arm aarch64"
PKG_LICENSE="BSD-3c"
PKG_SITE="https://github.com/crust-firmware/crust"
PKG_URL="https://github.com/crust-firmware/crust/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="gcc-or1k-linux:host"
PKG_LONGDESC="Crust: Libre SCP firmware for Allwinner sunxi SoCs"
PKG_TOOLCHAIN="manual"
PKG_STAMP="${UBOOT_SYSTEM}"

pre_configure_target() {
  export CROSS_COMPILE="${TOOLCHAIN}/lib/gcc-or1k-linux/bin/or1k-linux-"
}

make_target() {
  if [ -z "${UBOOT_SYSTEM}" ]; then
    echo "crust is only built when building an image"
    exit 0
  fi

  CRUST_CONFIG=$(${ROOT}/${SCRIPTS}/uboot_helper ${PROJECT} ${DEVICE} ${UBOOT_SYSTEM} crust_config)
  if [ -z "${CRUST_CONFIG}" ]; then
    echo "crust_config must be set to build crust firmware"
    echo "see './scripts/uboot_helper' for more information"
    exit 0
  fi

  make distclean
  if [ "${BUILD_WITH_DEBUG}" = "yes" ]; then
    echo "CONFIG_DEBUG_LOG=y" >> configs/${CRUST_CONFIG}
  else
    echo "CONFIG_SERIAL=n" >> configs/${CRUST_CONFIG}
  fi
  # Boards with a PMIC need to disable CONFIG_PMIC_SHUTDOWN to get CIR wakeup from suspend
  echo "CONFIG_PMIC_SHUTDOWN=n" >> configs/${CRUST_CONFIG}
  echo "CONFIG_CIR=y" >> configs/${CRUST_CONFIG}
  make ${CRUST_CONFIG}
  make scp
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/share/bootloader
  cp -a build/scp/scp.bin ${INSTALL}/usr/share/bootloader
}
