PKG_NAME="switch-u-boot"
PKG_VERSION="f6ee487cdf2a2efaf0cac8d1b3b003ea90fb1ef3"
PKG_GIT_CLONE_BRANCH="linux-hekatf"
PKG_DEPENDS_HOST="toolchain Python3:host gcc:host swig:host"
PKG_DEPENDS_TARGET="toolchain Python3 gcc:target swig:host"
PKG_SITE="https://gitlab.com/switchroot/switch-uboot"
PKG_URL="${PKG_SITE}.git"
PKG_TOOLCHAIN="make"

make_target() {
  ARCH=arm64 CROSS_COMPILE="${TARGET_KERNEL_PREFIX}" make nintendo-switch_defconfig
  ARCH=arm64 CROSS_COMPILE="${TARGET_KERNEL_PREFIX}" make
}

make_host() {
  ARCH=arm64 CROSS_COMPILE="${TARGET_KERNEL_PREFIX}" make nintendo-switch_defconfig
  make tools-only
}

makeinstall_host() {
  mkdir -p ${TOOLCHAIN}/bin
    cp -v tools/mkimage ${TOOLCHAIN}/bin
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/share/bootloader/boot
   cp u-boot-dtb.bin ${INSTALL}/usr/share/bootloader/boot/bl33.bin
}
