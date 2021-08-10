PKG_NAME="duckstation"
PKG_ARCH="aarch64"
PKG_LICENSE="GPL"
PKG_VERSION="Lakka33"
PKG_SITE="https://www.duckstation.org"
PKG_URL="https://www.duckstation.org/libretro/duckstation_libretro_linux_aarch64.zip"
PKG_SECTION="libretro"
PKG_SHORTDESC="DuckStation is an simulator/emulator of the Sony PlayStation(TM) console, focusing on playability, speed, and long-term maintainability."
PKG_TOOLCHAIN="manual"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

make_target() {
  cd $PKG_BUILD
  wget $PKG_URL
  unzip duckstation_libretro_linux_aarch64.zip
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/lib/libretro
  cp $PKG_BUILD/duckstation_libretro.so $INSTALL/usr/lib/libretro/
}
