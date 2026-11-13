# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="armsx2"
PKG_VERSION="2.9.3"
PKG_SHA256="6eeddb071129e76b96cb3bbf7fa7ca369ff4316dad4298b376acb00f53b6557a"
PKG_ARCH="aarch64"
PKG_LICENSE="GPL-3.0"
PKG_SITE="https://armsx2.net/"
PKG_URL="https://github.com/ARMSX2/ARMSX2/archive/refs/tags/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain zlib libpng libjpeg-turbo zstd lz4 libwebp plutovg freetype plutosvg \
                    shaderc libpcap SDL3 curl fontconfig dbus systemd"
PKG_LONGDESC="ARMSX2 is a free and open-source PlayStation 2 (PS2) emulator based on PCSX2."
PKG_TOOLCHAIN="cmake"

PKG_CMAKE_OPTS_TARGET="-DENABLE_QT_UI=OFF \
                       -DENABLE_SDL_FRONTEND=OFF \
                       -DENABLE_LIBRETRO=ON \
                       -DENABLE_GSRUNNER=OFF \
                       -DENABLE_TESTS=OFF \
                       -DENABLE_RECOMPILER_TEST_HOOKS=OFF \
                       -DENABLE_SETCAP=OFF \
                       -DUSE_BACKTRACE=OFF \
                       -DX11_API=OFF \
                       -DWAYLAND_API=OFF \
                       -DDISABLE_ADVANCE_SIMD=TRUE \
                       -DHOST_PAGE_SIZE=4096 \
                       -DHOST_CACHE_LINE_SIZE=64 \
                       -DCMAKE_DISABLE_PRECOMPILE_HEADERS=ON \
                       -DCMAKE_C_COMPILER_TARGET=aarch64-libreelec-linux-gnu \
                       -DCMAKE_CXX_COMPILER_TARGET=aarch64-libreelec-linux-gnu \
                       -DCMAKE_SYSROOT=${SYSROOT_PREFIX} \
                       -DCMAKE_C_FLAGS_INIT=\"--gcc-toolchain=${TOOLCHAIN}\" \
                       -DCMAKE_CXX_FLAGS_INIT=\"--gcc-toolchain=${TOOLCHAIN}\""

if [ "${OPENGL_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGL}"
fi

if [ "${OPENGLES_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGLES}"
  PKG_CMAKE_OPTS_TARGET+=" -DUSE_GLES=ON"
fi

if [ "${VULKAN_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${VULKAN}"
  PKG_CMAKE_OPTS_TARGET+=" -DUSE_VULKAN=ON"
fi

if [ "${DEVICE}" = "RPi5" ]; then
  PKG_CMAKE_OPTS_TARGET="${PKG_CMAKE_OPTS_TARGET/-DHOST_PAGE_SIZE=4096/-DHOST_PAGE_SIZE=16384}"
  PKG_CMAKE_OPTS_TARGET="${PKG_CMAKE_OPTS_TARGET/-DHOST_CACHE_LINE_SIZE=64/-DHOST_CACHE_LINE_SIZE=128}"

fi

pre_configure_target() {
  # ARMSX2 needs Clang (__attribute__((preserve_most)) in vtlb.h), so swap the
  # compiler in a copy of the toolchain file and drop GCC-only flags
  local clang_conf="${PKG_BUILD}/cmake-${TARGET_NAME}-clang.conf"

  sed -e "s#${TARGET_NAME}-gcc#clang#" \
      -e "s#${TARGET_NAME}-g++#clang++#" \
      "${CMAKE_CONF}" > "${clang_conf}"

  TARGET_CMAKE_OPTS="${TARGET_CMAKE_OPTS/${CMAKE_CONF}/${clang_conf}}"

  # Clang rejects GCC's -mabi=lp64 (LP64 is the only AArch64 ABI anyway)
  CFLAGS="${CFLAGS/-mabi=lp64/}"
  CXXFLAGS="${CXXFLAGS/-mabi=lp64/}"
  TARGET_CFLAGS="${TARGET_CFLAGS/-mabi=lp64/}"
  TARGET_CXXFLAGS="${TARGET_CXXFLAGS/-mabi=lp64/}"

  # Clang does not understand GCC's big.LITTLE -mtune=<big>.<little> form;
  # keep only the big core (e.g. cortex-a75.cortex-a55 -> cortex-a75)
  CFLAGS="$(echo "${CFLAGS}" | sed -E 's/(-mtune=[^ .]+)\.[^ ]+/\1/')"
  CXXFLAGS="$(echo "${CXXFLAGS}" | sed -E 's/(-mtune=[^ .]+)\.[^ ]+/\1/')"
  TARGET_CFLAGS="$(echo "${TARGET_CFLAGS}" | sed -E 's/(-mtune=[^ .]+)\.[^ ]+/\1/')"
  TARGET_CXXFLAGS="$(echo "${TARGET_CXXFLAGS}" | sed -E 's/(-mtune=[^ .]+)\.[^ ]+/\1/')"
}

makeinstall_target() {
  mkdir -p "${INSTALL}/usr/lib/libretro"
    cp -av "${PKG_BUILD}/.${TARGET_NAME}/bin/armsx2_libretro.so" "${INSTALL}/usr/lib/libretro/"
    cp -av "${PKG_BUILD}/armsx2_libretro.info" "${INSTALL}/usr/lib/libretro/"

  # resources (shaders, GameIndex.yaml, fonts)
  mkdir -p "${INSTALL}/usr/share/retroarch/system/pcsx2"
    cp -av "${PKG_BUILD}/bin/resources" "${INSTALL}/usr/share/retroarch/system/pcsx2/"
}
