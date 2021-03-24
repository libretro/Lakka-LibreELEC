PKG_NAME="lakka-update"
PKG_VERSION="0"
PKG_LICENSE="GPL"
PKG_SECTION="libretro_suite"
PKG_SHORTDESC="Shell script to wget the latest update"
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  mkdir -p $INSTALL/usr/bin
    cp lakka-update.sh $INSTALL/usr/bin/lakka-update
    chmod +x $INSTALL/usr/bin/lakka-update
}
