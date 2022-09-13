PKG_NAME="glsl_shaders"
PKG_VERSION="ab3eeabd097211998934d87d991c3253f2d32335"
PKG_SHA256="7afa56dc73f21b985c99edded1c5061b2d6e286bf4af4a163dadb6af98ab2072"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://github.com/libretro/glsl-shaders"
PKG_URL="https://github.com/libretro/glsl-shaders/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="gcc:host"
PKG_LONGDESC="GLSL shaders converted by hand from libretro's common-shaders repo."
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  cd ${PKG_BUILD}
  make install INSTALLDIR="${INSTALL}/usr/share/retroarch/shaders/GLSL-Shaders"
}

