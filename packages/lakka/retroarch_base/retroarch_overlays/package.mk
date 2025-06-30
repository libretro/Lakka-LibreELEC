PKG_NAME="retroarch_overlays"
PKG_VERSION="de100b2ae7789a2428ab318df3e51c3eea353b44"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/libretro/common-overlays"
PKG_URL="${PKG_SITE}.git"
PKG_LONGDESC="Collection of overlay files for use with libretro frontends, such as RetroArch."
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  make -C ${PKG_BUILD} install INSTALLDIR="${INSTALL}/usr/share/retroarch/overlays"
}
