
PKG_NAME="scummvm_mainline"
PKG_VERSION="8d29673b74aae64b3878176bdaa7e701214a0d4d" # v2.6.1.2
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/spleen1981/scummvm-mainline-libretro"
PKG_URL="$PKG_SITE.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_SHORTDESC="Script Creation Utility for Maniac Mansion Virtual Machine"
PKG_LONGDESC="ScummVM is a program which allows you to run certain classic graphical point-and-click adventure games, provided you already have their data files."
PKG_TOOLCHAIN="make"
PKG_LR_UPDATE_TAG="yes"

pre_make_target() {

  if [ "${DEVICE}" = "OdroidGoAdvance" ]; then
    PKG_MAKE_OPTS_TARGET+=" platform=oga_a35_neon_hardfloat"
  else
    PKG_MAKE_OPTS_TARGET+=" platform=$TARGET_NAME"
  fi
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
  cp -v ${PKG_BUILD}/scummvm_mainline_libretro.so ${INSTALL}/usr/lib/libretro/
  cp -v ${PKG_BUILD}/scummvm_mainline_libretro.info ${INSTALL}/usr/lib/libretro/

  # unpack files to retroarch-system folder and create basic ini file
  mkdir -p ${INSTALL}/usr/share/retroarch/system
  unzip ${PKG_BUILD}/scummvm.zip -d ${INSTALL}/usr/share/retroarch/system

  cat << EOF > ${INSTALL}/usr/share/retroarch/system/scummvm.ini
[scummvm]
extrapath=/tmp/system/scummvm/extra
browser_lastpath=/tmp/system/scummvm/extra
themepath=/tmp/system/scummvm/theme
guitheme=scummmodern
EOF
}
