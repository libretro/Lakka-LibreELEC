
# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libdrm"
PKG_VERSION="2.4.97"
PKG_SHA256="77d0ccda3e10d6593398edb70b1566bfe1a23a39bd3da98ace2147692eadd123"
PKG_LICENSE="GPL"
PKG_SITE="http://dri.freedesktop.org"
PKG_URL="http://dri.freedesktop.org/libdrm/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_TARGET="toolchain libpciaccess"
PKG_LONGDESC="The userspace interface library to kernel DRM services."
PKG_TOOLCHAIN="meson"

get_graphicdrivers

PKG_DRM_CONFIG="-Dnouveau=false \
                -Domap=false \
                -Dexynos=false \
                -Dtegra=false"

listcontains "$GRAPHIC_DRIVERS" "(i915|i965)" &&
  PKG_DRM_CONFIG+=" -Dintel=true" || PKG_DRM_CONFIG+=" -Dintel=false"

listcontains "$GRAPHIC_DRIVERS" "(r200|r300|r600|radeonsi)" &&
  PKG_DRM_CONFIG+=" -Dradeon=true" || PKG_DRM_CONFIG+=" -Dradeon=false"

listcontains "$GRAPHIC_DRIVERS" "radeonsi" &&
  PKG_DRM_CONFIG+=" -Damdgpu=true" || PKG_DRM_CONFIG+=" -Damdgpu=false"

listcontains "$GRAPHIC_DRIVERS" "vmware" &&
  PKG_DRM_CONFIG+=" -Dvmwgfx=true" || PKG_DRM_CONFIG+=" -Dvmwgfx=false"

listcontains "$GRAPHIC_DRIVERS" "vc4" &&
  PKG_DRM_CONFIG+=" -Dvc4=true" || PKG_DRM_CONFIG+=" -Dvc4=false"

listcontains "$GRAPHIC_DRIVERS" "freedreno" &&
  PKG_DRM_CONFIG+=" -Dfreedreno=true" || PKG_DRM_CONFIG+=" -Dfreedreno=false"

listcontains "$GRAPHIC_DRIVERS" "etnaviv" &&
  PKG_DRM_CONFIG+=" -Detnaviv=true" || PKG_DRM_CONFIG+=" -Detnaviv=false"

PKG_MESON_OPTS_TARGET="-Dlibkms=false \
                       $PKG_DRM_CONFIG \
                       -Dcairo-tests=false \
                       -Dman-pages=false \
                       -Dvalgrind=false \
                       -Dfreedreno-kgsl=false \
                       -Dinstall-test-programs=false \
                       -Dudev=false"

post_makeinstall_target() {
  mkdir -p $INSTALL/usr/bin
    cp -a $PKG_BUILD/.$TARGET_NAME/tests/modetest/modetest $INSTALL/usr/bin/
}
