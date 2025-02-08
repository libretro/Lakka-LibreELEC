PKG_NAME="holani"
PKG_VERSION="61114880081cc518b54c898708ad1d162d9077ec"
PKG_LICENSE="GPLv3"
PKG_ARCH="x86_64"
PKG_SITE="https://github.com/LLeny/holani-retro"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain cargo:host"
PKG_LONGDESC="A cycle-stepped Atari Lynx emulator"
PKG_TOOLCHAIN="manual"

make_target() {
	cargo build --release --target ${TARGET_NAME}
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v ${PKG_BUILD}/.${TARGET_NAME}/target/${TARGET_NAME}/release/libholani.so ${INSTALL}/usr/lib/libretro/holani_libretro.so
}
