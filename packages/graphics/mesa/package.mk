# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="mesa"
PKG_VERSION="20.3.3"
PKG_SHA256="84e29a3830d4cf8e4440db11988391068c43f7e4ba314e64d9a3dd84c95d0d7c"
PKG_LICENSE="OSS"
PKG_SITE="http://www.mesa3d.org/"
PKG_URL="https://github.com/mesa3d/mesa/archive/mesa-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain Mako:host expat libdrm"
PKG_LONGDESC="Mesa is a 3-D graphics library with an API."
PKG_TOOLCHAIN="meson"

get_graphicdrivers

PKG_MESON_OPTS_TARGET="-Ddri-drivers=${DRI_DRIVERS// /,} \
                       -Dgallium-drivers=${GALLIUM_DRIVERS// /,} \
                       -Dgallium-extra-hud=false \
                       -Dgallium-xvmc=false \
                       -Dgallium-omx=disabled \
                       -Dgallium-nine=false \
                       -Dgallium-opencl=disabled \
                       -Dvulkan-drivers= \
                       -Dshader-cache=true \
                       -Dshared-glapi=true \
                       -Dopengl=true \
                       -Dgbm=true \
                       -Degl=true \
                       -Dglvnd=false \
                       -Dasm=true \
                       -Dvalgrind=false \
                       -Dlibunwind=false \
                       -Dlmsensors=false \
                       -Dbuild-tests=false \
                       -Dselinux=false \
                       -Dosmesa=none"

if [ "$TARGET_ARCH" = "i386" ]; then
  PKG_MESON_OPTS_TARGET="${PKG_MESON_OPTS_TARGET//-Dvulkan-drivers=auto/-Dvulkan-drivers=}"
fi

if [ "$DISPLAYSERVER" = "x11" ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET xorgproto libXext libXdamage libXfixes libXxf86vm libxcb libX11 libxshmfence libXrandr libglvnd"
  export X11_INCLUDES=
  PKG_MESON_OPTS_TARGET+=" -Dplatforms=x11 -Ddri3=true -Dglx=dri"
elif [ "$DISPLAYSERVER" = "weston" ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET wayland wayland-protocols"
  PKG_MESON_OPTS_TARGET+=" -Dplatforms=wayland -Ddri3=false -Dglx=disabled"
elif [ "$DISTRO" = "Lakka" ]; then
  PKG_DEPENDS_TARGET+=" glproto dri2proto dri3proto presentproto xorgproto libXext libXdamage libXfixes libXxf86vm libxcb libX11 libxshmfence xrandr systemd openssl"
  export X11_INCLUDES=
  PKG_MESON_OPTS_TARGET+=" -Dplatforms=x11 -Ddri3=true -Dglx=dri"
else
  PKG_MESON_OPTS_TARGET+=" -Dplatforms= -Ddri3=false -Dglx=disabled"
fi

if [ "$LLVM_SUPPORT" = "yes" ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET elfutils llvm"
  export LLVM_CONFIG="$SYSROOT_PREFIX/usr/bin/llvm-config-host"
  PKG_MESON_OPTS_TARGET+=" -Dllvm=true"
else
  PKG_MESON_OPTS_TARGET+=" -Dllvm=false"
fi

if [ "$VDPAU_SUPPORT" = "yes" -a "$DISPLAYSERVER" = "x11" ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET libvdpau"
  PKG_MESON_OPTS_TARGET+=" -Dgallium-vdpau=true"
else
  PKG_MESON_OPTS_TARGET+=" -Dgallium-vdpau=false"
fi

if [ "$VAAPI_SUPPORT" = "yes" ] && listcontains "$GRAPHIC_DRIVERS" "(r600|radeonsi)"; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET libva"
  PKG_MESON_OPTS_TARGET+=" -Dgallium-va=true"
else
  PKG_MESON_OPTS_TARGET+=" -Dgallium-va=false"
fi

if listcontains "$GRAPHIC_DRIVERS" "vmware"; then
  PKG_MESON_OPTS_TARGET+=" -Dgallium-xa=true"
else
  PKG_MESON_OPTS_TARGET+=" -Dgallium-xa=false"
fi

if [ "$OPENGLES_SUPPORT" = "yes" ]; then
  PKG_MESON_OPTS_TARGET+=" -Dgles1=false -Dgles2=true"
else
  PKG_MESON_OPTS_TARGET+=" -Dgles1=false -Dgles2=false"
fi
