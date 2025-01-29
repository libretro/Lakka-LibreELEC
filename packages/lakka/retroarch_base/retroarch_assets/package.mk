PKG_NAME="retroarch_assets"
PKG_VERSION="c4f1ec8bddba15e1b1a00a7e56c50cf0eca8b5c9"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/libretro/retroarch-assets"
PKG_URL="${PKG_SITE}.git"
PKG_LONGDESC="RetroArch assets. Background and icon themes for the menu drivers."
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  make -C ${PKG_BUILD} install INSTALLDIR="${INSTALL}/usr/share/retroarch/assets"
}

post_makeinstall_target() {
  mkdir -p ${INSTALL}/etc/fonts/conf.d
    cp -v ${PKG_DIR}/conf.d/*.conf ${INSTALL}/etc/fonts/conf.d
}
