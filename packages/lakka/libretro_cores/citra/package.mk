PKG_NAME="citra"
PKG_VERSION="d7e1612c17b1acb5d5eb68bb046820db49aeea5e"
PKG_ARCH="x86_64"
PKG_LICENSE="GPLv2+"
PKG_SITE="https://github.com/libretro/citra"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="A Nintendo 3DS Emulator"
PKG_TOOLCHAIN="make"

PKG_MAKE_OPTS_TARGET="HAVE_FFMPEG_STATIC=1 \
                      FFMPEG_DISABLE_VDPAU=1 \
                      HAVE_FFMPEG_CROSSCOMPILE=1"

if [ "${OPENGL_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGL}"
fi

if [ "${OPENGLES_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGLES}"
fi

pre_make_target() {
  cd ${PKG_BUILD}
  PKG_MAKE_OPTS_TARGET+=" FFMPEG_XC_CPU=${TARGET_CPU} \
                          FFMPEG_XC_ARCH=${TARGET_ARCH} \
                          FFMPEG_XC_PREFIX=${TARGET_PREFIX} \
                          FFMPEG_XC_SYSROOT=${SYSROOT_PREFIX} \
                          FFMPEG_XC_NM=${NM} \
                          FFMPEG_XC_AR=${AR} \
                          FFMPEG_XC_AS=${CC} \
                          FFMPEG_XC_CC=${CC} \
                          FFMPEG_XC_LD=${CC}"
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v citra_libretro.so ${INSTALL}/usr/lib/libretro/
}
