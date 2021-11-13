PKG_NAME="lowres_nx"
PKG_VERSION="12aeb1690108c5fe3f404475d59f86a12a21949d"
PKG_LICENSE="Zlib"
PKG_SITE="https://github.com/timoinutilis/lowres-nx"
PKG_URL="${PKG_SITE}.git"
PKG_GIT_CLONE_BRANCH="retroarch"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="A simulated retro game console, which can be programmed in the classic BASIC language"
PKG_TOOLCHAIN="make"

PKG_MAKE_OPTS_TARGET="-C platform/LibRetro"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v platform/LibRetro/lowresnx_libretro.so ${INSTALL}/usr/lib/libretro/
}
