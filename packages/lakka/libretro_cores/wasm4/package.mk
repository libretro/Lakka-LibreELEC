PKG_NAME="wasm4"
PKG_VERSION="35fb9facbee2159dde3881e64a61710bae8db828"
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

