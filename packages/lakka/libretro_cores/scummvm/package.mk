PKG_NAME="scummvm"
PKG_VERSION="18add58f142f0b0fe1614f79a9a9cb48aa3eb033"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/scummvm"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="ScummVM with libretro backend."
PKG_TOOLCHAIN="make"
PKG_LR_UPDATE_TAG="yes"

PKG_MAKE_OPTS_TARGET="all"

pre_make_target() {
  CXXFLAGS+=" -DHAVE_POSIX_MEMALIGN=1"
  if [ "${DEVICE}" = "OdroidGoAdvance" ]; then
    PKG_MAKE_OPTS_TARGET+=" platform=oga_a35_neon_hardfloat"
  else
    PKG_MAKE_OPTS_TARGET+=" platform=${TARGET_NAME}"
  fi
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v scummvm_libretro.so ${INSTALL}/usr/lib/libretro/
    cp -v scummvm_libretro.info ${INSTALL}/usr/lib/libretro/

  # unpack files to retroarch-system folder and create basic ini file
  mkdir -p ${INSTALL}/usr/share/retroarch/system
    unzip scummvm.zip -d ${INSTALL}/usr/share/retroarch/system

    cat << EOF > ${INSTALL}/usr/share/retroarch/system/scummvm.ini
[scummvm]
extrapath=/tmp/system/scummvm/extra
browser_lastpath=/tmp/system/scummvm/extra
themepath=/tmp/system/scummvm/theme
guitheme=scummmodern
EOF
}
