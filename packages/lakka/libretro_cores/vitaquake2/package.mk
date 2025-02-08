PKG_NAME="vitaquake2"
PKG_VERSION="49bb33e6e82ee3b5ee2e1043c56917587fda5934"
PKG_ARCH="aarch64 x86_64"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/vitaquake2"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Quake II Game Engine"
PKG_TOOLCHAIN="make"

if [ "${OPENGL_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGL}"
fi

if [ "${OPENGLES_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGLES}"
fi

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v vitaquake2_libretro.so ${INSTALL}/usr/lib/libretro/
}
