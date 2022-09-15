# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libdrm"
PKG_VERSION="2.4.113"
PKG_SHA256="7fd7eb2967f63beb4606f22d50e277d993480d05ef75dd88a9bd8e677323e5e1"
PKG_LICENSE="GPL"
PKG_SITE="https://dri.freedesktop.org"
PKG_URL="https://dri.freedesktop.org/libdrm/libdrm-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain libpciaccess"
PKG_LONGDESC="The userspace interface library to kernel DRM services."

get_graphicdrivers

PKG_MESON_OPTS_TARGET="-Dnouveau=disabled \
                       -Domap=disabled \
                       -Dexynos=disabled \
                       -Dtegra=disabled \
                       -Dcairo-tests=disabled \
                       -Dman-pages=disabled \
                       -Dvalgrind=disabled \
                       -Dfreedreno-kgsl=false \
                       -Dinstall-test-programs=true \
                       -Dudev=false"

listcontains "${GRAPHIC_DRIVERS}" "(crocus|i915|iris)" &&
  PKG_MESON_OPTS_TARGET+=" -Dintel=enabled" || PKG_MESON_OPTS_TARGET+=" -Dintel=disabled"

listcontains "${GRAPHIC_DRIVERS}" "(r300|r600|radeonsi)" &&
  PKG_MESON_OPTS_TARGET+=" -Dradeon=enabled" || PKG_MESON_OPTS_TARGET+=" -Dradeon=disabled"

listcontains "${GRAPHIC_DRIVERS}" "radeonsi" &&
  PKG_MESON_OPTS_TARGET+=" -Damdgpu=enabled" || PKG_MESON_OPTS_TARGET+=" -Damdgpu=disabled"

listcontains "${GRAPHIC_DRIVERS}" "vmware" &&
  PKG_MESON_OPTS_TARGET+=" -Dvmwgfx=enabled" || PKG_MESON_OPTS_TARGET+=" -Dvmwgfx=disabled"

listcontains "${GRAPHIC_DRIVERS}" "vc4" &&
  PKG_MESON_OPTS_TARGET+=" -Dvc4=enabled" || PKG_MESON_OPTS_TARGET+=" -Dvc4=disabled"

listcontains "${GRAPHIC_DRIVERS}" "freedreno" &&
  PKG_MESON_OPTS_TARGET+=" -Dfreedreno=enabled" || PKG_MESON_OPTS_TARGET+=" -Dfreedreno=disabled"

listcontains "${GRAPHIC_DRIVERS}" "etnaviv" &&
  PKG_MESON_OPTS_TARGET+=" -Detnaviv=enabled" || PKG_MESON_OPTS_TARGET+=" -Detnaviv=disabled"

post_makeinstall_target() {
  mkdir -p ${INSTALL}/usr/bin
    cp -a ${PKG_BUILD}/.${TARGET_NAME}/tests/modetest/modetest ${INSTALL}/usr/bin/
  if [ "$PROJECT" = "L4T" ]; then
    rm ${INSTALL}/usr/lib/libdrm.so.2
  fi
  
  # Remove all test programs installed by install-test-programs=true except modetest
  for PKG_LIBDRM_TEST in \
    drmdevice modeprint proptest vbltest
  do
    safe_remove ${INSTALL}/usr/bin/${PKG_LIBDRM_TEST}
  done

  if listcontains "${GRAPHIC_DRIVERS}" "radeonsi"; then
    safe_remove ${INSTALL}/usr/bin/amdgpu_stress
  fi
}
