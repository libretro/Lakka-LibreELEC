# PKG_VERSION is from https://www.duckstation.org/libretro/changelog.txt
# Archive with binary core must be present on LAKKA_MIRROR. This is achieved
# by a separate script that runs on LAKKA_MIRROR and downloads new versions
# of the core.

PKG_NAME="duckstation"
PKG_ARCH="x86_64 arm aarch64"
PKG_LICENSE="GPL"
PKG_VERSION="f799f62a1a058b88079fae40f20bf424070e5719"
PKG_SITE="https://www.duckstation.org"
PKG_SOURCE_DIR="${PKG_NAME}_${ARCH}-${PKG_VERSION}"
PKG_SOURCE_NAME="${PKG_SOURCE_DIR}.zip"
PKG_URL="${LAKKA_MIRROR}/${PKG_SOURCE_NAME}"
PKG_SECTION="libretro"
PKG_SHORTDESC="DuckStation is an simulator/emulator of the Sony PlayStation(TM) console, focusing on playability, speed, and long-term maintainability."
PKG_TOOLCHAIN="manual"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

makeinstall_target() {
  mkdir -p $INSTALL/usr/lib/libretro
  cp $PKG_BUILD/duckstation_libretro.so $INSTALL/usr/lib/libretro/
}
