PKG_NAME="sixpair"
PKG_VERSION="23e6e08"
PKG_LICENSE="GPL"
PKG_SITE="http://www.pabr.org/sixlinux/"
PKG_URL="https://github.com/lakkatv/sixpair/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain libusb libusb-compat"
PKG_LONGDESC="Associate PS3 Sixaxis controller to system bluetoothd via USB"
PKG_TOOLCHAIN="manual"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

make_target() {
  make sixpair LDLIBS=-lusb
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/bin
    cp sixpair ${INSTALL}/usr/bin
}
