PKG_NAME="scummvm"
PKG_VERSION="63e57573a9ffe71a1083ff46d9cd210203b87afb"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/scummvm"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="ScummVM with libretro backend."
PKG_TOOLCHAIN="make"

PKG_MAKE_OPTS_TARGET="-C ../backends/platform/libretro/build/"

pre_make_target() {
  CXXFLAGS+=" -DHAVE_POSIX_MEMALIGN=1"
  if [ "${DEVICE}" = "OdroidGoAdvance" ]; then
    PKG_MAKE_OPTS_TARGET+=" platform=oga_a35_neon_hardfloat"
  fi
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v ../backends/platform/libretro/build/scummvm_libretro.so ${INSTALL}/usr/lib/libretro/

  # unpack files to retroarch-system folder and create basic ini file
  mkdir -p ${INSTALL}/usr/share/retroarch-system
    unzip ${PKG_BUILD}/backends/platform/libretro/aux-data/scummvm.zip \
          -d ${INSTALL}/usr/share/retroarch-system

    cat << EOF > ${INSTALL}/usr/share/retroarch-system/scummvm.ini
[scummvm]
extrapath=/tmp/system/scummvm/extra
browser_lastpath=/tmp/system/scummvm/extra
themepath=/tmp/system/scummvm/theme
guitheme=scummmodern
EOF
}
