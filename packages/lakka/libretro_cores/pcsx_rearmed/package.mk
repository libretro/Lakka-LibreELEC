PKG_NAME="pcsx_rearmed"
PKG_VERSION="0739265dc0123d200d43ebf99bb79a37d48d6bac"
PKG_SITE="https://github.com/libretro/pcsx_rearmed"
PKG_URL="https://github.com/libretro/pcsx_rearmed/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain linux glibc"
PKG_LONGDESC="PCSX ReARMed is yet another PCSX fork based on the PCSX-Reloaded project, which itself contains code from PCSX, PCSX-df and PCSX-Revolution."
PKG_TOOLCHAIN="make"

configure_package() {
  if [ ! "${ARCH}" = "arm" ]; then
    PKG_BUILD_FLAGS+=" +lto"
  else
    PKG_BUILD_FLAGS+=" -gold"
  fi
}

PKG_MAKE_OPTS_TARGET="-f Makefile.libretro -C ../"

pre_configure_target() {
if target_has_feature neon; then
  PKG_MAKE_OPTS_TARGET+=" HAVE_NEON=1 BUILTIN_GPU=neon"
  else
  PKG_MAKE_OPTS_TARGET+=" HAVE_NEON=0"
fi

if [ "${ARCH}" = "arm" ]; then
  if target_has_feature neon ; then
  PKG_MAKE_OPTS_TARGET+=" HAVE_NEON=1 BUILTIN_GPU=neon"
  else
  PKG_MAKE_OPTS_TARGET+=" HAVE_NEON=0 BUILTIN_GPU=unai"
fi
 fi

  case ${TARGET_ARCH} in
    aarch64)
      PKG_MAKE_OPTS_TARGET+=" DYNAREC=ari64 platform=aarch64"
      ;;
    arm)
      PKG_MAKE_OPTS_TARGET+=" DYNAREC=ari64 platform=unix"
      ;;
    x86_64)
      PKG_MAKE_OPTS_TARGET+=" DYNAREC=lightrec"
      ;;
  esac
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v ../pcsx_rearmed_libretro.so ${INSTALL}/usr/lib/libretro/
}
