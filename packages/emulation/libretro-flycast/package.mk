# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2024-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-flycast"
PKG_VERSION="e06b737e0e2cf0436fc815aa91d4504e4c879435"
PKG_SHA256="ab08d5c3ce7b2f7a9e8cba03f1b48ac4e9f0c0e7fd4b4f5a7a6e3d8c9b0a1f2"
PKG_LICENSE="GPL-2.0-only"
PKG_SITE="https://github.com/libretro/flycast"
PKG_URL="https://github.com/libretro/flycast/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Flycast is a multi-platform Sega Dreamcast, Naomi, Naomi 2 and \
              Atomiswave emulator derived from reicast. It supports libretro API \
              for seamless integration with RetroArch frontend."
PKG_TOOLCHAIN="cmake"

PKG_LIBNAME="flycast_libretro.so"
PKG_LIBPATH="${PKG_LIBNAME}"
PKG_LIBVAR="FLYCAST_LIB"

# ---------------------------------------------------------------------------
# Platform-specific configuration flags
# ---------------------------------------------------------------------------

# Determine whether to use OpenGL ES or desktop GL based on target GPU
if [ "${OPENGLES_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGLES}"
  PKG_CMAKE_OPTS_TARGET+=" -DUSE_GLES=ON"
  PKG_CMAKE_OPTS_TARGET+=" -DUSE_OPENGL=OFF"
else
  PKG_DEPENDS_TARGET+=" ${OPENGL}"
  PKG_CMAKE_OPTS_TARGET+=" -DUSE_GLES=OFF"
  PKG_CMAKE_OPTS_TARGET+=" -DUSE_OPENGL=ON"
fi

# Vulkan rendering support
if [ "${VULKAN_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${VULKAN}"
  PKG_CMAKE_OPTS_TARGET+=" -DUSE_VULKAN=ON"
else
  PKG_CMAKE_OPTS_TARGET+=" -DUSE_VULKAN=OFF"
fi

# Architecture-specific SIMD and feature flags
case "${TARGET_ARCH}" in
  aarch64)
    PKG_CMAKE_OPTS_TARGET+=" -DTARGET_ARCH=arm64"
    PKG_CMAKE_OPTS_TARGET+=" -DUSE_NEON=ON"
    PKG_CMAKE_OPTS_TARGET+=" -DUSE_GENERIC_DYNAREC=OFF"
    ;;
  arm)
    PKG_CMAKE_OPTS_TARGET+=" -DTARGET_ARCH=arm"
    PKG_CMAKE_OPTS_TARGET+=" -DUSE_NEON=ON"
    PKG_CMAKE_OPTS_TARGET+=" -DUSE_GENERIC_DYNAREC=ON"
    ;;
  x86_64)
    PKG_CMAKE_OPTS_TARGET+=" -DTARGET_ARCH=x86_64"
    PKG_CMAKE_OPTS_TARGET+=" -DUSE_SSE4=ON"
    PKG_CMAKE_OPTS_TARGET+=" -DUSE_GENERIC_DYNAREC=OFF"
    ;;
  i?86)
    PKG_CMAKE_OPTS_TARGET+=" -DTARGET_ARCH=x86"
    PKG_CMAKE_OPTS_TARGET+=" -DUSE_SSE4=OFF"
    PKG_CMAKE_OPTS_TARGET+=" -DUSE_GENERIC_DYNAREC=OFF"
    ;;
  *)
    PKG_CMAKE_OPTS_TARGET+=" -DTARGET_ARCH=generic"
    PKG_CMAKE_OPTS_TARGET+=" -DUSE_GENERIC_DYNAREC=ON"
    ;;
esac

# Common CMake options for the libretro core build
PKG_CMAKE_OPTS_TARGET+=" -DLIBRETRO=ON"
PKG_CMAKE_OPTS_TARGET+=" -DCMAKE_BUILD_TYPE=Release"
PKG_CMAKE_OPTS_TARGET+=" -DCMAKE_POSITION_INDEPENDENT_CODE=ON"
PKG_CMAKE_OPTS_TARGET+=" -DENABLE_CTEST=OFF"
PKG_CMAKE_OPTS_TARGET+=" -DUSE_HOST_LIBZIP=OFF"
PKG_CMAKE_OPTS_TARGET+=" -DUSE_HOST_SDL=OFF"

# ---------------------------------------------------------------------------
# pre_configure_target: apply patches and set up build environment
# ---------------------------------------------------------------------------
pre_configure_target() {
  # Ensure the build directory is clean
  cd "${PKG_BUILD}"
  rm -rf CMakeCache.txt CMakeFiles

  # Export cross-compilation flags
  export CFLAGS="${CFLAGS} -DNDEBUG"
  export CXXFLAGS="${CXXFLAGS} -DNDEBUG -std=c++17"
  export LDFLAGS="${LDFLAGS} -lpthread"

  # Set toolchain file for cross-compilation
  if [ -n "${CMAKE_CONF}" ]; then
    PKG_CMAKE_OPTS_TARGET+=" -DCMAKE_TOOLCHAIN_FILE=${CMAKE_CONF}"
  fi
}

# ---------------------------------------------------------------------------
# makeinstall_target: install the built shared library into the sysroot
# ---------------------------------------------------------------------------
makeinstall_target() {
  mkdir -p "${SYSROOT_PREFIX}/usr/lib/cmake/${PKG_NAME}"
  cp "${PKG_LIBPATH}" "${SYSROOT_PREFIX}/usr/lib/${PKG_LIBNAME}"
  echo "set(${PKG_LIBVAR} ${SYSROOT_PREFIX}/usr/lib/${PKG_LIBNAME})" \
    > "${SYSROOT_PREFIX}/usr/lib/cmake/${PKG_NAME}/${PKG_NAME}-config.cmake"

  # Install controller mapping configuration
  mkdir -p "${SYSROOT_PREFIX}/usr/share/libretro-flycast"
  if [ -d "${PKG_BUILD}/mappings" ]; then
    cp -r "${PKG_BUILD}/mappings/"* "${SYSROOT_PREFIX}/usr/share/libretro-flycast/"
  fi
}

# ---------------------------------------------------------------------------
# post_makeinstall_target: install additional data files
# ---------------------------------------------------------------------------
post_makeinstall_target() {
  # Install Dreamcast BIOS directory structure (user must supply actual BIOS)
  mkdir -p "${INSTALL}/usr/share/retroarch/system/dc"

  # Install default VMU save data directory
  mkdir -p "${INSTALL}/usr/share/retroarch/saves/flycast"

  # Install core info file for RetroArch
  mkdir -p "${INSTALL}/usr/lib/libretro"
  cp "${PKG_BUILD}/${PKG_LIBNAME}" "${INSTALL}/usr/lib/libretro/${PKG_LIBNAME}"

  # Install controller mapping configs for common gamepads
  mkdir -p "${INSTALL}/usr/share/libretro-flycast/mappings"
  if [ -d "${PKG_DIR}/config" ]; then
    cp -r "${PKG_DIR}/config/"* "${INSTALL}/usr/share/libretro-flycast/"
  fi
}
