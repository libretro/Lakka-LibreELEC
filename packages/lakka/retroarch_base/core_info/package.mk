PKG_NAME="core_info"
PKG_VERSION="26d15c57d1dbdee1ffa42035e511930d5389458a"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/libretro/libretro-core-info"
PKG_URL="${PKG_SITE}.git"
PKG_LONGDESC="Info files for libretro cores"
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  make -C ${PKG_BUILD} install INSTALLDIR="${INSTALL}/usr/lib/libretro"
}

