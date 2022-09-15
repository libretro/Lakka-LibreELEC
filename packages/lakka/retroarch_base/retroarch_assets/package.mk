PKG_NAME="retroarch_assets"
PKG_VERSION="1daf54ede25763c3ae196303d9dc27610a2338a7"
PKG_SHA256="b6502497d2e0547d0a19f99397659b945e82b6951a928a697425de41d7300223"
PKG_LICENSE="CC-BY-4.0"
PKG_SITE="https://github.com/libretro/retroarch-assets"
PKG_URL="https://github.com/libretro/retroarch-assets/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="gcc:host"
PKG_LONGDESC="RetroArch assets. Background and icon themes for the menu drivers."
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  cd ${PKG_BUILD}
  make install INSTALLDIR="${INSTALL}/usr/share/retroarch/assets"
}

post_makeinstall_target() {
  # Remove unnecessary files
  safe_remove ${INSTALL}/usr/share/retroarch/assets/devtools
  safe_remove ${INSTALL}/usr/share/retroarch/assets/README.md
}
