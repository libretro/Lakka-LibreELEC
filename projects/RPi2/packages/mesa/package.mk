################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
#      Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)
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

PKG_NAME="mesa"
PKG_VERSION="19.1.1"
PKG_ARCH="any"
PKG_LICENSE="OSS"
PKG_SITE="http://www.mesa3d.org/"
PKG_URL="https://mesa.freedesktop.org/archive/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain Python:host meson:host ninja:host Mako:host expat glproto dri2proto presentproto libdrm libXext libXdamage libXfixes libXxf86vm libxcb libX11 systemd dri3proto libxshmfence openssl xrandr"
PKG_SECTION="graphics"
PKG_SHORTDESC="mesa: 3-D graphics library with OpenGL API"
PKG_LONGDESC="Mesa is a 3-D graphics library with an API which is very similar to that of OpenGL*. To the extent that Mesa utilizes the OpenGL command syntax or state machine, it is being used with authorization from Silicon Graphics, Inc. However, the author makes no claim that Mesa is in any way a compatible replacement for OpenGL or associated with Silicon Graphics, Inc. Those who want a licensed implementation of OpenGL should contact a licensed vendor. While Mesa is not a licensed OpenGL implementation, it is currently being tested with the OpenGL conformance tests. For the current conformance status see the CONFORM file included in the Mesa distribution."

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

MESON_OPTS_TARGET="-Dplatforms=x11,drm \
                   -Ddri3=true \
                   -Dshader-cache=true \
                   -Dshared-glapi=true \
                   -Dgbm=true \
                   -Degl=true \
                   -Dglvnd=false \
                   -Dasm=true \
                   -Dvalgrind=false \
                   -Dlibunwind=false \
                   -Dlmsensors=false \
                   -Dbuild-tests=false \
                   -Dselinux=false \
                   -Dosmesa=none \
                   -Dglx=dri \
                   -Dllvm=false \
                   -Dgallium-vdpau=false \
                   -Dgallium-va=false \
                   -Dgallium-xa=false \
                   -Dgles1=true \
                   -Dgles2=true \
                   -Dopengl=true \
                   -Dgallium-drivers=vc4,v3d,kmsro"

MESON_FLAGS="--prefix=/usr \
                   --bindir=/usr/bin \
                   --sbindir=/usr/sbin \
                   --sysconfdir=/etc \
                   --libdir=/usr/lib \
                   --libexecdir=/usr/lib \
                   --localstatedir=/var \
                   --buildtype=plain"

create_meson_conf() {
  local endian root
  root="$SYSROOT_PREFIX/usr"

  cat > meson.conf <<EOF
[binaries]
c = '$CC'
cpp = '$CXX'
ar = '$AR'
strip = '$STRIP'
pkgconfig = '$PKG_CONFIG'
llvm-config = '$SYSROOT_PREFIX/usr/bin/llvm-config-host'

[host_machine]
system = 'linux'
cpu_family = '$TARGET_ARCH'
cpu = '$TARGET_SUBARCH'
endian = 'little'

[properties]
root = '$root'
$(python -c "import os; print('c_args = {}'.format([x for x in os.getenv('CFLAGS').split()]))")
$(python -c "import os; print('c_link_args = {}'.format([x for x in os.getenv('LDFLAGS').split()]))")
$(python -c "import os; print('cpp_args = {}'.format([x for x in os.getenv('CXXFLAGS').split()]))")
$(python -c "import os; print('cpp_link_args = {}'.format([x for x in os.getenv('LDFLAGS').split()]))")
EOF
}
 
configure_target() {
  cd $PKG_BUILD
  create_meson_conf
  CC="${HOST_CC}" CXX="${HOST_CXX}" meson ${MESON_FLAGS} --cross-file=meson.conf ${MESON_OPTS_TARGET} build
}

make_target() {
  cd $PKG_BUILD
  ninja -C build
}

makeinstall_target() {
  cd $PKG_BUILD
  DESTDIR=${SYSROOT_PREFIX} ninja -C build install
  DESTDIR=${INSTALL} ninja -C build install
}
