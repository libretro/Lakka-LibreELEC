PKG_NAME="duckstation"
PKG_ARCH="x86_64 arm aarch64"
PKG_LICENSE="GPL"
PKG_VERSION="Lakka33"
PKG_SITE="https://www.duckstation.org"
PKG_SECTION="libretro"
PKG_SHORTDESC="DuckStation is an simulator/emulator of the Sony PlayStation(TM) console, focusing on playability, speed, and long-term maintainability."
PKG_TOOLCHAIN="manual"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

case ${ARCH} in
aarch64)
  binary_filename="duckstation_libretro_linux_aarch64.zip"
  ;;
arm)
  binary_filename="duckstation_libretro_linux_armv7.zip"
  ;;
x86_64)
  binary_filename="duckstation_libretro_linux_x64.zip"
  ;;
esac
PKG_URL="https://www.duckstation.org/libretro/${binary_filename}"

make_target() {
  cd $PKG_BUILD
  wget $PKG_URL
  unzip $binary_filename
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/lib/libretro
  cp $PKG_BUILD/duckstation_libretro.so $INSTALL/usr/lib/libretro/
}
