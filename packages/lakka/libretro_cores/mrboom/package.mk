PKG_NAME="mrboom"
PKG_VERSION="1bc0933b71051411404cdc092b14ade17efb2027"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/libretro/mrboom-libretro"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Mr.Boom is a 8 players Bomberman clone for RetroArch/Libretro"
PKG_TOOLCHAIN="make"

PKG_MAKE_OPTS_TARGET=""

if target_has_feature neon ; then
  PKG_MAKE_OPTS_TARGET+=" HAVE_NEON=1"
fi

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v mrboom_libretro.so ${INSTALL}/usr/lib/libretro/
}
