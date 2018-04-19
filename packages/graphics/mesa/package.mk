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

PKG_NAME="mesa"
PKG_VERSION="18.0.1"
PKG_SHA256="b2d2f5b5dbaab13e15cb0dcb5ec81887467f55ebc9625945b303a3647cd87954"
PKG_ARCH="any"
PKG_LICENSE="OSS"
PKG_SITE="http://www.mesa3d.org/"
PKG_URL="ftp://freedesktop.org/pub/mesa/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain expat libdrm"
PKG_SECTION="graphics"
PKG_SHORTDESC="mesa: 3-D graphics library with OpenGL API"
PKG_LONGDESC="Mesa is a 3-D graphics library with an API which is very similar to that of OpenGL*. To the extent that Mesa utilizes the OpenGL command syntax or state machine, it is being used with authorization from Silicon Graphics, Inc. However, the author makes no claim that Mesa is in any way a compatible replacement for OpenGL or associated with Silicon Graphics, Inc. Those who want a licensed implementation of OpenGL should contact a licensed vendor. While Mesa is not a licensed OpenGL implementation, it is currently being tested with the OpenGL conformance tests. For the current conformance status see the CONFORM file included in the Mesa distribution."
PKG_TOOLCHAIN="autotools"

if [ "$DISPLAYSERVER" = "x11" ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET glproto dri2proto presentproto libXext libXdamage libXfixes libXxf86vm libxcb libX11 dri3proto libxshmfence"
  export DRI_DRIVER_INSTALL_DIR=$XORG_PATH_DRI
  export DRI_DRIVER_SEARCH_DIR=$XORG_PATH_DRI
  export X11_INCLUDES=
  MESA_DRI="--enable-dri --enable-dri3"
  MESA_GLX="--enable-glx --enable-driglx-direct --enable-glx-tls"
  MESA_PLATFORMS="--with-platforms=x11,drm"
elif [ "$DISPLAYSERVER" = "weston" ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET wayland wayland-protocols"
  MESA_DRI="--enable-dri --disable-dri3"
  # The glx in glx-tls is a misnomer - there's nothing glx in it.
  MESA_GLX="--disable-glx --disable-driglx-direct --enable-glx-tls"
  MESA_PLATFORMS="--with-platforms=drm,wayland"
else
  MESA_DRI="--enable-dri --disable-dri3"
  # The glx in glx-tls is a misnomer - there's nothing glx in it.
  MESA_GLX="--disable-glx --disable-driglx-direct --enable-glx-tls"
  MESA_PLATFORMS="--with-platforms=drm"
fi

# configure GPU drivers and dependencies:
  get_graphicdrivers

if [ "$LLVM_SUPPORT" = "yes" ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET elfutils llvm"
  export LLVM_CONFIG="$SYSROOT_PREFIX/usr/bin/llvm-config-host"
  MESA_GALLIUM_LLVM="--enable-llvm --enable-llvm-shared-libs"
else
  MESA_GALLIUM_LLVM="--disable-llvm"
fi

if [ "$VDPAU_SUPPORT" = "yes" -a "$DISPLAYSERVER" = "x11" ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET libvdpau"
  MESA_VDPAU="--enable-vdpau"
else
  MESA_VDPAU="--disable-vdpau"
fi

if [ "$VAAPI_SUPPORT" = "yes" ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET libva"
  MESA_VAAPI="--enable-va"
else
  MESA_VAAPI="--disable-va"
fi

XA_CONFIG="--disable-xa"
for drv in $GRAPHIC_DRIVERS; do
  [ "$drv" = "vmware" ] && XA_CONFIG="--enable-xa"
done

if [ "$OPENGLES_SUPPORT" = "yes" ]; then
  MESA_GLES="--disable-gles1 --enable-gles2"
else
  MESA_GLES="--disable-gles1 --disable-gles2"
fi

PKG_CONFIGURE_OPTS_TARGET="CC_FOR_BUILD=$HOST_CC \
                           CXX_FOR_BUILD=$HOST_CXX \
                           CFLAGS_FOR_BUILD= \
                           CXXFLAGS_FOR_BUILD= \
                           LDFLAGS_FOR_BUILD= \
                           --disable-debug \
                           --disable-mangling \
                           --enable-texture-float \
                           --enable-asm \
                           --disable-selinux \
                           $MESA_PLATFORMS \
                           --disable-libunwind \
                           --enable-opengl \
                           $MESA_GLES \
                           $MESA_DRI \
                           $MESA_GLX \
                           --disable-osmesa \
                           --disable-gallium-osmesa \
                           --enable-egl \
                           $XA_CONFIG \
                           --enable-gbm \
                           --disable-nine \
                           --disable-xvmc \
                           $MESA_VDPAU \
                           --disable-omx-bellagio \
                           $MESA_VAAPI \
                           --disable-opencl \
                           --enable-opencl-icd \
                           --disable-gallium-tests \
                           --enable-shared-glapi \
                           $MESA_GALLIUM_LLVM \
                           --disable-silent-rules \
                           --with-osmesa-lib-name=OSMesa \
                           --with-gallium-drivers=$GALLIUM_DRIVERS \
                           --with-dri-drivers=$DRI_DRIVERS \
                           --with-vulkan-drivers=no \
                           --with-sysroot=$SYSROOT_PREFIX"

# Temporary workaround:
# Listed libraries are static, while mesa expects shared ones. This breaks the
# dependency tracking. The following has some ideas on how to address that.
# https://github.com/LibreELEC/LibreELEC.tv/pull/2163
pre_configure_target() {
  if [ "$DISPLAYSERVER" = "x11" ]; then
    export LIBS="-lxcb-dri3 -lxcb-dri2 -lxcb-xfixes -lxcb-present -lxcb-sync -lxshmfence -lz"
  fi
}

post_makeinstall_target() {
  # Similar hack is needed on EGL, GLES* front. Might as well drop it and test the GLVND?
  if [ "$DISPLAYSERVER" = "x11" ]; then
    # rename and relink for cooperate with nvidia drivers
    rm -rf $INSTALL/usr/lib/libGL.so
    rm -rf $INSTALL/usr/lib/libGL.so.1
    ln -sf libGL.so.1 $INSTALL/usr/lib/libGL.so
    ln -sf /var/lib/libGL.so $INSTALL/usr/lib/libGL.so.1
    mv $INSTALL/usr/lib/libGL.so.1.2.0 $INSTALL/usr/lib/libGL_mesa.so.1
  fi
}
