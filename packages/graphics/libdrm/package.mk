
# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libdrm"
PKG_VERSION="2.4.104"
PKG_SHA256="d66ad8b5c2441015ac1333e40137bb803c3bde3612ff040286fcc12158ea1bcb"
PKG_LICENSE="GPL"
PKG_SITE="http://dri.freedesktop.org"
PKG_URL="http://dri.freedesktop.org/libdrm/libdrm-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain libpciaccess"
PKG_LONGDESC="The userspace interface library to kernel DRM services."
PKG_TOOLCHAIN="meson"

get_graphicdrivers

PKG_MESON_OPTS_TARGET="-Dlibkms=false \
                       -Domap=false \
                       -Dexynos=false \
                       -Dtegra=false \
                       -Dcairo-tests=false \
                       -Dman-pages=false \
                       -Dvalgrind=false \
                       -Dfreedreno-kgsl=false \
                       -Dinstall-test-programs=false \
                       -Dudev=false"

listcontains "${GRAPHIC_DRIVERS}" "(iris|i915|i965)" &&
  PKG_MESON_OPTS_TARGET+=" -Dintel=true" || PKG_MESON_OPTS_TARGET+=" -Dintel=false"

listcontains "${GRAPHIC_DRIVERS}" "(r200|r300|r600|radeonsi)" &&
  PKG_MESON_OPTS_TARGET+=" -Dradeon=true" || PKG_MESON_OPTS_TARGET+=" -Dradeon=false"

listcontains "${GRAPHIC_DRIVERS}" "radeonsi" &&
  PKG_MESON_OPTS_TARGET+=" -Damdgpu=true" || PKG_MESON_OPTS_TARGET+=" -Damdgpu=false"

listcontains "${GRAPHIC_DRIVERS}" "vmware" &&
  PKG_MESON_OPTS_TARGET+=" -Dvmwgfx=true" || PKG_MESON_OPTS_TARGET+=" -Dvmwgfx=false"

listcontains "${GRAPHIC_DRIVERS}" "vc4" &&
  PKG_MESON_OPTS_TARGET+=" -Dvc4=true" || PKG_MESON_OPTS_TARGET+=" -Dvc4=false"

listcontains "${GRAPHIC_DRIVERS}" "freedreno" &&
  PKG_MESON_OPTS_TARGET+=" -Dfreedreno=true" || PKG_MESON_OPTS_TARGET+=" -Dfreedreno=false"

listcontains "${GRAPHIC_DRIVERS}" "etnaviv" &&
  PKG_MESON_OPTS_TARGET+=" -Detnaviv=true" || PKG_MESON_OPTS_TARGET+=" -Detnaviv=false"

listcontains "${GRAPHIC_DRIVERS}" "nouveau" &&
  PKG_MESON_OPTS_TARGET+=" -Dnouveau=true" || PKG_MESON_OPTS_TARGET+=" -Dnouveau=false"

if [ "${DISTRO}" = "Lakka" ]; then
  PKG_MESON_OPTS_TARGET="${PKG_MESON_OPTS_TARGET//-Dlibkms=false/-Dlibkms=true}"
fi

post_makeinstall_target() {
  mkdir -p ${INSTALL}/usr/bin
    cp -a ${PKG_BUILD}/.${TARGET_NAME}/tests/modetest/modetest ${INSTALL}/usr/bin/
}
