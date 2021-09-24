# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)

PKG_NAME="network"
PKG_VERSION=""
PKG_LICENSE="various"
PKG_SITE="https://libreelec.tv"
PKG_URL=""
PKG_DEPENDS_TARGET="toolchain connman netbase ethtool openssh iw"
PKG_SECTION="virtual"
PKG_LONGDESC="Metapackage for various packages to install network support"

if [ "$BLUETOOTH_SUPPORT" = "yes" ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET bluez"
fi

if [ "$SAMBA_SERVER" = "yes" ] || [ "$SAMBA_SUPPORT" = "yes" ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET samba"
fi

if [ "$OPENVPN_SUPPORT" = "yes" ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET openvpn"
fi

if [ "$WIREGUARD_SUPPORT" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" wireguard-tools"
  # Kernels 5.6 and above have support already in tree
  case $PROJECT in
    Allwinner | Amlogic | OdroidXU3 | Rockchip)
      PKG_DEPENDS_TARGET+=" wireguard-linux-compat"
      ;;
  esac
fi

# nss needed by inputstream.adaptive, chromium etc.
if [ "$TARGET_ARCH" = "x86_64" ] || [ "$TARGET_ARCH" = "i386" ] || [ "$TARGET_ARCH" = "arm" ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET nss"
fi
