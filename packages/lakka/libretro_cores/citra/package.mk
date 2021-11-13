PKG_NAME="citra"
PKG_VERSION="b1959d07a340bfd9af65ad464fd19eb6799a96ef"
PKG_ARCH="x86_64"
PKG_LICENSE="GPLv2+"
PKG_SITE="https://github.com/libretro/citra"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain boost curl"
PKG_LONGDESC="A Nintendo 3DS Emulator"

PKG_CMAKE_OPTS_TARGET="-DENABLE_LIBRETRO=1 \
                       -DENABLE_SDL2=0 \
                       -DENABLE_QT=0 \
                       -DCMAKE_BUILD_TYPE=Release \
                       -DBOOST_ROOT=$(get_build_dir boost) \
                       -DUSE_SYSTEM_CURL=1 \
                       -DTHREADS_PTHREAD_ARG=OFF \
                       -DCMAKE_NO_SYSTEM_FROM_IMPORTED=1 \
                       -DCMAKE_VERBOSE_MAKEFILE=1 \
                       --target citra_libretro"

pre_make_target() {
  find ${PKG_BUILD} -name flags.make -exec sed -i "s:isystem :I:g" \{} \;
  find ${PKG_BUILD} -name build.ninja -exec sed -i "s:isystem :I:g" \{} \;
}


makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v src/citra_libretro/citra_libretro.so ${INSTALL}/usr/lib/libretro/
}
