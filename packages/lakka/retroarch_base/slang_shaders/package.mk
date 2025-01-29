PKG_NAME="slang_shaders"
PKG_VERSION="e2236e6a637a9396394ff238ea151bc0dbe4968e"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/libretro/slang-shaders"
PKG_URL="${PKG_SITE}.git"
PKG_LONGDESC="Common Slang shaders for RetroArch"
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  make -C ${PKG_BUILD} install INSTALLDIR="${INSTALL}/usr/share/retroarch/shaders/Vulkan-Shaders"
}
