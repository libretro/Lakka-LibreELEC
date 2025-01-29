PKG_NAME="prosystem"
PKG_VERSION="acae250da8d98b8b9707cd499e2a0bf6d8500652"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/prosystem-libretro"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Port of ProSystem to libretro."
PKG_TOOLCHAIN="make"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v prosystem_libretro.so ${INSTALL}/usr/lib/libretro/
}
