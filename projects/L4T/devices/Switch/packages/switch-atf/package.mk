PKG_NAME="switch-atf"
PKG_VERSION="8902c539ce83b15637c5f47fc8aff5d14d95b992"
PKG_GIT_CLONE_BRANCH="switch-v4-atf2.6"
PKG_DEPENDS_TARGET="toolchain gcc:host dtc:host"
PKG_SITE="https://gitlab.com/switchroot/bootstack/switch-atf"
PKG_URL="${PKG_SITE}.git"
PKG_TOOLCHAIN="make"

make_target() {
  ARCH=arm64 \
   CROSS_COMPILE="${TARGET_KERNEL_PREFIX}" \
   LDFLAGS="--emit-relocs" \
   CFLAGS="-fno-pic -fno-stack-protector -Wno-deprecated-declarations -Wno-unused-function" \
   make bl31 \
   PLAT=tegra \
   TARGET_SOC=t210 \
   TZDRAM_BASE=0xFFF00000 \
   RESET_TO_BL31=1 \
   COLD_BOOT_SINGLE_CPU=1 \
   PROGRAMMABLE_RESET_ADDRESS=1 \
   ENABLE_STACK_PROTECTOR=none \
   SDEI_SUPPORT=0 \
   CRASH_REPORTING=1 \
   ENABLE_ASSERTIONS=1 \
   LOG_LEVEL=0 \
   PLAT_LOG_LEVEL_ASSERT=0
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/share/bootloader/boot
    cp build/tegra/t210/release/bl31.bin ${INSTALL}/usr/share/bootloader/boot/bl31.bin
}
