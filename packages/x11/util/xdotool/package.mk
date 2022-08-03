PKG_NAME="xdotool"
PKG_VERSION="3.20160805.1"
PKG_SHA256="35be5ff6edf0c620a0e16f09ea5e101d5173280161772fca18657d83f20fcca8"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/jordansissel/xdotool"
PKG_URL="https://github.com/jordansissel/xdotool/releases/download/v${PKG_VERSION}/${PKG_NAME}-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain libXinerama libXtst libxkbcommon"
PKG_SECTION="x11/app"
PKG_LONGDESC="This tool lets you simulate keyboard input and mouse activity, move and resize windows, etc."
PKG_TOOLCHAIN="make"

pre_configure_target() {
  LDFLAGS="${LDFLAGS} -lXext"
}

make_target() {
  make
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/{lib,bin}
  cp -v xdotool ${INSTALL}/usr/bin
  cp -v libxdo* ${INSTALL}/usr/lib
  cp -v libxdo* ${TOOLCHAIN}/aarch64-libreelec-linux-gnueabi/sysroot/usr/lib/
}
