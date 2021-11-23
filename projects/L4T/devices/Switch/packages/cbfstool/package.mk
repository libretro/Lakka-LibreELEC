PKG_NAME="cbfstool"
PKG_VERSION="6087335b0847a66a725156e39bf1329462c03751"
PKG_GIT_CLONE_BRANCH="switch-linux"
PKG_DEPENDS_HOST="zlib:host openssl:host"
PKG_SITE="https://gitlab.com/switchroot/switch-coreboot"
PKG_URL="https://gitlab.com/switchroot/switch-coreboot.git"
PKG_TOOLCHAIN="manual"

GET_SKIP_SUBMODULE="yes"

make_host() {
  cd ${PKG_BUILD}
  git submodule update --init --recursive
  cd ${PKG_BUILD}/util/cbfstool/
  make
}

makeinstall_host() {
  if [ -f "${TOOLCHAIN}/bin/cbfstool" ]; then
    rm -r ${TOOLCHAIN}/bin/cbfstool
  fi
  mkdir -p ${INSTALL_PKG}/usr/bin
  cp -P ${PKG_BUILD}/util/cbfstool/cbfstool ${TOOLCHAIN}/bin
}

pre_make_host() {
  :
}

make_target() {
  :
}

makeinstall_target() {
  :
}
