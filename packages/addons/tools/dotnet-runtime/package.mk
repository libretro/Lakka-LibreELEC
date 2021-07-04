# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="dotnet-runtime"
PKG_VERSION="3.1.16"
PKG_REV="113"
PKG_ARCH="any"
PKG_LICENSE="MIT"
PKG_SITE="https://dotnet.microsoft.com/"
PKG_DEPENDS_TARGET="toolchain icu"
PKG_SECTION="tools"
PKG_SHORTDESC=".NET Core Runtime"
PKG_LONGDESC=".NET Core Runtime (${PKG_VERSION}) runs applications built with .NET Core, a cross-platform .NET implementation."
PKG_TOOLCHAIN="manual"

PKG_IS_ADDON="yes"
PKG_ADDON_NAME=".Net Core Runtime"
PKG_ADDON_PROJECTS="any !RPi1"
PKG_ADDON_TYPE="xbmc.python.script"
PKG_MAINTAINER="Anton Voyl (awiouy)"

case "${ARCH}" in
  "aarch64")
    PKG_SHA256="b76c049484efd86466d2e1cd88994521633c399d090adb1c6804128603816abe"
    PKG_URL="https://download.visualstudio.microsoft.com/download/pr/64353333-3080-45f7-a3d5-33e391e4596c/e9d5d53cb318628485e8d1fbd26ec30d/aspnetcore-runtime-3.1.16-linux-arm64.tar.gz"
    ;;
  "arm")
    PKG_SHA256="a0163cd5c5ceae228bfffb40053f3509e155a110c23e81c38705757a870e24cc"
    PKG_URL="https://download.visualstudio.microsoft.com/download/pr/bd734390-3b5f-402a-826f-e0eae538b8ba/5914dd937ede96cb9297e6e7a80f46f3/aspnetcore-runtime-3.1.16-linux-arm.tar.gz"
    ;;
  "x86_64")
    PKG_SHA256="b1a2f61d8a49e2a3ca5eb9daa103b83eb49ea1bcf14914560e601222e94a3022"
    PKG_URL="https://download.visualstudio.microsoft.com/download/pr/c20a5ac5-5174-46b8-a875-b916a416050d/b2ddd212a183260569178d880899bd94/aspnetcore-runtime-3.1.16-linux-x64.tar.gz"
    ;;
esac
PKG_SOURCE_NAME="aspnetcore-runtime_${PKG_VERSION}_${ARCH}.tar.gz"

addon() {
  mkdir -p ${ADDON_BUILD}/${PKG_ADDON_ID}/bin
    cp -r ${PKG_BUILD}/* \
          ${ADDON_BUILD}/${PKG_ADDON_ID}/bin

  mkdir -p ${ADDON_BUILD}/${PKG_ADDON_ID}/lib
    cp -L $(get_install_dir icu)/usr/lib/lib*.so.?? \
          ${ADDON_BUILD}/${PKG_ADDON_ID}/lib/
}
