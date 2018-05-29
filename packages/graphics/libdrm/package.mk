
################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
#
#  OpenELEC is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 2 of the License, or
#  (at your option) any later version.
#
#  OpenELEC is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with OpenELEC.  If not, see <http://www.gnu.org/licenses/>.
################################################################################

PKG_NAME="libdrm"
PKG_VERSION="2.4.92"
PKG_SHA256="e9e48fdb4de139dc4d9880aa1473158a16ff6aff63d14341367bd30a51ff39fa"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://dri.freedesktop.org"
PKG_URL="http://dri.freedesktop.org/libdrm/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_TARGET="toolchain libpciaccess"
PKG_SECTION="graphics"
PKG_SHORTDESC="libdrm: Userspace interface to kernel DRM services"
PKG_LONGDESC="The userspace interface library to kernel DRM services."
PKG_TOOLCHAIN="meson"

get_graphicdrivers

PKG_DRM_CONFIG="-Dnouveau=false \
                -Domap=false \
                -Dexynos=false \
                -Dfreedreno=false \
                -Dtegra=false \
                -Detnaviv=false"

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
