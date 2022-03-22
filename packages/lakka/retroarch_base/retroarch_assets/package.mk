PKG_NAME="retroarch_assets"
PKG_VERSION="f45dd1351e6bfb9f01e12bee8d358ad22a2bb8f9"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/libretro/retroarch-assets"
PKG_URL="${PKG_SITE}.git"
PKG_LONGDESC="RetroArch assets. Background and icon themes for the menu drivers."
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  make -C ${PKG_BUILD} install INSTALLDIR="${INSTALL}/usr/share/retroarch-assets"
}

post_makeinstall_target() {
  mkdir -p ${INSTALL}/etc/fonts/conf.d
    cp -v ${PKG_DIR}/conf.d/*.conf ${INSTALL}/etc/fonts/conf.d
}
