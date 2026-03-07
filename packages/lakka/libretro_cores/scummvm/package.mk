PKG_NAME="scummvm"
PKG_VERSION="a58821e3f8d6e0d22dd5652980b9428a9110b09b"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/scummvm"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain curl fluidsynth flac libvorbis zlib faad2 freetype"
PKG_LONGDESC="ScummVM with libretro backend."
PKG_TOOLCHAIN="make"

PKG_MAKE_OPTS_TARGET="all \
                      USE_CLOUD=1 \
                      USE_SYSTEM_fluidsynth=1 \
                      USE_SYSTEM_FLAC=1 \
                      USE_SYSTEM_vorbis=1 \
                      USE_SYSTEM_z=1 \
                      USE_SYSTEM_faad=1 \
                      USE_SYSTEM_freetype=1"

pre_make_target() {
  PKG_MAKE_OPTS_TARGET+=" -C ${PKG_BUILD}/backends/platform/libretro"
  CXXFLAGS+=" -DHAVE_POSIX_MEMALIGN=1"
  if [ "${DEVICE}" = "RK3326" ]; then
    PKG_MAKE_OPTS_TARGET+=" platform=oga_a35_neon_hardfloat"
  else
    PKG_MAKE_OPTS_TARGET+=" platform=${TARGET_NAME}"
  fi
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
