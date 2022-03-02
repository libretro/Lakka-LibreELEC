PKG_NAME="vitaquake3"
PKG_VERSION="7a633867cf0a35c71701aef6fc9dd9dfab9c33a9"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/vitaquake3"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Quake 3 Game Engine"
PKG_TOOLCHAIN="make"

if [ "${OPENGL_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGL}"
fi

if [ "${OPENGLES_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGLES}"
fi

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v vitaquake3_libretro.so ${INSTALL}/usr/lib/libretro/
}
