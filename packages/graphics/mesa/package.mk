# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="mesa"
PKG_VERSION="23.2.1"
PKG_SHA256="64de0616fc2d801f929ab1ac2a4f16b3e2783c4309a724c8a259b20df8bbc1cc"
PKG_LICENSE="OSS"
PKG_SITE="http://www.mesa3d.org/"
PKG_URL="https://mesa.freedesktop.org/archive/mesa-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain expat libdrm Mako:host"
PKG_LONGDESC="Mesa is a 3-D graphics library with an API."

get_graphicdrivers

PKG_MESON_OPTS_TARGET="-Dgallium-drivers=${GALLIUM_DRIVERS// /,} \
                       -Dgallium-extra-hud=false \
                       -Dgallium-omx=disabled \
                       -Dgallium-nine=false \
                       -Dgallium-opencl=disabled \
                       -Dshader-cache=enabled \
                       -Dshared-glapi=enabled \
                       -Dopengl=true \
                       -Dgbm=enabled \
                       -Degl=enabled \
                       -Dvalgrind=disabled \
                       -Dlibunwind=disabled \
                       -Dlmsensors=disabled \
                       -Dbuild-tests=false \
                       -Ddraw-use-llvm=false \
                       -Dselinux=false \
                       -Dosmesa=false"

if [ "${DISPLAYSERVER}" = "x11" ]; then
  PKG_DEPENDS_TARGET+=" xorgproto libXext libXdamage libXfixes libXxf86vm libxcb libX11 libxshmfence libXrandr"
  export X11_INCLUDES=
  PKG_MESON_OPTS_TARGET+=" -Dplatforms=x11 \
                           -Ddri3=enabled \
                           -Dglx=dri"
  if [ "${DEVICE}" = "Odin" ]; then
     PKG_MESON_OPTS_TARGET+=" -Dglx-direct=true"
  fi
  if [ "${PROJECT}" = "L4T" ]; then
    PKG_DEPENDS_TARGET+=" libglvnd"
    PKG_MESON_OPTS_TARGET+=" -Dglvnd=true"
  fi
elif [ "${DISPLAYSERVER}" = "wl" ]; then
  PKG_DEPENDS_TARGET+=" wayland wayland-protocols"
  PKG_MESON_OPTS_TARGET+=" -Dplatforms=wayland \
                           -Ddri3=disabled \
                           -Dglx=disabled"
elif [ "${DISTRO}" = "Lakka" -o "${PROJECT}" = "L4T" ]; then
  PKG_DEPENDS_TARGET+=" libglvnd"
  PKG_MESON_OPTS_TARGET+=" -Dplatforms="" -Ddri3=enabled -Dglx=disabled -Dglvnd=true"
else
  PKG_MESON_OPTS_TARGET+=" -Dplatforms="" \
                           -Ddri3=disabled \
                           -Dglx=disabled"
fi

if listcontains "${GRAPHIC_DRIVERS}" "iris"; then
  PKG_MESON_OPTS_TARGET+=" -Dintel-xe-kmd=enabled"
fi

if listcontains "${GRAPHIC_DRIVERS}" "(nvidia|nvidia-ng)"; then
  PKG_DEPENDS_TARGET+=" libglvnd"
  PKG_MESON_OPTS_TARGET+=" -Dglvnd=true"
else
  if [ ! "${DISTRO}" = "Lakka" -a ! "${PROJECT}" = "L4T" ]; then
    PKG_MESON_OPTS_TARGET+=" -Dglvnd=false"
  fi
fi

if [ "${LLVM_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" elfutils llvm"
  PKG_MESON_OPTS_TARGET+=" -Dllvm=enabled"
else
  PKG_MESON_OPTS_TARGET+=" -Dllvm=disabled"
fi

if [ "${VDPAU_SUPPORT}" = "yes" -a "${DISPLAYSERVER}" = "x11" ]; then
  PKG_DEPENDS_TARGET+=" libvdpau"
  PKG_MESON_OPTS_TARGET+=" -Dgallium-vdpau=enabled"
else
  PKG_MESON_OPTS_TARGET+=" -Dgallium-vdpau=disabled"
fi

if [ "${VAAPI_SUPPORT}" = "yes" ] && listcontains "${GRAPHIC_DRIVERS}" "(r600|radeonsi)"; then
  PKG_DEPENDS_TARGET+=" libva"
  PKG_MESON_OPTS_TARGET+=" -Dgallium-va=enabled \
                           -Dvideo-codecs=vc1dec,h264dec,h264enc,h265dec,h265enc"
else
  PKG_MESON_OPTS_TARGET+=" -Dgallium-va=disabled"
fi

if listcontains "${GRAPHIC_DRIVERS}" "vmware" || listcontains "${GRAPHIC_DRIVERS}" "freedreno"; then
  PKG_MESON_OPTS_TARGET+=" -Dgallium-xa=enabled"
else
  PKG_MESON_OPTS_TARGET+=" -Dgallium-xa=disabled"
fi

if [ "${OPENGLES_SUPPORT}" = "yes" ]; then
  PKG_MESON_OPTS_TARGET+=" -Dgles1=disabled -Dgles2=enabled"
else
  PKG_MESON_OPTS_TARGET+=" -Dgles1=disabled -Dgles2=disabled"
fi

if [ "${VULKAN_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${VULKAN} vulkan-tools"
  PKG_MESON_OPTS_TARGET+=" -Dvulkan-drivers=${VULKAN_DRIVERS_MESA// /,}"
else
  PKG_MESON_OPTS_TARGET+=" -Dvulkan-drivers="
fi

post_makeinstall_target() {
  if [ "${PROJECT}" = "L4T" ]; then
    safe_remove ${INSTALL}/usr/lib/libgbm.so.1
  fi
}
