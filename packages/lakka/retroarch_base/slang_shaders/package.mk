PKG_NAME="slang_shaders"
PKG_VERSION="feb1fcaee0fe5294b9885fdcc87cb16f0bac06be"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://github.com/libretro/slang-shaders"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="gcc:host"
PKG_LONGDESC="Vulkan GLSL RetroArch shader system"
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  cd ${PKG_BUILD}
  make install INSTALLDIR="${INSTALL}/usr/share/retroarch/shaders/Vulkan-Shaders"
}
