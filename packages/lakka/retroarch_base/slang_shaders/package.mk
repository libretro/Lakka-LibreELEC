PKG_NAME="slang_shaders"
PKG_VERSION="6b0413b1fef0ca4dec335457004bc56065f76471"
PKG_SHA256="abf69d88d0b61c9f4721bd0df30b07feed7fe0c3c3d0a525704fb740010f29f6"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://github.com/libretro/slang-shaders"
PKG_URL="https://github.com/libretro/slang-shaders/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="gcc:host"
PKG_LONGDESC="Vulkan GLSL RetroArch shader system"
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  cd ${PKG_BUILD}
  make install INSTALLDIR="${INSTALL}/usr/share/retroarch/shaders/Vulkan-Shaders"
}
