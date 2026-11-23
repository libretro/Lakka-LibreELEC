PKG_NAME="boytacean"
PKG_VERSION="29b98dec9248d0ee2b9a155a625fa45467c038d8"
PKG_LICENSE="Apache-2.0"
PKG_ARCH="any !i386"
PKG_SITE="https://github.com/joamag/boytacean"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain cargo:host"
PKG_LONGDESC="A GB emulator that is written in Rust"
PKG_TOOLCHAIN="manual"

make_target() {
	 cd ${PKG_BUILD}/frontends/libretro
	 cargo build --release --target ${TARGET_NAME}
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v ${PKG_BUILD}/.${TARGET_NAME}/target/${TARGET_NAME}/release/libboytacean_libretro.so ${INSTALL}/usr/lib/libretro/boytacean_libretro.so
}
