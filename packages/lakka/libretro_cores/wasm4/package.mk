PKG_NAME="wasm4"
PKG_VERSION="1b29b4b8fcf27fb70cb55c497fed9b45e3c94db5"
PKG_LICENSE="ISC"
PKG_SITE="https://github.com/aduros/wasm4"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="WASM-4 is a low-level fantasy game console for building small games with WebAssembly."
PKG_TOOLCHAIN="cmake"
PKG_CMAKE_OPTS_TARGET="-DLIBRETRO=on \
                       -DCMAKE_BUILD_TYPE=Release"

pre_configure_target() {
  PKG_CMAKE_SCRIPT="${PKG_BUILD}/runtimes/native/CMakeLists.txt"
}

pre_make_target() {
  find ${PKG_BUILD} -name flags.make -exec sed -i "s:isystem :I:g" \{} \;
  find ${PKG_BUILD} -name build.ninja -exec sed -i "s:isystem :I:g" \{} \;
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v wasm4_libretro.so ${INSTALL}/usr/lib/libretro/
}

