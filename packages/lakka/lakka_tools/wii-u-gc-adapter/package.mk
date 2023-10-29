PKG_NAME="wii-u-gc-adapter"
PKG_VERSION="64d7ddc"
PKG_LICENSE="Non-commercial"
PKG_SITE="https://github.com/ToadKing/wii-u-gc-adapter"
PKG_URL="https://github.com/ToadKing/wii-u-gc-adapter/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain libusb systemd"
PKG_LONGDESC="Tool for using the Wii U GameCube Adapter on Linux"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/bin
    cp wii-u-gc-adapter ${INSTALL}/usr/bin/
}

post_install() {
  enable_service wii-u-gc-adapter.service
}
