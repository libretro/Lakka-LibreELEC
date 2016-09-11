PKG_NAME="sunxi-tools"
PKG_VERSION="ed6f796"
PKG_SITE="https://github.com/cubieboard/sunxi-tools"
PKG_URL="$LAKKA_MIRROR/${PKG_NAME}-${PKG_VERSION}.tar.xz"
PKG_REV="1"
PKG_ARCH="arm"
PKG_LICENSE="GPL"
PKG_DEPENDS=""
PKG_DEPENDS_HOST="toolchain libusb:host"
PKG_PRIORITY="optional"
PKG_SECTION="tools"
PKG_SHORTDESC="extra tools for cubieboards"
PKG_LONGDESC="Tools to help hacking Allwinner A10 (aka sun4i) based devices and it's successors."
PKG_IS_ADDON="no"

PKG_AUTORECONF="no"

makeinstall_host() {
  find . -maxdepth 1 -type f -executable |while read file; do cp -vL $file $ROOT/$TOOLCHAIN/bin; done
}
