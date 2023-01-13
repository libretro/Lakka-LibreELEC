PKG_NAME="glsl_shaders"
PKG_VERSION="66cd3917c3cde8c96b5492bca00c95e3e17b44b9"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://github.com/libretro/glsl-shaders"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="gcc:host"
PKG_LONGDESC="GLSL shaders converted by hand from libretro's common-shaders repo."
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  cd ${PKG_BUILD}
  make install INSTALLDIR="${INSTALL}/usr/share/retroarch/shaders/GLSL-Shaders"
}

