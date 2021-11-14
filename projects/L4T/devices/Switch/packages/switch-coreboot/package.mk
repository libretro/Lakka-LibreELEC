PKG_NAME="switch-coreboot"
PKG_VERSION="d01561464b6cc4dab72a4f518a23b725e4d9bb7a"
PKG_GIT_CLONE_BRANCH="switch-linux"
PKG_DEPENDS_HOST="gcc-linaro-aarch64-linux-gnu:host gcc-linaro-arm-linux-gnueabi:host zlib:host openssl:host"
PKG_DEPENDS_TARGET="toolchain switch-coreboot:host switch-u-boot gcc-linaro-aarch64-linux-gnu:host gcc-linaro-arm-linux-gnueabi:host curl:host"
PKG_SITE="https://gitlab.com/switchroot/switch-coreboot"
PKG_URL="${PKG_SITE}.git"
PKG_CLEAN="switch-bootloader"
PKG_TOOLCHAIN="make"

make_host() {
  export PATH=${TOOLCHAIN}/lib/gcc-linaro-aarch64-linux-gnu/bin/:${PATH}
  export PATH=${TOOLCHAIN}/lib/gcc-linaro-arm-linux-gnueabi/bin/:${PATH}
  export C_INCLUDE_PATH="${TOOLCHAIN}/include:${C_INCLUDE_PATH}"
  export LIBRARY_PATH="${TOOLCHAIN}/lib:${LIBRARY_PATH}"
  make nintendo_switch_defconfig
  make iasl
  make tools
}

makeinstall_host() {
  :
}

pre_make_host() {
  sed -i -e "s|../switch-uboot/u-boot.elf|${BUILD}/switch-boot/u-boot.elf|" ${PKG_BUILD}/configs/nintendo_switch_defconfig
}

make_target() {
  export PATH=${TOOLCHAIN}/lib/gcc-linaro-aarch64-linux-gnu/bin/:${PATH}
  export PATH=${TOOLCHAIN}/lib/gcc-linaro-arm-linux-gnueabi/bin/:${PATH}
  OLD_CROSS_COMPILE=${CROSS_COMPILE}
  export CROSS_COMPILE=aarch64-linux-gnu-

  # Make
  make

  export CROSS_COMPILE=${OLD_CROSS_COMPILE}
}

makeinstall_target() {
  mkdir -p ${BUILD}/switch-boot
    cp -v ${PKG_BUILD}/build/coreboot.rom ${BUILD}/switch-boot
}
