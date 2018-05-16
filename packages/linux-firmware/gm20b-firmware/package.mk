PKG_NAME="gm20b-firmware"
PKG_VERSION="cb7daa2"
PKG_ARCH="any"
PKG_SITE="https://github.com/lakka-switch/gm20b-firmware"
PKG_URL="https://github.com/lakka-switch/gm20b-firmware/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="firmware"
PKG_SHORTDESC="gm20b-firmware: firmwares for the Tegra X1 SoC"

make_target() {
  :
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/lib/firmware/nvidia/gm20b
  cp -PRv $BUILD/$PKG_NAME-$PKG_VERSION/* $INSTALL/usr/lib/firmware/nvidia/gm20b
}
