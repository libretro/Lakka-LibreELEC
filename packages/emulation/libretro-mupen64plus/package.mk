# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-mupen64plus"
PKG_VERSION="b21e3292e6ff7afb954d4871362ab6e6473d680f"
PKG_SHA256="2bc4424ac80ee03d248d261908a857dc1e0ae919704830e1629cd111a9acc91e"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/mupen64plus-libretro"
PKG_URL="https://github.com/libretro/mupen64plus-libretro/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform"
PKG_LONGDESC="game.libretro.mupen64plus: Mupen64Plus for Kodi"

PKG_LIBNAME="mupen64plus_libretro.so"
PKG_LIBPATH="$PKG_LIBNAME"
PKG_LIBVAR="MUPEN64PLUS_LIB"

make_target() {

  if target_has_feature neon; then
    export HAVE_NEON=1
  fi

  if [ -z "$DEVICE" ]; then
    PKG_DEVICE_NAME=$PROJECT
  else
    PKG_DEVICE_NAME=$DEVICE
  fi

  case $PKG_DEVICE_NAME in
    RPi|RPi2)
      make platform=${PKG_DEVICE_NAME,,}
      ;;
    Generic)
      make WITH_DYNAREC=x86_64
      ;;
    *)
      if [[ "$TARGET_CPU" = "cortex-a9" ]] || [[ "$TARGET_CPU" = *"cortex-a53" ]] || [[ "$TARGET_CPU" = "cortex-a17" ]]; then
        if [ "$TARGET_ARCH" = "aarch64" ]; then
          make platform=aarch64
        else
          make platform=linux-gles FORCE_GLES=1 WITH_DYNAREC=arm
        fi
      fi
      ;;
  esac
}

makeinstall_target() {
  mkdir -p $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME
  cp $PKG_LIBPATH $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME
  echo "set($PKG_LIBVAR $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME)" > $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME/$PKG_NAME-config.cmake
}
