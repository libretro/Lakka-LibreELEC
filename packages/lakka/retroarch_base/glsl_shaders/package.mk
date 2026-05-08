PKG_NAME="glsl_shaders"
PKG_VERSION="42fa8a98ab19bdaffb53280746a30819eb21f807"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/libretro/glsl-shaders"
PKG_URL="${PKG_SITE}.git"
PKG_LONGDESC="Common GSLS shaders for RetroArch"
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  make -C ${PKG_BUILD} install INSTALLDIR="${INSTALL}/usr/share/retroarch/shaders/GLSL-Shaders"
}
