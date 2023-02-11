PKG_NAME="pcsx2"
PKG_VERSION="f3c8743d6a42fe429f703b476fecfdb5655a98a9"
PKG_ARCH="x86_64"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/LRPS2"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="libaio toolchain xz"
PKG_LONGDESC="LRPS2 is fork/port of PCSX2, a free and open-source PlayStation 2 (PS2) emulator"
PKG_TOOLCHAIN="cmake"

PKG_CMAKE_OPTS_TARGET="-DLIBRETRO=ON \
                       -DENABLE_QT=OFF \
                       -DCMAKE_BUILD_TYPE=Release"

if [ "${OPENGL_SUPPORT}" = yes ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGL}"
fi

if [ "${OPENGLES_SUPPORT}" = yes ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGLES}"
fi

pre_make_target() {
  find ${PKG_BUILD} -name flags.make -exec sed -i "s:isystem :I:g" \{} \;
  find ${PKG_BUILD} -name build.ninja -exec sed -i "s:isystem :I:g" \{} \;
}


makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v pcsx2/pcsx2_libretro.so ${INSTALL}/usr/lib/libretro/
}

