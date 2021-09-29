PKG_NAME="mupen64plus"
PKG_VERSION="ab8134a"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/mupen64plus-libretro"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain nasm:host"
PKG_LONGDESC="mupen64plus + RSP-HLE + GLideN64 + libretro"
#PKG_BUILD_FLAGS="-lto"
PKG_TOOLCHAIN="manual"

if [ "${OPENGL_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGL}"
fi

if [ "${OPENGLES_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGLES}"
fi

make_target() {
  case ${DEVICE:-$PROJECT} in
    RPi|Gamegirl)
      CFLAGS+=" -I${SYSROOT_PREFIX}/usr/include/interface/vcos/pthreads \
	        -I${SYSROOT_PREFIX}/usr/include/interface/vmcs_host/linux"
      make platform=rpi GLES=1 FORCE_GLES=1 WITH_DYNAREC=arm
      ;;
    RPi2)
      CFLAGS+=" -I$SYSROOT_PREFIX/usr/include/interface/vcos/pthreads \
                -I$SYSROOT_PREFIX/usr/include/interface/vmcs_host/linux"
      make platform=rpi2 GLES=1 FORCE_GLES=1 HAVE_NEON=1 WITH_DYNAREC=arm
      ;;
    RPi4)
      make platform=unix GLES3=1 FORCE_GLES3=1 HAVE_NEON=1 WITH_DYNAREC=arm
      ;;
    Generic)
      case ${ARCH} in
        x86_64)
          make WITH_DYNAREC=x86_64
          ;;
        i386)
          make WITH_DYNAREC=x86
          ;;
      esac
      ;;
    OdroidXU3)
      make platform=odroid BOARD=ODROID-XU3 GLES=1 FORCE_GLES=1 HAVE_NEON=1 WITH_DYNAREC=arm
      ;;
    *)
      make platform=unix-gles GLES=1 FORCE_GLES=1 HAVE_NEON=1 WITH_DYNAREC=arm
      ;;
  esac
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v mupen64plus_libretro.so ${INSTALL}/usr/lib/libretro/
}
