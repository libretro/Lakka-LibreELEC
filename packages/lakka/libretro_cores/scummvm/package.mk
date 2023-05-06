PKG_NAME="scummvm"
PKG_VERSION="6be7019fb0b5563b6c48136d8d5a3e3a86b9fbbb"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/libretro/scummvm"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain curl fluidsynth flac libvorbis zlib faad2 freetype"
PKG_SHORTDESC="The ScummVM adventure game engine ported to libretro."
PKG_LONGDESC="ScummVM is a program which allows you to run certain classic graphical point-and-click adventure games, provided you already have their data files."
PKG_TOOLCHAIN="make"

PKG_MAKE_OPTS_TARGET="USE_CLOUD=1 \
                      USE_SYSTEM_fluidsynt=1 \
                      USE_SYSTEM_FLAC=1 \
                      USE_SYSTEM_vorbis=1 \
                      USE_SYSTEM_z=1 \
                      USE_SYSTEM_faad=1 \
                      USE_SYSTEM_freetype=1"

pre_make_target() {
  if [ "${DEVICE}" = "OdroidGoAdvance" ]; then
    PKG_MAKE_OPTS_TARGET+=" platform=oga_a35_neon_hardfloat"
  else
    PKG_MAKE_OPTS_TARGET+=" platform=${TARGET_NAME}"
  fi
}

make_target() {
  make all -C ${PKG_BUILD}/backends/platform/libretro ${PKG_MAKE_OPTS_TARGET}
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
  cp -v ${PKG_BUILD}/backends/platform/libretro/scummvm_libretro.so ${INSTALL}/usr/lib/libretro/
  cp -v ${PKG_BUILD}/backends/platform/libretro/scummvm_libretro.info ${INSTALL}/usr/lib/libretro/

  # unpack files to retroarch-system folder and create basic ini file
  mkdir -p ${INSTALL}/usr/share/retroarch/system
  unzip ${PKG_BUILD}/backends/platform/libretro/scummvm.zip -d ${INSTALL}/usr/share/retroarch/system

  cat << EOF > ${INSTALL}/usr/share/retroarch/system/scummvm.ini
[scummvm]
extrapath=/tmp/system/scummvm/extra
browser_lastpath=/tmp/system/scummvm/extra
themepath=/tmp/system/scummvm/theme
guitheme=scummmodern
EOF
}
