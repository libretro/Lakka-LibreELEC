PKG_NAME="citra"
PKG_VERSION="8e634afee9e870620b40efedaef77478cd1f3c99"
PKG_ARCH="x86_64 aarch64"
PKG_LICENSE="GPLv2+"
PKG_SITE="https://github.com/libretro/citra"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="A Nintendo 3DS Emulator"
PKG_TOOLCHAIN="cmake"

PKG_CMAKE_OPTS_TARGET="-DENABLE_TESTS=OFF \
                       -DENABLE_DEDICATED_ROOM=OFF \
                       -DENABLE_SDL2=OFF \
                       -DENABLE_QT=OFF \
                       -DENABLE_WEB_SERVICE=OFF \
                       -DENABLE_SCRIPTING=OFF \
                       -DENABLE_OPENAL=OFF \
                       -DENABLE_LIBUSB=OFF \
                       -DCITRA_ENABLE_BUNDLE_TARGET=OFF \
                       -DCITRA_WARNINGS_AS_ERRORS=OFF"

if [ "${OPENGL_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGL}"
fi

if [ "${OPENGLES_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGLES}"
fi

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v citra_libretro.so ${INSTALL}/usr/lib/libretro/
}
