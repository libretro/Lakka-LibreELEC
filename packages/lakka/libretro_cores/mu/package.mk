PKG_NAME="mu"
PKG_VERSION="91a46734dd4083cb8841ff2a6d8874b24203241d"
PKG_LICENSE="Non-commercial"
PKG_SITE="https://github.com/libretro/Mu"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="A new Palm OS emulator targeting compatibility, speed and accuracy in that order."
PKG_TOOLCHAIN="make"

PKG_MAKE_OPTS_TARGET="-C ../libretroBuildSystem"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v ../libretroBuildSystem/mu_libretro.so ${INSTALL}/usr/lib/libretro/mu_libretro.so
}
