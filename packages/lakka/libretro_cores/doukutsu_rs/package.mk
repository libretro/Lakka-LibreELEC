PKG_NAME="doukutsu_rs"
PKG_VERSION="9eca63d36dda3d28ad731092ce3507e42f88275b"
PKG_LICENSE="MIT"
PKG_ARCH="any !i386"
PKG_SITE="https://github.com/DrGlaucous/doukutsu-rs-libretro"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain cargo:host"
PKG_LONGDESC="A faithful and open-source remake of Cave Story's engine written in Rust"
PKG_TOOLCHAIN="manual"

make_target() {
	cargo build --release --target ${TARGET_NAME}
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v ${PKG_BUILD}/.${TARGET_NAME}/target/${TARGET_NAME}/release/libdoukutsu_rs.so ${INSTALL}/usr/lib/libretro/doukutsu_rs_libretro.so
}
