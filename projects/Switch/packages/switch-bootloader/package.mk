PKG_NAME="switch-bootloader"
PKG_VERSION="1.0"
PKG_ARCH="any"

makeinstall_target() {
  mkdir -p $INSTALL/usr/share/bootloader/boot
  mkimage -A arm -T script -O linux -d $PKG_DIR/bootscript/boot.txt $BUILD/$PKG_NAME-$PKG_VERSION/boot.scr
  
  cp -PRv $BUILD/$PKG_NAME-$PKG_VERSION/boot.scr $INSTALL/usr/share/bootloader/boot.scr
  cp -PRv $(kernel_path)/arch/arm64/boot/dts/nvidia/tegra210-nintendo-switch.dtb $INSTALL/usr/share/bootloader/tegra210-nintendo-switch.dtb
}

make_target() {
  :
}
