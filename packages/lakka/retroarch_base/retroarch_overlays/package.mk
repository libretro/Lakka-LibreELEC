PKG_NAME="retroarch_overlays"
PKG_VERSION="e2568e3ff9abaeddd087e093ac0b3acd4b649f7d"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/libretro/common-overlays"
PKG_URL="${PKG_SITE}.git"
PKG_LONGDESC="Collection of overlay files for use with libretro frontends, such as RetroArch."
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  make -C ${PKG_BUILD} install INSTALLDIR="${INSTALL}/usr/share/retroarch/overlays"
}
