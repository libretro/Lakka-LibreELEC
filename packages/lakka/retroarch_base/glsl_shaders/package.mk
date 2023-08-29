PKG_NAME="glsl_shaders"
PKG_VERSION="6aee329c59e8ef19dc645872506a2ba3e7660cdf"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/libretro/glsl-shaders"
PKG_URL="${PKG_SITE}.git"
PKG_LONGDESC="Common GSLS shaders for RetroArch"
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  make -C ${PKG_BUILD} install INSTALLDIR="${INSTALL}/usr/share/retroarch/shaders/GLSL-Shaders"
}
