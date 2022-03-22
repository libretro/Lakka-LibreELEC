PKG_NAME="mrboom"
PKG_VERSION="64e874abdd11b845c013ea74e5a62ed1e12d09e2"
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
