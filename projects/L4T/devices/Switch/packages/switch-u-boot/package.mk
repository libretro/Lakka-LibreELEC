PKG_NAME="switch-u-boot"
PKG_VERSION="6cdb578a09d6a55a45b01ca9f333e0d13314cd48"
PKG_GIT_CLONE_BRANCH="linux-norebase"
<<<<<<< HEAD
PKG_DEPENDS_TARGET="toolchain gcc-linaro-aarch64-linux-gnu:host gcc-linaro-arm-linux-gnueabi:host Python3 Python3:host swig:host"
PKG_SITE="https://gitlab.com/switchroot/switch-uboot"
PKG_URL="${PKG_SITE}.git"
PKG_CLEAN="switch-coreboot"
PKG_TOOLCHAIN="make"

make_target() {
  export PATH=${TOOLCHAIN}/lib/gcc-linaro-aarch64-linux-gnu/bin/:${PATH}
  export PATH=${TOOLCHAIN}/lib/gcc-linaro-arm-linux-gnueabi/bin/:${PATH}
  OLD_CROSS_COMPILE=${CROSS_COMPILE}
=======
PKG_ARCH="any"
PKG_DEPENDS_HOST="toolchain Python3:host gcc-linaro-aarch64-linux-gnu:host gcc-linaro-arm-linux-gnueabi:host swig:host"
PKG_SITE="https://gitlab.com/switchroot/switch-uboot.git"
PKG_GIT_URL="$PKG_SITE"
PKG_URL="$PKG_SITE"
#PKG_CLEAN="switch-coreboot"
PKG_TOOLCHAIN="make"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

make_host() {
  export PATH=$TOOLCHAIN/lib/gcc-linaro-aarch64-linux-gnu/bin/:$PATH
  export PATH=$TOOLCHAIN/lib/gcc-linaro-arm-linux-gnueabi/bin/:$PATH
  OLD_CROSS_COMPILE=$CROSS_COMPILE
>>>>>>> aaaa8166b0... Bootloader cleanups, seperate bootloader stuff for libreelec builds
  export CROSS_COMPILE=aarch64-linux-gnu-
  
  make nintendo-switch_defconfig
  make tools-only
  
  export CROSS_COMPILE=${OLD_CROSS_COMPILE}
}

<<<<<<< HEAD
makeinstall_target() {
  #mkdir -p ${BUILD}/switch-boot
    #cp -v ${PKG_BUILD}/u-boot.elf ${BUILD}/switch-boot
  
  mkdir -p ${TOOLCHAIN}/bin
    cp -v tools/mkimage ${TOOLCHAIN}/bin
=======
makeinstall_host() {
  mkdir -p ${TOOLCHAIN}/bin
  cp tools/mkimage ${TOOLCHAIN}/bin
>>>>>>> aaaa8166b0... Bootloader cleanups, seperate bootloader stuff for libreelec builds
}
