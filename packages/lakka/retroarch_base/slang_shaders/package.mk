PKG_NAME="slang_shaders"
PKG_VERSION="23046258f7fd02242cc6dd4c08c997a8ddb84935"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/libretro/slang-shaders"
PKG_URL="${PKG_SITE}.git"
PKG_LONGDESC="Common Slang shaders for RetroArch"
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  make -C ${PKG_BUILD} install INSTALLDIR="${INSTALL}/usr/share/retroarch/shaders/Vulkan-Shaders"
}
