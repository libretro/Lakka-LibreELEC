PKG_NAME="u-boot-tools"
PKG_VERSION="2016.03"
PKG_REV="0"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://www.denx.de/wiki/U-Boot/WebHome"
PKG_URL="ftp://ftp.denx.de/pub/u-boot/u-boot-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="tools"
PKG_SHORTDESC="U-Boot bootloader utility tools"
PKG_LONGDESC="U-Boot bootloader utility tools. This package includes the mkimage program, which allows generation of U-Boot images in various formats, and the fw_printenv and fw_setenv programs to read and modify U-Boot's environment and other tools."
PKG_AUTORECONF="no"
PKG_IS_ADDON="no"

UBOOT_TOOLS_ARCH="arm"

unpack() {
  mkdir -p $BUILD/u-boot-tools-$PKG_VERSION
  tar jxf $SOURCES/$PKG_NAME/$PKG_SOURCE_NAME -C $BUILD/u-boot-tools-$PKG_VERSION --strip 1
}

make_target() {
  make dummy_defconfig
  make CROSS_COMPILE="$TARGET_PREFIX" ARCH="$UBOOT_TOOLS_ARCH" env
  make CROSS_COMPILE="$TARGET_PREFIX" cross_tools
}

makeinstall_target() {
  mkdir -p $INSTALL/etc
  cp $PKG_DIR/config/fw_env.config $INSTALL/etc/fw_env.config

  mkdir -p $INSTALL/usr/sbin
  cp tools/env/fw_printenv $INSTALL/usr/sbin/fw_printenv
  cp tools/env/fw_printenv $INSTALL/usr/sbin/fw_setenv
  cp tools/dumpimage $INSTALL/usr/sbin/dumpimage
  cp tools/fdtgrep $INSTALL/usr/sbin/fdtgrep
  cp tools/gen_eth_addr $INSTALL/usr/sbin/gen_eth_addr
  cp tools/img2srec $INSTALL/usr/sbin/img2srec
  cp tools/mkenvimage $INSTALL/usr/sbin/mkenvimage
  cp tools/mkimage $INSTALL/usr/sbin/mkimage
  cp tools/proftool $INSTALL/usr/sbin/proftool
  cp tools/relocate-rela $INSTALL/usr/sbin/relocate-rela
}
